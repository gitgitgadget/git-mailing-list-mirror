Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10321C4320A
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 13:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E56E5603E9
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 13:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbhHCNq0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 09:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236279AbhHCNqX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 09:46:23 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AB6C06179A
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 06:46:11 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id k4so12528557wms.3
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 06:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5wMfBYQQGn68BcMBLr5Rh1+p/RT8SGsQUyUXtfrs+5k=;
        b=V12n/1oS6jNre4+l6vDCDaWGRJ3rlfG02ZkJcGkH+YEC5paOjaTHNZAMEQFqfirMHg
         iY2tv/3qNLKduo576TCnuY0fgGfQo1dqZ15qIy+7hpWFj4md/IvRw5BfCcTJke+EJZAl
         QcIabsLIW5uu002TQ6vNQ9/MHJYZWw5/E2ooZiomg0OBBptPZtgdHQA2ZkGajp6ZsJk2
         GSteznZ/u06CKd6Cx8c7S35v8UJXtfeGPLbBkEOsJeN9A3fmNxNszgR4LqBkXL6fFLDD
         xkYcI5g6jFZBX0Gjca5O+ycM7J5awsji+U17PPp4GJIRxrxpnwbuhVFAaHdSvP3PXJPg
         nDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5wMfBYQQGn68BcMBLr5Rh1+p/RT8SGsQUyUXtfrs+5k=;
        b=OfNkR7OJzUUSLEkgTll6E6/+B0cMsdlH7MjbTFW+YSggAIDdt3H1M7tP4S+FNB2c9T
         e3eBxMs/pkLKsmyL5sZVMuVGngqiylkv43h/omU4hRoo/AcPpiQRjUurjLeYOHY0wk2K
         duqZ+L31o3/03Cw3z3x8z0UzWX29aaorWNYnkJdiOsMSibVufqhUV97m3jr4YDYhUF8y
         CV4mo5DT8bghWKMA80DEsmXBjKYbjiJpc2tsCpzaAiLGBXn3yEabNmDJCSPx2dS547tB
         lq4sIfLCu3zO64volM6IIwOS8p0TCjhsXfHCer3MGVBTbQSg1kTizH98hSKt0t0A2K2V
         0OFw==
X-Gm-Message-State: AOAM532rSKoP3WvAhP8gArFI7Hv57n30JGGyIsNtXYkgm8C6c187TlwB
        KjYYR70Tr/wiq9KIni65OXv+4Bj8lVI=
X-Google-Smtp-Source: ABdhPJyMajESWVb8QqQ9f2i537+VOiQPDr3Gco+tqSGgIHT1i9sGBSpYMZZYNIJwd5LDOrmoOh16jA==
X-Received: by 2002:a7b:cb09:: with SMTP id u9mr4426224wmj.63.1627998369898;
        Tue, 03 Aug 2021 06:46:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j14sm14649362wrr.16.2021.08.03.06.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 06:46:07 -0700 (PDT)
Message-Id: <83ece42e1dee09968444abe808e030c9210a5ba8.1627998358.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v7.git.git.1627998358.gitgitgadget@gmail.com>
References: <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
        <pull.1041.v7.git.git.1627998358.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Aug 2021 13:45:53 +0000
Subject: [PATCH v7 4/9] ssh signing: retrieve a default key from ssh-agent
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
        Fabian Stelzer <fs@gigacodes.de>,
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

