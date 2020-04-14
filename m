Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E95C2BB86
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 12:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1BA0206D5
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 12:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SITn3E6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502007AbgDNMd2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 08:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2501994AbgDNMdK (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 08:33:10 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F227C061A10
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 05:33:09 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g2so4609880plo.3
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 05:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JYboaKpjAoYwIKr0RNOYcugoTKy6HS62FUf5oeWWZHc=;
        b=SITn3E6gnLrHD7J+T5VYG8HadB5Jx3zf2ybdLI6Acss79OeQ/8q5DSnMeha9jRI+Bf
         kkrgRh+ppInTShkFfkDbt3ZiUCnjV/cxs3AYYupQscINZeNeWjycc+kx5zQiQsqJImXa
         SGfPCxslWayNwdDrf+vndq+sGDxk6g+48kkvzIy52vP2Fz4h2aJRw+rZ3w9hmEi80e2f
         bUJrIcPhN2Rc/3h2FyOFFu2pynvJ/pXMnkIYiyZhTILoZGiL4wrgxGIvVppQkcjtWWtO
         MtvXyIdFEiljGsdFfhYpzIeNleAnMxCTvSBMuUlu4Z3xeViXu2lkABIrxC4EohewDTVW
         1b7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JYboaKpjAoYwIKr0RNOYcugoTKy6HS62FUf5oeWWZHc=;
        b=r9ja84KkSeHXwTcIj9C/zN4wVGYVGOpNgpuMCWRH06UlLR12w/UvnzdlNBqt04k+Lx
         2XeQZXPvuhk479AGcIHwy0zQVkKu3dANeD10rIIu/1XoY6vM++mtIp/T3tj7AuEx527s
         wlLEdpPqUrWLIKZ8pHqK+obNXVjtundLpRZnQ/7UH7bgjd1IKhz0GcyJFrMaYtS5+0tM
         nkqwvRpMLwG5I8mpImg5uqVsiXtc4A7Be1QGumSdNrUK/PmmvntgnQjyuatoG7uo+yj0
         uz2Ym0PBM3SBsZAOTQsDbHVbKyJEbBM+UEzJOzy7Zw2dxKtIOgO55Oyy4M67Rx8qvidA
         JjyA==
X-Gm-Message-State: AGi0PuadSF5kADDYvrfmbuamBljSZ2do4P4BG/EDm5KDcdrLwoADGm35
        OkpfuFC7Y3bT3ArQaULyKIMUi5MseKg=
X-Google-Smtp-Source: APiQypJcwqGhBknpwIVs9b/sjkfvUNt/k014Evuvn77ba8iJxvOM+pxgpNO1uWaNHQx7bv20LWw91g==
X-Received: by 2002:a17:902:bd8d:: with SMTP id q13mr7730169pls.2.1586867588745;
        Tue, 14 Apr 2020 05:33:08 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id c9sm996177pfp.53.2020.04.14.05.33.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2020 05:33:08 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v12 5/7] refs.c: refactor to reuse ref_is_hidden()
Date:   Tue, 14 Apr 2020 08:32:55 -0400
Message-Id: <20200414123257.27449-6-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <xmqq3697cax0.fsf@gitster.c.googlers.com>
References: <xmqq3697cax0.fsf@gitster.c.googlers.com>
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
 refs.c | 13 +++++++++----
 refs.h |  1 +
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 1ab0bb54d3..a20f56a463 100644
--- a/refs.c
+++ b/refs.c
@@ -1388,14 +1388,14 @@ int parse_hide_refs_config(const char *var, const char *value, const char *secti
 	return 0;
 }
 
-int ref_is_hidden(const char *refname, const char *refname_full)
+int ref_matches(struct string_list *match_refs, const char *refname, const char *refname_full)
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
@@ -1421,6 +1421,11 @@ int ref_is_hidden(const char *refname, const char *refname_full)
 	return 0;
 }
 
+int ref_is_hidden(const char *refname, const char *refname_full)
+{
+	return ref_matches(hide_refs, refname, refname_full);
+}
+
 const char *find_descendant_ref(const char *dirname,
 				const struct string_list *extras,
 				const struct string_list *skip)
diff --git a/refs.h b/refs.h
index 545029c6d8..d02c72d3ad 100644
--- a/refs.h
+++ b/refs.h
@@ -739,6 +739,7 @@ int parse_hide_refs_config(const char *var, const char *value, const char *);
  * parameter always points to the full ref name.
  */
 int ref_is_hidden(const char *, const char *);
+int ref_matches(struct string_list *, const char *, const char *);
 
 enum ref_type {
 	REF_TYPE_PER_WORKTREE,	  /* refs inside refs/ but not shared       */
-- 
2.24.1.15.g448c31058d.agit.4.5

