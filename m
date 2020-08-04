Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A33C433E0
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 17:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8A6E206DA
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 17:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biKOYDL7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgHDRua (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 13:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbgHDRuV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 13:50:21 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54763C06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 10:50:20 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 185so34352324ljj.7
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 10:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6wsfxxRAOpGF19D/TPZc760bc52sTUzbq4s7LI2HP/k=;
        b=biKOYDL7oxgPvmCpTmuc/dcK4E1/lfVLBd9N7CvIFR3pndV2dtizVD8ii9wjH9tgKX
         JB88cA03GRmkhpDwJVqV9V3rXIeL1Y1F1MK+gQbYWUY1Vj726LerroNadkBPZpxbH7nu
         tEdOmRdBr3QP6+d7c1djg5RZmi0oHANcgDZsoZKjniWM+RXM3CkgJzusbiSxHaNcewKm
         ebkd0IbhjxnWZ7udmNUFSj/ctqccuXWxPEnTzd6SE1qtiWAFxRWXrdFfDe4UHlEfMZlf
         sQs+JqyKQ0e60XndUKtLHWAvHx46DA/wnca2c+/0cVGtG2/X4KLBR66XEByoxVvU2qwy
         SjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=6wsfxxRAOpGF19D/TPZc760bc52sTUzbq4s7LI2HP/k=;
        b=XPINozhJ90dPHat58+iR4OdFhNuZoL4U+IgsuSrWk3L4yDPMYQlwuFEl6CAcicdKEf
         InF+dOCtj1vuCaTdIQteOp7Q/8mSRrNBhU8kK+i4R3lZNjvOiKeM/6vcf5eNSDtmEQUL
         7riEf8LxPpgTE3oLA0He/GrKNPiZEVpPlp2vyCZyCiaBmQq1XG+tVSzaAMMMOxfUOP7X
         ZXO+PSzBx3HmSWEiYWSNDOlAfQ3ZGa6ZT61VmGV0Lj02ylS5jl4QFWjsF2ijLnoxf+CL
         v9qMSmacfOO+RBRkebJtNgN+MTLPbu5i5bhzLP3tJiCiq7HgoiXodXrtkgPnK6+dumpF
         /arQ==
X-Gm-Message-State: AOAM530ngtqkkeskSfkLbJ4Lx3I+4Tn45LFDlNDY3D341YT6LUAWxWiR
        LPhh3g/6GCr5ynF7Xjd8xHc=
X-Google-Smtp-Source: ABdhPJzVTfLuqQFoIxl2nOKWLkMDaNoEpgjq5vFZ/ojyx0ZhnmVi8PUPZjHqVwN81fjNzaHsgdtsyQ==
X-Received: by 2002:a2e:92d0:: with SMTP id k16mr11107284ljh.48.1596563418698;
        Tue, 04 Aug 2020 10:50:18 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id m142sm6577650lfa.47.2020.08.04.10.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 10:50:17 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
References: <20200728163617.GA2649887@coredump.intra.peff.net>
        <20200729201002.GA2989059@coredump.intra.peff.net>
        <871rku3soc.fsf@osv.gnss.ru>
        <20200731230858.GA1461090@coredump.intra.peff.net>
        <87mu3drynx.fsf@osv.gnss.ru> <xmqqsgd5rlwi.fsf@gitster.c.googlers.com>
        <87o8nrybnb.fsf@osv.gnss.ru>
        <20200803180824.GA2711830@coredump.intra.peff.net>
Date:   Tue, 04 Aug 2020 20:50:16 +0300
In-Reply-To: <20200803180824.GA2711830@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 3 Aug 2020 14:08:24 -0400")
Message-ID: <874kpi47xj.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--=-=-=
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> It's too late for "-m" to change semantics (we could do a long
> deprecation, but I don't see much point in doing so). But --diff-merges
> is definitely still changeable until we release v2.29. My resistance was
> mostly that I didn't want to complicate my series by adding new
> elements. But we could do something on top.

Attached is rather minimal incompatible change to --diff-merges that'd
allow extensions in the future, to get out of urge for the discussed
changes. I'm going to follow-up with actual improvements and I'm aware
it lacks documentation changes.

What do you think, is it OK to have something like this before v2.29?
And, by the way, what's approximate timeline to v2.29?

As for me, I'm not sure 'combined-all-paths' should be included and if
it should, is it a good enough name. In addition, do we need more
descriptive (additional) names for "c" and "cc" modes?

-- Sergey


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline;
 filename=0001-revision-change-diff-merges-option-to-require-parame.patch

From b75e410797d4576e266d056ece16acf07e4b0116 Mon Sep 17 00:00:00 2001
From: Sergey Organov <sorganov@gmail.com>
Date: Tue, 4 Aug 2020 16:48:27 +0300
Subject: [PATCH RFC] revision: change "--diff-merges" option to require
 parameter

Make --diff-merges require parameter having one of the following values:

  off, all, c, cc, combined-all-paths

that are equivalents of passing the following separate options, respectively:

  --no-diff-merges, -m, -c, -cc, --combined-all-paths

that, except --no-diff-merges, could be deprecated later.

This gives us single option that entirely defines how merge commits are to be
represented.

This patch is a preparation for supporting --diff-merges=<parent>, where
<parent> is parent number to provide diff against, that adds new essential
functionality and therefore is a separate change.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 revision.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 669bc856694f..dcdff59bc36a 100644
--- a/revision.c
+++ b/revision.c
@@ -2323,10 +2323,31 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->diff = 1;
 		revs->diffopt.flags.recursive = 1;
 		revs->diffopt.flags.tree_in_recursive = 1;
-	} else if (!strcmp(arg, "-m") || !strcmp(arg, "--diff-merges")) {
+	} else if ((argcount = parse_long_opt("diff-merges", argv, &optarg))) {
 		revs->ignore_merges = 0;
+		if (!strcmp(optarg, "off")) {
+			revs->ignore_merges = 1;
+		} else if (!strcmp(optarg, "all")) {
+			revs->diff = 0;
+		} else if (!strcmp(optarg, "c")) {
+			revs->diff = 1;
+			revs->dense_combined_merges = 0;
+			revs->combine_merges = 1;
+		} else if (!strcmp(optarg, "cc")) {
+			revs->diff = 1;
+			revs->dense_combined_merges = 1;
+			revs->combine_merges = 1;
+		} else if (!strcmp(optarg, "combined-all-paths")) {
+			revs->diff = 1;
+			revs->combined_all_paths = 1;
+		} else {
+			die("--diff-merges: unknown value '%s'.", optarg);
+		}
+		return argcount;
 	} else if (!strcmp(arg, "--no-diff-merges")) {
 		revs->ignore_merges = 1;
+	} else if (!strcmp(arg, "-m")) {
+		revs->ignore_merges = 0;
 	} else if (!strcmp(arg, "-c")) {
 		revs->diff = 1;
 		revs->dense_combined_merges = 0;
-- 
2.20.1


--=-=-=--
