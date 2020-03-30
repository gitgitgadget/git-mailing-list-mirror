Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233F5C2D0F1
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 16:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B832073B
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 16:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lxi/gTgK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbgC3Q6J (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 12:58:09 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:40428 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgC3Q6G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 12:58:06 -0400
Received: by mail-pj1-f65.google.com with SMTP id kx8so7590603pjb.5
        for <git@vger.kernel.org>; Mon, 30 Mar 2020 09:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W67WP641RvaQ20itm2tkbra0rHFN+eyr2uZzNfMDRKA=;
        b=Lxi/gTgKGoMxf9CmOYE0slM/MXv3ZtS6B/USw1O9NrblNYpC1UZezydwmQx2GGjs5Q
         cws9IXnK+gYHZ5dvyEhX992TmauZryrKSEZIufN0oGAHMWehq6fMMccVjdHQD99/eFZI
         e+Zyb+fVQGb0VrgMl73FPwLpRztPfl0LDn+sfUPyfcA2z5jWqPqNvyeAqD5I6pknlF6g
         Lo0nBRthVXBgv6pAIiWBMabM7VG3nzy0Zo1VclhTiJSPLFwh3z/P2TW4CtekIJ32iLIq
         nCdGAnvuELiI6O3z+csQ1/dnRaapE1qbIuSO6CzLUPL7RdQZ59WBe/h04GjUxMlhBSeq
         zMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W67WP641RvaQ20itm2tkbra0rHFN+eyr2uZzNfMDRKA=;
        b=ebaj5AdVOkpd6aYVRNlVvoeOFxb7ROvN4tknOQW7rM8s8NL25ZbnuesnC/XL8P5EZH
         kRlCOoHgXwzQy8H7KWTxrIulq4BHIGXfouuOEhfyDnO6Xf/r+ils2PKAES3ao/5+8QxJ
         F/+LEqA46mUel/R54cL7j6WA/weLcbZvj0iQW02RS3bFNPIoOTfQ8NDbOrYCJS8ZxFPx
         hCIDIwOdjV/ocCAZbzoHy0gIrx+StmDZpZJGXD8kcXM5q5tgWPLMKQMVxX4Bk8KfEfbU
         XL0DFhBu4ilE1ycX9MrJxeOALQ130UP4Btbb9DYSRtdqZ/xL33DQwKKAQJghi2y64dyF
         8yMw==
X-Gm-Message-State: AGi0PuZrPoV+xFFnNp1DwAt9DGHgfaNoXe+Fmz6faTRwHxBLA6U6t1jt
        T7hlfDnQTXmixZrpulldCrjsf/yzelc=
X-Google-Smtp-Source: APiQypIC+8qt2JTLvNkCMKM/91m+Hrbvq8bUOV2lzkOSI7qaqhoygk9+gzR/3M9/Q6m0ElMgRzdhFA==
X-Received: by 2002:a17:90b:2318:: with SMTP id mt24mr337486pjb.66.1585587485717;
        Mon, 30 Mar 2020 09:58:05 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id a24sm10589604pfl.115.2020.03.30.09.58.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Mar 2020 09:58:05 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v5 3/6] refs.c: refactor to reuse ref_is_hidden()
Date:   Mon, 30 Mar 2020 12:57:51 -0400
Message-Id: <20200330165754.19195-4-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200304113312.34229-1-zhiyou.jx@alibaba-inc.com>
References: <20200304113312.34229-1-zhiyou.jx@alibaba-inc.com>
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
2.26.0.4.g39bcdcb101.dirty

