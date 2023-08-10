Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89D5C001DE
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 21:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjHJVRP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 17:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjHJVRF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 17:17:05 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB23F2D40
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:17:04 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe1a17f983so11828655e9.3
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691702223; x=1692307023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1Xj5UebKAlbiXHIurjVUfY3O8Y0z5fQmFB76s4cJKw=;
        b=qtn2apozDUS6oYmL5ekLwJv0aOP7ZkdWk5i3Iz69QacGlnjgHAEXXOY6uc6kVAKJWh
         sSFaU2bKhaGd5fSGaQ1emOB+qhv6b6CysxbZ05/5FSi9cNzZx3Cv+Dc5hEF9sKn0hVgv
         XTGJwp1D51ak6YP9UGZzPx6H0jvSRvWPrqZqLEHbdXvnDt466hLPwbXclqxA+JgkZ/bw
         Gg78OAdimlPA9D4C0oiVssM7Df6+7WOhOUWd3gf8ilizCvpoBFcp5ZwHnjoU9U036hLi
         Y/Cq+bIvSs9PJie5fmKAynObuesjBHbBGLmAR/U7cStn9R747BtVe5Hqw6gkeW0D2HhP
         Uvkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691702223; x=1692307023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s1Xj5UebKAlbiXHIurjVUfY3O8Y0z5fQmFB76s4cJKw=;
        b=WFoTBJPzp5lxsmki8G0heDYUcyP7pLJBcDwnF7798WxcuEt9747fT1tdh5TTrqRROJ
         UepRacenL5jlS7NwpNhrPIvvKBQ6GXMIrTT/pSIm4OFfghrI3pPtlMYI6rtEw4XbKMcb
         vTicG5/NmCnoL5amCEkfSsGKdvI6dyV1wkvV24ZGC1oFeR8l6c9Llj4Vf6YDXOywcq2u
         WYQj1OZPwIFiNqBwTo2VTIoxfYLIUVWHXhzcrXn9jumRza33LyYmH8UoAUTO8Plc3vDN
         kICJpQlJ71RlDYEOp+ZjPOChsfogPwxqefhTSR36TPcO80lbckpEc3V3ZAnDh8yetaBh
         0NxQ==
X-Gm-Message-State: AOJu0YyNrfbs5/t8FhgIFAWmBVRibQR6igXrK3+IyJM/bRIAWCSs3gDQ
        cX4sdD3jxDWGgZGq4qocPOwXqpkXhwSmOg==
X-Google-Smtp-Source: AGHT+IGllt1ljQXdEGpz9PLL36Cbc8o6801RwB9zS27kCJcqIU/o0NC6txyjW3zTfnCAQgp+HvjbXg==
X-Received: by 2002:a1c:4c14:0:b0:3fe:18a3:b3c with SMTP id z20-20020a1c4c14000000b003fe18a30b3cmr62504wmf.12.1691702222975;
        Thu, 10 Aug 2023 14:17:02 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id 19-20020a05600c229300b003fe24da493dsm3169864wmf.41.2023.08.10.14.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 14:17:02 -0700 (PDT)
From:   Andy Koppe <andy.koppe@gmail.com>
To:     git@vger.kernel.org
Cc:     Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v3 5/7] decorate: color each token separately
Date:   Thu, 10 Aug 2023 22:16:17 +0100
Message-ID: <20230810211619.19055-5-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.0-rc1
In-Reply-To: <20230810211619.19055-1-andy.koppe@gmail.com>
References: <20230715160730.4046-1-andy.koppe@gmail.com>
 <20230810211619.19055-1-andy.koppe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wrap "tag:" prefixes and the arrows in "HEAD -> branch" annotations in
their own color sequences, because otherwise tag names or arrows can end
up uncolored when %w width formatting breaks lines just before them.

Use the commit color for arrows, for visual consistency with the '(',
',' and ')' symbols used as prefix, separator and suffix, which are also
colored with the commit color.

Amend test t4207-log-decoration-colors.sh accordingly.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 log-tree.c                       | 14 +++++++---
 t/t4207-log-decoration-colors.sh | 44 ++++++++++++++++++--------------
 2 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 7c6d3f1ac3..3b62dca048 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -342,26 +342,34 @@ void format_decorations(struct strbuf *sb,
 		 * appeared, skipping the entry for current.
 		 */
 		if (decoration != current_and_HEAD) {
+			const char *color =
+				decorate_get_color(use_color, decoration->type);
+
 			if (*prefix) {
 				strbuf_addstr(sb, color_commit);
 				strbuf_addstr(sb, prefix);
 				strbuf_addstr(sb, color_reset);
 			}
 
-			strbuf_addstr(sb, decorate_get_color(use_color, decoration->type));
-			if (decoration->type == DECORATION_REF_TAG)
+			if (decoration->type == DECORATION_REF_TAG) {
+				strbuf_addstr(sb, color);
 				strbuf_addstr(sb, "tag: ");
+				strbuf_addstr(sb, color_reset);
+			}
 
+			strbuf_addstr(sb, color);
 			show_name(sb, decoration);
+			strbuf_addstr(sb, color_reset);
 
 			if (current_and_HEAD &&
 			    decoration->type == DECORATION_REF_HEAD) {
+				strbuf_addstr(sb, color_commit);
 				strbuf_addstr(sb, " -> ");
 				strbuf_addstr(sb, color_reset);
 				strbuf_addstr(sb, decorate_get_color(use_color, current_and_HEAD->type));
 				show_name(sb, current_and_HEAD);
+				strbuf_addstr(sb, color_reset);
 			}
-			strbuf_addstr(sb, color_reset);
 
 			prefix = separator;
 		}
diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colors.sh
index ded33a82e2..21986a866d 100755
--- a/t/t4207-log-decoration-colors.sh
+++ b/t/t4207-log-decoration-colors.sh
@@ -53,15 +53,17 @@ cmp_filtered_decorations () {
 # to this test since it does not contain any decoration, hence --first-parent
 test_expect_success 'commit decorations colored correctly' '
 	cat >expect <<-EOF &&
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD -> \
-${c_reset}${c_branch}main${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: v1.0${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: B${c_reset}${c_commit})${c_reset} B
-${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A1${c_reset}${c_commit}, \
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD${c_reset}\
+${c_commit} -> ${c_reset}${c_branch}main${c_reset}${c_commit}, \
+${c_reset}${c_tag}tag: ${c_reset}${c_tag}v1.0${c_reset}${c_commit}, \
+${c_reset}${c_tag}tag: ${c_reset}${c_tag}B${c_reset}${c_commit})${c_reset} B
+${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}A1${c_reset}${c_commit}, \
 ${c_reset}${c_remoteBranch}other/main${c_reset}${c_commit})${c_reset} A1
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_stash}refs/stash${c_reset}${c_commit})${c_reset} \
-On main: Changes to A.t
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A${c_reset}${c_commit})${c_reset} A
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
+${c_stash}refs/stash${c_reset}${c_commit})${c_reset} On main: Changes to A.t
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_commit})${c_reset} A
 	EOF
 
 	git log --first-parent --no-abbrev --decorate --oneline --color=always --all >actual &&
@@ -76,12 +78,14 @@ test_expect_success 'test coloring with replace-objects' '
 	git replace HEAD~1 HEAD~2 &&
 
 	cat >expect <<-EOF &&
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD -> \
-${c_reset}${c_branch}main${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: D${c_reset}${c_commit})${c_reset} D
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: C${c_reset}${c_commit}, \
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD${c_reset}\
+${c_commit} -> ${c_reset}${c_branch}main${c_reset}${c_commit}, \
+${c_reset}${c_tag}tag: ${c_reset}${c_tag}D${c_reset}${c_commit})${c_reset} D
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}C${c_reset}${c_commit}, \
 ${c_reset}${c_grafted}replaced${c_reset}${c_commit})${c_reset} B
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A${c_reset}${c_commit})${c_reset} A
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_commit})${c_reset} A
 EOF
 
 	git log --first-parent --no-abbrev --decorate --oneline --color=always HEAD >actual &&
@@ -100,13 +104,15 @@ test_expect_success 'test coloring with grafted commit' '
 	git replace --graft HEAD HEAD~2 &&
 
 	cat >expect <<-EOF &&
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD -> \
-${c_reset}${c_branch}main${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: D${c_reset}${c_commit}, \
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD${c_reset}\
+${c_commit} -> ${c_reset}${c_branch}main${c_reset}${c_commit}, \
+${c_reset}${c_tag}tag: ${c_reset}${c_tag}D${c_reset}${c_commit}, \
 ${c_reset}${c_grafted}replaced${c_reset}${c_commit})${c_reset} D
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: v1.0${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: B${c_reset}${c_commit})${c_reset} B
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A${c_reset}${c_commit})${c_reset} A
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}v1.0${c_reset}${c_commit}, \
+${c_reset}${c_tag}tag: ${c_reset}${c_tag}B${c_reset}${c_commit})${c_reset} B
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_commit})${c_reset} A
 	EOF
 
 	git log --first-parent --no-abbrev --decorate --oneline --color=always HEAD >actual &&
-- 
2.42.0-rc1

