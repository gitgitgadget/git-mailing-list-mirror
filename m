Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A0E720802
	for <e@80x24.org>; Thu, 22 Jun 2017 21:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753795AbdFVVi2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 17:38:28 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34916 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753772AbdFVVi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 17:38:26 -0400
Received: by mail-wr0-f196.google.com with SMTP id z45so7825815wrb.2
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 14:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LTbPm22L/iy2UxGXb1/xHzUN6DpmirLk+uNEjSfbf6U=;
        b=krck5EUdnLcc7MTyyferbC1AF6KPnHRQI/Q4sJLrh6A1O7qXdu69p/OpOUuym1OsDS
         IV59OwhxSTlyxDeU83XekdRPr+xHIJ4vO3eP0Jk1l4nCmTsedO1z68WhCYWFykVPLiFM
         P1Xbw8OrYwjjOkj4Vpt48AAIdi30GM7oBiRjdFOwhX3ZlBUsZdvmLuWsaE1y+C0WFMhk
         FX3ncNgl8OzowpG+IOEtGGMkMNNRem5PiAdTi2UkdyYm+VFKC7fLd8dn8WOnbdnd5Gbd
         Is32WJlgGcU5P8Shn3HLH+0uUjV2lmoOpn8ivMlPGsbNhmZP8eubhwbb3l7JFhdHB12j
         jTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LTbPm22L/iy2UxGXb1/xHzUN6DpmirLk+uNEjSfbf6U=;
        b=X/c2tb+nb93M4qx+gb9Fu6NTQZaCEGU7Gdl5Tpe1dOMbjRjAcFmWsi9Y2BkpRpz+Jp
         a8cuplVa8+ItegA9RdbjK1EpMVYhQ3+YnEjXUKGg2NPsH/a6JVJJo1w/rZB1YLSMVATe
         CJpLWyXbAPjefTqa/ItBhiTnGQLRk/izNNS6M1wCdAXtUSe9etWVuadp0Tg5O5aSOFlE
         X91VF0sNzvjFuUvamLS3fS7v4lQVfVnpSSzKOrDB48RxM9bW/H+6bEPFPOa3j1HZGGTP
         GkwrIOYOZua3QdCqSe/+PXblR9/EyK17uOV5uIraL90CAhKzrLd/qb47TsIm3dLKmWQT
         e5QA==
X-Gm-Message-State: AKS2vOzn3MxE0O5y8VAmnwKYY6lqS31TLUHRFCj+clZqZJ+NohANcEVU
        5oWl0qICTD0CFOyqfOo=
X-Received: by 10.80.183.146 with SMTP id h18mr4006232ede.39.1498167505087;
        Thu, 22 Jun 2017 14:38:25 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w26sm1404966edw.28.2017.06.22.14.38.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jun 2017 14:38:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/PATCH 2/3] wildmatch: add interface for precompiling wildmatch() patterns
Date:   Thu, 22 Jun 2017 21:38:09 +0000
Message-Id: <20170622213810.14785-3-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <20170622213810.14785-1-avarab@gmail.com>
References: <20170622213810.14785-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the scaffolding necessary for precompiling wildmatch()
patterns.

There is currently no point in doing this with the wildmatch()
function we have now, since it can't make any use of precompiling the
pattern.

But adding this interface and making use of it will make it easy to
refactor the wildmatch() function to e.g. parse the pattern into
opcode as the BSD glob() implementation does, or to drop an alternate
wildmatch() backend in which trades parsing slowness for faster
matching.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 wildmatch.c | 20 ++++++++++++++++++++
 wildmatch.h |  9 +++++++++
 2 files changed, 29 insertions(+)

diff --git a/wildmatch.c b/wildmatch.c
index d074c1be10..ba6a92a393 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -276,3 +276,23 @@ int wildmatch(const char *pattern, const char *text, unsigned int flags)
 {
 	return dowild((const uchar*)pattern, (const uchar*)text, flags);
 }
+
+struct wildmatch_compiled *wildmatch_compile(const char *pattern, unsigned int flags)
+{
+	struct wildmatch_compiled *code = xmalloc(sizeof(struct wildmatch_compiled));
+	code->pattern = xstrdup(pattern);
+	code->flags = flags;
+
+	return code;
+}
+
+int wildmatch_match(struct wildmatch_compiled *code, const char *text)
+{
+	return wildmatch(code->pattern, text, code->flags);
+}
+
+void wildmatch_free(struct wildmatch_compiled *code)
+{
+	free((void *)code->pattern);
+	free(code);
+}
diff --git a/wildmatch.h b/wildmatch.h
index b8c826aa68..6156d46a33 100644
--- a/wildmatch.h
+++ b/wildmatch.h
@@ -10,5 +10,14 @@
 #define WM_ABORT_ALL -1
 #define WM_ABORT_TO_STARSTAR -2
 
+struct wildmatch_compiled {
+	const char *pattern;
+	unsigned int flags;
+};
+
 int wildmatch(const char *pattern, const char *text, unsigned int flags);
+struct wildmatch_compiled *wildmatch_compile(const char *pattern, unsigned int flags);
+int wildmatch_match(struct wildmatch_compiled *code, const char *text);
+void wildmatch_free(struct wildmatch_compiled *code);
+
 #endif
-- 
2.13.1.611.g7e3b11ae1

