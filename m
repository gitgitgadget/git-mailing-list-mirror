Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A73C61DA4
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 14:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjBIOfS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 09:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjBIOfP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 09:35:15 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F9F1F5C9
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 06:35:13 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h16so1943226wrz.12
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 06:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvPUo3Q3otPmAondEiTJrOMXcBD72bDr0YvXmo9Bu9k=;
        b=nkcBkpAnU7OEeYH+omBKqWQmi01Cp7VZq7AVPWanajEC/zX1pNjwdHvTiF2ZI7vfTp
         qeDi1sabb1cTkJSnpPovBotlqi6gdksMEzeWUMdM+7x9KMRx5ypZAMUaOxCyUrjlNhkR
         7442jbBdfRmrGNmFagNCU6rJO9e5GqgamBk9uostfFIDx2W+kSaKdtH+TB7in7twx5UA
         PZahP/NPtlLx6uLTIpK4RjI1pt1IpiiSMXPxnzXuGZnJFnNMQXsfn7zUzAzTDgvwbM7z
         R9qQEqC59iPidgCJDN2xpzPT7445TZx9MrQZ7CrcZwcjvNFMRM7vFFIF8zbDLq30O1bx
         h1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LvPUo3Q3otPmAondEiTJrOMXcBD72bDr0YvXmo9Bu9k=;
        b=tyo2i7pNOZIKlWaYU+ltAda/Me/SFTmO9yMS6NxQozRhiIW+j5LODeaiZErErGQiqK
         ZNIkuPLnxoZALlX8JzQyVvko3uNDhP18y2ep6JI2P/4SLbNiyN8CuAclrZMOFUiBTn/v
         p+Lt1f9Mket67k2uJPvRqlmJzY3xVT2/Iz3+yLulQclgasvjBgFdhjATFAjYVoE6OKxS
         sh+CrP6Y44FMc7EWFxYhUw4xqtllWyk12braBlgimXvpl7b2NfoeMbhb/7JU0DcSAftm
         sKz1e3jm4dmiWxJIjEGRN1cQIuC7y0mO1vjm6elHRUK6Eip3j8ekxbLcrpQRhcYseo0/
         vBbQ==
X-Gm-Message-State: AO0yUKWVwgiftwiA2kCnRvyifXls0f0XXrKKXG0UH8+RHcpY56gh4u+F
        8/ku3OAcANI/AaudHFQ94WYGx3wVMpWmxiFv
X-Google-Smtp-Source: AK7set+Vr6NVuXnrDSCfvB0CshS2LqgPyE2biH5gK7tcUOtQVkmejJ9CBtB0MWaHpVPFV2NSxU6Qig==
X-Received: by 2002:a5d:4350:0:b0:2bf:d137:9945 with SMTP id u16-20020a5d4350000000b002bfd1379945mr9973147wrr.51.1675953311770;
        Thu, 09 Feb 2023 06:35:11 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k10-20020a056000004a00b002c3d814cc63sm1391477wrx.76.2023.02.09.06.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 06:35:11 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Max Gautier <max.gautier@redhat.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] gpg-interface.c: lazily get GPG config variables on demand
Date:   Thu,  9 Feb 2023 15:35:06 +0100
Message-Id: <patch-2.2-c099d48b4bf-20230209T142225Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1475.gc2542cdc5ef
In-Reply-To: <cover-0.2-00000000000-20230209T142225Z-avarab@gmail.com>
References: <+TqEM21o+3TGx6D@coredump.intra.peff.net> <cover-0.2-00000000000-20230209T142225Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the preceding commit we started calling gpg_interface_lazy_init()
when the interface is used, in order to lazily init config.

Parts of the git_gpg_config() we were left with then are going to be
harder to convert to the configset API. E.g. in the case of
"configured_signing_key" the set_signing_key() and get_signing_key()
will modify our global variable, assigning either the config to it, a
user-supplied key (see "keyid" in builtin/tag.c). To avoid the global
we'd need to pass that "keyid" all the way down to the callbacks in
"struct gpg_format".

But in the cases being changed here we can move the reading of the
config variable to be adjacent to its use.

As with the preceding change this isn't without its downsides, just as
in the preceding commit this stopped being an immediate error, and
instead depends on whether we'll reach something that lazily inits the
GPG config:

	git -c gpg.mintrustlevel=bad show --show-signature

This change likewise defers our initialization of these variables even
further. But this should be OK, it's the common pattern for most other
config we read.

At this point we could remove gpg_interface_lazy_init() from
check_signature(), as it only uses gpg.minTrustLevel, and calls
functions that don't need the lazy config, but let's keep to
future-proof changes to the API that may need the initialization at a
distance.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 gpg-interface.c | 66 +++++++++++++++++++------------------------------
 1 file changed, 25 insertions(+), 41 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 404d4cccf34..ab24ed3c57b 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -22,8 +22,6 @@ static void gpg_interface_lazy_init(void)
 }
 
 static char *configured_signing_key;
-static const char *ssh_default_key_command, *ssh_allowed_signers, *ssh_revocation_file;
-static enum signature_trust_level configured_min_trust_level = TRUST_UNDEFINED;
 
 struct gpg_format {
 	const char *name;
@@ -453,6 +451,7 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 	struct strbuf ssh_keygen_out = STRBUF_INIT;
 	struct strbuf ssh_keygen_err = STRBUF_INIT;
 	struct strbuf verify_time = STRBUF_INIT;
+	char *ssh_allowed_signers;
 	const struct date_mode verify_date_mode = {
 		.type = DATE_STRFTIME,
 		.strftime_fmt = "%Y%m%d%H%M%S",
@@ -460,7 +459,8 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 		.local = 1,
 	};
 
-	if (!ssh_allowed_signers) {
+	if (git_config_get_string("gpg.ssh.allowedsignersfile",
+				  &ssh_allowed_signers)) {
 		error(_("gpg.ssh.allowedSignersFile needs to be configured and exist for ssh signature verification"));
 		return -1;
 	}
@@ -520,6 +520,7 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 		     *line;
 		     line = next) {
 			const char *end_of_text;
+			char *ssh_revocation_file;
 
 			next = end_of_text = strchrnul(line, '\n');
 
@@ -556,7 +557,8 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 				     verify_time.buf,
 				     NULL);
 
-			if (ssh_revocation_file) {
+			if (!git_config_get_pathname("gpg.ssh.revocationfile",
+						     (const char **)&ssh_revocation_file)) {
 				if (file_exists(ssh_revocation_file)) {
 					strvec_pushl(&ssh_keygen.args, "-r",
 						     ssh_revocation_file, NULL);
@@ -564,6 +566,7 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 					warning(_("ssh signing revocation file configured but not found: %s"),
 						ssh_revocation_file);
 				}
+				free(ssh_revocation_file);
 			}
 
 			sigchain_push(SIGPIPE, SIG_IGN);
@@ -599,6 +602,7 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 	strbuf_release(&ssh_keygen_out);
 	strbuf_release(&ssh_keygen_err);
 	strbuf_release(&verify_time);
+	free(ssh_allowed_signers);
 
 	return ret;
 }
@@ -643,6 +647,8 @@ int check_signature(struct signature_check *sigc,
 {
 	struct gpg_format *fmt;
 	int status;
+	static enum signature_trust_level configured_min_trust_level = TRUST_UNDEFINED;
+	const char *value;
 
 	gpg_interface_lazy_init();
 
@@ -661,6 +667,19 @@ int check_signature(struct signature_check *sigc,
 	if (status && !sigc->output)
 		return !!status;
 
+	if (!git_config_get_string_tmp("gpg.mintrustlevel", &value)) {
+		char *trust;
+		int ret;
+
+		trust = xstrdup_toupper(value);
+		ret = parse_gpg_trust_level(trust, &configured_min_trust_level);
+		free(trust);
+
+		if (ret)
+			return error(_("invalid value for '%s': '%s'"),
+				     "gpg.mintrustlevel", value);
+	}
+
 	status |= sigc->result != 'G';
 	status |= sigc->trust_level < configured_min_trust_level;
 
@@ -719,8 +738,6 @@ static int git_gpg_config(const char *var, const char *value, void *cb UNUSED)
 {
 	struct gpg_format *fmt = NULL;
 	char *fmtname = NULL;
-	char *trust;
-	int ret;
 
 	if (!strcmp(var, "user.signingkey")) {
 		if (!value)
@@ -740,38 +757,6 @@ static int git_gpg_config(const char *var, const char *value, void *cb UNUSED)
 		return 0;
 	}
 
-	if (!strcmp(var, "gpg.mintrustlevel")) {
-		if (!value)
-			return config_error_nonbool(var);
-
-		trust = xstrdup_toupper(value);
-		ret = parse_gpg_trust_level(trust, &configured_min_trust_level);
-		free(trust);
-
-		if (ret)
-			return error(_("invalid value for '%s': '%s'"),
-				     var, value);
-		return 0;
-	}
-
-	if (!strcmp(var, "gpg.ssh.defaultkeycommand")) {
-		if (!value)
-			return config_error_nonbool(var);
-		return git_config_string(&ssh_default_key_command, var, value);
-	}
-
-	if (!strcmp(var, "gpg.ssh.allowedsignersfile")) {
-		if (!value)
-			return config_error_nonbool(var);
-		return git_config_pathname(&ssh_allowed_signers, var, value);
-	}
-
-	if (!strcmp(var, "gpg.ssh.revocationfile")) {
-		if (!value)
-			return config_error_nonbool(var);
-		return git_config_pathname(&ssh_revocation_file, var, value);
-	}
-
 	if (!strcmp(var, "gpg.program") || !strcmp(var, "gpg.openpgp.program"))
 		fmtname = "openpgp";
 
@@ -851,16 +836,15 @@ static const char *get_default_ssh_signing_key(void)
 	int ret = -1;
 	struct strbuf key_stdout = STRBUF_INIT, key_stderr = STRBUF_INIT;
 	struct strbuf **keys;
-	char *key_command = NULL;
+	char *key_command;
 	const char **argv;
 	int n;
 	char *default_key = NULL;
 	const char *literal_key = NULL;
 
-	if (!ssh_default_key_command)
+	if (git_config_get_string("gpg.ssh.defaultkeycommand", &key_command))
 		die(_("either user.signingkey or gpg.ssh.defaultKeyCommand needs to be configured"));
 
-	key_command = xstrdup(ssh_default_key_command);
 	n = split_cmdline(key_command, &argv);
 
 	if (n < 0)
-- 
2.39.1.1475.gc2542cdc5ef

