Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D910DEE49AB
	for <git@archiver.kernel.org>; Sun, 20 Aug 2023 18:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjHTS4I (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Aug 2023 14:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjHTS4D (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2023 14:56:03 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC06F7
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 11:50:59 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fee87dd251so8329655e9.2
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 11:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692557458; x=1693162258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qiqD3kvSXbgsPdz2fouf+93nbEh+ABrlnUBeqKFPJc=;
        b=HjvCjvPV6LQ2RDQB1/3hrRtrn7MriWSyd4l6LA77Z/+DA++413P/CqstaJqcgvGxlG
         NnPiBidZQrgj/KgLf7Y5knkLpapPvmWuFRxmgGlYLTXJMOtAbPzpmcTPQ/EtF3ReisN8
         0AP7NWD+mztkOwHYZkJVJ5rKskj4HFGTQRDdG2jt0FXi7qjeuwgT4Wc6HD8FPdBenDOO
         1ktjlKNgcs0JSz31EP2tImshS980ToVbPHwbEvGHUkyBaL/pSQoBv/1mCaDokVQVEO8r
         oSIRNPneeL0Q1q3f6M/Zbo1YaVa3vt1h8W9w8v4Cj9sncrE3SqWf8dDEB5fTxP4/ydEQ
         jREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692557458; x=1693162258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qiqD3kvSXbgsPdz2fouf+93nbEh+ABrlnUBeqKFPJc=;
        b=ksiynRGm+VIQ4L6NcPonJRepZWyh3rh8qnO+aZUONFpZVjpmkONNkED/VnzOlx1/fm
         bOXBaiWoZddmji+Hme7kN+Aq9ZRft0UFf5yWHovyracXR30JRD7dUNTt75fYw1ifkKXZ
         ms2QezWjA/FfmTec8jzWiOpChcCTwYLoFiem/0hMp12Qk9wN8sgLa+YglcUpHGSJ+gsZ
         Z956q0wp9sZfGkObIfiLWJsOB7KbayHR6coOGkwB4IMkKtPmqC0XyzC1dj+UPm7/AFug
         wx1SKW8Ekws+gfREiHzLvJUSG3fhKmibC3e9EJNV3kDfA+5RMhiejq+2cbz+vLhj/868
         jQvQ==
X-Gm-Message-State: AOJu0YzijpRjQeeuHV5nh6324wILLjEv4RW8VDBEl9pYLqS9OqFjLfCT
        H7Mh8AZE5WrQ6YuXvlEHSbVf8VlQISUl//Ou
X-Google-Smtp-Source: AGHT+IH51uvo3zcaijTmuPifiz3y+c78+gjKtJAU5jycGGtBawiq6oSk3Z3Zr7gbndNRR3xHN53w/w==
X-Received: by 2002:a1c:7707:0:b0:3fe:179d:d42e with SMTP id t7-20020a1c7707000000b003fe179dd42emr3706189wmi.23.1692557457902;
        Sun, 20 Aug 2023 11:50:57 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c021a00b003fa95f328afsm13603604wmi.29.2023.08.20.11.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 11:50:57 -0700 (PDT)
From:   Andy Koppe <andy.koppe@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, glencbz@gmail.com, phillip.wood123@gmail.com,
        Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v5 8/8] decorate: use commit color for HEAD arrow
Date:   Sun, 20 Aug 2023 19:50:09 +0100
Message-ID: <20230820185009.20095-9-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.0-rc1
In-Reply-To: <20230820185009.20095-1-andy.koppe@gmail.com>
References: <20230820085336.8615-1-andy.koppe@gmail.com>
 <20230820185009.20095-1-andy.koppe@gmail.com>
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

