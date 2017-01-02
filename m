Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEA611FEB3
	for <e@80x24.org>; Mon,  2 Jan 2017 11:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932687AbdABLPE (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 06:15:04 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:47776 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751307AbdABLPD (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 2 Jan 2017 06:15:03 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id C48DF2093A;
        Mon,  2 Jan 2017 06:15:02 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 02 Jan 2017 06:15:02 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
        date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=QfD
        S+2GRat/UG2pXWg3xtU6QffU=; b=kYgfyHCQZnIPehMxnB/ma53xkvfsclgZ4WG
        pV5lPx0GtAn9rkOhSAvKjPBEXOY+FMslKCgcbJ1SuHdQMp2dTElzRkrlv49amAr1
        SH6IC6PEu/3QkILwVIDCXemzPrUCU8fI4MMjgG3WX3mmj0xcHCEREO4FPovOTPe6
        EDeGKhrA=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc
        :x-sasl-enc; s=smtpout; bh=QfDS+2GRat/UG2pXWg3xtU6QffU=; b=NjOqt
        ynhgkb8LZ90kvhgSpo3jkrkJ0qhsCNIqaLV4ntlce303kjZe3vVdysB1CwzQkpd1
        o/K7x8j6wbHrw2riS4wS3TOmlBd0o7+I2emwTSXty5Y5PrPB9o7iiJdSL1A1ZbZK
        oO8dCNWco9iv+ygIMXw4jH9gPX66oMjjxrCt6w=
X-ME-Sender: <xms:NjZqWC055jQIpgFIK6RQlE47t7p9ULOSCDtxHITND6-T1zU9qoqXJg>
X-Sasl-enc: lbtFwJRHGk7AHFw0Q5uORJVLiWkTFwv+yjCHaRFtdCml 1483355702
Received: from localhost (p5dc51a6b.dip0.t-ipconnect.de [93.197.26.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id C78387E8C3;
        Mon,  2 Jan 2017 06:15:01 -0500 (EST)
From:   Michael J Gruber <git@drmicha.warpmail.net>
To:     git@vger.kernel.org
Subject: [RFC PATCH 2/5] error/warn framework: provide localized variants
Date:   Mon,  2 Jan 2017 12:14:51 +0100
Message-Id: <732991717d24d92df8e87838cff51a551e263a17.1483354746.git.git@drmicha.warpmail.net>
X-Mailer: git-send-email 2.11.0.372.g2fcea0e476
In-Reply-To: <cover.1483354746.git.git@drmicha.warpmail.net>
References: <cover.1483354746.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Provide localized variants of error(), warning(), die() etc.
to go along with localized messages.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 git-compat-util.h |  8 ++++++
 usage.c           | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index f1bf0a6749..48209a6c67 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -405,13 +405,21 @@ struct strbuf;
 /* General helper functions */
 extern void vreportf(const char *prefix, const char *err, va_list params);
 extern NORETURN void usage(const char *err);
+extern NORETURN void usage_(const char *err);
 extern NORETURN void usagef(const char *err, ...) __attribute__((format (printf, 1, 2)));
+extern NORETURN void usagef_(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));
+extern NORETURN void die_(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern NORETURN void die_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
+extern NORETURN void die_errno_(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
+extern int error_(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern int error_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
+extern int error_errno_(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
+extern void warning_(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
+extern void warning_errno_(const char *err, ...) __attribute__((format (printf, 1, 2)));
 
 #ifndef NO_OPENSSL
 #ifdef APPLE_COMMON_CRYPTO
diff --git a/usage.c b/usage.c
index 4270b04bf9..d0cfb02a64 100644
--- a/usage.c
+++ b/usage.c
@@ -105,11 +105,25 @@ void NORETURN usagef(const char *err, ...)
 	va_end(params);
 }
 
+void NORETURN usagef_(const char *err, ...)
+{
+	va_list params;
+
+	va_start(params, err);
+	usage_routine(_("usage: "), err, params);
+	va_end(params);
+}
+
 void NORETURN usage(const char *err)
 {
 	usagef("%s", err);
 }
 
+void NORETURN usage_(const char *err)
+{
+	usagef_("%s", err);
+}
+
 void NORETURN die(const char *err, ...)
 {
 	va_list params;
@@ -124,6 +138,20 @@ void NORETURN die(const char *err, ...)
 	va_end(params);
 }
 
+void NORETURN die_(const char *err, ...)
+{
+	va_list params;
+
+	if (die_is_recursing()) {
+		fputs(_("fatal: recursion detected in die handler\n"), stderr);
+		exit(128);
+	}
+
+	va_start(params, err);
+	die_routine(_("fatal: "), err, params);
+	va_end(params);
+}
+
 static const char *fmt_with_err(char *buf, int n, const char *fmt)
 {
 	char str_error[256], *err;
@@ -163,6 +191,22 @@ void NORETURN die_errno(const char *fmt, ...)
 	va_end(params);
 }
 
+void NORETURN die_errno_(const char *fmt, ...)
+{
+	char buf[1024];
+	va_list params;
+
+	if (die_is_recursing()) {
+		fputs(_("fatal: recursion detected in die_errno handler\n"),
+			stderr);
+		exit(128);
+	}
+
+	va_start(params, fmt);
+	die_routine(_("fatal: "), fmt_with_err(buf, sizeof(buf), fmt), params);
+	va_end(params);
+}
+
 #undef error_errno
 int error_errno(const char *fmt, ...)
 {
@@ -175,6 +219,17 @@ int error_errno(const char *fmt, ...)
 	return -1;
 }
 
+int error_errno_(const char *fmt, ...)
+{
+	char buf[1024];
+	va_list params;
+
+	va_start(params, fmt);
+	error_routine(_("error: "), fmt_with_err(buf, sizeof(buf), fmt), params);
+	va_end(params);
+	return -1;
+}
+
 #undef error
 int error(const char *err, ...)
 {
@@ -186,6 +241,16 @@ int error(const char *err, ...)
 	return -1;
 }
 
+int error_(const char *err, ...)
+{
+	va_list params;
+
+	va_start(params, err);
+	error_routine(_("error: "), err, params);
+	va_end(params);
+	return -1;
+}
+
 void warning_errno(const char *warn, ...)
 {
 	char buf[1024];
@@ -204,3 +269,12 @@ void warning(const char *warn, ...)
 	warn_routine("warning: ", warn, params);
 	va_end(params);
 }
+
+void warning_(const char *warn, ...)
+{
+	va_list params;
+
+	va_start(params, warn);
+	warn_routine(_("warning: "), warn, params);
+	va_end(params);
+}
-- 
2.11.0.372.g2fcea0e476

