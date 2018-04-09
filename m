Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F02D1F404
	for <e@80x24.org>; Mon,  9 Apr 2018 20:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754374AbeDIUmb (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 16:42:31 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:40374 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754117AbeDIUmV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 16:42:21 -0400
Received: by mail-io0-f194.google.com with SMTP id e79so11226029ioi.7
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 13:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j6lIcoh7v8cXPcH4fimL6AKt+VFTmc1QKsOzAqxqA4E=;
        b=P5lpOavnl97G99vBKRgf8Y/X9kCP9rmAt37zjWMLCgomvoblG6AfveiT5merbODYbG
         vybU86lvd89n3CvcRdsI/3BnCc6e0uq+FafrBPuu+fjuv85sjHbEjxtX92uBQqms0tXu
         d2LRrrCQePaX/EeS5L9n9EnlumTvnQuBI9FU8jifzLT7qMma6l87GMvVSDWC6liaDadd
         oMnshcHDmAdnJSxO6o9vTlcKCvgpSTycOsFsC0m46KHPS60lJa3kOmpcvFouHUjY3HsY
         4Dn+t1sHXYD9Q/Yz1QRD/uqnIorfLMlTh+aAxLv+Tu7ltGFsjW1V8/9mEzz5Uj8hvxKI
         qfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j6lIcoh7v8cXPcH4fimL6AKt+VFTmc1QKsOzAqxqA4E=;
        b=lw90KsyP2gxnP1PziBDfn2Dfx1D51HbbjjM/iEWUR8vh1bFzlzO9Y/xkr6RN0m6n5W
         TYUj4G7SlBbNOoIFPD8WeFg27T4NoTVFHxolAVlmP7PeNo2wZ/CuWeHJDILmZt6gJrQt
         earf10pci1UOEYpGKFqrnV9u0/6Nmlo1eLL7GEeVxrHGKtuf1jx+3hJEVjo7cFR1H2iC
         bNFRKCXpnjT4KFctPY10+31BVjNccKspV2OvcbcNTdbcB9UJ+k8Gd2l/m9RVcUEiXId2
         XGH6s19kaYwS9g0vBPUg1XHoxOURwjgVCrbKTUCuTRYfnp11VFgfX6yQUXR3Gv98xPYC
         t8Gw==
X-Gm-Message-State: ALQs6tBhr8W3pZpfJmdv5mTZ3360C75aZnNF5gsSwvo70SP+oBSk2v/H
        f5G05zVwNVfZPcw4DgiOo7YHvwR9
X-Google-Smtp-Source: AIpwx48IOzpV/ZWQT9QfI/rVUcYWsEvgVyBceQptiwb2FJll4kbtvdZMHGsy/GS4LdlSPYk3ighh7g==
X-Received: by 10.107.143.9 with SMTP id r9mr484981iod.191.1523306540107;
        Mon, 09 Apr 2018 13:42:20 -0700 (PDT)
Received: from localhost.localdomain (174-16-129-48.hlrn.qwest.net. [174.16.129.48])
        by smtp.gmail.com with ESMTPSA id 134-v6sm98775itl.34.2018.04.09.13.42.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Apr 2018 13:42:19 -0700 (PDT)
From:   Ben Toews <mastahyeti@gmail.com>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, mastahyeti@gmail.com
Subject: [PATCH 6/8] gpg-interface: find the last gpg signature line
Date:   Mon,  9 Apr 2018 14:41:27 -0600
Message-Id: <20180409204129.43537-7-mastahyeti@gmail.com>
X-Mailer: git-send-email 2.15.1 (Apple Git-101)
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

