Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75241C2D0DB
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 19:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B36206D4
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 19:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="fr4tkPF+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgA2Tro (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 14:47:44 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:44463 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726251AbgA2Tro (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Jan 2020 14:47:44 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580327263; h=Content-Type: Content-Transfer-Encoding:
 MIME-Version: References: In-Reply-To: Message-ID: Date: Subject: Cc:
 To: From: Sender; bh=BK8AMAKSg47crc+jyzavBBGMikcaN228Q2/dTH2wAIg=; b=fr4tkPF+IQfZ+BdrcHAKBQDySbjw2W/N+RsQFyZVE+EQV+Ffjr5q4i5C+b/g4Ol+PiNwLDnE
 6lpm8ZYlAFxqZyiqEZN3foJbo1bFD3ZI4jXb76/nkIGnglM995p6eI/xfW8hqiHghs2JTtNP
 E1khqR+uZr2YIR0Yonz3+3RLVYg=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyJjNzk3NCIsICJnaXRAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e31e15d.7f2f7ae32ae8-smtp-out-n02;
 Wed, 29 Jan 2020 19:47:41 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E5C63C433CB; Wed, 29 Jan 2020 19:47:40 +0000 (UTC)
Received: from mfick-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 50A6EC43383;
        Wed, 29 Jan 2020 19:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 50A6EC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Jeff King <peff@peff.net>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 5/5] Reftable support for git-core
Date:   Wed, 29 Jan 2020 12:47:38 -0700
Message-ID: <2165647.H0RpPiDeFZ@mfick-lnx>
User-Agent: KMail/5.1.3 (Linux/4.4.0-154-generic; KDE/5.18.0; x86_64; ; )
In-Reply-To: <CAFQ2z_NkU6ekZkMqZpcFSEr8M3kfw0tiVCB2doHp3QTZtQ8UNg@mail.gmail.com>
References: <pull.539.git.1579808479.gitgitgadget@gmail.com> <9138554.c73hJVQVja@mfick-lnx> <CAFQ2z_NkU6ekZkMqZpcFSEr8M3kfw0tiVCB2doHp3QTZtQ8UNg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday, January 29, 2020 7:40:50 PM MST Han-Wen Nienhuys wrote:
> On Wed, Jan 29, 2020 at 5:49 PM Martin Fick <mfick@codeaurora.org> wrote:
> > > If you're actually doing the correct locking and packed-refs read (which
> > > "real" implementations like libgit2 do) then no, I don't think that's
> > > dangerous. And I think libgit2 properly complains when it sees a
> > > repositoryformatversion above 0. I don't know offhand about JGit, or any
> > > of the lesser-used ones like dulwich or go-git.
> > 
> > Today, some of these sound like shortcuts that are very likely taken quite
> > a bit by cleanup and other maintenance scripts (not necessarily formal
> > git tools), and the impact of these shortcuts is likely low with the
> > current model. However, I suspect these tools/scripts could be seriously
> > disruptive if we leave the refs dir around when using reftable,
> 
> Maybe we can leave the refs dir, but have no heads/ directory inside,
> and make the whole thing read-only?

That might be a good enough safety. I guess the next question would be,  would 
it be OK for reftable to ignore and entries under the refs/ dir if they happen 
to appear there somehow?

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation
