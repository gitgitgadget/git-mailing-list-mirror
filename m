Return-Path: <SRS0=1y/A=EO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6054C4741F
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FEBA20657
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcOE97ir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbgKHVll (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Nov 2020 16:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728941AbgKHVlf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Nov 2020 16:41:35 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1635C0613D3
        for <git@vger.kernel.org>; Sun,  8 Nov 2020 13:41:33 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id u18so9542286lfd.9
        for <git@vger.kernel.org>; Sun, 08 Nov 2020 13:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6uBk7wgI2yeVqsDY6kvr2F6GiNd8dhXM9z7GG2OcM+k=;
        b=ZcOE97ir4oZNjQn3Ku394GQ9I8F9F/pxHJD+CuwR26CEBu/MRs3uHi4N2ezPCeClnx
         d/aC3LMlgAObOeUAXZQcGsqelict4BGWlQE69l4rwUMa0QR3E9RT08OqodL5HY6cK/EF
         Yq/DvirUMC2+PYgnhGd/4vnyzxP7+1xH2c1JKbibkzTsh6RR35JqLIbZ1ntdeXd5osnq
         39xBI85Tc6wDBwp+lJcIqeVbPfa3g98K/SoYekxiyBL+FJPQw+/xro+y1y6TEU8tHjgW
         NahKllq9McdWmhSID8W58YZd4fZ3yqfGTVedI9FkqcfqWrdUd1Hce2bWWj1Q4RFthMZh
         uSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6uBk7wgI2yeVqsDY6kvr2F6GiNd8dhXM9z7GG2OcM+k=;
        b=HagE68hdEonGsVHrx9H7OXvpX80ntlAGxrBVUPuiHSyw5kHByIH5jrrz1PALUbf1dw
         NTKLvRjrAPYmQq4jSl3XZJfIAMO1YiR+NEIvfrw2Ymoe+sEbILqMOF6xR2atOmGFz/lw
         nUoxic3MUTcibLJSstOVd6EgXwDGrpST+4rZaEaMTcXGGy4yUBXP2xED/BVtGYIscIj/
         A8XuOzA3xdVekNZMvblH44h6Ltlt7q7jkgpU+MlMvBO1NuJBraQxh1USIAn2CBetcWkE
         CnnUhiiMW+aultPrbErSRf6EiGc3adm3WeqSeZrtIZgoPoo3r0AHGPiUcwin7fsMfAa1
         Ofxw==
X-Gm-Message-State: AOAM531f0sQLpfRrMQIYVTVOcqJaoSSK0ryMaCknaFQbbxa3WwRunA3V
        lWNo23IlPBkl0wfNiRFEykY=
X-Google-Smtp-Source: ABdhPJwoY4a2Y0ic2DGnUnCFUWJqW6r1tuXRYI0b10rHdS0NbpivjbOI7v3UhHmPUyO9gbYUYoNaTg==
X-Received: by 2002:ac2:47eb:: with SMTP id b11mr2555429lfp.512.1604871692328;
        Sun, 08 Nov 2020 13:41:32 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id k21sm1937392ljb.43.2020.11.08.13.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 13:41:31 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 13/27] diff-merges: revise revs->diff flag handling
Date:   Mon,  9 Nov 2020 00:38:24 +0300
Message-Id: <20201108213838.4880-14-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201108213838.4880-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201108213838.4880-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Do not set revs->diff when we encounter an option that needs it, as
it'd be impossible to undo later. Besides, some other options than
what we handle here set this flag as well, and we'd interfere with
them trying to clear this flag later.

Rather set revs->diff, if finally needed, in diff_merges_setup_revs().

As an additional bonus, this also makes our code shorter.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/diff-merges.c b/diff-merges.c
index 63912ddedc76..a30c730a457f 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -37,16 +37,13 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv) {
 		revs->ignore_merges = 0;
 		revs->match_missing = 1;
 	} else if (!strcmp(arg, "-c")) {
-		revs->diff = 1;
 		revs->dense_combined_merges = 0;
 		revs->combine_merges = 1;
 	} else if (!strcmp(arg, "--cc")) {
-		revs->diff = 1;
 		set_dense_combined(revs);
 	} else if (!strcmp(arg, "--no-diff-merges")) {
 		suppress(revs);
 	} else if (!strcmp(arg, "--combined-all-paths")) {
-		revs->diff = 1;
 		revs->combined_all_paths = 1;
 	} else if ((argcount = parse_long_opt("diff-merges", argv, &optarg))) {
 		if (!strcmp(optarg, "off")) {
@@ -94,4 +91,6 @@ void diff_merges_setup_revs(struct rev_info *revs)
 		revs->ignore_merges = 1;
 	if (revs->combined_all_paths && !revs->combine_merges)
 		die("--combined-all-paths makes no sense without -c or --cc");
+	if (revs->combine_merges)
+		revs->diff = 1;
 }
-- 
2.25.1

