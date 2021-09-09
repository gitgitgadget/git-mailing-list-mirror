Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFE1C433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 03:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8C1A61178
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 03:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350199AbhIID0j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 23:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348438AbhIID0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 23:26:25 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2B0C06129E
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 20:25:11 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id b10so511796ioq.9
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 20:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=aG4vFDRSstWIxGq9i2r2LsI+fZ6ttAvueBHHOcVtyLo=;
        b=xCFDLR1fImwxb7xnExiUGHv+B0TIUa5x95O13b76mijXdkp16dHs+9n1/DF41nhDPy
         wy+hX/qGXjON7YgByqh1IhikuEa+mC8g/FAGDQG2E9jDKogWwRW5qre1ktyh2QVl0erN
         n0ljuQUb5UxekeOFno79Xnl5lxBtDQZqyeNTAEPW67JYQjBopJprPp3e1V3sm2NyapqS
         /bl9ZC1KxRrmQFHWxwom9R2Gj0AI6Vjhj7gakyxzwmUrnsvwzQ50tEvjBFc77/fsbO2Y
         bUBsOKZCiEcbsFokveCzXx0hcT1Kh70EtmoDU96kZs6qjfyxRrIAZC39K+jbCwr/UAyD
         SJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=aG4vFDRSstWIxGq9i2r2LsI+fZ6ttAvueBHHOcVtyLo=;
        b=4pD+MkTaSWG0mMkXbaCjKn5DnlFVtQ/e7MpS+YgIjFbR75AXnAj3T8q+h6XB0n4ZUR
         BuNOUw56bTFHrcJxzVFHk3A1TPqUkWxrzIZHVwXE49G07yng5EE4bK/1FJoNOQxD9JdA
         Jis+rtBKePJaLjkSCyUH+HVkivPcsEcRUAlznJ7W0JT8XI4Tpi//JNRzRJpgMmYeLunD
         yzXhRy2EhFMpOnm/LG7vrGJUox9wKHMCNuce66A6QX6BDH761msuIfz7gIxlQjaWyIDn
         6b1NylnMxvoetrZMssJuM3QSa3T0H2wtdHrERhBQA/0IM+yfdvIgla1VkQmZiugImGM6
         gklQ==
X-Gm-Message-State: AOAM5307Z2LOktqGhEfqrhC4/zhFvlJ06hRIR1Wuu6DSOkOWh2J1hi6U
        RRHPcjydgfCSU8HofX3I5cn3cvRclwYGDCzf
X-Google-Smtp-Source: ABdhPJx77SbtsnyxAHYw+8GNK1SncYRsA+D95JVv9UhQxV0eo/dMAEnBEvtXOvSSHkOOy10R3+OtRQ==
X-Received: by 2002:a02:ad17:: with SMTP id s23mr841449jan.135.1631157910466;
        Wed, 08 Sep 2021 20:25:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p135sm305443iod.26.2021.09.08.20.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 20:25:10 -0700 (PDT)
Date:   Wed, 8 Sep 2021 23:25:09 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com
Subject: [PATCH 6/9] index-pack: refactor renaming in final()
Message-ID: <3c9b515907ecb632faf73ce8db83efed1493d1f1.1631157880.git.me@ttaylorr.com>
References: <cover.1630461918.git.me@ttaylorr.com>
 <cover.1631157880.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1631157880.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Refactor the renaming in final() into a helper function, this is
similar in spirit to a preceding refactoring of finish_tmp_packfile()
in pack-write.c.

Before e37d0b8730b (builtin/index-pack.c: write reverse indexes,
2021-01-25) it probably wasn't worth it to have this sort of helper,
due to the differing "else if" case for "pack" files v.s. "idx" files.

But since we've got "rev" as well now, let's do the renaming via a
helper, this is both a net decrease in lines, and improves the
readability, since we can easily see at a glance that the logic for
writing these three types of files is exactly the same, aside from the
obviously differing cases of "*final_xyz_name" being NULL, and
"else_chmod_if" being different.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/index-pack.c | 48 +++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 6cc4890217..cd4e85f5bb 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1477,6 +1477,22 @@ static void write_special_file(const char *suffix, const char *msg,
 	strbuf_release(&name_buf);
 }
 
+static void rename_tmp_packfile(const char **final_xyz_name,
+				const char *curr_xyz_name,
+				struct strbuf *xyz_name, unsigned char *hash,
+				const char *ext, int else_chmod_if)
+{
+	if (*final_xyz_name != curr_xyz_name) {
+		if (!*final_xyz_name)
+			*final_xyz_name = odb_pack_name(xyz_name, hash, ext);
+		if (finalize_object_file(curr_xyz_name, *final_xyz_name))
+			die(_("unable to rename temporary '*.%s' file to '%s"),
+			    ext, *final_xyz_name);
+	} else if (else_chmod_if) {
+		chmod(*final_xyz_name, 0444);
+	}
+}
+
 static void final(const char *final_pack_name, const char *curr_pack_name,
 		  const char *final_index_name, const char *curr_index_name,
 		  const char *final_rev_index_name, const char *curr_rev_index_name,
@@ -1505,31 +1521,13 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 		write_special_file("promisor", promisor_msg, final_pack_name,
 				   hash, NULL);
 
-	if (final_pack_name != curr_pack_name) {
-		if (!final_pack_name)
-			final_pack_name = odb_pack_name(&pack_name, hash, "pack");
-		if (finalize_object_file(curr_pack_name, final_pack_name))
-			die(_("cannot store pack file"));
-	} else if (from_stdin)
-		chmod(final_pack_name, 0444);
-
-	if (final_index_name != curr_index_name) {
-		if (!final_index_name)
-			final_index_name = odb_pack_name(&index_name, hash, "idx");
-		if (finalize_object_file(curr_index_name, final_index_name))
-			die(_("cannot store index file"));
-	} else
-		chmod(final_index_name, 0444);
-
-	if (curr_rev_index_name) {
-		if (final_rev_index_name != curr_rev_index_name) {
-			if (!final_rev_index_name)
-				final_rev_index_name = odb_pack_name(&rev_index_name, hash, "rev");
-			if (finalize_object_file(curr_rev_index_name, final_rev_index_name))
-				die(_("cannot store reverse index file"));
-		} else
-			chmod(final_rev_index_name, 0444);
-	}
+	rename_tmp_packfile(&final_pack_name, curr_pack_name, &pack_name,
+			    hash, "pack", from_stdin);
+	rename_tmp_packfile(&final_index_name, curr_index_name, &index_name,
+			    hash, "idx", 1);
+	if (curr_rev_index_name)
+		rename_tmp_packfile(&final_rev_index_name, curr_rev_index_name,
+				    &rev_index_name, hash, "rev", 1);
 
 	if (do_fsck_object) {
 		struct packed_git *p;
-- 
2.33.0.96.g73915697e6

