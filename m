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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F39C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 13:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C83C1601FD
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 13:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbhG0NP4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 09:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236593AbhG0NPu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 09:15:50 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F80BC061760
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 06:15:50 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r2so15232713wrl.1
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 06:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WKUmfR+xPYjtTbX8Y7JT+oOJgo85mI67Y0kQM/ICFhU=;
        b=lfCpLkwhX2x9bA1M6gYPRPce4RKqMljli2P7/cZW1Lm6mTl89Maonfu2Pt255j3y7Y
         WpO2fx7k1lVh54GBCdgkvVybgnq5oMQ1UVHZJm83ALrpaupRXvXKHLv82krFtl8gzC40
         iru080887TaSpfFUxNMZcb1MHy34PIwtNKwLmQLmvsFOgziTpql0hsKTafA3pi5ASh9H
         InyO+CYym9hKvGarHy3eRmzicgdzwqfxfqTksbC8FXRkb5DRM3By/p0uS+KU+k0U+WqD
         nOAnH2glmHmJmtw2ip0g11hOM2g6IlUBFjhM4BwD+zkNAYYZcD3erkV9JLdl57pRVX/Z
         oOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WKUmfR+xPYjtTbX8Y7JT+oOJgo85mI67Y0kQM/ICFhU=;
        b=K3sElb2mgMTFkgUGMohU87uRKksBEklcZ+n0Fm4OXvEu0C1SnvqawnXWt8KnDEciyB
         +UVRp2xnnyvtSCsgGdYjV65Tsgkz4icpzFaxsSufORrTCXxyb4M7zpYiDYZkH7km+IX3
         24aW7aweVObKcqCM5VTZP3VhWWCEHPwSlowSEHYtNdPCCUzJa3zl6daIlj7ZGBKNEW/l
         gC2E5PS9pRShD0a1IiQ3UTxPZ4i5Wq7gtqkf5J9fUzvqjnLZOXS8WwoGwaxQhVm9g4sw
         MNN39/XA9Y8mQUhtNLAFXOHL0iYy9UYdJdZhQw9stNASyw605VzObadiihLINStX1IoX
         5+pQ==
X-Gm-Message-State: AOAM532FwJZHJC0tMijUxKsaT536TNFXFV/UQjMGmQLzwF/lTAbZ+MpI
        KSETmdZpWmwDcGLZ6PvjZ3ecbJztfQk=
X-Google-Smtp-Source: ABdhPJwZOyijfBLG3/p01Etoyg/CrxFclbE/jbnOWY3w3l1+LBMC1kpE6MvdkVvuB2h4SPQhDVepjw==
X-Received: by 2002:adf:f44e:: with SMTP id f14mr18459479wrp.101.1627391749122;
        Tue, 27 Jul 2021 06:15:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d18sm2751874wmp.46.2021.07.27.06.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 06:15:48 -0700 (PDT)
Message-Id: <7d1d131ff5b43559c8a750ebdfd6faaba93c1ad1.1627391744.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v5.git.git.1627391744.gitgitgadget@gmail.com>
References: <pull.1041.v4.git.git.1626701596.gitgitgadget@gmail.com>
        <pull.1041.v5.git.git.1627391744.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Jul 2021 13:15:39 +0000
Subject: [PATCH v5 4/9] ssh signing: provide a textual representation of the
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

