Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD8A1862
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 21:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737063363; cv=none; b=hksDc22SdqjRsexvsiXCMberuVmzOY9S5uSKL6JhaQECwCUskxzWqLn7M3g0eyGkhogZRA9jjdsQ4gwCQWCL+4+9/FziOUX/5nacZ0X4sJuOHbmRDn94tvIlAKBNcLacGH6MTaxttOvk7A0IwqiL1rE+KoC5Hc84caSGJgWnoMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737063363; c=relaxed/simple;
	bh=riA/mmEX2eRmX8sEDFVDgPdnkMrWf3LCA/Fy30olJ70=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DWOKTPicxCidQC1MDyZm0rVSvW4Ida0Qz4aq5hI/TSgh7wCX2xTgFn3xON7VNXM23an7p2R2Nbag4EMhFtj2yZc3k1uwqGyMBCboSpUtKUMExKUVwhPXKcwVRnxQ08BWCpPF966gwlITI2q3VAAe+DxZWPNueXOjTlQHSkxt35Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dohDFD/d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KkSSCtll; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dohDFD/d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KkSSCtll"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 44876114015B;
	Thu, 16 Jan 2025 16:36:00 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 16 Jan 2025 16:36:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1737063360; x=
	1737149760; bh=CDBNdiJ2azPePsVjLKi5aVBT0zEDrKIUhJnqCZqNZPE=; b=d
	ohDFD/d5KBJPV0kg8Yg3b1BKiQvr2TtjK1L+xFeTuxvxL2CkNsMCPQhaI+SHneLn
	qYh4gbR2tUZDvI24DHzGRzPW61rRGc2p9Ety93XEiACgeEgOi236ZkkKUv5r99jH
	oFtIT85owzfYJz+/s7qf5Irg3wQ5BYGvNJzwKU9EEhQspeZ491WIuG0NI/evJFl0
	ThmXlfZfspm6aZibXYzpgokDq05d+/XlML1AL1U/tdjeKCLydfp0AJUL0uhpl7w3
	hOUdhTmNcPEGhHyVBnxL9crR/gv7FxKuq8083Cn7lH/cvwIRf38hQ/LX3Dc14Qhd
	2iFGDfqtn4UPs90Le7Aeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1737063360; x=1737149760; bh=CDBNdiJ2azPePsVjLKi5aVBT0zED
	rKIUhJnqCZqNZPE=; b=KkSSCtllGEWMrcEE+f1ecgAyo92XaGWeOr27oACA7aeQ
	tqbSXlflozWpyd8wgiKSmCfBxbkmVp69WinNCvJvbo/7W0eRctYjPV0R4FYCAthc
	xVygh51//3decs0L44Szs3Kp6F+FyjPVyeoNDTYmYXlIeU2yEGnpM0XiNxR/MysB
	IEahhfoen3t4PQ+Akg1KmivLbgpLn+D/Zz4zIRGCglUQ0tnVaeyOEbzWSOxhGa7E
	LcWn+h7R1C/4DYC3BH9UBd0qzUMFQGcXEPqeOmLUbklAf3YSjukBJ0+/KSLQHFb4
	snMTdULCnMTPGwYMaWVxuKVh7K+ZZ3hyTAlyIeDobQ==
X-ME-Sender: <xms:wHuJZ1C4G2_NVV4uOI_d6zl_KG5PBk4V1DcKtfIeObDnHZjrXvWAhg>
    <xme:wHuJZzh2G8h6fvPwpxubhUbrOb8y6i0mDtW0DaI9lKqwDTirhX_Ulh9fUHE3ouuVz
    6SMNAS0e4-bsM1mbA>
X-ME-Received: <xmr:wHuJZwn-52IgBQ0cR9Jgp0kDOplZ-cvH68pFquGLLAo_pMnMVs6aBv1RZZn5pFL80mpesfCsxwbYHk49xIGx7LCz-wf9Y_usXFrt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgudegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeelve
    eifeeiueffueeghfevueeggfefvedvfeelveeuvdefvddufeekhedtfedtgeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:wHuJZ_yrMs7Sm86RdXlw1rbkbX7WyjVCyVS04Zudg81PZVIiXR6U_A>
    <xmx:wHuJZ6Rmq6IPX7VDFIa3d2Ep8_3zCDzQ2uz8cOuOcdt5dxrNgRCTRA>
    <xmx:wHuJZyaoSJmpTCFgP6UK5gCb9WayFnBQSf-y_OrDsQ6p3DWShFR09A>
    <xmx:wHuJZ7RNp_R06Y44F_eN4UO-mMcIF3mc79EAHC7_ci8IyFY3l3R0xg>
    <xmx:wHuJZ1ckV9uxI9emAtOimpaCHVMgUTXtUPDldLoWG42CHz6GQ0ftRU3U>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 16:35:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v4 3/6] usage: add show_usage_if_asked()
Date: Thu, 16 Jan 2025 13:35:50 -0800
Message-ID: <20250116213553.2563751-4-gitster@pobox.com>
X-Mailer: git-send-email 2.48.1-210-gaa1682cadd
In-Reply-To: <20250116213553.2563751-1-gitster@pobox.com>
References: <20250116012524.1557441-1-gitster@pobox.com>
 <20250116213553.2563751-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some commands call usage() when they are asked to give the help
message with "git cmd -h", but this has the same problem as we
fixed with callers of usage_with_options() for the same purpose.

Introduce a helper function that captures the common pattern

	if (argc == 2 && !strcmp(argv[1], "-h"))
		usage(usage);

and replaces it with

	show_usage_if_asked(argc, argv, usage);

to help correct these code paths.

Note that this helper function still exits with status 129, and
t0012 insists on it.  After converting all the mistaken callers of
usage_with_options() to call this new helper, we may want to address
it---the end user is asking us to give the help text, and we are
doing exactly as asked, so there is no reason to exit with non-zero
status.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * Helper function renamed.

 git-compat-util.h |  2 ++
 usage.c           | 28 +++++++++++++++++++++++++---
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index e283c46c6f..d43dd248c4 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -701,6 +701,8 @@ int error_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
 void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 
+void show_usage_if_asked(int ac, const char **av, const char *err);
+
 #ifndef NO_OPENSSL
 #ifdef APPLE_COMMON_CRYPTO
 #include "compat/apple-common-crypto.h"
diff --git a/usage.c b/usage.c
index 47709006c1..d9f323a0bd 100644
--- a/usage.c
+++ b/usage.c
@@ -8,7 +8,7 @@
 #include "gettext.h"
 #include "trace2.h"
 
-static void vreportf(const char *prefix, const char *err, va_list params)
+static void vfdreportf(int fd, const char *prefix, const char *err, va_list params)
 {
 	char msg[4096];
 	char *p, *pend = msg + sizeof(msg);
@@ -32,8 +32,14 @@ static void vreportf(const char *prefix, const char *err, va_list params)
 	}
 
 	*(p++) = '\n'; /* we no longer need a NUL */
-	fflush(stderr);
-	write_in_full(2, msg, p - msg);
+	if (fd == 2)
+		fflush(stderr);
+	write_in_full(fd, msg, p - msg);
+}
+
+static void vreportf(const char *prefix, const char *err, va_list params)
+{
+	vfdreportf(2, prefix, err, params);
 }
 
 static NORETURN void usage_builtin(const char *err, va_list params)
@@ -173,6 +179,22 @@ void NORETURN usage(const char *err)
 	usagef("%s", err);
 }
 
+static void show_usage_if_asked_helper(const char *err, ...)
+{
+	va_list params;
+
+	va_start(params, err);
+	vfdreportf(1, _("usage: "), err, params);
+	va_end(params);
+	exit(129);
+}
+
+void show_usage_if_asked(int ac, const char **av, const char *err)
+{
+	if (ac == 2 && !strcmp(av[1], "-h"))
+		show_usage_if_asked_helper(err);
+}
+
 void NORETURN die(const char *err, ...)
 {
 	va_list params;
-- 
2.48.1-191-gafe818080f

