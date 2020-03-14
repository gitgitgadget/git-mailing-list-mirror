Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEF8C0044D
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 01:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49AC920637
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 01:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sWJjFhlO";
	dkim=pass (1024-bit key) header.d=kyleam.com header.i=@kyleam.com header.b="Pvte9vcR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgCOBdv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Mar 2020 21:33:51 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57879 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgCOBdv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Mar 2020 21:33:51 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 24306B362A;
        Sat, 14 Mar 2020 01:57:46 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=beExoCBygyz5efZxEwctNh+cx0I=; b=sWJjFh
        lOGh//hx6LYaEH5jnxK23DvEzYtIgs7surNYnwwLK6p1Se/iG7JGNQ6at/283H95
        daN0Ai3d3EWOvQ4OZfghnqFnYSCHIXnsDa1Yk63JvSbYSK3Kpvua72QH+xzCKEsI
        I31FZ4ioiW6OSdTJxKoIDxKHRNMmYO39HWREU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0F913B3629;
        Sat, 14 Mar 2020 01:57:46 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:in-reply-to:references:date:message-id:mime-version:content-type; s=mesmtp; bh=HNZ7H62Ywj6aMYiTzHNBpJaj3BneeAzdfJLhnsJtKSA=; b=Pvte9vcR5ki6jZqYF+SRUkGxqLkw8sx89ttfrO5paylLa8NuC6qA0g8CQMCa/Jecu5cvEniy9Tv1mLVdBX+pfycXDHyh1O1fsNAq0/o2Rdq55BLqzV5cxEEyikDRO6Gyckdt4EbYeinSWGFRw0loR+HkKBi1A2z4qAR3Lw8npJ8=
Received: from localhost (unknown [45.33.91.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E843EB3627;
        Sat, 14 Mar 2020 01:57:42 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: Regression in v2.26.0-rc0 and Magit
In-Reply-To: <xmqqy2s4axa2.fsf@gitster.c.googlers.com>
References: <3091652.KAqcNXvZJ4@cayenne> <20200312233504.GH120942@google.com> <xmqqk13pdsw1.fsf@gitster.c.googlers.com> <xmqq36accdpt.fsf@gitster.c.googlers.com> <xmqqy2s4axa2.fsf@gitster.c.googlers.com>
Date:   Sat, 14 Mar 2020 05:57:40 +0000
Message-ID: <87h7yr8omj.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B85CC9F8-65B8-11EA-8C70-B0405B776F7B-24757444!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> That does not still explain why Magit (which is sufficiently mature)
> is expecting "cd .git && ls-files .." to show the entire working
> tree, though.

The specific ls-files call that seems to trigger the segfault on Magit's
end is equivalent to

  cd .git && git ls-files --error-unmatch -- $PWD/COMMIT_EDITMSG

The code is running ls-files to ask whether the file is tracked, which
of course isn't a sensible thing to do outside of the working tree.
I'll propose a change on Magit's end to avoid doing so.

[ A few more specifics that might be of interest to Magit users ]

This happens in magit-auto-revert-mode.  When visiting a file in .git/
(e.g., COMMIT_EDITMSG when committing), magit-auto-revert-mode decides
whether to turn on auto-revert-mode in the same way it does for other
files, magit-turn-on-auto-revert-mode-if-desired.  That function doesn't
distinguish whether the file is in .git or the working tree, leading to
the odd "is tracked file?" query above.
