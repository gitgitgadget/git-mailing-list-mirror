Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F382EEE49A8
	for <git@archiver.kernel.org>; Sun, 20 Aug 2023 09:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjHTJAM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Aug 2023 05:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjHTJAF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2023 05:00:05 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3F3D2
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 01:55:01 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe12baec61so22410985e9.2
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 01:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692521700; x=1693126500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qiqD3kvSXbgsPdz2fouf+93nbEh+ABrlnUBeqKFPJc=;
        b=h4p5bul2bwi89U3AqIp3dtGJqi4x0TwxHuPyosyVew2Vu/h7qYbrIm7EQAUHpIg+8m
         lHn3Lo8YEZVQ+UhbUocU6pN6GVZJjw9ETioV7uhlsIrz2Qken8rxUvLtenS0yTJuDArZ
         i3yUOFhH5g/4qf4aVWgTiYr9EAOVrx/okeAnpPoevR4bA3h/igIKmuvh623JEQuBZ9LM
         gfM7kOKssT6VWTHIcdG0pV7GIONPJnIouXHk7fRn2NgKJQLQiYdBEBi1OX8/ESuDCE90
         6pl4dQfCVhRGHEL3Ey5LElz1o7VJbufGvDjk4ttephHnUPihTh6CFGzvKQ0lDlCfweTI
         aScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692521700; x=1693126500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qiqD3kvSXbgsPdz2fouf+93nbEh+ABrlnUBeqKFPJc=;
        b=GQT+IvrcZnv2gtHjdLoNUaVCbeqiMhA76JBZKKR5/we/jUlDlDxpGkVOzMcMX2IyX1
         ySLwY/udClHQGN7iXyPwoXaoR0BzR87oLyZKSohU0epYppw2gbZfLcVTHSeDTu9V122q
         yDjjxXmQgErnfYOWXznuB7T0VhhWLpjzepSNv/ymL5wG3kmZ2Ibs0vsmv9hPcQ/Lqwh+
         3LVTwbmjUkPH5nDLPVw1URSkquV6wPNC3obIkzoNSwsS9mMSpFWgZ/JUtGBXPMLlfIbU
         drcH9AX9LvGgmjkHV0ZiJfA83hwPDqNByaTtvnDxmnQ3dj/LzE5x/hModLCi3oDP2bWL
         Xk5Q==
X-Gm-Message-State: AOJu0YwngxvepjZ4I/33wX21rwdqkD1SlVsJTCxCL4aTBuKv16pARPda
        n7iFG4w36l7q/eO6p4kI2aCGNQ8+aWEGtqGV
X-Google-Smtp-Source: AGHT+IHj9vDpmtVQoBgvlnpFi5ZXcHMMCjL/5eLmLH/eCVBXH8qswOJqwr5RcbODKrcci0b8lInjMg==
X-Received: by 2002:a5d:66ce:0:b0:31a:d5fa:d710 with SMTP id k14-20020a5d66ce000000b0031ad5fad710mr2874139wrw.2.1692521699632;
        Sun, 20 Aug 2023 01:54:59 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id y15-20020adff6cf000000b0031759e6b43fsm8652539wrp.39.2023.08.20.01.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 01:54:59 -0700 (PDT)
From:   Andy Koppe <andy.koppe@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, glencbz@gmail.com, phillip.wood123@gmail.com,
        Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v4 8/8] decorate: use commit color for HEAD arrow
Date:   Sun, 20 Aug 2023 09:53:36 +0100
Message-ID: <20230820085336.8615-9-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.0-rc1
In-Reply-To: <20230820085336.8615-1-andy.koppe@gmail.com>
References: <20230810211619.19055-1-andy.koppe@gmail.com>
 <20230820085336.8615-1-andy.koppe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the commit color instead of the HEAD color for the arrow or custom
symbol in "HEAD -> branch" decorations, for visual consistency with the
prefix, separator and suffix symbols, which are also colored with the
commit color.

This change was triggered by the possibility that one could choose to
use the same symbol for the pointer and the separator options in
%(decorate), in which case they ought to be the same color.

A related precedent is 'ls -l', where the arrow for symlinks gets the
default color rather than that of the symlink name.

Amend test t4207-log-decoration-colors.sh accordingly.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 log-tree.c                       | 2 +-
 t/t4207-log-decoration-colors.sh | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 50b4850eda..504da6b519 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -369,7 +369,7 @@ void format_decorations(struct strbuf *sb,
 
 			if (current_and_HEAD &&
 			    decoration->type == DECORATION_REF_HEAD) {
-				strbuf_addstr(sb, color);
+				strbuf_addstr(sb, color_commit);
 				strbuf_addstr(sb, pointer);
 				strbuf_addstr(sb, color_reset);
 				strbuf_addstr(sb, decorate_get_color(use_color, current_and_HEAD->type));
diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colors.sh
index df804f38e2..21986a866d 100755
--- a/t/t4207-log-decoration-colors.sh
+++ b/t/t4207-log-decoration-colors.sh
@@ -54,7 +54,7 @@ cmp_filtered_decorations () {
 test_expect_success 'commit decorations colored correctly' '
 	cat >expect <<-EOF &&
 	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD${c_reset}\
-${c_HEAD} -> ${c_reset}${c_branch}main${c_reset}${c_commit}, \
+${c_commit} -> ${c_reset}${c_branch}main${c_reset}${c_commit}, \
 ${c_reset}${c_tag}tag: ${c_reset}${c_tag}v1.0${c_reset}${c_commit}, \
 ${c_reset}${c_tag}tag: ${c_reset}${c_tag}B${c_reset}${c_commit})${c_reset} B
 ${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
@@ -79,7 +79,7 @@ test_expect_success 'test coloring with replace-objects' '
 
 	cat >expect <<-EOF &&
 	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD${c_reset}\
-${c_HEAD} -> ${c_reset}${c_branch}main${c_reset}${c_commit}, \
+${c_commit} -> ${c_reset}${c_branch}main${c_reset}${c_commit}, \
 ${c_reset}${c_tag}tag: ${c_reset}${c_tag}D${c_reset}${c_commit})${c_reset} D
 	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
 ${c_tag}tag: ${c_reset}${c_tag}C${c_reset}${c_commit}, \
@@ -105,7 +105,7 @@ test_expect_success 'test coloring with grafted commit' '
 
 	cat >expect <<-EOF &&
 	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD${c_reset}\
-${c_HEAD} -> ${c_reset}${c_branch}main${c_reset}${c_commit}, \
+${c_commit} -> ${c_reset}${c_branch}main${c_reset}${c_commit}, \
 ${c_reset}${c_tag}tag: ${c_reset}${c_tag}D${c_reset}${c_commit}, \
 ${c_reset}${c_grafted}replaced${c_reset}${c_commit})${c_reset} D
 	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
-- 
2.42.0-rc2

