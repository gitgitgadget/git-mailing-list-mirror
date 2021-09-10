Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FA5C433FE
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 20:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1960611F2
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 20:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbhIJUJF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 16:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbhIJUI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 16:08:59 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7728DC061756
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 13:07:47 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id w29so3481501wra.8
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 13:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5wMfBYQQGn68BcMBLr5Rh1+p/RT8SGsQUyUXtfrs+5k=;
        b=TNCaEqsu/dy56AI36KvTFQv92O2H7urlYqDvzrd/ZrBI7JvuECf3CLY/ziSefCGqD0
         XIrEwY/sbF9aLmko+KhyRQz4vvSdxUlN7JAQTQ/8zwRHL9R4SzylFhE42/8Im754lUo5
         b46lH/KS+I8KZQgJnnqz5T/mfal82ILbprECmhLpuYAd2xp/2bVWS7MPdjvh3g7uJ45F
         LGB3JMAW/Zp134tN+rKIY7Gc3dXHiPkTL2VTdKRUCkYTjo6NtUecND0FHdor3kWQNovY
         WWXck9o+TvvNwmce9JnYhwA2F2i1MWi3U5THJWl2g9gSppMSONthSC/xKuB1Vs/24r6U
         OjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5wMfBYQQGn68BcMBLr5Rh1+p/RT8SGsQUyUXtfrs+5k=;
        b=MQnNW6NCglApiuPXWO22SA6yktd58F6yjh5ENwfbiABTPL37iJleH9MhazBuxAfpsk
         CKNpC8d9Fj0xkbU1K3Q+DS4ngjvnggGGx6jZgxJvLojt+bYAM0YhBY30wD+hBSnUrfUn
         Auy+vgqnY+xVbc9EvNXET4EAdXwaJS5SippBnVOeLWO3jam/ObW9aZ9o7B1KV+lw7REr
         wY5z+8ok9M44DisS/3lB14TSCCIMrNnaFJyTq6nczydFL2P/kwFJ4KVtvg7JYq++I5W/
         BG6+I/rmelL4J0aFu1sd9l4HF29LOP7qe5YcP9gQqkkioIeWNIeFfbihruGNAgO4k9CF
         /0HQ==
X-Gm-Message-State: AOAM530dBJ+vz+401nLc43nTBmACCdXaTVv0rHd1fCGPf1EU+0LhLTzh
        Os3IErYS/7sXJb4c9lfO0N6FYGdit98=
X-Google-Smtp-Source: ABdhPJyAFM16uY1/wn8UOPLELjzDZWI2DPiZt3evLyOxMjEWm8I2tjzcLnPYXsrfSh++7q/+CBdkIQ==
X-Received: by 2002:adf:e6c9:: with SMTP id y9mr11810821wrm.430.1631304465918;
        Fri, 10 Sep 2021 13:07:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m12sm5430864wrq.29.2021.09.10.13.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 13:07:45 -0700 (PDT)
Message-Id: <8c430fc7a1b0bc60911e3fe338b094abc09b4ef9.1631304462.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v8.git.git.1631304462.gitgitgadget@gmail.com>
References: <pull.1041.v7.git.git.1627998358.gitgitgadget@gmail.com>
        <pull.1041.v8.git.git.1631304462.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Sep 2021 20:07:37 +0000
Subject: [PATCH v8 4/9] ssh signing: retrieve a default key from ssh-agent
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
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Fabian Stelzer <fabian@stelzer.cloud>,
        Fabian Stelzer <fs@gigacodes.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Fabian Stelzer <fs@gigacodes.de>

If user.signingkey is not set and a ssh signature is requested we call
gpg.ssh.defaultKeyCommand (typically "ssh-add -L") and use the first key we get

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 Documentation/config/gpg.txt  |  6 +++
 Documentation/config/user.txt |  4 +-
 gpg-interface.c               | 70 ++++++++++++++++++++++++++++++++++-
 3 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
index 88531b15f0f..9b95dd280c3 100644
--- a/Documentation/config/gpg.txt
+++ b/Documentation/config/gpg.txt
@@ -33,3 +33,9 @@ gpg.minTrustLevel::
 * `marginal`
 * `fully`
 * `ultimate`
+
+gpg.ssh.defaultKeyCommand:
+	This command that will be run when user.signingkey is not set and a ssh
+	signature is requested. On successful exit a valid ssh public key is
+	expected in the	first line of its output. To automatically use the first
+	available key from your ssh-agent set this to "ssh-add -L".
diff --git a/Documentation/config/user.txt b/Documentation/config/user.txt
index 2155128957c..ad78dce9ecb 100644
--- a/Documentation/config/user.txt
+++ b/Documentation/config/user.txt
@@ -40,4 +40,6 @@ user.signingKey::
 	key (e.g.: "ssh-rsa XXXXXX identifier") or a file which contains it and
 	corresponds to the private key used for signing. The private key
 	needs to be available via ssh-agent. Alternatively it can be set to
-	a file containing a private key directly.
+	a file containing a private key directly. If not set git will call
+	gpg.ssh.defaultKeyCommand (e.g.: "ssh-add -L") and try to use the first
+	key available.
diff --git a/gpg-interface.c b/gpg-interface.c
index 7ca682ac6d6..3a0cca1b1d2 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -6,8 +6,10 @@
 #include "gpg-interface.h"
 #include "sigchain.h"
 #include "tempfile.h"
+#include "alias.h"
 
 static char *configured_signing_key;
+static const char *ssh_default_key_command;
 static enum signature_trust_level configured_min_trust_level = TRUST_UNDEFINED;
 
 struct gpg_format {
@@ -21,6 +23,7 @@ struct gpg_format {
 				    size_t signature_size);
 	int (*sign_buffer)(struct strbuf *buffer, struct strbuf *signature,
 			   const char *signing_key);
+	const char *(*get_default_key)(void);
 };
 
 static const char *openpgp_verify_args[] = {
@@ -56,6 +59,8 @@ static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
 static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
 			   const char *signing_key);
 
+static const char *get_default_ssh_signing_key(void);
+
 static struct gpg_format gpg_format[] = {
 	{
 		.name = "openpgp",
@@ -64,6 +69,7 @@ static struct gpg_format gpg_format[] = {
 		.sigs = openpgp_sigs,
 		.verify_signed_buffer = verify_gpg_signed_buffer,
 		.sign_buffer = sign_buffer_gpg,
+		.get_default_key = NULL,
 	},
 	{
 		.name = "x509",
@@ -72,6 +78,7 @@ static struct gpg_format gpg_format[] = {
 		.sigs = x509_sigs,
 		.verify_signed_buffer = verify_gpg_signed_buffer,
 		.sign_buffer = sign_buffer_gpg,
+		.get_default_key = NULL,
 	},
 	{
 		.name = "ssh",
@@ -79,7 +86,8 @@ static struct gpg_format gpg_format[] = {
 		.verify_args = ssh_verify_args,
 		.sigs = ssh_sigs,
 		.verify_signed_buffer = NULL, /* TODO */
-		.sign_buffer = sign_buffer_ssh
+		.sign_buffer = sign_buffer_ssh,
+		.get_default_key = get_default_ssh_signing_key,
 	},
 };
 
@@ -453,6 +461,12 @@ int git_gpg_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "gpg.ssh.defaultkeycommand")) {
+		if (!value)
+			return config_error_nonbool(var);
+		return git_config_string(&ssh_default_key_command, var, value);
+	}
+
 	if (!strcmp(var, "gpg.program") || !strcmp(var, "gpg.openpgp.program"))
 		fmtname = "openpgp";
 
@@ -470,11 +484,63 @@ int git_gpg_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
+/* Returns the first public key from an ssh-agent to use for signing */
+static const char *get_default_ssh_signing_key(void)
+{
+	struct child_process ssh_default_key = CHILD_PROCESS_INIT;
+	int ret = -1;
+	struct strbuf key_stdout = STRBUF_INIT, key_stderr = STRBUF_INIT;
+	struct strbuf **keys;
+	char *key_command = NULL;
+	const char **argv;
+	int n;
+	char *default_key = NULL;
+
+	if (!ssh_default_key_command)
+		die(_("either user.signingkey or gpg.ssh.defaultKeyCommand needs to be configured"));
+
+	key_command = xstrdup(ssh_default_key_command);
+	n = split_cmdline(key_command, &argv);
+
+	if (n < 0)
+		die("malformed build-time gpg.ssh.defaultKeyCommand: %s",
+		    split_cmdline_strerror(n));
+
+	strvec_pushv(&ssh_default_key.args, argv);
+	ret = pipe_command(&ssh_default_key, NULL, 0, &key_stdout, 0,
+			   &key_stderr, 0);
+
+	if (!ret) {
+		keys = strbuf_split_max(&key_stdout, '\n', 2);
+		if (keys[0] && starts_with(keys[0]->buf, "ssh-")) {
+			default_key = strbuf_detach(keys[0], NULL);
+		} else {
+			warning(_("gpg.ssh.defaultKeycommand succeeded but returned no keys: %s %s"),
+				key_stderr.buf, key_stdout.buf);
+		}
+
+		strbuf_list_free(keys);
+	} else {
+		warning(_("gpg.ssh.defaultKeyCommand failed: %s %s"),
+			key_stderr.buf, key_stdout.buf);
+	}
+
+	free(key_command);
+	free(argv);
+	strbuf_release(&key_stdout);
+
+	return default_key;
+}
+
 const char *get_signing_key(void)
 {
 	if (configured_signing_key)
 		return configured_signing_key;
-	return git_committer_info(IDENT_STRICT|IDENT_NO_DATE);
+	if (use_format->get_default_key) {
+		return use_format->get_default_key();
+	}
+
+	return git_committer_info(IDENT_STRICT | IDENT_NO_DATE);
 }
 
 int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key)
-- 
gitgitgadget

