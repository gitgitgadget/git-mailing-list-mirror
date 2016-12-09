Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1D8B1FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 19:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752937AbcLITQz (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 14:16:55 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56905 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752111AbcLITQz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 14:16:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 193F855D21;
        Fri,  9 Dec 2016 14:16:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DHLYM66EAw1Ue/s3wB0pGZppSZ0=; b=TLi1Ag
        NxVThQiTJnfg/aT1SDTn5bC3ZyIg7drXhC0V25L8aw9rJ3SV6Le68IAECweLBVSA
        mH1oP4TbTGvUwuElNuelilCbPAS5wtIp015f3YyTTSolfN/XZEarfsRll6r/MwcR
        UW/MqTGahb79Mylzym8BXnd4SyusH7fJILU7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=L6EulXIrl3RRflTyyfViPRzDgZIjZEa0
        F/oTrk2QTUOK/ECuw/frqZ4nRkPZLyAxgMI+NT7C31TOKzV+SFMieUQDQZ2LHC5m
        nWtb0fkCVh1R+FoAra8LjfsCKkH6/5uZvD4mrDTHCLhAKKHa0AzRscP/mWJzT2R8
        qPPG77bTHWY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0FBBB55D20;
        Fri,  9 Dec 2016 14:16:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7CAC855D1E;
        Fri,  9 Dec 2016 14:16:53 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Chris Packham <judge.packham@gmail.com>, GIT <git@vger.kernel.org>
Subject: Re: Any interest in 'git merge --continue' as a command
References: <CAFOYHZDs5rBt5+4D_ViMYfV04foq3h_UrsSMA3FfyMzLh9QdwA@mail.gmail.com>
        <20161209091127.sxxczhfslrqsqs3m@sigill.intra.peff.net>
Date:   Fri, 09 Dec 2016 11:16:52 -0800
In-Reply-To: <20161209091127.sxxczhfslrqsqs3m@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 9 Dec 2016 04:11:27 -0500")
Message-ID: <xmqqshpwrjyz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B22F114-BE44-11E6-97CB-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> They knew about git rebase --continue (and git am and git cherry-pick)
>> but they were unsure how to "continue" a merge (it didn't help that
>> the advice saying to use 'git commit' was scrolling off the top of the
>> terminal). I know that using 'git commit' has been the standard way to
>> complete a merge but given other commands have a --continue should
>> merge have it as well?
>
> It seems like that would be in line with 35d2fffdb (Provide 'git merge
> --abort' as a synonym to 'git reset --merge', 2010-11-09), whose stated
> goal was providing consistency with other multi-command operations.
>
> I assume it would _just_ run a vanilla "git commit", and not try to do
> any trickery with updating the index (which could be disastrous).

If we were to have "merge --continue", I agree that it would be the
logical implementation.

There is nothing to "continue" in a stopped merge where Git asked
for help from the user, and because of that, I view the final "git
commit" as "concluding the merge", not "continuing".  "continue"
makes quite a lot of sense with rebase and cherry-pick A..B that
stopped; it concludes the current step and let it continue to
process the remainder.  So from that point of view, it somewhat
feels strange to call it "merge --continue", but it probably is just
me.



