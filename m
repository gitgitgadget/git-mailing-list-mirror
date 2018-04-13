Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47E791F404
	for <e@80x24.org>; Fri, 13 Apr 2018 21:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbeDMVTX (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 17:19:23 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53651 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751670AbeDMVTP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 17:19:15 -0400
Received: by mail-it0-f68.google.com with SMTP id m134-v6so4869306itb.3
        for <git@vger.kernel.org>; Fri, 13 Apr 2018 14:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=AyM4gg0uv/+z0zHAXD7mJWRpPyUA1TjTHlAaOCpYAYw=;
        b=bXO0QEjDMKNez9iUAQuXo6UhgTolnNfHAYgcD3AyV6fVAQqmQITaCX2cKNFqiYef5O
         tsxxB0h9eCvyVL8T9ymElxZnAaAI5Tn5Ebdepqey0YNkt73AsWtLW5w8sV/4FSMkK7ah
         f9Jv6y1Pex19OJxpl4pM7ZtEW4YGtHOqKEs7TmVZyFiIUBpZw1t3snJo8DFvb6N9m59k
         J5uGDLQvyL0OcJ0ijTNWwRFUIaOng1q4tatN52+eR2UUvOnVW8blZNfr/Z8QJyvFE4R0
         RX9WnueUVcLGIsounieok90t6mPJOEUQKvLb0MKsCKisiFKA4ICxbDp+/Gd/tSFWi+RZ
         s3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=AyM4gg0uv/+z0zHAXD7mJWRpPyUA1TjTHlAaOCpYAYw=;
        b=U1YLVLz/eZN2hOiKsNDNjsljvwlQxP8jDr3PW+sfjpOOHHJEQZYLzbOA7gcOSLfOIs
         9sRLMpw27V0rg1vaT59Q5nlZ0gHpY3SqSZ2lJSHCPTOAZU5zRRRNJaS2F1NA3QhPnhJ6
         Tdl8+fv7kI4qTTPSa6zZ0ejT+h9Zjf5HkIpVs+bTd3dlXlXghFHpfazc+1kqZXLbfjT7
         cn2/CUhAicaT3Qgp8v8MVXA93Ywp5U9VuK2DmaDNGOUYFeZv4LMh7R+Os2VIEfP4NM0R
         tgw14yFQTfy4QV1ohUmeFPlb/DS7iT+8Xn+Z3/Pr43QiLzbl+lhzIojRb6XyPsJLY9Yi
         hjlA==
X-Gm-Message-State: ALQs6tAObKEavKp2TJJ0fWsR0GUfuudslvK3gPG/A2OzdBO94wsUOF0E
        sXi7O0qhjaInEheUUQ+4JvDdT98g4HQ=
X-Google-Smtp-Source: AIpwx49JhPzdFEuXBoXJWtKLgUKwK+j+pqROOOhhhffQrBaapkk+tqBOBfGvphUi/dEXtZqVsjC60A==
X-Received: by 2002:a24:7855:: with SMTP id p82-v6mr6971801itc.11.1523654354827;
        Fri, 13 Apr 2018 14:19:14 -0700 (PDT)
Received: from localhost.localdomain (174-16-129-48.hlrn.qwest.net. [174.16.129.48])
        by smtp.gmail.com with ESMTPSA id z7sm3125124iob.9.2018.04.13.14.19.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Apr 2018 14:19:14 -0700 (PDT)
From:   Ben Toews <mastahyeti@gmail.com>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, sbeller@google.com,
        gitster@pobox.com, szeder.dev@gmail.com, sunshine@sunshineco.com,
        Ben Toews <mastahyeti@gmail.com>
Subject: [PATCH v2 6/9] gpg-interface: extract gpg line matching helper
Date:   Fri, 13 Apr 2018 15:18:34 -0600
Message-Id: <20180413211837.99415-7-mastahyeti@gmail.com>
X-Mailer: git-send-email 2.15.1 (Apple Git-101)
In-Reply-To: <20180413211837.99415-1-mastahyeti@gmail.com>
References: <20180413211837.99415-1-mastahyeti@gmail.com>
In-Reply-To: <20180409204129.43537-1-mastahyeti@gmail.com>
References: <20180409204129.43537-1-mastahyeti@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Let's separate the actual line-by-line parsing of signatures
from the notion of "is this a gpg signature line". That will
make it easier to do more refactoring of this loop in future
patches.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Ben Toews <mastahyeti@gmail.com>
---
 gpg-interface.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 3414af38b9..79333c1ee8 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -101,11 +101,16 @@ void print_signature_buffer(const struct signature_check *sigc, unsigned flags)
 		fputs(output, stderr);
 }

+static int is_gpg_start(const char *line)
+{
+	return starts_with(line, PGP_SIGNATURE) ||
+		starts_with(line, PGP_MESSAGE);
+}
+
 size_t parse_signature(const char *buf, size_t size)
 {
 	size_t len = 0;
-	while (len < size && !starts_with(buf + len, PGP_SIGNATURE) &&
-			!starts_with(buf + len, PGP_MESSAGE)) {
+	while (len < size && !is_gpg_start(buf + len)) {
 		const char *eol = memchr(buf + len, '\n', size - len);
 		len += eol ? eol - (buf + len) + 1 : size - len;
 	}
--
2.15.1 (Apple Git-101)
