Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEABC07E96
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 03:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E95D361CB9
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 03:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhGGDHo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 23:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhGGDHo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 23:07:44 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0007DC061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 20:05:03 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id u11so1797182oiv.1
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 20:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sEMeG+riLh3JNCgZAuTO1nazbkUoL1kTiHz1z97/fTk=;
        b=IVoXTgBbUc120ady9EQjrZaF20cfzMMNOkyPP4CstEbZOhe/22iRid272vZ3Lgk4lM
         roN44iLZnP7OtUzhzOh4WQ2qXzIWJtNOW/QSETHzjLrQe+2Cwco3TUE8zu6RxGdKWrCV
         YgJHfIghHrHqi0saIGX+JPxAa+MJyLg/VvOEMB5YV+GLhonb0PkLPsYM6d6J/vF4cB59
         zg0a0WmIk9PpkJ/93sN0IwBhuR8AETUDTbSnyTSBM3dJlmNU3mJqR2a96h1P4ffGq6KR
         FB2AfL1Cmgr6QjascA3x+2lKIZ5pSVpfAgIomMZIyiqVdANMmo3DTN1NJtQfQ8RftWGj
         Ckxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sEMeG+riLh3JNCgZAuTO1nazbkUoL1kTiHz1z97/fTk=;
        b=jQbm5hKTQPly3WMb9KGzwQoyD75fQnXpT3t5kXCtXrnVQuu/7H+V+fbkLtHaBv2edY
         nKqtIG57WxYZ/bFcfnZ0kJ3lD2KF2hvtOoYdY0MZbaTSE4YSk5Di927koeMuNYLhRT/q
         AZ6EI/edhjjm5Y4ihlhDGiGvfrzVFq402w9KnThADxlAYI7Lrm3bx/BU1Wq7QJBDVHmg
         4mXDInfeWZmX4emswzJVckUBwi/y4NRNxvCtVlGplzkzXKWk3Rb6uvKRIN4YyGSsst+O
         iCwiACt9TrKWHfGtwaMfjER/Y0TGXqeCUNjfTzHcDFt3MTUzo2vSkK7/QZWM+xERBu+3
         lF1Q==
X-Gm-Message-State: AOAM530fvqv6WPRdGiqA0YpjF/9zfEkXZtc53RDY2SD1Z8AdHyquXCo1
        h+7g3ti3ywI2LCXHbRCQ3Otww5SxFdM=
X-Google-Smtp-Source: ABdhPJxtv6XCP3bVkKu/Buh789AMQRY2TTTrwk+aqRLxQj4UhjD0w63dY7i0oAAmSCQn25ZIjqiK+Q==
X-Received: by 2002:aca:3017:: with SMTP id w23mr1331857oiw.141.1625627103062;
        Tue, 06 Jul 2021 20:05:03 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id f12sm3353111ooh.38.2021.07.06.20.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 20:05:02 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH try2] rev-parse: make --quiet really be quiet
Date:   Tue,  6 Jul 2021 22:04:58 -0500
Message-Id: <20210707030458.3134502-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently `git rev-parse --quiet --verify @{upstream}` throws an error,
when it clearly shouldn't.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 object-name.c               | 7 ++++---
 t/t1503-rev-parse-verify.sh | 2 ++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/object-name.c b/object-name.c
index 64202de60b..b45369baab 100644
--- a/object-name.c
+++ b/object-name.c
@@ -806,10 +806,11 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 	char *real_ref = NULL;
 	int refs_found = 0;
 	int at, reflog_len, nth_prior = 0;
+	int quiet = !!(flags & GET_OID_QUIETLY);
 
 	if (len == r->hash_algo->hexsz && !get_oid_hex(str, oid)) {
 		if (warn_ambiguous_refs && warn_on_object_refname_ambiguity) {
-			refs_found = repo_dwim_ref(r, str, len, &tmp_oid, &real_ref, 0);
+			refs_found = repo_dwim_ref(r, str, len, &tmp_oid, &real_ref, quiet);
 			if (refs_found > 0) {
 				warning(warn_msg, len, str);
 				if (advice_object_name_warning)
@@ -860,11 +861,11 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 
 	if (!len && reflog_len)
 		/* allow "@{...}" to mean the current branch reflog */
-		refs_found = repo_dwim_ref(r, "HEAD", 4, oid, &real_ref, 0);
+		refs_found = repo_dwim_ref(r, "HEAD", 4, oid, &real_ref, quiet);
 	else if (reflog_len)
 		refs_found = repo_dwim_log(r, str, len, oid, &real_ref);
 	else
-		refs_found = repo_dwim_ref(r, str, len, oid, &real_ref, 0);
+		refs_found = repo_dwim_ref(r, str, len, oid, &real_ref, quiet);
 
 	if (!refs_found)
 		return -1;
diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index bf08102391..688c5abdc9 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -83,6 +83,8 @@ test_expect_success 'fails silently when using -q' '
 	test_must_fail git rev-parse --quiet --verify baz HEAD 2>error &&
 	test_must_be_empty error &&
 	test_must_fail git rev-parse -q --verify $HASH2 HEAD 2>error &&
+	test_must_be_empty error &&
+	test_must_fail git rev-parse -q --verify @{upstream} 2>error &&
 	test_must_be_empty error
 '
 
-- 
2.32.0.36.g70aac2b1aa

