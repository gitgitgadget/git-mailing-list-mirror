Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6422C54E4A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 16:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A58792083B
	for <git@archiver.kernel.org>; Thu,  7 May 2020 16:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tcIsMd/3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgEGQLN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 12:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726521AbgEGQLK (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 12:11:10 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EE5C05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 09:11:10 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id a4so3027888pgc.0
        for <git@vger.kernel.org>; Thu, 07 May 2020 09:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gYoUHSIeeTaF/kr+/sv87o+NKKI5PPTy3kEsV2YXYQ4=;
        b=tcIsMd/3zwps5LRj1JNiN2jadecVQchZrvXkWZRfQ1zGNSg2EE75UfXGMP2EIRRuZy
         TOOcGlygCo8rosanRk5zhKf96Ubex04OAFLYyFehU4m8cFkLzusFzrWv+by58HpEH+35
         YBn/dqkktXqqLTIb3XHU4W4oGPHM1nkXugsiCtbowCjawuedDqcAjr5DzMwkbDMxWxfN
         LQwXU5JpAI0nGRnH/v4VJSfmQtGDRzO7h0+OUSs7ri6wx3T1SQsCXOV9+Zn/16XZaXZd
         Cj7Uq6+ApxtrJPHgsz/lzqOcuaia1TsoxNiSM6NdTmIcS5KSp9+zTAIVmh4k9yBLyA/Y
         CfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gYoUHSIeeTaF/kr+/sv87o+NKKI5PPTy3kEsV2YXYQ4=;
        b=O5l2EMB0QZjYBEDLXaIeI4g60M2JO4H6B9eytt3PGoSDtcNRx1Oi6DxqE5c11QzGbv
         HfZOuJKZVhUYW9/Su5CmnUO4WYBkOmk6dLOnEZvSqxMPgnlkoVOBJheHLNhOjapQRcu3
         +90yPzTn/uUyoqZs+sDwA1z2KlwN7RBKYEl+0nyKbEWSGDLv8JD4azrYQNT7TChGEbqp
         DCjTJT3ldivLgB+YWnjyiez17ihXaJ55Sc6lBfJBaZAl03bpW0XTa4C+NFCUwF27w3lq
         I/JVhG80tqATkkt6wria21kwFs+JIxRptq9s/XGxe++qhd060JquODAtI6amEQP31SaG
         Gn4g==
X-Gm-Message-State: AGi0PuYNATuGfRgcnyPUfj3bOHbSBdv2+TIIF8VCbvBdOuG++kB2u64Z
        WHJzpXTtMXTHrsR5awOqIQMJ+Ojq9Y0=
X-Google-Smtp-Source: APiQypJt/2fBqaG+sDtYculL/CDqOrV7jrFxW+Ik6rQcDYAy9UiS1dY+TmzsoEnPatZ2tg3aB+vfIA==
X-Received: by 2002:a63:5353:: with SMTP id t19mr12129080pgl.391.1588867870038;
        Thu, 07 May 2020 09:11:10 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id gq6sm238800pjb.54.2020.05.07.09.11.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 09:11:09 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v15 5/7] refs.c: refactor to reuse ref_is_hidden()
Date:   Thu,  7 May 2020 12:10:55 -0400
Message-Id: <20200507161057.12690-6-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <xmqq4kss64h7.fsf@gitster.c.googlers.com>
References: <xmqq4kss64h7.fsf@gitster.c.googlers.com>
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
index 224ff66c7b..76a91ac0f6 100644
--- a/refs.c
+++ b/refs.c
@@ -1344,14 +1344,14 @@ int parse_hide_refs_config(const char *var, const char *value, const char *secti
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
@@ -1377,6 +1377,11 @@ int ref_is_hidden(const char *refname, const char *refname_full)
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
index a92d2c74c8..9907dd12b0 100644
--- a/refs.h
+++ b/refs.h
@@ -727,6 +727,7 @@ int parse_hide_refs_config(const char *var, const char *value, const char *);
  * parameter always points to the full ref name.
  */
 int ref_is_hidden(const char *, const char *);
+int ref_matches(struct string_list *, const char *, const char *);
 
 enum ref_type {
 	REF_TYPE_PER_WORKTREE,	  /* refs inside refs/ but not shared       */
-- 
2.26.1.120.g98702cf3e9

