Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C263C433E2
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 20:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 525922078B
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 20:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jm2W7quU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgHaUOf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 16:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgHaUOe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 16:14:34 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85679C061573
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 13:14:34 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id r13so8246104ljm.0
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 13:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ETa54mXSuaPVn8JUQfTykcZmB1AE+xlrY7YA8ixFGlQ=;
        b=jm2W7quU3fb1tO8z8hFL/ktD+Trcs9bgFNP6fFgMm7AF5OlbCngZc87ck2t+iT+Vnl
         Z4So9Ng6zRGS4w/FK3NItkEC65a+JlR7QQtcKINE+jbXKhiPjNI5O+68/EtWT3/oOz3p
         2LGgBVUALs8rgl5uIUeRRvrzfqLaoKGR95NvFnO9WReqjQsZ6zs8ctXsjgL8NoKWIlh/
         fma2OctDLUHS4ab/KBybSGus8seQsnTbputqWbdxTmxsxZB6qSMh/01dA6RWA+migDod
         4cz3bsLebYEu0uC0V8cSzg9cRR2w/6PUvc610Mj7aWpfcf0kFOylTT4bB73BIZdfGBcg
         VsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ETa54mXSuaPVn8JUQfTykcZmB1AE+xlrY7YA8ixFGlQ=;
        b=LOcWlUCf5HHW5IBrTOItKea3B2KdmpYKCPbvwlcaNPpWFAgoOYWqdJu4xrBhnNJktZ
         On16BaiTnDR/aSNhRecO43eCdWLbO+ag6NBvE19guEFIbI2Q1TvyVig/1J3n2uEC7RAR
         lTJBqpWeZCP4g7utEQGQg2eoz7yae32QFKifkLWS4sG3TBh/vPyYKcr0/LmZh1y1QNpD
         7rIZXdesys2WqOMiKnlxE8mKbf0f8uwMglZd2Q+yH+Qi4kvhTCWRzfKJETo9NXXRERKZ
         nfSloXPVxWzB8u75kx6XLqZBb62ZX/SSB58sWxiiXTQIQTdmgytOtaK3vfKy6T0ZWKkx
         B/4A==
X-Gm-Message-State: AOAM533WK+zat4OcsNe9mBkZ040IOhIeBiu567BaJ6E3Qw8tHzbya1lq
        STSjqCI715yfBD1bbMaHPFQ=
X-Google-Smtp-Source: ABdhPJxMJWDdL7LDEDySJGsl2JollVLpX4vwSbzaWCZErILuAQsJ/INFjCRWoIbn0DcVj3UmJIuz/w==
X-Received: by 2002:a2e:b051:: with SMTP id d17mr1312208ljl.190.1598904872734;
        Mon, 31 Aug 2020 13:14:32 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id i16sm1773161ljn.100.2020.08.31.13.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 13:14:31 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v4] revision: add separate field for "-m" of "diff-index -m"
Date:   Mon, 31 Aug 2020 23:14:22 +0300
Message-Id: <20200831201422.27189-1-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200829194634.23306-1-sorganov@gmail.com>
References: <20200829194634.23306-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add separate 'match_missing' field for diff-index to use and set it when we
encounter "-m" option. This field won't then be cleared when another meaning of
"-m" is reverted (e.g., by "--no-diff-merges"), nor it will be affected by
future option(s) that might drive 'ignore_merges' field.

Use this new field from diff-lib:do_oneway_diff() instead of reusing
'ignore_merges' field.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---

v4: fix new field name to be 'match_missing', and improve comment in the code to
    treat both involved bits similarily

v3: improve commit message

v2: rebased from 'maint' onto 'master'

 diff-lib.c | 10 ++--------
 revision.c |  6 ++++++
 revision.h |  1 +
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 50521e2093fc..5d5d3dafab33 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -405,14 +405,8 @@ static void do_oneway_diff(struct unpack_trees_options *o,
 	/* if the entry is not checked out, don't examine work tree */
 	cached = o->index_only ||
 		(idx && ((idx->ce_flags & CE_VALID) || ce_skip_worktree(idx)));
-	/*
-	 * Backward compatibility wart - "diff-index -m" does
-	 * not mean "do not ignore merges", but "match_missing".
-	 *
-	 * But with the revision flag parsing, that's found in
-	 * "!revs->ignore_merges".
-	 */
-	match_missing = !revs->ignore_merges;
+
+	match_missing = revs->match_missing;
 
 	if (cached && idx && ce_stage(idx)) {
 		struct diff_filepair *pair;
diff --git a/revision.c b/revision.c
index 96630e31867d..73e3d14cc165 100644
--- a/revision.c
+++ b/revision.c
@@ -2344,7 +2344,13 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->diffopt.flags.recursive = 1;
 		revs->diffopt.flags.tree_in_recursive = 1;
 	} else if (!strcmp(arg, "-m")) {
+		/*
+		 * To "diff-index", "-m" means "match missing", and to the "log"
+		 * family of commands, it means "show full diff for merges". Set
+		 * both fields appropriately.
+		 */
 		revs->ignore_merges = 0;
+		revs->match_missing = 1;
 	} else if ((argcount = parse_long_opt("diff-merges", argv, &optarg))) {
 		if (!strcmp(optarg, "off")) {
 			revs->ignore_merges = 1;
diff --git a/revision.h b/revision.h
index c1e5bcf139d7..f6bf860d19e5 100644
--- a/revision.h
+++ b/revision.h
@@ -188,6 +188,7 @@ struct rev_info {
 	unsigned int	diff:1,
 			full_diff:1,
 			show_root_diff:1,
+			match_missing:1,
 			no_commit_id:1,
 			verbose_header:1,
 			combine_merges:1,
-- 
2.25.1

