Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A6BE7E652
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 16:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbjIZQup (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 12:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjIZQuo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 12:50:44 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B00E5
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 09:50:38 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A292519B856;
        Tue, 26 Sep 2023 12:50:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=Vd7+xidPwnW3Ih02JuQ0grBS3brcShBjLI7vQc
        N9wxs=; b=STwKxexe3iL3eoXy8HbPUj3assFrYwk2aWLtJ9Y4YehKcuVKCeySDf
        Vzo+2bTLFi9uRoIH8Vh5bu19tVvmzSmD8ICaTMC9SxZvjREBK944PxSkTvB6YFa+
        aX8AWFDL51y2kxLaVveZFIfprORobWGT1Zbqx8wKrj+AKe1+mC00U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A66A19B855;
        Tue, 26 Sep 2023 12:50:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 138B319B854;
        Tue, 26 Sep 2023 12:50:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/6] coverity: allow overriding the Coverity project
In-Reply-To: <20230926143933.GA1897653@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 26 Sep 2023 10:39:33 -0400")
References: <pull.1588.git.1695379323.gitgitgadget@gmail.com>
        <6c1c82862814f40a408231cb249fb4b653276b52.1695379323.git.gitgitgadget@gmail.com>
        <20230923070019.GD1469941@coredump.intra.peff.net>
        <a839daf1-9e32-96f8-4eab-7c845e128488@gmx.de>
        <20230925121157.GB1623701@coredump.intra.peff.net>
        <4e0f404e-0c49-b085-c35d-be53b0381402@gmx.de>
        <xmqq4jjhow3h.fsf@gitster.g>
        <20230926143933.GA1897653@coredump.intra.peff.net>
Date:   Tue, 26 Sep 2023 09:50:36 -0700
Message-ID: <xmqqh6ngop43.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D1419344-5C8C-11EE-938C-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Sep 26, 2023 at 07:19:46AM -0700, Junio C Hamano wrote:
>
>> At the same time, it would be one less thing they need to tweak
>> before starting to use it, and if there are two or more users to do
>> so, it would already have paid off.  Developers typically outnumber
>> projects they work on.
>> 
>> I also have to wonder if it might make it more obvious what is going
>> on if you made the default to $user/$fork and have the project
>> override it, which hopefully may make it easier to find out what
>> they need to do for those who want to override it to a different
>> value to suit their need?
>
> Yeah, that was my thinking (and what I had been proposing).
>
> But I really think it probably doesn't matter that much either way. I
> would not be surprised if there are zero developers who use this,
> because of the setup on the coverity side, and the fact that the results
> are not always immediately actionable.
>
> Even I, who has been running coverity on my local fork for a few years,
> will probably just switch to using the git.git run and occasionally
> looking at the results (that creates an extra headache because somebody
> has to grant acess to the git.git run results to interested parties, but
> it's also a one-time setup thing).

Sure.  

I do not care too much either way, and in a situation like this
where the design decision does not have a crucial longer-term impact
either way exactly because it is a one-time thing for any user,
whoever has invested their work on should have the final say.

Thanks.
