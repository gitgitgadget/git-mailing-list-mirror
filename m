Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9339EE4996
	for <git@archiver.kernel.org>; Sun, 20 Aug 2023 18:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjHTS4E (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Aug 2023 14:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjHTSz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2023 14:55:59 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B242EE
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 11:50:57 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fee51329feso7029225e9.0
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 11:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692557456; x=1693162256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7XFeevufjAjcE2XkTtR0tFM7aOlYpNqLsPQ1W9Wbzs=;
        b=WEPn/dI/imrvm8s78VpFdxRVTtUQZfF17aJrxknxQHSoYg80W07usvrCJUNLgK0u0R
         nP4+I98/ljdZNI8x/tjRxQiA1HcBszuMV0PL5hJMFvmNjXBxAhpyJl/do3Q2StPbPtGA
         ATxc3Jt984jEM+k7zat5ohyCzcSMafvXt6EMI01P1zNnIjJHsfJDW0FSZScq2I1n84X/
         d6qh5ZYkdz9Ng+MNJFcBce06qpJpqCFV3JPwT6EdWrO+D5vHamUAmVMpDmBTGcioJVtG
         0CGR/yqEJf/89xpA4SQouG9/bZFUg0lglYfaIi8iAt9MqHrP+lZtAjw7Rfz5fb74IAQz
         qiag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692557456; x=1693162256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X7XFeevufjAjcE2XkTtR0tFM7aOlYpNqLsPQ1W9Wbzs=;
        b=WuWfch7cAZ96NWwUy9K/UrWO3joL0Kym7mi7FIz/9iGwYsS7eXtz4b6fqRFyxwdXQo
         DoO37so3XQV8lEKMndio/Nijahtim2oy60lqxH+A0APaqcNYe9VkgboZleGw3SzmwC4b
         aAbX9a6corL7QbmKV0c1NcDLyac2t6ScjLGx9zltEOZreIwaUpe9Sg4ZRCNYUNpVaPg6
         4hDt3cOGXlJNWD/EoatQ+1oHLqAbSwmK/OyWWFra56AyuJzpidftO6E3Hm55J5Yjzu7K
         2dNtbDKkoBqYQN3Ief7l0An2Qwz8KfVRrjA6JntnFVIG3K2GEoGeQUs194U5af1Q3wzw
         O8Gw==
X-Gm-Message-State: AOJu0YyLYV0pYl98nsK8FddEckizU98CwVYdntKaXIwWJmb1LdMKqaRl
        Pysr/8su0idnHOIOiNtqjxYY/AVe1f02niNO
X-Google-Smtp-Source: AGHT+IFBWLi18O7NWRkwEYHNweBnUo6VRuVJjszW4hBcGPoJbrlWoJftfF95+ibFUTihTBh+OJNG8g==
X-Received: by 2002:a7b:c38a:0:b0:3fe:215e:44a0 with SMTP id s10-20020a7bc38a000000b003fe215e44a0mr3630716wmj.18.1692557455744;
        Sun, 20 Aug 2023 11:50:55 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c021a00b003fa95f328afsm13603604wmi.29.2023.08.20.11.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 11:50:55 -0700 (PDT)
From:   Andy Koppe <andy.koppe@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, glencbz@gmail.com, phillip.wood123@gmail.com,
        Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v5 5/8] decorate: color each token separately
Date:   Sun, 20 Aug 2023 19:50:06 +0100
Message-ID: <20230820185009.20095-6-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.0-rc1
In-Reply-To: <20230820185009.20095-1-andy.koppe@gmail.com>
References: <20230820085336.8615-1-andy.koppe@gmail.com>
 <20230820185009.20095-1-andy.koppe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wrap "tag:" prefixes and the arrows in "HEAD -> branch" decorations in
their own color sequences. Otherwise, if --graph is used, tag names or
arrows can end up uncolored when %w width formatting breaks a line just
before them. This is because --graph resets the color after doing its
drawing at the start of a line.

Amend test t4207-log-decoration-colors.sh accordingly.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 log-tree.c                       | 14 +++++++---
 t/t4207-log-decoration-colors.sh | 44 ++++++++++++++++++--------------
 2 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 7c6d3f1ac3..44f4693567 100644
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
+				strbuf_addstr(sb, color);
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
index ded33a82e2..df804f38e2 100755
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
+${c_HEAD} -> ${c_reset}${c_branch}main${c_reset}${c_commit}, \
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
+${c_HEAD} -> ${c_reset}${c_branch}main${c_reset}${c_commit}, \
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
+${c_HEAD} -> ${c_reset}${c_branch}main${c_reset}${c_commit}, \
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
2.42.0-rc2

