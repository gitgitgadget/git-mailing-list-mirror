Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12CAC433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 12:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C3BE611C9
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 12:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344965AbhKRMyv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 07:54:51 -0500
Received: from h2.fbrelay.privateemail.com ([131.153.2.43]:47033 "EHLO
        h2.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344974AbhKRMws (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 18 Nov 2021 07:52:48 -0500
Received: from MTA-06-4.privateemail.com (mta-06-1.privateemail.com [68.65.122.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h1.fbrelay.privateemail.com (Postfix) with ESMTPS id 220988118A
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 07:49:45 -0500 (EST)
Received: from mta-06.privateemail.com (localhost [127.0.0.1])
        by mta-06.privateemail.com (Postfix) with ESMTP id C0FA218000A0;
        Thu, 18 Nov 2021 07:49:40 -0500 (EST)
Received: from [192.168.0.46] (unknown [10.20.151.216])
        by mta-06.privateemail.com (Postfix) with ESMTPA id 520C1180009F;
        Thu, 18 Nov 2021 07:49:39 -0500 (EST)
Date:   Thu, 18 Nov 2021 07:49:29 -0500
From:   Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: [PATCH v2] grep: avoid setting UTF mode when dangerous with PCRE
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        avarab@gmail.com, =?iso-8859-1?b?UmVu6Q==?= Scharfe <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>
Message-Id: <HAQR2R.KZGF0ERBQ2Z72@effective-light.com>
In-Reply-To: <CAPUEsphbA0Qrnt-MdxyYT2OMrnXnbi0tN5_YNqLypCqDqZyeWg@mail.gmail.com>
References: <20211116110035.22140-1-carenas@gmail.com>
        <20211117102329.95456-1-carenas@gmail.com> <xmqqpmqxyla3.fsf@gitster.g>
        <CAPUEsphbA0Qrnt-MdxyYT2OMrnXnbi0tN5_YNqLypCqDqZyeWg@mail.gmail.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If none of the patches that are trying to fix our usage of PCRE2 are 
ACKed.
It would be preferable (from my perspective) to revert only ae39ba431a
(grep/pcre2: fix an edge case concerning ascii patterns and UTF-8 data,
2021-10-15) and disable the feature (for the time being) if PCRE2 is 
selected, like so:

diff --git a/pretty.c b/pretty.c
index 1af5b093ae..a53d008d1e 100644
--- a/pretty.c
+++ b/pretty.c
@@ -452,7 +452,7 @@ static void append_line_with_color(struct strbuf 
*sb, struct grep_opt *opt,
  buf = line;
  eol = buf + linelen;

- if (!opt || !want_color(color) || opt->invert)
+ if (!opt || !want_color(color) || opt->invert || opt->pcre2)
   goto end;

  line_color = opt->colors[GREP_COLOR_SELECTED];


On Thu, Nov 18 2021 at 02:15:49 AM -0800, Carlo Arenas 
<carenas@gmail.com> wrote:
> 
> This will likely need at least some ACKs.
> 
> Apologies for the noise.
> 
> Carlo


