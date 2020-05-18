Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7092C433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 09:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F9052067D
	for <git@archiver.kernel.org>; Mon, 18 May 2020 09:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GizxVO8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgERJlA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 05:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbgERJk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 05:40:57 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F71C05BD0B
        for <git@vger.kernel.org>; Mon, 18 May 2020 02:40:57 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t40so4785857pjb.3
        for <git@vger.kernel.org>; Mon, 18 May 2020 02:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gYoUHSIeeTaF/kr+/sv87o+NKKI5PPTy3kEsV2YXYQ4=;
        b=GizxVO8vOb9yI/UxqRQqMhRBYvN/YVgvBeVBK8G0GnA9niSSk/AtpAny/Vk7bQKt1s
         GXnTO0v9XKkkOYwJEy7Qsp9WCzfkuCksdukFbFm+S9QggSUDi22g/l9LnX/iH8S3bPcN
         Ceyvk5bw5CSdCRIell53QfTGwERMfnRNoTin6tSVAaZxUiEV/Raq3UOA+iRBmReYZ066
         R5NbS5yoYvgT0jO7YJ4rv8cXb1fxtqWz8RKfBh3DUR82e4S4A7koPlUI4PE5znxIdk1s
         QUvJ/Igfti3wmalN7768a4xq6BgaJyD7remLIeNTtPlfQwDaUp+W4JjHmuNS1DDPDPlX
         VvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gYoUHSIeeTaF/kr+/sv87o+NKKI5PPTy3kEsV2YXYQ4=;
        b=W2FqD/CudF1lA/3SSyqqeXjBFPWMZfO503rWXElAKu6Rw917FzXH5hkQEIEOshETX2
         ByCxZNJQJuB2b+kckOFEcsQFEYwsaA/HjVRlCaQZS3bA97fpa3e4kGB+BpcuFTewhFfj
         6rRNdjvsTAkTbr0Xb9w6jthKsGHNT35sn5O3/ZSky7rb/nfzAVhUFQ+CMkmnnQ+3DF5l
         M1Vp+XbSh8oTZFeVT+GJqA2AaCHmnfO8je61Aef96t/oBBgySAxrrVA3z8bkk0Sp+P3K
         L7w2+Be5k5HYSi5T8rDch1Am9mF00qcwY0MEm423p2RXzd4MU5ltWY30xhnBhC41DfZ0
         M6sw==
X-Gm-Message-State: AOAM533hhqB2295tDiLkykXglL4WUrGvBE7QctInL/ouGN5Dmv99pqQz
        /MGvewG5U5K0Dvuf2l2HG1jpa1fe
X-Google-Smtp-Source: ABdhPJwd0kBtRNh4BcmFembw1e6sDTPcwGeTDtkJyzXaUP3PVhJ++9H6G/iQgihC6//O3lczpOlvdw==
X-Received: by 2002:a17:90b:d8a:: with SMTP id bg10mr5069671pjb.103.1589794856795;
        Mon, 18 May 2020 02:40:56 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id e1sm8119867pjv.54.2020.05.18.02.40.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 02:40:56 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v16 07/11] refs.c: refactor to reuse ref_is_hidden()
Date:   Mon, 18 May 2020 05:40:35 -0400
Message-Id: <20200518094039.757-8-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200507161057.12690-1-worldhello.net@gmail.com>
References: <20200507161057.12690-1-worldhello.net@gmail.com>
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

