Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4E9C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 01:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D173B613D0
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 01:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351509AbhJABju (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 21:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351469AbhJABjr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 21:39:47 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADB4C06176C
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 18:38:03 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so2327834pjb.0
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 18:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KMrW3T+dNX1hA1iYAScQawmJ+PNR0g4QQpf8KJmIOrM=;
        b=UNw/3EBJcpb5bZTCBYXTeNy8H+P3WFptXmiye73zrW2l+5CAXNK+kWF9SjYBHQETjA
         Iy8FlAVItXO0t5SH43rpyUoR+vHHUhPiI4qWI1b3NnXMxbhIkyvjXSgpoUSD3iMgJDCR
         TTRBj/HwuAIMUGIxhIYiUMcmhkXFOf5HpugzjxAMkGMPCajOAEPwrviX4RmI4vqisIN2
         FVR67U/5IxRC4fgviVcHygT/Z1K2HjdKktKjg0zoDRnXMNP9zoMWzun6PTdC4VijvRRg
         lVDmH1Kplv9K9ki36NpVPXFaE74tpWhPtOj8WjTHAXo7Ycuy1Uomuve/qJTj6HvvTxS6
         i/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KMrW3T+dNX1hA1iYAScQawmJ+PNR0g4QQpf8KJmIOrM=;
        b=hFN2S16otDGaRiUkdgLQGAEpbbH67tLifryanxGCQa3llLR0XyZP6xwKAlZkEwrg6Y
         NQ2Es6Y0byXrHiLj2c76R2/CZnj2gTY8ZYwCqzkEN0xWD/tjmmyGBIyKrQGxxWUirz9P
         W3hnrDm+vpy3q+tELb/VacUhsAvPiGR67ZGoM4Lh8TN6xzAeLv6tWvxYmImQYiNxdN8s
         qo1vszI5ubDeFUvi2rSDWT440Npi2Qd3moXTLUTuAe7QuLCFlJwvvYoaKzxJviLBn5uk
         O482tHBApU1Up+MGpzOfoMvyEf5ln5I4TIezWxz4gxK6Y60hg6zRweEeUV9SjQIEN2D6
         cLYg==
X-Gm-Message-State: AOAM530ic0bT2sGb1l7XMxFm1+YoZpvn1ltWuXQzaZTBwTib1tZOrTkv
        BcJGBRQ2buoJqacNfF1rOb9XmnS+E3w=
X-Google-Smtp-Source: ABdhPJwzlbriR2ftX0Bb478veXBqwmGj6HSTr5njZ7KyUYYBZSqUfc2i2u8E57EKbjdorRz2hQFemg==
X-Received: by 2002:a17:902:c408:b0:13d:c6ef:7cf3 with SMTP id k8-20020a170902c40800b0013dc6ef7cf3mr6957113plk.86.1633052283113;
        Thu, 30 Sep 2021 18:38:03 -0700 (PDT)
Received: from sarawiggum.fas.fa.disney.com ([198.187.190.10])
        by smtp.gmail.com with ESMTPSA id c25sm4268199pfn.159.2021.09.30.18.38.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Sep 2021 18:38:02 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v7 2/4] difftool: refactor dir-diff to write files using helper functions
Date:   Thu, 30 Sep 2021 18:37:54 -0700
Message-Id: <20211001013756.37586-3-davvid@gmail.com>
X-Mailer: git-send-email 2.33.0.886.g5b6dfe5e5c
In-Reply-To: <20211001013756.37586-1-davvid@gmail.com>
References: <20211001013756.37586-1-davvid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a helpers function to handle the unlinking and writing
of the dir-diff submodule and symlink stand-in files.

Use the helpers to implement the guts of the hashmap loops.
This eliminate duplicate code and safeguards the submodules
hashmap loop against the symlink-chasing behavior that 5bafb3576a
(difftool: fix symlink-file writing in dir-diff mode, 2021-09-22)
addressed.

The submodules loop should not strictly require the unlink() call that
this is introducing to them, but it does not necessarily hurt them
either beyond the cost of the extra unlink().

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 builtin/difftool.c | 50 ++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 0e24421682..f3cd1e5b53 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -320,6 +320,31 @@ static int checkout_path(unsigned mode, struct object_id *oid,
 	return ret;
 }
 
+static void write_file_in_directory(struct strbuf *dir, size_t dir_len,
+			const char *path, const char *content)
+{
+	add_path(dir, dir_len, path);
+	ensure_leading_directories(dir->buf);
+	unlink(dir->buf);
+	write_file(dir->buf, "%s", content);
+}
+
+/* Write the file contents for the left and right sides of the difftool
+ * dir-diff representation for submodules and symlinks. Symlinks and submodules
+ * are written as regular text files so that external diff tools can diff them
+ * as text files, resulting in behavior that is analogous to to what "git diff"
+ * displays for symlink and submodule diffs.
+ */
+static void write_standin_files(struct pair_entry *entry,
+			struct strbuf *ldir, size_t ldir_len,
+			struct strbuf *rdir, size_t rdir_len)
+{
+	if (*entry->left)
+		write_file_in_directory(ldir, ldir_len, entry->path, entry->left);
+	if (*entry->right)
+		write_file_in_directory(rdir, rdir_len, entry->path, entry->right);
+}
+
 static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 			struct child_process *child)
 {
@@ -529,16 +554,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	 */
 	hashmap_for_each_entry(&submodules, &iter, entry,
 				entry /* member name */) {
-		if (*entry->left) {
-			add_path(&ldir, ldir_len, entry->path);
-			ensure_leading_directories(ldir.buf);
-			write_file(ldir.buf, "%s", entry->left);
-		}
-		if (*entry->right) {
-			add_path(&rdir, rdir_len, entry->path);
-			ensure_leading_directories(rdir.buf);
-			write_file(rdir.buf, "%s", entry->right);
-		}
+		write_standin_files(entry, &ldir, ldir_len, &rdir, rdir_len);
 	}
 
 	/*
@@ -548,18 +564,8 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	 */
 	hashmap_for_each_entry(&symlinks2, &iter, entry,
 				entry /* member name */) {
-		if (*entry->left) {
-			add_path(&ldir, ldir_len, entry->path);
-			ensure_leading_directories(ldir.buf);
-			unlink(ldir.buf);
-			write_file(ldir.buf, "%s", entry->left);
-		}
-		if (*entry->right) {
-			add_path(&rdir, rdir_len, entry->path);
-			ensure_leading_directories(rdir.buf);
-			unlink(rdir.buf);
-			write_file(rdir.buf, "%s", entry->right);
-		}
+
+		write_standin_files(entry, &ldir, ldir_len, &rdir, rdir_len);
 	}
 
 	strbuf_release(&buf);
-- 
2.33.0.886.g5b6dfe5e5c

