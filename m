Return-Path: <SRS0=VPsx=4V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEE9C3F2D1
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 11:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B375B20848
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 11:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6JyQeDU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387897AbgCDLeS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:34:18 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33404 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387774AbgCDLeR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Mar 2020 06:34:17 -0500
Received: by mail-pg1-f193.google.com with SMTP id m5so884036pgg.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2020 03:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JggJxmPP5gHy87da6j0Fnf92VHvN+o3kRi3I6Nj2eWI=;
        b=R6JyQeDUQBfx5IQzbgT8pBdm/2+DvL/SLyVJZa4Ty1QlFo+yfGOHy5w3KZ5mZCZhcX
         lMlYOZ9KPhSmg8Deh41usGK2W4w4PQU7rJ6EonFQUupM3mMPlYlxYnKX8a2EoFGbCDDd
         u1Iw/TTrupOLfceItgcEJwsM7wC+gDzSofghoRB45ls9eEQiDG28I8DpuTVmDIzuNS0L
         0ZLyPThM7Y/0c6XsEoV6vqlfo/DvfwOV6cwH9u0Lb++SmEPRMDr+frkbpbDZil5KLJIz
         PGos9gdw8/ff/oi7cjUYISkYqh02rXcHK8Fs5I7Te4rIef/dnYKA2Jcye8jVDqnyU3ue
         YaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JggJxmPP5gHy87da6j0Fnf92VHvN+o3kRi3I6Nj2eWI=;
        b=kZF1El97ZwIsl8ddQ7VYoCcR+M9Wfn51eP8cAfjTwQ8/5lmEjSUPtCesCkuTfQxf7f
         4ZJytif4s1dPBReArjQ2sBB+Qt3zsnSQyVBulF76a3lk7SY/hbqeaPwNz6QBln5WDsAX
         oURa7GfruSMA1c1VCgmgzIr0mHlR/T+pqVwatLcIA7IrZAE733u5dV7UCU8PfOASojSB
         yem2gKd+ChEp/0fLidTlChBJg+BvXFCruMIUm9KdpGeMGG5pHl2lCG9E3vTqEtFKKQ6k
         m1tK7MnJnzXn/IajXYx4iXVGoSJmeZzpjy59AJrKKuTqrQ5TVQLNBgTm2UpmpV/bMNeg
         62sw==
X-Gm-Message-State: ANhLgQ0e7DOkrPQdmYtGeW1wKyH147FKqA8LhlmFqzPMZjj2H+N5hiY7
        BKsXpw6wU+euRb2PsBTjXSuQoE25/OXaNQ==
X-Google-Smtp-Source: ADFU+vsPXek8bBjbI0aReR4kstMwlUzPkqvxxDYT4Y7+KvMZRWRuUrGTSMOHbeob3Hus8pX3ucIbWQ==
X-Received: by 2002:a63:c20e:: with SMTP id b14mr2118000pgd.394.1583321654976;
        Wed, 04 Mar 2020 03:34:14 -0800 (PST)
Received: from localhost.localdomain ([47.89.83.4])
        by smtp.gmail.com with ESMTPSA id d77sm15350050pfd.109.2020.03.04.03.34.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Mar 2020 03:34:14 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/7] refs.c: refactor to reuse ref_is_hidden()
Date:   Wed,  4 Mar 2020 19:33:10 +0800
Message-Id: <20200304113312.34229-6-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.25.1.362.g51ebf55b93
In-Reply-To: <20200304113312.34229-1-zhiyou.jx@alibaba-inc.com>
References: <20200304113312.34229-1-zhiyou.jx@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add new function `ref_is_matched()` to reuse `ref_is_hidden()`. Test
case t5512 covered this change.

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
2.25.1.362.g51ebf55b93

