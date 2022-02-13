Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB5FC433F5
	for <git@archiver.kernel.org>; Sun, 13 Feb 2022 05:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbiBMFyN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Feb 2022 00:54:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbiBMFyM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Feb 2022 00:54:12 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AEB5E778
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 21:54:06 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 60E40172C0E;
        Sun, 13 Feb 2022 00:54:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Fz6ZBdEFBsWPqlI4PB+CFLWBmX7OEEFGmimi4d
        ogVNw=; b=B69E4GJFd5ai30gnlk9j5F+xSOJrwsSYi37nYpXuMbJovHgQETqXiV
        VvccMIDGI/k24tATT4ngopveD2KjcZAV/8b9pepVV5dzRh97BewktbE98WDZ0bRU
        MFVF4lLQKfTlPoTt360iVSVoXE04DVrnwJv9OcqXcb9rmIDEF4HDY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4E2D1172C0D;
        Sun, 13 Feb 2022 00:54:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A4FF8172C0C;
        Sun, 13 Feb 2022 00:54:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmaso?= =?utf-8?Q?n?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v7 00/20] submodule: convert the rest of 'update' to C
References: <20220208083952.35036-1-chooglen@google.com>
        <20220210092833.55360-1-chooglen@google.com>
Date:   Sat, 12 Feb 2022 21:54:02 -0800
In-Reply-To: <20220210092833.55360-1-chooglen@google.com> (Glen Choo's message
        of "Thu, 10 Feb 2022 17:28:13 +0800")
Message-ID: <xmqqv8xj71mt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 593C2F84-8C91-11EC-BB88-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> This reroll contains another 'easy' preparatory patch and the fixups I
> alluded to in v6 [1]. This isn't the split-up I described in the
> footnote of v6, but it gets the big patch (patch 17) to what I think is
> a reviewable state.

Thanks.

This seems to heavily conflict with "clone, submodule: pass partial
clone filters to submodules, 2022-02-04" by Josh Steadmon
<690d2316ad518ea4551821b2b3aa652996858475.1644034886.git.steadmon@google.com>
in both builtins/submodule--helper.c and git-submodule.sh.

It also removes the code that "submodule: record superproject gitdir
during 'update', 2022-02-03" by Emily Shaffer
<20220203215914.683922-5-emilyshaffer@google.com>, so what the other
topic ends up adding to the shell script needs to eventually be
redone in the C code.

I think "superproject aware" topic would see a reroll due to a
slight redesign.  I am not sure how solid the design of the
"pass down partial clone filter" topic is at this moment.

I may try to eject them tentatively and see how well this topic
plays with the rest of the topics in flight.

Thanks.


