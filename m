Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7733BC433E2
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 07:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47B3921D46
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 07:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lckjjyTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgIHHRY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 03:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbgIHHRV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 03:17:21 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E03EC061573
        for <git@vger.kernel.org>; Tue,  8 Sep 2020 00:17:21 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id u126so15942971iod.12
        for <git@vger.kernel.org>; Tue, 08 Sep 2020 00:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BP2KcdJQOQUmLEdlu7UuJOrfrCv9wj1GL9Hf5Hcgfsk=;
        b=lckjjyTpHy/BJ1s2ySw/LCXAwPbsIaprK9KU0a5IIcD9RmPh9TIf3vMpJVvAa/VXpP
         uTApDL2OQALflWUJuj12PM5en8OyMn2G8tSCgz0cXjcqFTdTkLJxNpuXyKxizsjEDUjC
         PgfCpl8mcRDSQOq1i4oK1WtUGl7kmQwIzArTDoWgg4tdKz3kWzbDgbpI2mOb8utWbgGR
         6YWoODxEGZKdKGoBFVM/7oPPtgyLnDGOrpnQqHxAPd5hEZ6E/MoJyywqjICjl9H2WNbD
         8vTVMGecZdShyaQ+4MB1aQBMd2ddJvZzo2Yr2NSN9i5uwDUlTobmgQfIxlZwai1MTHD9
         KyTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=BP2KcdJQOQUmLEdlu7UuJOrfrCv9wj1GL9Hf5Hcgfsk=;
        b=uJdFQqwLCga4pPqOcilUPadqEYda0431AR8JQNfl13xJhzqgVPCTgHGGH/zn14HuPy
         MVERQCfj9IBwVHYDWpTUtNqDitMVhAU5Yu4xbT+4MOdKfSifbm4s0MMwc4Aaku1V6PsL
         iM70fpeS3xdxE6Btv6OjKGtFFAENghN7Pw1AmZRttTgUswC+9qo0ZyLZtLKCOlukY+KG
         mT7mYcOz/ElfMj6adjwqAtMCgmoMqoIKTcU6VAgKmCAoef0pHmhKPdnjTHuB1pSsqGyY
         73ZUwCrAWJlkbD/pFXUyT/Ls17xAeiTjOM7vXbu2YhlDy56TEkeQ6+Z4aLl1BY08pcWv
         sQag==
X-Gm-Message-State: AOAM531VRCzT5Z6mJRs8mPtJndWmtFXziWqzjDqWeUkj9i0AZEPHFEH2
        YPzsifYjJsXKfyoTEE9b8jiqvcHDKis=
X-Google-Smtp-Source: ABdhPJzwE2QH39lt4/6dYLKiYq6J+S3rOJ+m4Iv/bBOGLsiEOOMaj+eb0/p/f1WVcKidXmbRgpPBsQ==
X-Received: by 2002:a05:6602:1602:: with SMTP id x2mr5248249iow.22.1599549440335;
        Tue, 08 Sep 2020 00:17:20 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id m18sm9587778iln.80.2020.09.08.00.17.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2020 00:17:19 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/3] diff-lib: tighten show_interdiff()'s interface
Date:   Tue,  8 Sep 2020 03:16:09 -0400
Message-Id: <20200908071610.16714-3-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7
In-Reply-To: <20200908071610.16714-1-sunshine@sunshineco.com>
References: <20200908071610.16714-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To compute and show an interdiff, show_interdiff() needs only the two
OID's to compare and a diffopts, yet it expects callers to supply an
entire rev_info. The demand for rev_info is not only overkill, but also
places unnecessary burden on potential future callers which might not
otherwise have a rev_info at hand. Address this by tightening its
signature to require only the items it needs instead of a full rev_info.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Notes:
    Suggested by Sunshine[1] during review.
    
    [1]: https://lore.kernel.org/git/CAPig+cSuYUYSPTuKx08wcmQM-G12_-W2T4BS07fA=6grM1b8Gw@mail.gmail.com/

 builtin/log.c | 3 ++-
 diff-lib.c    | 7 ++++---
 diff.h        | 7 ++++++-
 log-tree.c    | 3 ++-
 4 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index ae9380da1b..37177b3e7f 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1206,7 +1206,8 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 
 	if (rev->idiff_oid1) {
 		fprintf_ln(rev->diffopt.file, "%s", rev->idiff_title);
-		show_interdiff(rev, 0);
+		show_interdiff(rev->idiff_oid1, rev->idiff_oid2, 0,
+			       &rev->diffopt);
 	}
 
 	if (rev->rdiff1) {
diff --git a/diff-lib.c b/diff-lib.c
index 9bab907412..a17becc509 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -577,19 +577,20 @@ static struct strbuf *idiff_prefix_cb(struct diff_options *opt, void *data)
 	return data;
 }
 
-void show_interdiff(struct rev_info *rev, int indent)
+void show_interdiff(const struct object_id *oid1, const struct object_id *oid2,
+		    int indent, struct diff_options *diffopt)
 {
 	struct diff_options opts;
 	struct strbuf prefix = STRBUF_INIT;
 
-	memcpy(&opts, &rev->diffopt, sizeof(opts));
+	memcpy(&opts, diffopt, sizeof(opts));
 	opts.output_format = DIFF_FORMAT_PATCH;
 	opts.output_prefix = idiff_prefix_cb;
 	strbuf_addchars(&prefix, ' ', indent);
 	opts.output_prefix_data = &prefix;
 	diff_setup_done(&opts);
 
-	diff_tree_oid(rev->idiff_oid1, rev->idiff_oid2, "", &opts);
+	diff_tree_oid(oid1, oid2, "", &opts);
 	diffcore_std(&opts);
 	diff_flush(&opts);
 
diff --git a/diff.h b/diff.h
index 308937c94b..49242d2733 100644
--- a/diff.h
+++ b/diff.h
@@ -600,7 +600,12 @@ int index_differs_from(struct repository *r, const char *def,
 		       const struct diff_flags *flags,
 		       int ita_invisible_in_index);
 
-void show_interdiff(struct rev_info *, int indent);
+/*
+ * Emit an interdiff of two object ID's to 'diff_options.file' optionally
+ * indented by 'indent' spaces.
+ */
+void show_interdiff(const struct object_id *, const struct object_id *,
+		    int indent, struct diff_options *);
 
 /*
  * Fill the contents of the filespec "df", respecting any textconv defined by
diff --git a/log-tree.c b/log-tree.c
index 39bb362d5e..ad1e7e31f8 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -799,7 +799,8 @@ void show_log(struct rev_info *opt)
 
 		next_commentary_block(opt, NULL);
 		fprintf_ln(opt->diffopt.file, "%s", opt->idiff_title);
-		show_interdiff(opt, 2);
+		show_interdiff(opt->idiff_oid1, opt->idiff_oid2, 2,
+			       &opt->diffopt);
 
 		memcpy(&diff_queued_diff, &dq, sizeof(diff_queued_diff));
 	}
-- 
2.28.0.618.gf4bc123cb7

