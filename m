Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C026E1F404
	for <e@80x24.org>; Fri, 13 Apr 2018 21:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751953AbeDMVTY (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 17:19:24 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:32804 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbeDMVTO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 17:19:14 -0400
Received: by mail-io0-f193.google.com with SMTP id p139so11760834iod.0
        for <git@vger.kernel.org>; Fri, 13 Apr 2018 14:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=2FLqehL9c/Bmbh+N4hXAROMIVlbHtaytA9KHL2XtH64=;
        b=FIIRh4mhnJ/ApxJJ4PXGPse3hD/Sm614ia263Z0FlMPJ86+v4iuq7PWJqBXSUHOJLG
         7vvBFsIwUhkWLbweF/BLOAoOMnX72f2971mj21co6BYEPFMWhPVzX/geaVfaklZRmVzp
         yTirKenRxuEpwZ3gQJW80bdd4WpmRSzvOFZ5IY5MtulGqIRbuJfqvPuEqGTk40oBguE4
         VDUOPA/uA5TJ927YwwSaaRQENz0M8WTkfpssV7BI/1/W7N4xk+6eds2EKr1bmqJPURaD
         1uT1KwfW83NNTAanT4iZDhNbrMOx0kvSc50qTSHVZvpkXYcFktsqzCakHd9OXK21Y2Gg
         wK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=2FLqehL9c/Bmbh+N4hXAROMIVlbHtaytA9KHL2XtH64=;
        b=VNf7GOnP89dMmZJB+584z7pMMztEDzwfaCQioqJl5dRhMmz/V2V6cmhV3cgfmfbPW8
         ZRU/7hYqQTXOqJgDAucaHGsryzTDbiNLdJPhelBD5VrxMgJhCOKEoagcezBBfdkoCcnk
         vrHb3fek2W3vlOeAGnddEFVFoLD8FdP+U16inEN/1Hjaqt+gq9Y7sDe47E/bSDXyIf1R
         3f/2yrVMWnuc5O/8W20MhB5Lx7EhINkq3V/CmwE6EoKoJsYaWuh7u3iWwUpA86Hc+9W4
         HTNz/gZk/SQQ0Bcfr6XNtkclWO1waW+1yFaMQfHVsjOvmdONgW+JuHuUvETaNvCEtBlx
         OhAQ==
X-Gm-Message-State: ALQs6tCbpbrtStNcikIg+bc25iXGQzcZuOD4G6EHe7C8BQHC+U+Kru0/
        sBEroWHXppir5K7MPQOUbN1WndXmpoc=
X-Google-Smtp-Source: AIpwx494utb1FyX3+6RQY9bpXXoRVqgTzGQXxjyqFz4PWfYE/sQNROplDcpdyUePibunYzv5KAqC4A==
X-Received: by 10.107.134.85 with SMTP id i82mr14552354iod.210.1523654353763;
        Fri, 13 Apr 2018 14:19:13 -0700 (PDT)
Received: from localhost.localdomain (174-16-129-48.hlrn.qwest.net. [174.16.129.48])
        by smtp.gmail.com with ESMTPSA id z7sm3125124iob.9.2018.04.13.14.19.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Apr 2018 14:19:13 -0700 (PDT)
From:   Ben Toews <mastahyeti@gmail.com>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, sbeller@google.com,
        gitster@pobox.com, szeder.dev@gmail.com, sunshine@sunshineco.com,
        Ben Toews <mastahyeti@gmail.com>
Subject: [PATCH v2 5/9] gpg-interface: fix const-correctness of "eol" pointer
Date:   Fri, 13 Apr 2018 15:18:33 -0600
Message-Id: <20180413211837.99415-6-mastahyeti@gmail.com>
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

We accidentally shed the "const" of our buffer by passing it
through memchr. Let's fix that, and while we're at it, move
our variable declaration inside the loop, which is the only
place that uses it.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Ben Toews <mastahyeti@gmail.com>
---
 gpg-interface.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index ac852ad4b9..3414af38b9 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -103,11 +103,10 @@ void print_signature_buffer(const struct signature_check *sigc, unsigned flags)

 size_t parse_signature(const char *buf, size_t size)
 {
-	char *eol;
 	size_t len = 0;
 	while (len < size && !starts_with(buf + len, PGP_SIGNATURE) &&
 			!starts_with(buf + len, PGP_MESSAGE)) {
-		eol = memchr(buf + len, '\n', size - len);
+		const char *eol = memchr(buf + len, '\n', size - len);
 		len += eol ? eol - (buf + len) + 1 : size - len;
 	}
 	return len;
--
2.15.1 (Apple Git-101)
