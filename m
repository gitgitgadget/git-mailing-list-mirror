Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412EFC4320A
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 19:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27B206101E
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 19:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhG1ThE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 15:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbhG1Tg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 15:36:57 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB59C061765
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 12:36:54 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id k4so2157454wms.3
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 12:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WKUmfR+xPYjtTbX8Y7JT+oOJgo85mI67Y0kQM/ICFhU=;
        b=ikdA4rXZyET7yavsuOdAVcIvSVsx/UBg/D3dD16gvcfYc07Ks2YEUW7mjc9Z03qxp4
         6liqJRl6POCTmiEa0AKDti3Ms95rjTl3u/gorkDMI5l6GGubHdh3oXc/OjSYxeK05D5l
         isVnroKhlP32uHPE0Sgu12wA8SiU1NmbzMfSEXm+aR4KjSEW5ixTmU7icxxEi3I0/T8n
         vlyzsjWixN6TaCrjOworWMX5anbOGYSIdlo9Q3071R/c56rwbxbhbj4jqeEpAfBlIJ6J
         KoLVsDNK5spgTXn96rR2qXiohzhZPKdSRCg0QK3LkaTGEw2QVHRGyJx3NXkEo3xty572
         vQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WKUmfR+xPYjtTbX8Y7JT+oOJgo85mI67Y0kQM/ICFhU=;
        b=UOOF06fyB60YYUsVYLL60t17n2eUND7OC/xNsJ6EXjaZc0sLBoJcig8dlJuuVLaxrR
         1Fbb2U1FSdf0k8aZVi8oLzzPsWLXLBnRU7/8H1vD6kuH2imj7oK/RNGiXPnnZuaX1D4n
         3ry5m92r5Ur7fQr/ix3bptTiyswWGH/cxR70w40+ZZguVMY5ufY1AzCKYn5/0VzeQhSY
         0XM+uAWNqVkTU/9zBT8iSND6Z8FvylkvWRSjuo2StgLMwB7UvTal64v/KeYChURrU/oG
         KoC5jj33zHmFZjNbnVosK2hAOuWehnJsaKKfsKWeebvW7Go4yEN4LQdkm+QlNM0JcWao
         5Ipg==
X-Gm-Message-State: AOAM5330Qaq6G/C7MOyTNmXgDKYQv4VFA44s454cC5W7InojnmmHxdfH
        arv8nm47dU/Lm+x0SxqXYKbctDmarbA=
X-Google-Smtp-Source: ABdhPJzUaXB0NvXbX6KXy0P69VdLYVjmxSSaDxu43le3YzboWssjcRwUMbCOdxAjJQv6QML6jIs1cw==
X-Received: by 2002:a05:600c:3201:: with SMTP id r1mr1150261wmp.41.1627501013339;
        Wed, 28 Jul 2021 12:36:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r2sm744880wrq.15.2021.07.28.12.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 12:36:53 -0700 (PDT)
Message-Id: <7d1d131ff5b43559c8a750ebdfd6faaba93c1ad1.1627501009.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
References: <pull.1041.v5.git.git.1627391744.gitgitgadget@gmail.com>
        <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 28 Jul 2021 19:36:44 +0000
Subject: [PATCH v6 4/9] ssh signing: provide a textual representation of the
 signing key
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>,
        Fabian Stelzer <fs@gigacodes.de>,
        Fabian Stelzer <fs@gigacodes.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Fabian Stelzer <fs@gigacodes.de>

for ssh the user.signingkey can be a filename/path or even a literal ssh pubkey.
in push certs and textual output we prefer the ssh fingerprint instead.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 gpg-interface.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 gpg-interface.h |  6 ++++++
 send-pack.c     |  8 ++++----
 3 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 3afacb48900..ec48a37b6cc 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -470,6 +470,41 @@ int git_gpg_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
+static char *get_ssh_key_fingerprint(const char *signing_key)
+{
+	struct child_process ssh_keygen = CHILD_PROCESS_INIT;
+	int ret = -1;
+	struct strbuf fingerprint_stdout = STRBUF_INIT;
+	struct strbuf **fingerprint;
+
+	/*
+	 * With SSH Signing this can contain a filename or a public key
+	 * For textual representation we usually want a fingerprint
+	 */
+	if (istarts_with(signing_key, "ssh-")) {
+		strvec_pushl(&ssh_keygen.args, "ssh-keygen", "-lf", "-", NULL);
+		ret = pipe_command(&ssh_keygen, signing_key,
+				   strlen(signing_key), &fingerprint_stdout, 0,
+				   NULL, 0);
+	} else {
+		strvec_pushl(&ssh_keygen.args, "ssh-keygen", "-lf",
+			     configured_signing_key, NULL);
+		ret = pipe_command(&ssh_keygen, NULL, 0, &fingerprint_stdout, 0,
+				   NULL, 0);
+	}
+
+	if (!!ret)
+		die_errno(_("failed to get the ssh fingerprint for key '%s'"),
+			  signing_key);
+
+	fingerprint = strbuf_split_max(&fingerprint_stdout, ' ', 3);
+	if (!fingerprint[1])
+		die_errno(_("failed to get the ssh fingerprint for key '%s'"),
+			  signing_key);
+
+	return strbuf_detach(fingerprint[1], NULL);
+}
+
 /* Returns the first public key from an ssh-agent to use for signing */
 static char *get_default_ssh_signing_key(void)
 {
@@ -490,6 +525,17 @@ static char *get_default_ssh_signing_key(void)
 	return "";
 }
 
+/* Returns a textual but unique representation ot the signing key */
+const char *get_signing_key_id(void)
+{
+	if (!strcmp(use_format->name, "ssh")) {
+		return get_ssh_key_fingerprint(get_signing_key());
+	} else {
+		/* GPG/GPGSM only store a key id on this variable */
+		return get_signing_key();
+	}
+}
+
 const char *get_signing_key(void)
 {
 	if (configured_signing_key)
diff --git a/gpg-interface.h b/gpg-interface.h
index feac4decf8b..beefacbb1e9 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -64,6 +64,12 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature,
 int git_gpg_config(const char *, const char *, void *);
 void set_signing_key(const char *);
 const char *get_signing_key(void);
+
+/*
+ * Returns a textual unique representation of the signing key in use
+ * Either a GPG KeyID or a SSH Key Fingerprint
+ */
+const char *get_signing_key_id(void);
 int check_signature(const char *payload, size_t plen,
 		    const char *signature, size_t slen,
 		    struct signature_check *sigc);
diff --git a/send-pack.c b/send-pack.c
index 5a79e0e7110..50cca7e439b 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -341,13 +341,13 @@ static int generate_push_cert(struct strbuf *req_buf,
 {
 	const struct ref *ref;
 	struct string_list_item *item;
-	char *signing_key = xstrdup(get_signing_key());
+	char *signing_key_id = xstrdup(get_signing_key_id());
 	const char *cp, *np;
 	struct strbuf cert = STRBUF_INIT;
 	int update_seen = 0;
 
 	strbuf_addstr(&cert, "certificate version 0.1\n");
-	strbuf_addf(&cert, "pusher %s ", signing_key);
+	strbuf_addf(&cert, "pusher %s ", signing_key_id);
 	datestamp(&cert);
 	strbuf_addch(&cert, '\n');
 	if (args->url && *args->url) {
@@ -374,7 +374,7 @@ static int generate_push_cert(struct strbuf *req_buf,
 	if (!update_seen)
 		goto free_return;
 
-	if (sign_buffer(&cert, &cert, signing_key))
+	if (sign_buffer(&cert, &cert, get_signing_key()))
 		die(_("failed to sign the push certificate"));
 
 	packet_buf_write(req_buf, "push-cert%c%s", 0, cap_string);
@@ -386,7 +386,7 @@ static int generate_push_cert(struct strbuf *req_buf,
 	packet_buf_write(req_buf, "push-cert-end\n");
 
 free_return:
-	free(signing_key);
+	free(signing_key_id);
 	strbuf_release(&cert);
 	return update_seen;
 }
-- 
gitgitgadget

