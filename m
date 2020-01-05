Return-Path: <SRS0=oqjl=22=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA157C33C9A
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 13:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B6C20866
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 13:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dyntopia-com.20150623.gappssmtp.com header.i=@dyntopia-com.20150623.gappssmtp.com header.b="lzFs+OIZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgAEN4Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Jan 2020 08:56:25 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40476 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgAEN4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Jan 2020 08:56:24 -0500
Received: by mail-pj1-f67.google.com with SMTP id bg7so6632883pjb.5
        for <git@vger.kernel.org>; Sun, 05 Jan 2020 05:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AuEqUdO3HLxFH9Ty1YYtq4IwkyqeDE3YoVNwDzdk+30=;
        b=lzFs+OIZPVz1Y/aFLZq4KL5duor6LpXrNtd+VWsRB9fAsuSh5hY0sXC/96la6U33fc
         aPbI9I6b4GLwwY5mWUkR8SHxEKTSnn7YOfO39FtEVP7gqIxLiprJ0FXC+hWedgSrM4Ma
         HrIML04FfBuiwrPmzmlhlEAa/Dh83IxtYxGalRuADSVvGbUtP9a0MFdKG/8IYjfnQE7p
         ZnuRRnJYY9U/CmCS1dPCUk3VXtDUWDqkQaASXM2NGwSo+kST3a7bPEWEbkwdGoqrT8Mt
         gu8vVDvdnwWVv8+zFYOqUn8/Wvez5duI7GHzNUOKu6O61fRstjgevzhCp0cRlkPe+EF/
         NTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AuEqUdO3HLxFH9Ty1YYtq4IwkyqeDE3YoVNwDzdk+30=;
        b=j8ml7SFOvlguPAeLp1MA3GT4x+QsSXv9ZCSMrrLqjeUFLPMco+3WDq5n+REahB6Mh2
         8WblRumsjD/Df/GuVsDgoWsrE8EloZcNyXmeqYiyL6TTOeglOSw1ABCTTREW6gJLlhwF
         xMHAVSgpTOCFakua0Ptj//5R4+mBiN0/2Sy91Hw4CAmVkvpAmnAlSi8SbJHG5ECtAyax
         zUeWJiankotemRKC9i5YjjmJuZyH3YFd92VvuN1lrfY9AF/M4EYwQj1PxD0elM1UOMS4
         4DwgvRtysKdoiAQlMWihZbJDDXI7bOs6Umgrh8FdoInKGzbQQ+JEy72IWhTEjjP+LYM4
         6cqQ==
X-Gm-Message-State: APjAAAUkM9zyLwYkSrkHbrwPO+7lhaYr/hzX0SlXpcLTAX48cY+pUySX
        Xnev/cdnsg4GZxb8HimkihyrMawXypk=
X-Google-Smtp-Source: APXvYqytiIWQLec8kJx/a0OAucdl2wKaSgfKj/m8FDW8QkQwxJtrITOtowbETCDstry3yb30++jK+w==
X-Received: by 2002:a17:90a:3945:: with SMTP id n5mr37487169pjf.34.1578232583934;
        Sun, 05 Jan 2020 05:56:23 -0800 (PST)
Received: from localhost ([202.62.47.81])
        by smtp.gmail.com with ESMTPSA id a28sm73784633pfh.119.2020.01.05.05.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 05:56:23 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     git@vger.kernel.org
Cc:     Hans Jerry Illikainen <hji@dyntopia.com>
Subject: [PATCH 1/5] gpg-interface: conditionally show the result in print_signature_buffer()
Date:   Sun,  5 Jan 2020 13:56:12 +0000
Message-Id: <20200105135616.19102-2-hji@dyntopia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200105135616.19102-1-hji@dyntopia.com>
References: <20200105135616.19102-1-hji@dyntopia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The print_signature_buffer() function in gpg-interface.c is used to
print the result of a GPG verified payload.  It takes a 'flags'
parameter that determines what to print.

Previously, the 'flags' parameter processed 2 flags:

- GPG_VERIFY_RAW: to print the raw output from GPG instead of the
  human(ish)-readable output.  One of these outputs were always
  shown, irregardless of any other flags.
- GPG_VERIFY_VERBOSE: to print the payload that was verified

Interestingly, there was also a third flag defined in gpg-interface.h;
GPG_VERIFY_OMIT_STATUS.  That flag wasn't used by the print function
itself -- instead, callers would check for the presence of
GPG_VERIFY_OMIT_STATUS before invoking print_signature_buffer().

It seems reasonable that the GPG interface should handle all flags
related to how the result should be (or shouldn't be) shown.  This patch
implements that behavior by removing GPG_VERIFY_OMIT_STATUS and adding
GPG_VERIFY_FULL.  If neither GPG_VERIFY_FULL nor GPG_VERIFY_VERBOSE is
present, then nothing is printed.  This allows callers to invoke
print_signature_buffer() unconditionally.

Signed-off-by: Hans Jerry Illikainen <hji@dyntopia.com>
---
 builtin/tag.c           | 4 ++--
 builtin/verify-commit.c | 2 +-
 builtin/verify-tag.c    | 4 ++--
 gpg-interface.c         | 2 +-
 gpg-interface.h         | 6 +++---
 tag.c                   | 4 +---
 6 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index e0a4c25382..8489e220e8 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -112,10 +112,10 @@ static int verify_tag(const char *name, const char *ref,
 {
 	int flags;
 	const struct ref_format *format = cb_data;
-	flags = GPG_VERIFY_VERBOSE;
+	flags = GPG_VERIFY_FULL | GPG_VERIFY_VERBOSE;
 
 	if (format->format)
-		flags = GPG_VERIFY_OMIT_STATUS;
+		flags = 0;
 
 	if (gpg_verify_tag(oid, name, flags))
 		return -1;
diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index 40c69a0bed..2a099ec6ba 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -63,7 +63,7 @@ static int git_verify_commit_config(const char *var, const char *value, void *cb
 int cmd_verify_commit(int argc, const char **argv, const char *prefix)
 {
 	int i = 1, verbose = 0, had_error = 0;
-	unsigned flags = 0;
+	unsigned flags = GPG_VERIFY_FULL;
 	const struct option verify_commit_options[] = {
 		OPT__VERBOSE(&verbose, N_("print commit contents")),
 		OPT_BIT(0, "raw", &flags, N_("print raw gpg status output"), GPG_VERIFY_RAW),
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index f45136a06b..bd5e99925b 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -30,7 +30,7 @@ static int git_verify_tag_config(const char *var, const char *value, void *cb)
 int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 {
 	int i = 1, verbose = 0, had_error = 0;
-	unsigned flags = 0;
+	unsigned flags = GPG_VERIFY_FULL;
 	struct ref_format format = REF_FORMAT_INIT;
 	const struct option verify_tag_options[] = {
 		OPT__VERBOSE(&verbose, N_("print tag contents")),
@@ -53,7 +53,7 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 		if (verify_ref_format(&format))
 			usage_with_options(verify_tag_usage,
 					   verify_tag_options);
-		flags |= GPG_VERIFY_OMIT_STATUS;
+		flags = 0;
 	}
 
 	while (i < argc) {
diff --git a/gpg-interface.c b/gpg-interface.c
index 2d538bcd6e..fc182d39be 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -341,7 +341,7 @@ void print_signature_buffer(const struct signature_check *sigc, unsigned flags)
 	if (flags & GPG_VERIFY_VERBOSE && sigc->payload)
 		fputs(sigc->payload, stdout);
 
-	if (output)
+	if (flags & GPG_VERIFY_FULL && output)
 		fputs(output, stderr);
 }
 
diff --git a/gpg-interface.h b/gpg-interface.h
index f4e9b4f371..4631a91330 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -3,9 +3,9 @@
 
 struct strbuf;
 
-#define GPG_VERIFY_VERBOSE		1
-#define GPG_VERIFY_RAW			2
-#define GPG_VERIFY_OMIT_STATUS	4
+#define GPG_VERIFY_VERBOSE (1 << 0)
+#define GPG_VERIFY_RAW (1 << 1)
+#define GPG_VERIFY_FULL (1 << 2)
 
 enum signature_trust_level {
 	TRUST_UNDEFINED,
diff --git a/tag.c b/tag.c
index 71b544467e..b8d6da81eb 100644
--- a/tag.c
+++ b/tag.c
@@ -28,9 +28,7 @@ static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
 
 	ret = check_signature(buf, payload_size, buf + payload_size,
 				size - payload_size, &sigc);
-
-	if (!(flags & GPG_VERIFY_OMIT_STATUS))
-		print_signature_buffer(&sigc, flags);
+	print_signature_buffer(&sigc, flags);
 
 	signature_check_clear(&sigc);
 	return ret;
-- 
2.25.0.rc1.302.gc71d20beed

