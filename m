Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926FEC433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 21:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D68A64ECB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 21:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbhBWV55 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 16:57:57 -0500
Received: from z11.mailgun.us ([104.130.96.11]:28506 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230268AbhBWV54 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 16:57:56 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614117455; h=Content-Type: Content-Transfer-Encoding:
 MIME-Version: References: In-Reply-To: Message-ID: Date: Subject: Cc:
 To: From: Sender; bh=MZPUoxroQq7eJhiJ2RrPXOj3q7dsPTiOm8HiFzns5Tw=; b=WQHZb1+CdZsoubMHeUly7AD3ZKkDVyBZKYfBjzGl/RNafDsJRV0YFXHaJxxP/pbs613bzgSD
 eKGMgbZAQVCK4PEf0pIQf0GZ4TQV+lsyrvKO20ToAeOpTz3x9JAmg7lkftSLV+Pll1fJU5wN
 B1E73jlxgidSMpyjEEuqCT+uo/c=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyJjNzk3NCIsICJnaXRAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 60357a474511108a812bd4cf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Feb 2021 21:57:27
 GMT
Sender: mfick=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 198ADC43463; Tue, 23 Feb 2021 21:57:27 +0000 (UTC)
Received: from mfick-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4C527C433ED;
        Tue, 23 Feb 2021 21:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4C527C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH v4 0/8] repack: support repacking into a geometric sequence
Date:   Tue, 23 Feb 2021 14:57:25 -0700
Message-ID: <2190798.zr6bNypoxz@mfick-lnx>
User-Agent: KMail/5.2.3 (Linux/4.4.0-154-generic; KDE/5.36.0; x86_64; ; )
In-Reply-To: <YDVgPtkaTb9zNq0/@nand.local>
References: <cover.1611098616.git.me@ttaylorr.com> <1724378.IzK8VI2DXP@mfick-lnx> <YDVgPtkaTb9zNq0/@nand.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday, February 23, 2021 3:06:22 PM MST Taylor Blau wrote:
> On Tue, Feb 23, 2021 at 12:54:56PM -0700, Martin Fick wrote:
> > Would it make sense to somehow detect all new packs since the last rollup
> > and always include them in the rollup no matter what their size? That is
> > one thing that my git-exproll script did.
> 
> I'm certainly not opposed, and this could certainly be done in an
> additive way (i.e., after this series). I think the current approach has
> nice properties, but I could also see "roll-up all packs that have
> mtimes after xyz timestamp" being useful.

Just to be clear, I meant to combine the two approaches. And yes, my 
suggestion would likely make more sense as an additive switch later on.
 
> It would even be possible to reuse a lot of the geometric repack
> machinery. Having a separate path to arrange packs by their mtimes and
> determine the "split" at pack whose mtime is nearest the provided one
> would do exactly what you want.

I was thinking to keep all of your geometric repack machinery and only looking 
for the split point starting at the right most pack which is newer than the 
provided mtime, and then possibly enhancing the approach with a clever way to 
use the mtime of the last consolidation (maybe by touching a pack/.geometric 
file?).

> (As a side-note, reading the original threads about your git-exproll was
> quite humbling, since it turns out all of the problems I thought were
> hard had already been discussed eight years ago!)

Thanks, but I think you have likely done a much better job than what I did. 
Your approach of using object counts is likely much better as it should be 
stable, using byte counts is not. You are also solving only one problem at a 
time, that's probably better than my hodge-podge of at least 3 different 
problems. And the most important part of your approach as I understand it, is 
that it actually saves CPU time whereas my approach only saved IO.

Cheers,

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation

