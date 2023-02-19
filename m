Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15838C05027
	for <git@archiver.kernel.org>; Sun, 19 Feb 2023 17:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjBSRuw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Feb 2023 12:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjBSRuu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2023 12:50:50 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285601351A
        for <git@vger.kernel.org>; Sun, 19 Feb 2023 09:50:49 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id i5-20020a05600c354500b003e1f5f2a29cso760961wmq.4
        for <git@vger.kernel.org>; Sun, 19 Feb 2023 09:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BMPliqJtRgbFhn01sbL/LMH+fP3bPfX0mETjx0mnirw=;
        b=mvNCziLn1NClbZDIZ0/4QFAuppYeIJmAz18VNtye6a5UX1HX1JzudG9FUzOiXZABjr
         8vz7BbWYso+VnL+Id3o6788a89efbMJQ88Yf+6NvVu+Xj0lrB+JH6bwIR5YtEX/pE/sp
         kMMItskoCPK5ydFYRdzXcbJ3IkMHk4rQc+rfAkCixKf167/p92RLWgNOsA3S0XSOi8cQ
         IQpietgTw+1aEHQ/zvIFJTmTQxmr4BsFUkgR3qZcMUA31H5JvUcWm2PwCu1apphYJ+3s
         sMJyd4juBe/0PWFm60PglapyLpPu4DlJWCYjy1/HPJFQhqFp5J8Dtvk2jeqHTqAAun7Q
         lfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BMPliqJtRgbFhn01sbL/LMH+fP3bPfX0mETjx0mnirw=;
        b=fNZQJjKjbttO6x3ePvpJhR69vxjMl3KDx/mC4a25ndxu226dqixPTPxsdw2WRliSUr
         jRUi2oqNYZ4LEgph+Kj1BNnBmK2biGbMG+XXYDdacCvwSFUAG40IM4hWO63TES6dkU0V
         2+uXcbQBz1vaVbFhqH9L5iyeR/vUyqY9ELEBHxduurHPuLPxLZ7Q40XszfmOm5YKzbvY
         a1sbQSsjHARbPVoKhfl1hHqulxF4cov9UwNs/2ib26anzvI2/mJPqT9whwwvhRqJ0JMF
         vdaunhHns3kyayn15rOh+iTHlOo06vz8IVeHrbjpW8rtx7wJchmMGsGY3ZhBVIUvbXo5
         7hbA==
X-Gm-Message-State: AO0yUKXAOnk3zCd7c10CoabXjXVSrBHVgjzaEFe/9KqKaii4VMkyRBLL
        Y9hbMlSI39TbYJeqvIFlMEXcVIrbutI=
X-Google-Smtp-Source: AK7set+F1Tvd6oiVJBYqdW4A0ZUU7XJkLkfT8NnVzSkSfqIdIKOjHS1PkgHbxJZuGlHqTWRYhJ59Pw==
X-Received: by 2002:a05:600c:4da3:b0:3e2:19b0:887d with SMTP id v35-20020a05600c4da300b003e219b0887dmr8528277wmp.25.1676829047527;
        Sun, 19 Feb 2023 09:50:47 -0800 (PST)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id l37-20020a05600c1d2500b003db0ad636d1sm9126159wms.28.2023.02.19.09.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 09:50:47 -0800 (PST)
From:   Andy Koppe <andy.koppe@gmail.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH] log: omit tag prefix for color decoration
Date:   Sun, 19 Feb 2023 17:46:30 +0000
Message-Id: <20230219174631.1040-1-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Omit the "tag: " prefix for tags in commit decorations when coloring is
enabled. The prefix isn't necessary as such when tags are distinguished
by color already, and omitting it saves a bit of space and visual noise.

It also avoids a problem: when the %d or %D placeholders are used while
a %w wrapping specifier is in force in a format string, lines can be
broken between the prefix and the tag name. In that case, the prefix
gets colored correctly, but the tag name gets the default color instead.

Also remove the tag prefix from test t4207 for color decorations, and
add --no-color to a test t6002 check of the output of rev-list --bisect
that expects tag prefixes to be present.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---

CI run: https://github.com/ak2/git/actions/runs/4211957381

 log-tree.c                       |  3 ++-
 t/t4207-log-decoration-colors.sh | 22 +++++++++++-----------
 t/t6002-rev-list-bisect.sh       |  2 +-
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 1dd5fcbf7b..64ea15e0a0 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -324,7 +324,8 @@ void format_decorations_extended(struct strbuf *sb,
 			strbuf_addstr(sb, prefix);
 			strbuf_addstr(sb, color_reset);
 			strbuf_addstr(sb, decorate_get_color(use_color, decoration->type));
-			if (decoration->type == DECORATION_REF_TAG)
+			if (!use_color &&
+			    decoration->type == DECORATION_REF_TAG)
 				strbuf_addstr(sb, "tag: ");
 
 			show_name(sb, decoration);
diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colors.sh
index ded33a82e2..a5ee7b19d7 100755
--- a/t/t4207-log-decoration-colors.sh
+++ b/t/t4207-log-decoration-colors.sh
@@ -55,13 +55,13 @@ test_expect_success 'commit decorations colored correctly' '
 	cat >expect <<-EOF &&
 	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD -> \
 ${c_reset}${c_branch}main${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: v1.0${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: B${c_reset}${c_commit})${c_reset} B
-${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A1${c_reset}${c_commit}, \
+${c_reset}${c_tag}v1.0${c_reset}${c_commit}, \
+${c_reset}${c_tag}B${c_reset}${c_commit})${c_reset} B
+${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}A1${c_reset}${c_commit}, \
 ${c_reset}${c_remoteBranch}other/main${c_reset}${c_commit})${c_reset} A1
 	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_stash}refs/stash${c_reset}${c_commit})${c_reset} \
 On main: Changes to A.t
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A${c_reset}${c_commit})${c_reset} A
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}A${c_reset}${c_commit})${c_reset} A
 	EOF
 
 	git log --first-parent --no-abbrev --decorate --oneline --color=always --all >actual &&
@@ -78,10 +78,10 @@ test_expect_success 'test coloring with replace-objects' '
 	cat >expect <<-EOF &&
 	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD -> \
 ${c_reset}${c_branch}main${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: D${c_reset}${c_commit})${c_reset} D
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: C${c_reset}${c_commit}, \
+${c_reset}${c_tag}D${c_reset}${c_commit})${c_reset} D
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}C${c_reset}${c_commit}, \
 ${c_reset}${c_grafted}replaced${c_reset}${c_commit})${c_reset} B
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A${c_reset}${c_commit})${c_reset} A
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}A${c_reset}${c_commit})${c_reset} A
 EOF
 
 	git log --first-parent --no-abbrev --decorate --oneline --color=always HEAD >actual &&
@@ -102,11 +102,11 @@ test_expect_success 'test coloring with grafted commit' '
 	cat >expect <<-EOF &&
 	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD -> \
 ${c_reset}${c_branch}main${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: D${c_reset}${c_commit}, \
+${c_reset}${c_tag}D${c_reset}${c_commit}, \
 ${c_reset}${c_grafted}replaced${c_reset}${c_commit})${c_reset} D
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: v1.0${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: B${c_reset}${c_commit})${c_reset} B
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A${c_reset}${c_commit})${c_reset} A
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}v1.0${c_reset}${c_commit}, \
+${c_reset}${c_tag}B${c_reset}${c_commit})${c_reset} B
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}A${c_reset}${c_commit})${c_reset} A
 	EOF
 
 	git log --first-parent --no-abbrev --decorate --oneline --color=always HEAD >actual &&
diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
index 162cf50778..924923afaa 100755
--- a/t/t6002-rev-list-bisect.sh
+++ b/t/t6002-rev-list-bisect.sh
@@ -305,7 +305,7 @@ test_expect_success '--bisect-all --first-parent' '
 	# expect results to be ordered by distance (descending),
 	# commit hash (ascending)
 	sort -k4,4r -k1,1 expect.unsorted >expect &&
-	git rev-list --bisect-all --first-parent E ^F >actual &&
+	git rev-list --bisect-all --first-parent --no-color E ^F >actual &&
 	test_cmp expect actual
 '
 
-- 
2.39.0

