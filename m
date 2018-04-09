Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A3B91F404
	for <e@80x24.org>; Mon,  9 Apr 2018 20:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754259AbeDIUmZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 16:42:25 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:36282 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754125AbeDIUmS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 16:42:18 -0400
Received: by mail-io0-f196.google.com with SMTP id o4so11229188iod.3
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 13:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2P0rUxS3x7oQVGJqy8GBFhIOHExky/mpSj6pv6L9S5k=;
        b=nHMv7rBkJ8a7l7V40OGPZulBjmrvy5XUyw+/HyvxKBm3yJTA8kOJcdmYa8p4gCIfv9
         VCogy+WqJ5DKdz71MM3vlLM1To+FzL20DUyXhWKDjaukCrnjvpVYGyFzvVXdnwImaRfk
         FmLEkSN/+HRK1rRNjmoLFeX1zSJ+254dwUvvbrARM2r8pMzJGdg/8xYI9oPQdbEilulJ
         GjVuX2w3Ln3uM3cU2xyaw1Nk29BExqrVRS/m0ZsnXs8TsZAXu+cs9MVKdaTUJMJwxIqV
         8amGzGTuQrrTy4m1tWeIfUceAHbd9CGaCd7aBofv3aL/qhbBouYktaTLippsmYdMx4O/
         +A4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2P0rUxS3x7oQVGJqy8GBFhIOHExky/mpSj6pv6L9S5k=;
        b=CuNvx2osm0SbAjHYTgvuA0ZrMir4ZV7cNx5m60wK4PgWvKV6CztXA4vjg67z8jcvNa
         HfdgVEKJE/FlwZ5F54oRkQ//l1VW+rVAfD4zJd93QGFjjcyXNhzPk8RTaHphk1BUKzpg
         YNl7nZWjdXWCUToefq5Bn8taoLU5oswi6NtANGtw86fio+s9QGY8mpUkycCAn3AQrhh8
         gia8ADiBfTrKjOsgTCk0XKomYTN6SzmofyKrpXAo7qNFxlvjJpSpFLI/sNUKoBWFoqwj
         Sjax1RLxzGRdCaF3kEuY0y8JEeZ2KHmVLJtQC7u63Ghei7wb2F09cD7uxRy1Yu/om604
         WUbA==
X-Gm-Message-State: ALQs6tDNLo4GTrduYh22EvZ55/eRGDYO2urL84LunVHvUR6EIk/nKNAI
        xYREE/A/duuDftsL/j8TtAy1Feld
X-Google-Smtp-Source: AIpwx48J47uwHjFXSnD5zE4592VcPC0nUFx4C7npROLFLOR3l+V/+EjbZakiMx+YTiOEgkKOkjmgFg==
X-Received: by 10.107.168.226 with SMTP id e95mr480423ioj.205.1523306537733;
        Mon, 09 Apr 2018 13:42:17 -0700 (PDT)
Received: from localhost.localdomain (174-16-129-48.hlrn.qwest.net. [174.16.129.48])
        by smtp.gmail.com with ESMTPSA id 134-v6sm98775itl.34.2018.04.09.13.42.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Apr 2018 13:42:16 -0700 (PDT)
From:   Ben Toews <mastahyeti@gmail.com>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, mastahyeti@gmail.com
Subject: [PATCH 4/8] gpg-interface: fix const-correctness of "eol" pointer
Date:   Mon,  9 Apr 2018 14:41:25 -0600
Message-Id: <20180409204129.43537-5-mastahyeti@gmail.com>
X-Mailer: git-send-email 2.15.1 (Apple Git-101)
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

