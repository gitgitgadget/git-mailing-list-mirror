Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1213C4725A
	for <git@archiver.kernel.org>; Tue,  5 May 2020 14:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 974B5206B9
	for <git@archiver.kernel.org>; Tue,  5 May 2020 14:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgjqbRzt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbgEEOlz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 10:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729470AbgEEOlp (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 10:41:45 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD9DC0610D5
        for <git@vger.kernel.org>; Tue,  5 May 2020 07:41:45 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x2so971299pfx.7
        for <git@vger.kernel.org>; Tue, 05 May 2020 07:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gYoUHSIeeTaF/kr+/sv87o+NKKI5PPTy3kEsV2YXYQ4=;
        b=NgjqbRztac9h8i8YXIH8jr78J+kkzra2j6HOkB61PHbFRML0QJeP6Wh//qP49yffWS
         CodcWp+7cP9jz/7BaaCzWKcVb1ok86YchyciRYiIxf/UVvjRy/0wTuHI90ClrZNYaNvI
         kWjr2K9Ca5OdJavhn66tk0ls9dYT//tuWsFKsoCqAUJAfP/9+NfAiTcsYKdm6KAo7I8U
         5UqsKrmX3wfGzGBwhLeLxN7ef+4qqexs3w7QJlCs/eP5tZ65Yfl4QUG/tVIwNZIbefan
         zfeUdacd6b19fg3WBb0wOYgrpRYeNTdYUUoOkSoZ9x6aO3o8Qj3ZDD+gNLO8SIX8NmQj
         hLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gYoUHSIeeTaF/kr+/sv87o+NKKI5PPTy3kEsV2YXYQ4=;
        b=p11RwHC+FFYnjfonUYhQH4ah8yH8OrtTXg2XU9wq/IWgqI+XMsvvjsTEeEf1us8xwh
         zDv9MBNaw0Vwwr2KPY/dIjFIbSKlX4wwupgu9xPu+tz6tql+5dfr2rrudDgFaVGU/UJM
         YgZ8H6x1P0XT4GN2egP/QuDJC1AI7Dj9GVP+LOqPbWpYXA89kK0K1017V/V26Gh096Zx
         D/6nPev8NtOh3XlZRzxofO93Y1EGW38yeM6kHwc+et09O5haGYmBDDanGTMji86dP/o1
         fskZZaDOrvIoinUNnOiJ9dHLVjR0gz/N5t3aHnA4C1cdiA0lIXjcEfegjwcQw9jDWbNY
         Z4vA==
X-Gm-Message-State: AGi0PubAPCagJgvTKx6eN7Ly9s63+eaTsgHxO86ebnQx22MSLBB5Zf1U
        O2AzpvgTxkRaRanWUnXjRA2k5ZvH
X-Google-Smtp-Source: APiQypIr1kwX4Dx4aqt9WKCSqIZiMHey6G2rfq2gJtk6EXYf+b1ONnuze9ELoo/dIfvg7uNMXX/cwg==
X-Received: by 2002:a63:5b4e:: with SMTP id l14mr3164914pgm.146.1588689705329;
        Tue, 05 May 2020 07:41:45 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id f99sm2431012pjg.22.2020.05.05.07.41.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 07:41:44 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v14 5/7] refs.c: refactor to reuse ref_is_hidden()
Date:   Tue,  5 May 2020 10:41:29 -0400
Message-Id: <20200505144131.30048-6-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <CANYiYbFCG1_hdy1kA06wjrvGSQ2=y-hJX3Rsh-rn=X9tcqv1VQ@mail.gmail.com>
References: <CANYiYbFCG1_hdy1kA06wjrvGSQ2=y-hJX3Rsh-rn=X9tcqv1VQ@mail.gmail.com>
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

