Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2405AC55186
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 13:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EECE320728
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 13:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4MgLJ/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgDWNsH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 09:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728339AbgDWNsG (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 23 Apr 2020 09:48:06 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0EBC08ED7D
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 06:48:06 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o10so2910818pgb.6
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 06:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pzkZCe5uYKk6rhdDUMXrg2Ostg9Jn3aYVIdQ6giVSrA=;
        b=c4MgLJ/6JiCP9mQ+ftlkYNFxBbVOUXRYqNdv0DHtkbPeTogJBSYzqDPKIcum8utwWb
         XmWzEh0KIARgfBnUbi/49hJRH7FoCjdsJLsvKq/J5dDBNXt1kgOPjiBb2EoOurBkxs7Q
         hW28Vq52Zz274ZL7VlvuwqBaDjfpE7pU4nZr61XDheaVBgAEWwsEIMGhrGP4qdZWLjH7
         7p9qULyMTC3bguNHlEjfkfDMhPc5fhau9T6GiyfJVWoAxzR5hpLuCYMiJ9RhtXQcWEWr
         IPy3HN7fEj/sVFm9MeCTovydH2TrdQ539U+uSTtz/7E4SzmHxr9Y14nSx3wtrf36PfeD
         AaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pzkZCe5uYKk6rhdDUMXrg2Ostg9Jn3aYVIdQ6giVSrA=;
        b=OKNuDF6ZIMk6JxB5hc/7cJ4PLd4bXrftgfwrXfVEmy31ykVaOOLMwxZS3QSnJ1ZcoL
         7sccoyaC9x2ImyRuhia4pQDUdF27SHA0RxmfNGocoNWtfYhZeHKpoG/3+3hxKa4ysTGP
         6MsB5eYf6Hm/OB8IXQRCwGPlgd/9sKRxRVRdBskVdZ77mZ/2jl7BbFMLa9UMWE5DuI0s
         0EJUrUvuc6kIAcaoXa9CoC9uKTRiFJTWMzrY4RcfTTN3E0vpKne6msLaiK5Nhw7iQqsJ
         /kEte3TSKn4c59oWFGP1j7MlTRfApNIftOjLnpD+EqAdWsWXg9vcV8DvpIrPoHMGFB4E
         8l1g==
X-Gm-Message-State: AGi0PuZF3Qpq5xQLQo3j9CCuV3kZdxHmAoApQzw4e+7Yt3PqK8kqFpD3
        LL5mypgOS/08gl5a/QoXCmNwjtJM
X-Google-Smtp-Source: APiQypKHoQrvCQ+YLZBC2xpgf1jrCNL39F2yNwJ6cC9s7s+CNU2NMbSyeM5XF0OPUsxyUnSpYteYsQ==
X-Received: by 2002:a63:ba09:: with SMTP id k9mr4235442pgf.305.1587649685937;
        Thu, 23 Apr 2020 06:48:05 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id z23sm2635958pfr.136.2020.04.23.06.48.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 06:48:05 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 1/4] C: s/0/NULL/ for pointer type
Date:   Thu, 23 Apr 2020 20:47:53 +0700
Message-Id: <c4fac2ae9d10bc426cb26e4a102b808549696763.1587648870.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.2.384.g435bf60bd5
In-Reply-To: <cover.1587648870.git.congdanhqx@gmail.com>
References: <cover.1587648870.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix warning from  `make sparse`.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 add-interactive.c                   | 2 +-
 builtin/fmt-merge-msg.c             | 2 +-
 log-tree.c                          | 4 ++--
 range-diff.c                        | 2 +-
 t/helper/test-parse-pathspec-file.c | 6 +++---
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 29cd2fe020..b8983838b9 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -526,7 +526,7 @@ static int get_modified_files(struct repository *r,
 
 	for (i = 0; i < 2; i++) {
 		struct rev_info rev;
-		struct setup_revision_opt opt = { 0 };
+		struct setup_revision_opt opt = { NULL };
 
 		if (filter == INDEX_ONLY)
 			s.mode = (i == 0) ? FROM_INDEX : FROM_WORKTREE;
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 172dfbd852..f4376bccef 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -494,7 +494,7 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 		enum object_type type;
 		unsigned long size, len;
 		char *buf = read_object_file(oid, &type, &size);
-		struct signature_check sigc = { 0 };
+		struct signature_check sigc = { NULL };
 		struct strbuf sig = STRBUF_INIT;
 
 		if (!buf || type != OBJ_TAG)
diff --git a/log-tree.c b/log-tree.c
index 0064788b25..ca721150d4 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -449,7 +449,7 @@ static void show_signature(struct rev_info *opt, struct commit *commit)
 {
 	struct strbuf payload = STRBUF_INIT;
 	struct strbuf signature = STRBUF_INIT;
-	struct signature_check sigc = { 0 };
+	struct signature_check sigc = { NULL };
 	int status;
 
 	if (parse_signed_commit(commit, &payload, &signature) <= 0)
@@ -496,7 +496,7 @@ static int show_one_mergetag(struct commit *commit,
 	struct object_id oid;
 	struct tag *tag;
 	struct strbuf verify_message;
-	struct signature_check sigc = { 0 };
+	struct signature_check sigc = { NULL };
 	int status, nth;
 	size_t payload_size;
 
diff --git a/range-diff.c b/range-diff.c
index f745567cf6..71dcd947c5 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -107,7 +107,7 @@ static int read_patches(const char *range, struct string_list *list,
 		}
 
 		if (starts_with(line, "diff --git")) {
-			struct patch patch = { 0 };
+			struct patch patch = { NULL };
 			struct strbuf root = STRBUF_INIT;
 			int linenr = 0;
 
diff --git a/t/helper/test-parse-pathspec-file.c b/t/helper/test-parse-pathspec-file.c
index 02f4ccfd2a..b3e08cef4b 100644
--- a/t/helper/test-parse-pathspec-file.c
+++ b/t/helper/test-parse-pathspec-file.c
@@ -6,7 +6,7 @@
 int cmd__parse_pathspec_file(int argc, const char **argv)
 {
 	struct pathspec pathspec;
-	const char *pathspec_from_file = 0;
+	const char *pathspec_from_file = NULL;
 	int pathspec_file_nul = 0, i;
 
 	static const char *const usage[] = {
@@ -20,9 +20,9 @@ int cmd__parse_pathspec_file(int argc, const char **argv)
 		OPT_END()
 	};
 
-	parse_options(argc, argv, 0, options, usage, 0);
+	parse_options(argc, argv, NULL, options, usage, 0);
 
-	parse_pathspec_file(&pathspec, 0, 0, 0, pathspec_from_file,
+	parse_pathspec_file(&pathspec, 0, 0, NULL, pathspec_from_file,
 			    pathspec_file_nul);
 
 	for (i = 0; i < pathspec.nr; i++)
-- 
2.26.2.384.g435bf60bd5

