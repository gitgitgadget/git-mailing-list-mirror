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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1BEC12002
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 13:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E8C561006
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 13:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238603AbhGSMwv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 08:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238574AbhGSMwn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 08:52:43 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB19C061762
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 05:55:05 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k4so22042921wrc.8
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 06:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=g8JFE2GPhkc+dxVkNqkAEWnWbAmj4nPn8KdldV0L4yA=;
        b=vPI0uCShRsj/8bqJadSJHH+deIIs2+eoLBWDVqZCGcMRuI3z6VooVgs8MxcxwFfHvX
         3l8bKza2GaPIR+9jAbFB661XfSfeMLMhz3IvpM2fzwOa2pG2VzQlZmzn/aohm70jmRJT
         SYB+CKy/U/AN6BhrUWN0tAoGODt7TjkHfsYUWVdXmHdU18gvcsgBad3+KSojSOVxEkhG
         TmNoHhlZPmnKSnu13rOehr/xozDQaR1AwLrCjNXIqRxbsbeAKg4nW3Ht3VHDxIjMAOBG
         ADv0l8P2lcJpkGXEV+v32As8Xbm08Ao2J/Gu1hImEFDW7nKcMDmgYCRTyfC7RGJ0c7os
         w6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=g8JFE2GPhkc+dxVkNqkAEWnWbAmj4nPn8KdldV0L4yA=;
        b=MBnG+jnlC9FS0GkJjrNKbmN8CRaWE6VvCfETVVUHGrMN26RTRbP6abt452CQnimRV8
         UNdJfPSAS0TC2vq1ANw9zwUPyx6sNmE+gJtj1PVJfvHcA02oST9KfUkdXYjIQAAj2Y5N
         jSEh7uIbtRZ/R52DYpwnXymE0dsA6Q54Bn7+OS7N1BRF1MTyYB8y/BbUd2twBf4ovQv6
         nvB2sby/1VAO2VR+4b2Qxcx85r9o+xJTZNIm99z462XwygSROA20lMRjcf6R7+LbwB+Y
         hXLkmicmGqgvJ40u+o9k0YSuTVdz4wlKX+byTbgGuB2S2MOR14DDiWD17w6hOcA+FgLv
         a5kA==
X-Gm-Message-State: AOAM530hsAZ4QlSZK5+xn92cH6Mqe7ohy4LGynqGH8f9Kyw7SvTWbsmz
        Lh6gKtMPHToqHiN6oUdfVmZvMXiigCs=
X-Google-Smtp-Source: ABdhPJyXJo47euIQDQrsc6VLYWOQQKSMgGqPJwmRjBpLwcdvBcGKNM1UMC5ZfqQ4FpTqxkQLJUQ3iA==
X-Received: by 2002:a05:6000:18a9:: with SMTP id b9mr30015905wri.418.1626701601951;
        Mon, 19 Jul 2021 06:33:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k22sm16257752wms.47.2021.07.19.06.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 06:33:21 -0700 (PDT)
Message-Id: <ec6931082ee6dc3a5820696d0db512faa88c256f.1626701596.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v4.git.git.1626701596.gitgitgadget@gmail.com>
References: <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com>
        <pull.1041.v4.git.git.1626701596.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Jul 2021 13:33:11 +0000
Subject: [PATCH v4 4/9] ssh signing: provide a textual representation of the
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
index 35e584b94ef..2c6eaf47d0f 100644
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
index 9cb9f716509..191fc6da544 100644
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

