Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B73C4332E
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 13:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2115206C3
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 13:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRtSE3fE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgCVNS3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 09:18:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45438 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgCVNS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 09:18:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id m15so5702879pgv.12
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 06:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DzqP6YXGD+BQsTS2yuVVIADxgEwBnu1kekSJxUOeFcA=;
        b=aRtSE3fEsa+taz2OjupZg9SkhJ0GNTeyvFQ6va4xVc+vAG5G6rs1azHbvyIKlUXiSN
         CsX7s2WG9vEht+lQwMYlqWnne5038B6GaPY84bCmS3B8wO0JNBl+S3IUpUdlIiEJfOz3
         Ft+l+o49ib6g3NbjkLWjQNgDuSHYqemnhiaJAZAPyY14WDH6HHMfT7qol1UPhBJLiZxN
         paqfB8Ge2HZ7rwLwUaUrlvTZtfrwb7o/qvIu/kgcbUmfRg9lmuZUFj+8hcA5CpFY/8jZ
         Hl1byuDNYp+VtsCL2A/k4kVl5CBiwWYol/hUmAOKLUcv8YSkPkgxzPTi/yLijMmEZV/c
         +anw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DzqP6YXGD+BQsTS2yuVVIADxgEwBnu1kekSJxUOeFcA=;
        b=QLLFpJmu4UsTVSl2WE9iHAXqh0W8yBmkLjTqQ2GI4JAsfB2e/BXvgvU/Xqa1eZj7Ix
         ki0vCEZ2v5qgM7LHm1F115/D1tPvvFCd8VlEzkSsTrRgz5B1y0NNVMQ4tALPOBZ0vuPJ
         vjlUxMCZb5sWAiTBjq4+642elc3quPN+3bYWa7ACSTHql1/djY2P8uEkj+DHZ9f7/zEK
         QfUnVnqBXxVskEAINJazpy6mOjPYNpRGw5HiEEk9ysA1y5+20WW8bkrD6mwYLwpDR7lL
         QyohuYSJ2n5QT6hLmOdbakFThysZecWIprSFk68wu2iTZjRT0N1VCtdIF1dFScVQmuqf
         fpEQ==
X-Gm-Message-State: ANhLgQ1gKpZlIsQP/0kgaEjAzXu8lrY3gt8qHotr2bg2FKxyEXFWwzKH
        /Ogsde1fpXU+b1lafQfekk0=
X-Google-Smtp-Source: ADFU+vvFzYbQ7+krAO14mRJqhMJ2GqRfS60kLtudDvAZF6hqdgHgRpoEUIZocqy4If4uZZt+YJhdqw==
X-Received: by 2002:a62:194c:: with SMTP id 73mr19794961pfz.159.1584883108170;
        Sun, 22 Mar 2020 06:18:28 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id nh4sm9456432pjb.39.2020.03.22.06.18.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Mar 2020 06:18:27 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v4 3/5] refs.c: refactor to reuse ref_is_hidden()
Date:   Sun, 22 Mar 2020 09:18:13 -0400
Message-Id: <20200322131815.11872-4-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200313122318.78000-1-zhiyou.jx@alibaba-inc.com>
References: <20200313122318.78000-1-zhiyou.jx@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Add new function `ref_is_matched()` to reuse `ref_is_hidden()`. Will use
this function for `receive-pack` to check commands with specific
prefixes.

Test case t5512 covered this change.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 refs.c | 11 ++++++++---
 refs.h |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 1ab0bb54d3..229159ea1a 100644
--- a/refs.c
+++ b/refs.c
@@ -1389,13 +1389,18 @@ int parse_hide_refs_config(const char *var, const char *value, const char *secti
 }
 
 int ref_is_hidden(const char *refname, const char *refname_full)
+{
+	return ref_is_matched(hide_refs, refname, refname_full);
+}
+
+int ref_is_matched(struct string_list *match_refs, const char *refname, const char *refname_full)
 {
 	int i;
 
-	if (!hide_refs)
+	if (!match_refs)
 		return 0;
-	for (i = hide_refs->nr - 1; i >= 0; i--) {
-		const char *match = hide_refs->items[i].string;
+	for (i = match_refs->nr - 1; i >= 0; i--) {
+		const char *match = match_refs->items[i].string;
 		const char *subject;
 		int neg = 0;
 		const char *p;
diff --git a/refs.h b/refs.h
index 545029c6d8..a2ea043f7f 100644
--- a/refs.h
+++ b/refs.h
@@ -739,6 +739,7 @@ int parse_hide_refs_config(const char *var, const char *value, const char *);
  * parameter always points to the full ref name.
  */
 int ref_is_hidden(const char *, const char *);
+int ref_is_matched(struct string_list *, const char *, const char *);
 
 enum ref_type {
 	REF_TYPE_PER_WORKTREE,	  /* refs inside refs/ but not shared       */
-- 
2.26.0.rc1.33.g4914ba4bcf

