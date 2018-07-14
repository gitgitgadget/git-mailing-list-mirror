Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 414861F915
	for <e@80x24.org>; Sat, 14 Jul 2018 21:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbeGNWFR (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jul 2018 18:05:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45012 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731242AbeGNWFR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jul 2018 18:05:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16-v6so28269297wrt.11
        for <git@vger.kernel.org>; Sat, 14 Jul 2018 14:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1BRcBR2cjcO95g6+ZdeVkFHujcIz5VGP7Xzw+iThbDg=;
        b=loAGnd3hFFyPga1MKGA3X/fqvqFuygikAskWE6zK0DiQJw8pvw0sdVVqKcAv55d93/
         aca3vWDHFF/Zi+QxBRFsglxElqjFQb7ps7cvep0xdHCNntHqMdvIuNS0AZ/PH7fT0Dwo
         RJiHX1AzN6E4z6pm8iYeUmuzMWd1dN3fZ4TYy25JSwtInGrqLjW35GYpxidJrA59nFhP
         4JeBqOU2+SMlZrM/FSr0NsYO3bchsOI3tf1QYCHDYPVB2Yvz4QBBRK9I2E9LoOmywvmL
         paIrWZS/+6h5j89+XW0YJC+FpTnRlehKq3jzV5sKKy7fh0SR7IIGtvIOjcI/suVDrPYL
         7V8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1BRcBR2cjcO95g6+ZdeVkFHujcIz5VGP7Xzw+iThbDg=;
        b=S2l834Ys8Zbkdhpf0WEbsLwhJ9NtDA/g9L21fPipMVIdyr7KRWvpLhFRu23TpGIhqT
         aL/FAyiH2cQFc0nUU9PjUmcZshVaWlOUxzBtMxS9NKggvyH+51zHQc2SbMcetYDJrwsz
         Jo+e02fwDmAnfi1dI29N7cdVr9yg1anNYNh8tEheDdI+w9m5WckjqRfRIZdRmCLhpWEq
         bJAY2n1HKSK0gL1Q4SxGxnyLSANzl9tZSngltMqfwLs8D2mXFoGa0o5NQzG//sLOg351
         rxTCIoSDmktgwgnfAG7eN9hMskLfoy3sO8NkosUiJPjZ/vU2EPH2k0LJJwxP3598S76j
         nGFA==
X-Gm-Message-State: AOUpUlHcAsNYRkJpQ803F87mGZN/CWgCDvF5ZinMoC/uQ+yc6kR7Vbq5
        LxyD8J20zwcayrCnAWas4jbSjGHv
X-Google-Smtp-Source: AAOMgpeOhHnilgnjiADoGM8ISZCPokr7JtdenuCoQkhWc3nb/NKg8cG9PFdLZMPRmuhIF3Ua4V16rQ==
X-Received: by 2002:adf:8466:: with SMTP id 93-v6mr7603099wrf.274.1531604690427;
        Sat, 14 Jul 2018 14:44:50 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id m129-v6sm14147809wmb.46.2018.07.14.14.44.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Jul 2018 14:44:49 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 01/11] rerere: unify error messages when read_cache fails
Date:   Sat, 14 Jul 2018 22:44:33 +0100
Message-Id: <20180714214443.7184-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.410.g65aef3a6c4
In-Reply-To: <20180714214443.7184-1-t.gummerer@gmail.com>
References: <20180605215219.28783-1-t.gummerer@gmail.com>
 <20180714214443.7184-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have multiple different variants of the error message we show to
the user if 'read_cache' fails.  The "Could not read index" variant we
are using in 'rerere.c' is currently not used anywhere in translated
form.

As a subsequent commit will mark all output that comes from 'rerere.c'
for translation, make the life of the translators a little bit easier
by using a string that is used elsewhere, and marked for translation
there, and thus most likely already translated.

"index file corrupt" seems to be the most common error message we show
when 'read_cache' fails, so use that here as well.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 rerere.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rerere.c b/rerere.c
index e0862e2778..473d32a5cd 100644
--- a/rerere.c
+++ b/rerere.c
@@ -568,7 +568,7 @@ static int find_conflict(struct string_list *conflict)
 {
 	int i;
 	if (read_cache() < 0)
-		return error("Could not read index");
+		return error("index file corrupt");
 
 	for (i = 0; i < active_nr;) {
 		int conflict_type;
@@ -601,7 +601,7 @@ int rerere_remaining(struct string_list *merge_rr)
 	if (setup_rerere(merge_rr, RERERE_READONLY))
 		return 0;
 	if (read_cache() < 0)
-		return error("Could not read index");
+		return error("index file corrupt");
 
 	for (i = 0; i < active_nr;) {
 		int conflict_type;
@@ -1103,7 +1103,7 @@ int rerere_forget(struct pathspec *pathspec)
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
 
 	if (read_cache() < 0)
-		return error("Could not read index");
+		return error("index file corrupt");
 
 	fd = setup_rerere(&merge_rr, RERERE_NOAUTOUPDATE);
 	if (fd < 0)
-- 
2.17.0.410.g65aef3a6c4

