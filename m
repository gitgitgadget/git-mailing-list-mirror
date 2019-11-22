Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1EBC432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 20:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F2172070E
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 20:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dyntopia-com.20150623.gappssmtp.com header.i=@dyntopia-com.20150623.gappssmtp.com header.b="WT/yyweG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfKVUX1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 15:23:27 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46316 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfKVUX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 15:23:26 -0500
Received: by mail-pg1-f194.google.com with SMTP id r18so3811411pgu.13
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 12:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oEv7NGJTSK4sWYicpUcjxWgocsqS1Eo2PnNJRw40eGU=;
        b=WT/yyweGrwewbe9jpsltKdx705Ido4zQnNCyCqFFyKVrW+3cHi6/IqSGZrjuxm8rB2
         q38LQNaBG2/03xjvKkb2+NWQML1Z2+s8p5wRXeNYMfd91VmsHHLh9NZ54y1wWj1iXbAz
         xwpqCXKDaZjLTbE4XriCvy/JO/YM7knmI6Kjqy0VCf5HEJaF2qsg/2DQd7j5ayaj00e3
         bH0G2vRANIjBKQqXEa1LKUDI5GlnN4nlN+CDAjnRKJ7h+TX3nLIZ99iMPEdS39EmTJY1
         NNz4bDzyLpE0EU9Tu9AaRFuoNXcymPMh3Z/XZyzc78dNNRNNJ1FPqDtkLIFuUAPZltwf
         8I7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oEv7NGJTSK4sWYicpUcjxWgocsqS1Eo2PnNJRw40eGU=;
        b=F2tegiGi/TqVIipM/fMMaz/Fm+QIC5D70vanFYuwMIJYJsLjdGD16QCqY2iPEqnB+z
         C03L77QUJzjQdlpDJ/WySYdwuq+ui1VfTcI7NVFibMeyL9qBBsAVb2uQNpgKTl/yA53w
         LywPO5qs2pItInbroX3itZwbqmpaZQffb5ZccHvQ1F/XYKRTjwvSCD3zhttnzST3JGq3
         8+KIcKyDvXOmYAgN1BhCZdWLOgai5QeWDpWnOKkRspyLhLGVbiDKEMQfSd1F+uGTZCK+
         RqyjxEvcdskIgB7cwgLiEZtKFa1GFq5+a5SlwkL9lgYsGWOcoy/XeXFogaJaIh9mAAmA
         zbuQ==
X-Gm-Message-State: APjAAAVX3DiBKx+X1WVbj84xag0ymrxyCDfQ1MYvE+KtvkGwtM4l76yP
        g4uaqeoKf1pLIMvRNCM5dgdFnjRRMv0=
X-Google-Smtp-Source: APXvYqyilbtsY6H0ygqWRwaPsoDCEl6T5XUrCbiO+N42EydANCX08VXnQqrUnxbTQqzWmhWO+4yfSA==
X-Received: by 2002:aa7:93cd:: with SMTP id y13mr19602851pff.240.1574454205250;
        Fri, 22 Nov 2019 12:23:25 -0800 (PST)
Received: from localhost ([182.232.178.105])
        by smtp.gmail.com with ESMTPSA id v19sm3678760pjr.14.2019.11.22.12.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 12:23:24 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     git@vger.kernel.org
Cc:     Hans Jerry Illikainen <hji@dyntopia.com>
Subject: [PATCH v4 2/2] gpg-interface: limit search for primary key fingerprint
Date:   Fri, 22 Nov 2019 20:23:12 +0000
Message-Id: <20191122202312.10120-3-hji@dyntopia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122202312.10120-1-hji@dyntopia.com>
References: <20191121234336.26300-1-hji@dyntopia.com>
 <20191122202312.10120-1-hji@dyntopia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The VALIDSIG status line from GnuPG with --status-fd is documented to
have 9 required and 1 optional fields [1].  The final, and optional,
field is used to specify the fingerprint of the primary key that made
the signature in case it was made by a subkey.  However, this field is
only available for OpenPGP signatures; not for CMS/X.509.

If the VALIDSIG status line does not have the optional 10th field, the
current code will continue reading onto the next status line.  And this
is the case for non-OpenPGP signatures [1].

The consequence is that a subsequent status line may be considered as
the "primary key" for signatures that does not have an actual primary
key.

The solution introduced by this commit is to limit the search for a
primary key to a single line.  The search for the 10th VALIDSIG field is
aborted as soon as it sees a newline character.  This keeps the parser
from interpreting subsequent lines as the primary key.

[Reference]
[1] GnuPG Details, General status codes
https://git.gnupg.org/cgi-bin/gitweb.cgi?p=gnupg.git;a=blob;f=doc/DETAILS;h=6ce340e8c04794add995e84308bb3091450bd28f;hb=HEAD#l483

The documentation say:

    VALIDSIG <args>

    The args are:

    - <fingerprint_in_hex>
    - <sig_creation_date>
    - <sig-timestamp>
    - <expire-timestamp>
    - <sig-version>
    - <reserved>
    - <pubkey-algo>
    - <hash-algo>
    - <sig-class>
    - [ <primary-key-fpr> ]

    This status indicates that the signature is cryptographically
    valid. [...] PRIMARY-KEY-FPR is the fingerprint of the primary key
    or identical to the first argument.

    The primary-key-fpr parameter is used for OpenPGP and not available
    for CMS signatures.  [...]

Signed-off-by: Hans Jerry Illikainen <hji@dyntopia.com>
---
 gpg-interface.c | 24 ++++++++++++++++++------
 t/t4202-log.sh  | 20 ++++++++++++++++++++
 2 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 37162c9a43..131e7d529e 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -156,21 +156,33 @@ static void parse_gpg_output(struct signature_check *sigc)
 				}
 				/* Do we have fingerprint? */
 				if (sigcheck_gpg_status[i].flags & GPG_STATUS_FINGERPRINT) {
+					const char *limit;
+					char **field;
+
 					next = strchrnul(line, ' ');
 					replace_cstring(&sigc->fingerprint, line, next);
 
-					/* Skip interim fields */
+					/*
+					 * Skip interim fields.  The search is
+					 * limited to the same line since only
+					 * OpenPGP signatures has a field with
+					 * the primary fingerprint.
+					 */
+					limit = strchrnul(line, '\n');
 					for (j = 9; j > 0; j--) {
-						if (!*next)
+						if (!*next || limit <= next)
 							break;
 						line = next + 1;
 						next = strchrnul(line, ' ');
 					}
 
-					next = strchrnul(line, '\n');
-					free(sigc->primary_key_fingerprint);
-					replace_cstring(&sigc->primary_key_fingerprint,
-							line, next);
+					field = &sigc->primary_key_fingerprint;
+					if (!j) {
+						next = strchrnul(line, '\n');
+						replace_cstring(field, line, next);
+					} else {
+						replace_cstring(field, NULL, NULL);
+					}
 				}
 
 				break;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index e803ba402e..d18613dad1 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1570,6 +1570,14 @@ test_expect_success GPG 'setup signed branch' '
 	git commit -S -m signed_commit
 '
 
+test_expect_success GPG 'setup signed branch with subkey' '
+	test_when_finished "git reset --hard && git checkout master" &&
+	git checkout -b signed-subkey master &&
+	echo foo >foo &&
+	git add foo &&
+	git commit -SB7227189 -m signed_commit
+'
+
 test_expect_success GPGSM 'setup signed branch x509' '
 	test_when_finished "git reset --hard && git checkout master" &&
 	git checkout -b signed-x509 master &&
@@ -1580,6 +1588,18 @@ test_expect_success GPGSM 'setup signed branch x509' '
 	git commit -S -m signed_commit
 '
 
+test_expect_success GPGSM 'log x509 fingerprint' '
+	echo "F8BF62E0693D0694816377099909C779FA23FD65 | " >expect &&
+	git log -n1 --format="%GF | %GP" signed-x509 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success GPGSM 'log OpenPGP fingerprint' '
+	echo "D4BE22311AD3131E5EDA29A461092E85B7227189" > expect &&
+	git log -n1 --format="%GP" signed-subkey >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success GPG 'log --graph --show-signature' '
 	git log --graph --show-signature -n1 signed >actual &&
 	grep "^| gpg: Signature made" actual &&
-- 
2.24.GIT

