Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F9B71F404
	for <e@80x24.org>; Sun, 31 Dec 2017 08:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751002AbdLaIGZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Dec 2017 03:06:25 -0500
Received: from mout.web.de ([212.227.17.12]:65038 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750946AbdLaIGO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Dec 2017 03:06:14 -0500
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LyljP-1f2ET13XdP-01682D; Sun, 31
 Dec 2017 09:06:00 +0100
From:   tboegi@web.de
To:     peff@peff.net, j6t@kdbg.org, lars.schneider@autodesk.com,
        git@vger.kernel.org, gitster@pobox.com, patrick@luehne.de,
        larsxschneider@gmail.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 4/5] utf8: add function to detect a missing UTF-16/32 BOM
Date:   Sun, 31 Dec 2017 09:05:58 +0100
Message-Id: <20171231080558.22401-1-tboegi@web.de>
X-Mailer: git-send-email 2.16.0.rc0.4.ga4e00d4fa4
In-Reply-To: <20171229152222.39680-1-lars.schneider@autodesk.com>
References: <20171229152222.39680-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:E8rvryJVX0tRaHj+7lK9gmoN3WjtFoGUgsi3L5GimTxZdP8+p4l
 4bGtq3U7dznjHK0xZoHeszHMfW3DHFczPjZ/w/pRbfE45uabRscX+bwFl1+iZtgIkaEBgZ9
 pFpftcyu+jHsWZtklQ9ic5TAYhvP4LgCNXjJDhF7jw3uWR2qLgGHQNB1TWQTfz1zy7EVQ6L
 AWEhsAcYDvIl5mCYsCR7A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DcjD2FEmG0s=:wXb17JmfsbjeGh/0BVoXnu
 uFjntIF3BrF+Ll21Rdn3X+yjJU2P4Zqtnkk+1pY8Y3xJtRPOSL6OBw7zRXSyY5QOAl8ClI14b
 eu0kkIJEnsKnzk78TC+UvlDIllRRg/KY/c3hKDffv/T5+9gq3UMa9iejRYLcl4gakHomZ1ECR
 upsr+Ah7aIy7QSgDifm81R6ntOUPYg2qk7Dt+1OqwdPIIjrIAE22nvipWzaIESkk/x/A1iNx2
 yedagz0jdR+0F0z+tKDzKDbUIk9qKGUTLxQfLuELM2TrjwLplvzdU+DjSzI1snHf6qmBzEv5z
 Ijjr/A/wGbAqvmimhC+fzza9PLKOC0IvTdC4Y9AG7JI3YOoi7crLfyRPh42uMjEvE9jyiyw0I
 eVAT5pcNrl81c45YfxMKh16aGzXTPI51l/4tsIABIHWmRjkABib7ydvUm8KrvzsMtkYWjlGko
 huBXBr80oeTnsiLp7bNNLvhPmwLhlF8OYZNnC8WsjTIGyqvOXi1FqKSwjclYMi7NSlDrXWOs+
 3W59+wo9m4lM0kO6WXjPkfcEn58yQyddi/H2MJwrw8cE0Vy4ILgTPNSXkPpMqtdDaRVxsPVvR
 aWaX504fsxBnTl/+pswIsNCgSdcrFiJfl4hFfglX6fvOninqRl1bdXRwAByQ450NbmiYv+NvC
 6xbnYXgls2OCTV3jN4YqDnjhsMeBYlVX8ewn5lUtsC+l6DivthzcKRmw+pkwpuSrnbamilwCf
 Aeew35W3ZOllOJiPMUNNr8rn34Q0MhOZcqEhLwllOzLXDeWeJWUnb7keRe0RA5GyhYM1DMqfu
 KQVciNifqgCgKaDIUxGsMAo8uHsalumQxLJcxyfn+ZLHOk3byI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

If the endianness is not defined in the encoding name, then let's
be strict and require a BOM to avoid any encoding confusion. The
has_missing_utf_bom() function returns true if a required BOM is
missing.

The Unicode standard instructs to assume big-endian if there in no BOM
for UTF-16/32 [1][2]. However, the W3C/WHATWG encoding standard used
in HTML5 recommends to assume little-endian to "deal with deployed
content" [3]. Strictly requiring a BOM seems to be the safest option
for content in Git.

This function is used in a subsequent commit.

[1] http://unicode.org/faq/utf_bom.html#gen6
[2] http://www.unicode.org/versions/Unicode10.0.0/ch03.pdf
     Section 3.10, D98, page 132
[3] https://encoding.spec.whatwg.org/#utf-16le

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 utf8.c | 13 +++++++++++++
 utf8.h | 16 ++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/utf8.c b/utf8.c
index 776660ee12..1978d6c42a 100644
--- a/utf8.c
+++ b/utf8.c
@@ -562,6 +562,19 @@ int has_prohibited_utf_bom(const char *enc, const char *data, size_t len)
 	);
 }
 
+int has_missing_utf_bom(const char *enc, const char *data, size_t len)
+{
+	return (
+	   !strcmp(enc, "UTF-16") &&
+	   !(has_bom_prefix(data, len, utf16_be_bom, sizeof(utf16_be_bom)) ||
+	     has_bom_prefix(data, len, utf16_le_bom, sizeof(utf16_le_bom)))
+	) || (
+	   !strcmp(enc, "UTF-32") &&
+	   !(has_bom_prefix(data, len, utf32_be_bom, sizeof(utf32_be_bom)) ||
+	     has_bom_prefix(data, len, utf32_le_bom, sizeof(utf32_le_bom)))
+	);
+}
+
 /*
  * Returns first character length in bytes for multi-byte `text` according to
  * `encoding`.
diff --git a/utf8.h b/utf8.h
index 4711429af9..26b5e91852 100644
--- a/utf8.h
+++ b/utf8.h
@@ -79,4 +79,20 @@ void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int wid
  */
 int has_prohibited_utf_bom(const char *enc, const char *data, size_t len);
 
+/*
+ * If the endianness is not defined in the encoding name, then we
+ * require a BOM. The function returns true if a required BOM is missing.
+ *
+ * The Unicode standard instructs to assume big-endian if there
+ * in no BOM for UTF-16/32 [1][2]. However, the W3C/WHATWG
+ * encoding standard used in HTML5 recommends to assume
+ * little-endian to "deal with deployed content" [3].
+ *
+ * [1] http://unicode.org/faq/utf_bom.html#gen6
+ * [2] http://www.unicode.org/versions/Unicode10.0.0/ch03.pdf
+ *     Section 3.10, D98, page 132
+ * [3] https://encoding.spec.whatwg.org/#utf-16le
+ */
+int has_missing_utf_bom(const char *enc, const char *data, size_t len);
+
 #endif
-- 
2.16.0.rc0.4.ga4e00d4fa4

