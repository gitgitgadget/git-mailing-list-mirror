Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DFAE1F404
	for <e@80x24.org>; Fri, 13 Apr 2018 21:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeDMVTU (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 17:19:20 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55263 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751421AbeDMVTR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 17:19:17 -0400
Received: by mail-it0-f68.google.com with SMTP id h143-v6so4856910ita.4
        for <git@vger.kernel.org>; Fri, 13 Apr 2018 14:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Z+yrCruKCwUos/xMm3b44NKnfiH4Ic/VaBqETpkKcWI=;
        b=BAaJafFTXPQx9SQ0d6njZ3Hd667GHMz4fOoZMyRKoXuG9YjglK0VbMq/J85F98Z1po
         kWUWxOWPkqdM9OGA48KEZ55apzOAHuDwM3z4dTVOBki0pkieHfgVE6uWVs8yAOReoBGj
         XgH/Kj8mMGq/C7WQ+J0QeWNBrFQAga5uiU+VFDUdRigOdnaSdqsbGqcaCMi2Nirr3cLX
         mOPwtETBa3erOMpmnnSupVWG9VHVc1jHWolNYAnkv1nPM0vI0zQUDjaEYsHZoBA1CZz4
         T+jidiqjugwbCpb34gU2M8FXO7RkA8lrZTRzbXWn0TNPMdVsCEy/hdbDsb8BbH1YHx+g
         41TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Z+yrCruKCwUos/xMm3b44NKnfiH4Ic/VaBqETpkKcWI=;
        b=Bjoq+n6sK9R9dJMbiEWwHERJNcnQjDAJqImm7zpGL+dloKMMaCWx+DfbZQzMIp5/HA
         73IQY6erOcYjzUBbI3mFVEGVwyLOs+cS+inOGjmrVkY+Fhm4g1sAJwQfRghqrqnH57kj
         ipQYSP3bCH6QaWyq1Gj/JdEqA/QowkRiwUCXV1bQLmwyFjO901IcYiXeIE+lDlkSIeuo
         Q1bXceGlz46OFUP+Dw/QZcR4+zoERTr7IR96/xLccdI6gMqgFRSS8JmyLhG7ayLjAh4E
         /ZCcLkKRtfXa/YWWDABfdver/Dpi/TY7yjpc2xkvAFf5f/oYXeoBKlHElEwXhEl/eG+x
         hcyg==
X-Gm-Message-State: ALQs6tAJzom5zVPi3sfICXehEXp4bEaKHBZso7UG6ekf9W/NTnQElxZ9
        +i8rtdhwkb8OAR5Y9KTglpikaxiJWrc=
X-Google-Smtp-Source: AIpwx4/uhHvilmov1TmVugX7EjFGDkWqfcXLNMGDaOAa6hlh883VBrhXHFbOpgPy4GoeqKYW/CfN2g==
X-Received: by 2002:a24:230a:: with SMTP id u10-v6mr6869893itu.49.1523654356968;
        Fri, 13 Apr 2018 14:19:16 -0700 (PDT)
Received: from localhost.localdomain (174-16-129-48.hlrn.qwest.net. [174.16.129.48])
        by smtp.gmail.com with ESMTPSA id z7sm3125124iob.9.2018.04.13.14.19.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Apr 2018 14:19:16 -0700 (PDT)
From:   Ben Toews <mastahyeti@gmail.com>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, sbeller@google.com,
        gitster@pobox.com, szeder.dev@gmail.com, sunshine@sunshineco.com,
        Ben Toews <mastahyeti@gmail.com>
Subject: [PATCH v2 8/9] gpg-interface: prepare for parsing arbitrary PEM blocks
Date:   Fri, 13 Apr 2018 15:18:36 -0600
Message-Id: <20180413211837.99415-9-mastahyeti@gmail.com>
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

In preparation for handling more PEM blocks besides "PGP
SIGNATURE" and "PGP MESSAGE', let's break up the parsing to
parameterize the actual block type.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Ben Toews <mastahyeti@gmail.com>
---
 gpg-interface.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 0647bd6348..0ba4a8ac3b 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -9,9 +9,6 @@
 static char *configured_signing_key;
 static const char *gpg_program = "gpg";

-#define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
-#define PGP_MESSAGE "-----BEGIN PGP MESSAGE-----"
-
 void signature_check_clear(struct signature_check *sigc)
 {
 	FREE_AND_NULL(sigc->payload);
@@ -101,10 +98,17 @@ void print_signature_buffer(const struct signature_check *sigc, unsigned flags)
 		fputs(output, stderr);
 }

-static int is_gpg_start(const char *line)
+static int is_pem_start(const char *line)
 {
-	return starts_with(line, PGP_SIGNATURE) ||
-		starts_with(line, PGP_MESSAGE);
+	if (!skip_prefix(line, "-----BEGIN ", &line))
+		return 0;
+	if (!skip_prefix(line, "PGP SIGNATURE", &line) &&
+	    !skip_prefix(line, "PGP MESSAGE", &line))
+		return 0;
+	if (!starts_with(line, "-----"))
+		return 0;
+
+	return 1;
 }

 size_t parse_signature(const char *buf, size_t size)
@@ -114,7 +118,7 @@ size_t parse_signature(const char *buf, size_t size)
 	while (len < size) {
 		const char *eol;

-		if (is_gpg_start(buf + len))
+		if (is_pem_start(buf + len))
 			match = len;

 		eol = memchr(buf + len, '\n', size - len);
--
2.15.1 (Apple Git-101)
