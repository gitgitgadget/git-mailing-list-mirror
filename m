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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F331FC4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 13:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDA67603E9
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 13:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbhHCNqQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 09:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbhHCNqP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 09:46:15 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3890C06175F
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 06:46:04 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b13so14518238wrs.3
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 06:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SamF6pB4gPy4v5Aig9Mr/SZJEFPShDcWoIFkKcInTd8=;
        b=CT19CYQh23otxKGWZ9YSDQca44h4b2qVrH3PYGFaDGm91JJVt0DvHPY6L7ErklyC8Z
         KppVppFxWWpE5se5F9GHFgSpuLhU/vVa0UM0MxNP8eNHjIkzibvAZGjQWdQAgTrl7M3t
         /COzIukR6LROdogkzmTF6I7FP02KAzxM8mPtQPOm/7ndDYhB2ssRPEyoYmz38OqHH9dR
         YTFlmG8nQFBchDlEz/bp88QWCduePkRDHY9y5TKAHJBWTG7SPV2VMfpV+XfDIRGMr+0b
         uvjR3ez0sFlHDatqPd19sC6NFkvNOPKp1+6vWfdEu4cK6QVoYBXT4qD0Nb+mljWNx/Nf
         PT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SamF6pB4gPy4v5Aig9Mr/SZJEFPShDcWoIFkKcInTd8=;
        b=quVKSYYJ2I742C/Mo9BpUfTJQ51yzAgZOReHA17pOfSJI3moavuCj0ElG41fVCizUZ
         3eeHsCnfJ6ygarnSCHf+TnWewqhWSDmvuklOFu6Ss3Up9VgKOBVkjbdsrCiI9qg2UFC7
         yj8mubecNvP/sXSA9upJGCFKXdD5DGVldYxxy5RtKmwUJ51pCIjD3NsqMyfdvDJizDGa
         zZhjE9AuPnxyoQvD+euNgts8RXztk8hNCT4LqrZqXmo0zvFyf+L8gbWNQzJkExsPYtp+
         qZg+rEIOmmlgn+S1imW6uTeKLyX/8yEp8IpIFUByf4MTv/qU4n9SLRWLsqqm8P7jiL8o
         xeqQ==
X-Gm-Message-State: AOAM533TYZ9RIGaTgf7VcwNpCZ3IG7HrmsL1Ive1TDHMb+DjTdfzVnUK
        m1gTN5ZEFZOW1RKUFtoCqJrBlMap4ok=
X-Google-Smtp-Source: ABdhPJzcPTjyCa3Dm7lXDe3fl3HMWaHXJpvf0ufYxabQ57RnoL/zR4CqcfHyZgdRX970gIV+27bJsA==
X-Received: by 2002:adf:cd92:: with SMTP id q18mr23529131wrj.18.1627998363295;
        Tue, 03 Aug 2021 06:46:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r129sm4607724wmr.7.2021.08.03.06.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 06:46:02 -0700 (PDT)
Message-Id: <91fd0159e1f8d729c9144f61109496f018dcef47.1627998358.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v7.git.git.1627998358.gitgitgadget@gmail.com>
References: <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
        <pull.1041.v7.git.git.1627998358.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Aug 2021 13:45:50 +0000
Subject: [PATCH v7 1/9] ssh signing: preliminary refactoring and clean-up
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

Openssh v8.2p1 added some new options to ssh-keygen for signature
creation and verification. These allow us to use ssh keys for git
signatures easily.

In our corporate environment we use PIV x509 Certs on Yubikeys for email
signing/encryption and ssh keys which I think is quite common
(at least for the email part). This way we can establish the correct
trust for the SSH Keys without setting up a separate GPG Infrastructure
(which is still quite painful for users) or implementing x509 signing
support for git (which lacks good forwarding mechanisms).
Using ssh agent forwarding makes this feature easily usable in todays
development environments where code is often checked out in remote VMs / containers.
In such a setup the keyring & revocationKeyring can be centrally
generated from the x509 CA information and distributed to the users.

To be able to implement new signing formats this commit:
 - makes the sigc structure more generic by renaming "gpg_output" to
   "output"
 - introduces function pointers in the gpg_format structure to call
   format specific signing and verification functions
 - moves format detection from verify_signed_buffer into the check_signature
   api function and calls the format specific verify
 - renames and wraps sign_buffer to handle format specific signing logic
   as well

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 fmt-merge-msg.c |   6 +--
 gpg-interface.c | 104 +++++++++++++++++++++++++++++-------------------
 gpg-interface.h |   2 +-
 log-tree.c      |   8 ++--
 pretty.c        |   4 +-
 5 files changed, 74 insertions(+), 50 deletions(-)

diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 0f66818e0f8..fb300bb4b67 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -526,11 +526,11 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 			buf = payload.buf;
 			len = payload.len;
 			if (check_signature(payload.buf, payload.len, sig.buf,
-					 sig.len, &sigc) &&
-				!sigc.gpg_output)
+					    sig.len, &sigc) &&
+			    !sigc.output)
 				strbuf_addstr(&sig, "gpg verification failed.\n");
 			else
-				strbuf_addstr(&sig, sigc.gpg_output);
+				strbuf_addstr(&sig, sigc.output);
 		}
 		signature_check_clear(&sigc);
 
diff --git a/gpg-interface.c b/gpg-interface.c
index 127aecfc2b0..db54b054162 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -15,6 +15,12 @@ struct gpg_format {
 	const char *program;
 	const char **verify_args;
 	const char **sigs;
+	int (*verify_signed_buffer)(struct signature_check *sigc,
+				    struct gpg_format *fmt, const char *payload,
+				    size_t payload_size, const char *signature,
+				    size_t signature_size);
+	int (*sign_buffer)(struct strbuf *buffer, struct strbuf *signature,
+			   const char *signing_key);
 };
 
 static const char *openpgp_verify_args[] = {
@@ -35,14 +41,29 @@ static const char *x509_sigs[] = {
 	NULL
 };
 
+static int verify_gpg_signed_buffer(struct signature_check *sigc,
+				    struct gpg_format *fmt, const char *payload,
+				    size_t payload_size, const char *signature,
+				    size_t signature_size);
+static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
+			   const char *signing_key);
+
 static struct gpg_format gpg_format[] = {
-	{ .name = "openpgp", .program = "gpg",
-	  .verify_args = openpgp_verify_args,
-	  .sigs = openpgp_sigs
+	{
+		.name = "openpgp",
+		.program = "gpg",
+		.verify_args = openpgp_verify_args,
+		.sigs = openpgp_sigs,
+		.verify_signed_buffer = verify_gpg_signed_buffer,
+		.sign_buffer = sign_buffer_gpg,
 	},
-	{ .name = "x509", .program = "gpgsm",
-	  .verify_args = x509_verify_args,
-	  .sigs = x509_sigs
+	{
+		.name = "x509",
+		.program = "gpgsm",
+		.verify_args = x509_verify_args,
+		.sigs = x509_sigs,
+		.verify_signed_buffer = verify_gpg_signed_buffer,
+		.sign_buffer = sign_buffer_gpg,
 	},
 };
 
@@ -72,7 +93,7 @@ static struct gpg_format *get_format_by_sig(const char *sig)
 void signature_check_clear(struct signature_check *sigc)
 {
 	FREE_AND_NULL(sigc->payload);
-	FREE_AND_NULL(sigc->gpg_output);
+	FREE_AND_NULL(sigc->output);
 	FREE_AND_NULL(sigc->gpg_status);
 	FREE_AND_NULL(sigc->signer);
 	FREE_AND_NULL(sigc->key);
@@ -257,16 +278,16 @@ error:
 	FREE_AND_NULL(sigc->key);
 }
 
-static int verify_signed_buffer(const char *payload, size_t payload_size,
-				const char *signature, size_t signature_size,
-				struct strbuf *gpg_output,
-				struct strbuf *gpg_status)
+static int verify_gpg_signed_buffer(struct signature_check *sigc,
+				    struct gpg_format *fmt, const char *payload,
+				    size_t payload_size, const char *signature,
+				    size_t signature_size)
 {
 	struct child_process gpg = CHILD_PROCESS_INIT;
-	struct gpg_format *fmt;
 	struct tempfile *temp;
 	int ret;
-	struct strbuf buf = STRBUF_INIT;
+	struct strbuf gpg_stdout = STRBUF_INIT;
+	struct strbuf gpg_stderr = STRBUF_INIT;
 
 	temp = mks_tempfile_t(".git_vtag_tmpXXXXXX");
 	if (!temp)
@@ -279,10 +300,6 @@ static int verify_signed_buffer(const char *payload, size_t payload_size,
 		return -1;
 	}
 
-	fmt = get_format_by_sig(signature);
-	if (!fmt)
-		BUG("bad signature '%s'", signature);
-
 	strvec_push(&gpg.args, fmt->program);
 	strvec_pushv(&gpg.args, fmt->verify_args);
 	strvec_pushl(&gpg.args,
@@ -290,18 +307,22 @@ static int verify_signed_buffer(const char *payload, size_t payload_size,
 		     "--verify", temp->filename.buf, "-",
 		     NULL);
 
-	if (!gpg_status)
-		gpg_status = &buf;
-
 	sigchain_push(SIGPIPE, SIG_IGN);
-	ret = pipe_command(&gpg, payload, payload_size,
-			   gpg_status, 0, gpg_output, 0);
+	ret = pipe_command(&gpg, payload, payload_size, &gpg_stdout, 0,
+			   &gpg_stderr, 0);
 	sigchain_pop(SIGPIPE);
 
 	delete_tempfile(&temp);
 
-	ret |= !strstr(gpg_status->buf, "\n[GNUPG:] GOODSIG ");
-	strbuf_release(&buf); /* no matter it was used or not */
+	ret |= !strstr(gpg_stdout.buf, "\n[GNUPG:] GOODSIG ");
+	sigc->payload = xmemdupz(payload, payload_size);
+	sigc->output = strbuf_detach(&gpg_stderr, NULL);
+	sigc->gpg_status = strbuf_detach(&gpg_stdout, NULL);
+
+	parse_gpg_output(sigc);
+
+	strbuf_release(&gpg_stdout);
+	strbuf_release(&gpg_stderr);
 
 	return ret;
 }
@@ -309,35 +330,32 @@ static int verify_signed_buffer(const char *payload, size_t payload_size,
 int check_signature(const char *payload, size_t plen, const char *signature,
 	size_t slen, struct signature_check *sigc)
 {
-	struct strbuf gpg_output = STRBUF_INIT;
-	struct strbuf gpg_status = STRBUF_INIT;
+	struct gpg_format *fmt;
 	int status;
 
 	sigc->result = 'N';
 	sigc->trust_level = -1;
 
-	status = verify_signed_buffer(payload, plen, signature, slen,
-				      &gpg_output, &gpg_status);
-	if (status && !gpg_output.len)
-		goto out;
-	sigc->payload = xmemdupz(payload, plen);
-	sigc->gpg_output = strbuf_detach(&gpg_output, NULL);
-	sigc->gpg_status = strbuf_detach(&gpg_status, NULL);
-	parse_gpg_output(sigc);
+	fmt = get_format_by_sig(signature);
+	if (!fmt)
+		die(_("bad/incompatible signature '%s'"), signature);
+
+	status = fmt->verify_signed_buffer(sigc, fmt, payload, plen, signature,
+					   slen);
+
+	if (status && !sigc->output)
+		return !!status;
+
 	status |= sigc->result != 'G';
 	status |= sigc->trust_level < configured_min_trust_level;
 
- out:
-	strbuf_release(&gpg_status);
-	strbuf_release(&gpg_output);
-
 	return !!status;
 }
 
 void print_signature_buffer(const struct signature_check *sigc, unsigned flags)
 {
-	const char *output = flags & GPG_VERIFY_RAW ?
-		sigc->gpg_status : sigc->gpg_output;
+	const char *output = flags & GPG_VERIFY_RAW ? sigc->gpg_status :
+							    sigc->output;
 
 	if (flags & GPG_VERIFY_VERBOSE && sigc->payload)
 		fputs(sigc->payload, stdout);
@@ -441,6 +459,12 @@ const char *get_signing_key(void)
 }
 
 int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key)
+{
+	return use_format->sign_buffer(buffer, signature, signing_key);
+}
+
+static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
+			  const char *signing_key)
 {
 	struct child_process gpg = CHILD_PROCESS_INIT;
 	int ret;
diff --git a/gpg-interface.h b/gpg-interface.h
index 80567e48948..feac4decf8b 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -17,7 +17,7 @@ enum signature_trust_level {
 
 struct signature_check {
 	char *payload;
-	char *gpg_output;
+	char *output;
 	char *gpg_status;
 
 	/*
diff --git a/log-tree.c b/log-tree.c
index 6dc4412268b..644893fd8cf 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -515,10 +515,10 @@ static void show_signature(struct rev_info *opt, struct commit *commit)
 
 	status = check_signature(payload.buf, payload.len, signature.buf,
 				 signature.len, &sigc);
-	if (status && !sigc.gpg_output)
+	if (status && !sigc.output)
 		show_sig_lines(opt, status, "No signature\n");
 	else
-		show_sig_lines(opt, status, sigc.gpg_output);
+		show_sig_lines(opt, status, sigc.output);
 	signature_check_clear(&sigc);
 
  out:
@@ -585,8 +585,8 @@ static int show_one_mergetag(struct commit *commit,
 		/* could have a good signature */
 		status = check_signature(payload.buf, payload.len,
 					 signature.buf, signature.len, &sigc);
-		if (sigc.gpg_output)
-			strbuf_addstr(&verify_message, sigc.gpg_output);
+		if (sigc.output)
+			strbuf_addstr(&verify_message, sigc.output);
 		else
 			strbuf_addstr(&verify_message, "No signature\n");
 		signature_check_clear(&sigc);
diff --git a/pretty.c b/pretty.c
index 9631529c10a..be477bd51f2 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1432,8 +1432,8 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 			check_commit_signature(c->commit, &(c->signature_check));
 		switch (placeholder[1]) {
 		case 'G':
-			if (c->signature_check.gpg_output)
-				strbuf_addstr(sb, c->signature_check.gpg_output);
+			if (c->signature_check.output)
+				strbuf_addstr(sb, c->signature_check.output);
 			break;
 		case '?':
 			switch (c->signature_check.result) {
-- 
gitgitgadget

