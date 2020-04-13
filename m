Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F063C352B6
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 16:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D9C020732
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 16:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THFHfS1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731784AbgDMQsp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731780AbgDMQsj (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Apr 2020 12:48:39 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD14FC0A3BDC
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 09:48:39 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d24so3575641pll.8
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 09:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JYboaKpjAoYwIKr0RNOYcugoTKy6HS62FUf5oeWWZHc=;
        b=THFHfS1/5prqdzYXDkCMAwjGpZpWjvCxZc/8kd56otVHPLDgUMRmXubtuucuYpEZJl
         PIQszG2ickrk+KhUKg07jqecYAF65OIXwp9qqZv+JbAAHZepgREyTyNFRviY3QmCw/Gh
         dWuZNxgFIasMTrHBRpIGzpI24h3b6c+9uCcwZYM7Td8EQMP3GPwg0cmrJKoG/BStRF3a
         kAnb6Ahd6G2+7dNzIVq87+1wsct8CmQ1sNF5sUFDKuCVc40WtUZmILez/rGNeNFyTG7J
         ox4BB9rZ7/yWCtcqYMAHnujfQuKdJQ9hAtnNNzZ6koubc+39O6dz/re+jZgRLhxncdkA
         MCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JYboaKpjAoYwIKr0RNOYcugoTKy6HS62FUf5oeWWZHc=;
        b=aN9O9mf9Ka1PGJK/rUqwZC4ZKo5R+XDf9wWivJx4U8EvQVY18pohN5tTNBqkQf/b8/
         8U4YGNUdrmzBbVfdAGR7n3I5t8NqAYgIuwywie4Nuly/hQhXT9Octp09fM+kKdtZ8g0Y
         30aiTCIFdhKoXYo8GhHUtFPgIM2PlqOuNooZWjbK6NePXBykQNb+1vs6dsTRx7+M2ffi
         510o2XmKe0yh7VMiz4NPar0RK82wxfNbSitrykbaRTBPuZM6jBil8PFouQCotFiU98mM
         Az1dlyYwBjtdmpzao6skTQ4w2yCIdx9W7ocvCXFMVSC6u3cMu7gzKuVRn+Cb5KixVkCv
         kZCQ==
X-Gm-Message-State: AGi0PuZikxvJWcWoDOllQT2RVuLIbYEMBN9NUIAa9PSMlsn2b3gCSh9q
        Ia0Qn1jdFOc0GezNzDk2mvA=
X-Google-Smtp-Source: APiQypL3bakYW8WO8R4TS7P8NzqmOHfgZLl1UlWmFWsQWuuMOO7oTTgpmMsLDgmYZA21Hg8Yhawhfw==
X-Received: by 2002:a17:90a:c24a:: with SMTP id d10mr9722982pjx.5.1586796519375;
        Mon, 13 Apr 2020 09:48:39 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id e11sm9254885pfh.117.2020.04.13.09.48.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Apr 2020 09:48:38 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v11 5/7] refs.c: refactor to reuse ref_is_hidden()
Date:   Mon, 13 Apr 2020 12:48:25 -0400
Message-Id: <20200413164828.23260-6-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200412133022.17590-1-worldhello.net@gmail.com>
References: <20200412133022.17590-1-worldhello.net@gmail.com>
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

