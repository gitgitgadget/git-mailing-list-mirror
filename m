Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9542B1F404
	for <e@80x24.org>; Fri, 13 Apr 2018 21:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751947AbeDMVTV (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 17:19:21 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:53650 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbeDMVTQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 17:19:16 -0400
Received: by mail-it0-f65.google.com with SMTP id m134-v6so4869381itb.3
        for <git@vger.kernel.org>; Fri, 13 Apr 2018 14:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=BVueeW1XPqM4Ya2FfuPhMO4mWT0JCKF2gcHthieZrdE=;
        b=Ai3EaVz6jW8wVhqlrNTfo6aG9sxV8WaCJ7KnLdCmobRoV9KiVYpeHtWfKUTbAz33mE
         6F5NZvZuWaZmoq8xXFubtNyRAZrQ5B0jkzwfAFyP2A8L4jr3Ykr+JA8qllYd+UL9udGD
         2ihcz++8gJlmBXtiwC/bp37Z/K10y0rHeYyE8X8qL8znvaUixMhu0e7j+o7T9aEgcwJq
         60+RAqScHb8OY09LFqtQQA6vzIq9ACfVRmhAeQmqbWFtC02EPPFOwBJAjsmO9fyNxJZk
         zT67fKdYw7FwuPydTNe9nclJJdMeKDoxZJ9H0dCx1KJgdw4vHObrm4CFD0IVDvQ8LqkD
         Fphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=BVueeW1XPqM4Ya2FfuPhMO4mWT0JCKF2gcHthieZrdE=;
        b=DGc45/XZYbUUUiTCENJLEpH3oHKUuX7fnjmNcgbg4sD7xPwalPh+pvgq/7sg/GHtbl
         sdMkBQwsonepkqVh5nRvhdZFNTXHTxQysW2a6DbjROwJOpbDGZSQUeLPHpQQxQRFW4UR
         wluiCZpHTKYlOU6KV2hkOswV4SWTizRpzv1HkR5m8CG5fLAUar/TUpbZNXEk8yIHOmMH
         hyiQh4suxmGkSTIbNvq4U8t0UUk0CcOl5NPQxuCrN3St3yls5bIaJvFG5fEhhNnO0eqM
         zGO05Nopi9G11nGjqSqLHoM6UvsYRlujP8H4VSTdj1BKJZsT/WDdSNaSBHNvf9J99zjP
         076g==
X-Gm-Message-State: ALQs6tDIhmne0EsVAirsWQ0Z9OZlhIsrHa9Z3BXJBZQnnybwRxcn02Xx
        3RtsmjlOU24cVB7qa+qxGrlh+Y54zkQ=
X-Google-Smtp-Source: AIpwx48a41K/Ar2PNOdmFkC7xJFy5FDKiqvUY9do71hhp9a8oyG8IKHRcg2nxdbEUUBA6xL6Tnssvg==
X-Received: by 2002:a24:27d7:: with SMTP id g206-v6mr6805875ita.21.1523654356002;
        Fri, 13 Apr 2018 14:19:16 -0700 (PDT)
Received: from localhost.localdomain (174-16-129-48.hlrn.qwest.net. [174.16.129.48])
        by smtp.gmail.com with ESMTPSA id z7sm3125124iob.9.2018.04.13.14.19.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Apr 2018 14:19:15 -0700 (PDT)
From:   Ben Toews <mastahyeti@gmail.com>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, sbeller@google.com,
        gitster@pobox.com, szeder.dev@gmail.com, sunshine@sunshineco.com,
        Ben Toews <mastahyeti@gmail.com>
Subject: [PATCH v2 7/9] gpg-interface: find the last gpg signature line
Date:   Fri, 13 Apr 2018 15:18:35 -0600
Message-Id: <20180413211837.99415-8-mastahyeti@gmail.com>
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

A signed tag has a detached signature like this:

  object ...
  [...more header...]

  This is the tag body.

  -----BEGIN PGP SIGNATURE-----
  [opaque gpg data]
  -----END PGP SIGNATURE-----

Our parser finds the _first_ line that appears to start a
PGP signature block, meaning we may be confused by a
signature (or a signature-like line) in the actual body.
Let's keep parsing and always find the final block, which
should be the detached signature over all of the preceding
content.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Ben Toews <mastahyeti@gmail.com>
---
 gpg-interface.c | 12 +++++++++---
 t/t7004-tag.sh  | 11 +++++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 79333c1ee8..0647bd6348 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -110,11 +110,17 @@ static int is_gpg_start(const char *line)
 size_t parse_signature(const char *buf, size_t size)
 {
 	size_t len = 0;
-	while (len < size && !is_gpg_start(buf + len)) {
-		const char *eol = memchr(buf + len, '\n', size - len);
+	size_t match = size;
+	while (len < size) {
+		const char *eol;
+
+		if (is_gpg_start(buf + len))
+			match = len;
+
+		eol = memchr(buf + len, '\n', size - len);
 		len += eol ? eol - (buf + len) + 1 : size - len;
 	}
-	return len;
+	return match;
 }

 void set_signing_key(const char *key)
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index ee093b393d..e3f1e014aa 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1059,6 +1059,17 @@ test_expect_success GPG \
 	git tag -v blanknonlfile-signed-tag
 '

+test_expect_success GPG 'signed tag with embedded PGP message' '
+	cat >msg <<-\EOF &&
+	-----BEGIN PGP MESSAGE-----
+
+	this is not a real PGP message
+	-----END PGP MESSAGE-----
+	EOF
+	git tag -s -F msg confusing-pgp-message &&
+	git tag -v confusing-pgp-message
+'
+
 # messages with commented lines for signed tags:

 cat >sigcommentsfile <<EOF
--
2.15.1 (Apple Git-101)
