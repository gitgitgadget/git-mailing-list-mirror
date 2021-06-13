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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE28C48BCF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 02:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B75C60E08
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 02:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhFMC71 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Jun 2021 22:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhFMC70 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jun 2021 22:59:26 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612CBC061574
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 19:57:12 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 102-20020a9d0eef0000b02903fccc5b733fso7334646otj.4
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 19:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o1TmVRqQqVhFC24IzFy9An++0IQNz2P0G+tWtlVrVW4=;
        b=X0BrvwaeaS5bHa4dqh9DOWf8N+Jp5mbijbcr3yQrj0vHbfYUOP1FU3IErEdojxIJRg
         KTX8BtuFTtssOjpv1ffHB2EhCPO93wB2Mp0xoQB8c1yysI0GAnOykH3tTTiuFu6jBXaS
         Uhf6upKAmsOu3vdv+3GTL/MWjZrgMcrYaPLJ1bE5/akqnufX5X8LuR/+PcN4pDpqf6m4
         LCmVaENuXKVrhzjgUoT6X80bGTeQNCYByMKhUy3WatV7jqZC8J4qsL322go0JDfVZuxp
         6m63R5rPoPurStCjFs1+fJepqUNKrfzhbj4vANab6FfO1Ns5D8ir/1xO5FzRQtLSz9PO
         iA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o1TmVRqQqVhFC24IzFy9An++0IQNz2P0G+tWtlVrVW4=;
        b=DEDREyqajm5dvIW+tN5hdX0WolE5JrDeGyWTeLkidmaynh1ZVmpc0z3kZSAb0NNMeN
         pWZyuty5kNLQkkMSVJwdJ2JaC0P4vlLQMNwNmCRq22J0AXxBK4e6xkv2rcgrYs7QsHG2
         hh2img6Y41Rybad2H0pJof/yFXxyKUpfFPWwGzk8h8XNPxzOxlRMoswmG21jm2bXo+Yl
         Z99fzxNWJEhGqVodXgGYsTHAwXiKGVbGLQ548M9Mt2sGe9cw7+gGFw+1Wf7FaSdI9SM+
         z6CeYgSvFSFKvyCapXKdnr4UfxhASX7F30QDnC26cii1e0K9lgtZl43JhU3G59WGjAvM
         amfw==
X-Gm-Message-State: AOAM530tIrpJuoUuqs/aaBrwzbBrzKk3yM8dtMkBIRuc4hEdxAjyJ312
        OErrQkqGy3qLomtYj3BQA+yaGx6k0NK3qQ==
X-Google-Smtp-Source: ABdhPJwL7aebT2YTw8j7z8WmQcpkqoZ1FOu9o76Z9iSbDqqXaLY+gIc9ZeRXuNaku9XFJoB3zFqy1Q==
X-Received: by 2002:a9d:a09:: with SMTP id 9mr8714457otg.126.1623553027116;
        Sat, 12 Jun 2021 19:57:07 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id l29sm2355980ots.4.2021.06.12.19.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 19:57:06 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] rev-parse: make --quiet really be quiet
Date:   Sat, 12 Jun 2021 21:57:02 -0500
Message-Id: <20210613025702.43619-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
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
2.32.0

