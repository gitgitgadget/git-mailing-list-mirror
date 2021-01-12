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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED11C43381
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13FB022EBE
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405668AbhALIsk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 03:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405619AbhALIs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 03:48:28 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC442C061794
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 00:47:47 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id q75so1274750wme.2
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 00:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AhtG3W2YUY58mimxwSeBbehCrJPBK9/gsdc2KTZkntU=;
        b=A9uqLftzEww/QYjccdKNmJogGDEyG4a3e1JozwvRwMBfGCo0JuDcmXI+cP39DJpHE6
         Uxi8slBoCoFpcssJ+mlOfoSqd4pRLKO9GYxo8YAkqR/+lgWvZjEIkAIn/8t9ge/gNypV
         c/DKjJFueZkU6SoVblzLcMoanVK0nZeVLV69k5NDqG/LFvsfx1WqYRiT9SxFIpM1p9CA
         S7QLdX3xz8RkltggmXYr07HcDsbhgHPfYgLRy1+qGTdWpI7MiKOdck5+wQQy00/lAgrR
         S4eZCM6GftHgdbMoiS5z85+IicOFgyKLkgvm0j8gXIjmd/N4sNxlqugZqhir0BSH8x3V
         QkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AhtG3W2YUY58mimxwSeBbehCrJPBK9/gsdc2KTZkntU=;
        b=lcxaNFepA1KVVR7cvjAYxoWoLH8hflNCe1sjxith/Kn07i+q66kzORbLZgv1OFUGog
         XyZBGpHr2SiEY1bQG5rC8rCNoqbM+BEVYpu9qEox65vxQvPxldLMhalgOEySkEs/wrAE
         eE6H2QnaT434CI+Q9kzN/ZTq2gysFkC3tpuURrtQ0kWq9E5BxFl62YgdxqgPDrhGdX6S
         +ddPCRuvOFNrRbE9JQABokRkpu5pnJfBr7BPb4Uqy6ek/QTAPKhWwqDJKLg7XevbQfPB
         2ovjHstAQYHghlsusdBv0Njlh0I721AQnnDch5Dk5O1Th8YhE120HlO2hvMyBbxaDqLG
         X0bg==
X-Gm-Message-State: AOAM531EL08lS0AgqQJxvFY5V28GYeFse7GuWORIO1RfpsYLsTl8N+1/
        ZGNbngXVJcIo6KMJesRxnWgWaD9vmKc=
X-Google-Smtp-Source: ABdhPJw03g8/b/KJDDx6G1eHdbo4iUQ9yi3lVmWWQO2ACMTAsf+qNLcr98jF5KJcdV2o/jevaKVOKg==
X-Received: by 2002:a1c:c2d4:: with SMTP id s203mr2466827wmf.58.1610441266531;
        Tue, 12 Jan 2021 00:47:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c4sm2819778wmf.19.2021.01.12.00.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 00:47:46 -0800 (PST)
Message-Id: <ab7832fc7ac783bc8f8c10014fc9747128fc37bc.1610441263.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.836.git.1610441262.gitgitgadget@gmail.com>
References: <pull.836.git.1610441262.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Jan 2021 08:47:33 +0000
Subject: [PATCH 02/11] Support GIT_TEST_GETTEXT_POISON=rot13
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 gettext.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 gettext.h |  5 +++--
 2 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/gettext.c b/gettext.c
index 35d2c1218db..7e8966d8326 100644
--- a/gettext.c
+++ b/gettext.c
@@ -68,11 +68,72 @@ const char *get_preferred_languages(void)
 int use_gettext_poison(void)
 {
 	static int poison_requested = -1;
-	if (poison_requested == -1)
-		poison_requested = git_env_bool("GIT_TEST_GETTEXT_POISON", 0);
+	if (poison_requested == -1) {
+		const char *v = getenv("GIT_TEST_GETTEXT_POISON");
+		if (v && !strcmp(v, "rot13"))
+			poison_requested = 2;
+		else
+			poison_requested =
+				git_env_bool("GIT_TEST_GETTEXT_POISON", 0);
+	}
 	return poison_requested;
 }
 
+static inline char do_rot13(char c)
+{
+	if (c >= 'a' && c <= 'm')
+		return c + 'n' - 'a';
+	if (c >= 'n' && c <= 'z')
+		return c + 'a' - 'n';
+	if (c >= 'A' && c <= 'M')
+		return c + 'N' - 'A';
+	if (c >= 'N' && c <= 'Z')
+		return c + 'A' - 'N';
+	return c;
+}
+
+const char *gettext_maybe_rot13(const char *msgid)
+{
+	static struct strbuf round_robin[4] = {
+		STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
+	};
+	static int current;
+	struct strbuf *buf;
+
+	if (use_gettext_poison() != 2)
+		return "# GETTEXT POISON #";
+
+	buf = &round_robin[current++];
+	if (current >= ARRAY_SIZE(round_robin))
+		current = 0;
+
+	strbuf_reset(buf);
+	while (*msgid) {
+		const char *p = strchrnul(msgid, '%'), *spec;
+
+		while (*p && p[1] == '%')
+			p = strchrnul(p + 2, '%');
+
+		if (p != msgid) {
+			strbuf_addstr(buf, "<rot13>");
+			while (p != msgid)
+				strbuf_addch(buf, do_rot13(*(msgid++)));
+			strbuf_addstr(buf, "</rot13>");
+		}
+
+		if (!*p)
+			break;
+
+		spec = strpbrk(p + 1, "diouxXeEfFgGaAcsCSpnm%");
+		if (!spec)
+			BUG("Unrecognized format string: %s", p);
+		strbuf_add(buf, p, spec + 1 - p);
+		msgid = spec + 1;
+	}
+
+	return buf->buf;
+}
+
 #ifndef NO_GETTEXT
 static int test_vsnprintf(const char *fmt, ...)
 {
diff --git a/gettext.h b/gettext.h
index bee52eb1134..298adda7e15 100644
--- a/gettext.h
+++ b/gettext.h
@@ -29,6 +29,7 @@
 #define FORMAT_PRESERVING(n) __attribute__((format_arg(n)))
 
 int use_gettext_poison(void);
+const char *gettext_maybe_rot13(const char *msgid);
 
 #ifndef NO_GETTEXT
 void git_setup_gettext(void);
@@ -48,14 +49,14 @@ static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
 {
 	if (!*msgid)
 		return "";
-	return use_gettext_poison() ? "# GETTEXT POISON #" : gettext(msgid);
+	return use_gettext_poison() ? gettext_maybe_rot13(msgid) : gettext(msgid);
 }
 
 static inline FORMAT_PRESERVING(1) FORMAT_PRESERVING(2)
 const char *Q_(const char *msgid, const char *plu, unsigned long n)
 {
 	if (use_gettext_poison())
-		return "# GETTEXT POISON #";
+		return gettext_maybe_rot13(n < 2 ? msgid : plu);
 	return ngettext(msgid, plu, n);
 }
 
-- 
gitgitgadget

