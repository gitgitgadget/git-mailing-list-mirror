Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA35C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 23:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52366206EC
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 23:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dyntopia-com.20150623.gappssmtp.com header.i=@dyntopia-com.20150623.gappssmtp.com header.b="p6zfBF9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfKUXnu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 18:43:50 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39405 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbfKUXnt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 18:43:49 -0500
Received: by mail-io1-f67.google.com with SMTP id k1so5697284ioj.6
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 15:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YAIUuo6ol+QKWSYd7ihm7lR7MQ9TijZd65B8l7/e0bw=;
        b=p6zfBF9bd2q/FmmaKkGcdF44XPMgebIwZzFcgU1CEwM9qfplkcuxFmENLG19yksflB
         pbir66fkt4qzGh/udbVBEV71qVe+72UrDLMhGHsMQe6lT5+QJA88TrOg76wmYTkP7PeL
         Bpk65+d/FPtplrmerz3sOeLaEK3qz/D0goARn3tgZtsUPAJhCydER2/lYQ6nBN1JyPfu
         kZ9gOcuRaHt55OPMgS+E8g00umNxPNXyGhXOGXgVsR980L5qIpEvZWTj5Sk0w3UYYFbY
         qwVn2S/yyL/Bk2MuUGiqHOjmshW7/xS9hJBDT26/sfwFkR6tutt7Ocky5a8k8MErOo1x
         0YgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YAIUuo6ol+QKWSYd7ihm7lR7MQ9TijZd65B8l7/e0bw=;
        b=HcsLMTQZ1jKb6b2UkkwpRIUh4wB8GQF7MgbLcI/EPbPieFSd1F6X/Zen+3So9jE6SV
         BSQa/mFqzAcwWzu4Pse+eeF3JSHWgaq6/AGb6u/xpmEFYZ4j6XlrR8suAfxtWeNX4a9q
         le3hVdRq6MXTeRAXjOThJ/WRbz7k5aYf+8xzlDTS9al6+TIAyMvx+UHzWaBetOyXVvqo
         rEeF0n85KRrT/Ip05je1EZmzexTHsK/JTggo7qn4imQ0d6NyrZ/Edq3IRMlz8fewZIeB
         7CepqODZSWi44ub59pn3SYLqMnLgEnpuGd43x3qRIsdbgqNSRC/upCC27h5YQXI7TbDI
         C6oQ==
X-Gm-Message-State: APjAAAVKsQ84mJUgp/kUpFOUaek9pdF4mZO+4O+6UY93ckh/mtqkdRJy
        CDki+d6DaulsoQYPu7dONP6GY8I9IbY=
X-Google-Smtp-Source: APXvYqzOyJ6RKn+7tDjcafEg6oUmtNyYpDxXldPQEG8+0FFapdtRPeC/9IqHxwzMtV94RVmLYeIAJg==
X-Received: by 2002:a6b:e016:: with SMTP id z22mr10366877iog.296.1574379828018;
        Thu, 21 Nov 2019 15:43:48 -0800 (PST)
Received: from localhost ([182.232.28.41])
        by smtp.gmail.com with ESMTPSA id i2sm4251671pgt.34.2019.11.21.15.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 15:43:47 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     git@vger.kernel.org
Cc:     Hans Jerry Illikainen <hji@dyntopia.com>
Subject: [PATCH v3 2/2] gpg-interface: limit search for primary key fingerprint
Date:   Thu, 21 Nov 2019 23:43:36 +0000
Message-Id: <20191121234336.26300-3-hji@dyntopia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191121234336.26300-1-hji@dyntopia.com>
References: <20191116215850.3919-1-hji@dyntopia.com>
 <20191121234336.26300-1-hji@dyntopia.com>
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

The current code assumes that the VALIDSIG status line always has 10
fields.  Furthermore, the current code assumes that each field is
separated by a space (0x20) character.

If the VALIDSIG status line does not have the optional 10th field, the
current code will continue reading onto the next status line -- because
only 0x20 is considered a field separator, not 0xa.  And this is the
case for non-OpenPGP signatures [1].

The consequence is that a subsequent status line may be considered as
the "primary key" for signatures that does not have an actual primary
key.

The solution introduced by this commit is to add 0xa as a bound for the
search for a primary key.  The search for the 10th VALIDSIG field is
aborted as soon as it sees a newline character.  This keeps the parser
from interpreting subsequent lines as the primary key.

[1] https://git.gnupg.org/cgi-bin/gitweb.cgi?p=gnupg.git;a=blob;f=doc/DETAILS#l483

Signed-off-by: Hans Jerry Illikainen <hji@dyntopia.com>
---
 gpg-interface.c | 24 +++++++++++++++++-------
 t/t4202-log.sh  | 20 ++++++++++++++++++++
 2 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index b4c4443287..4269937b83 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -119,7 +119,8 @@ static void replace_cstring(const char **field, const char *line,
 static void parse_gpg_output(struct signature_check *sigc)
 {
 	const char *buf = sigc->gpg_status;
-	const char *line, *next;
+	const char *line, *next, *limit;
+	const char **field;
 	int i, j;
 	int seen_exclusive_status = 0;
 
@@ -160,18 +161,27 @@ static void parse_gpg_output(struct signature_check *sigc)
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
index e803ba402e..17ec2401ec 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1570,6 +1570,14 @@ test_expect_success GPG 'setup signed branch' '
 	git commit -S -m signed_commit
 '
 
+test_expect_success GPG 'setup signed branch with subkey' '
+        test_when_finished "git reset --hard && git checkout master" &&
+        git checkout -b signed-subkey master &&
+        echo foo >foo &&
+        git add foo &&
+        git commit -SB7227189 -m signed_commit
+'
+
 test_expect_success GPGSM 'setup signed branch x509' '
 	test_when_finished "git reset --hard && git checkout master" &&
 	git checkout -b signed-x509 master &&
@@ -1580,6 +1588,18 @@ test_expect_success GPGSM 'setup signed branch x509' '
 	git commit -S -m signed_commit
 '
 
+test_expect_success GPGSM 'log x509 fingerprint' '
+        echo "F8BF62E0693D0694816377099909C779FA23FD65 | " >expect &&
+        git log -n1 --format="%GF | %GP" signed-x509 >actual &&
+        test_cmp expect actual
+'
+
+test_expect_success GPGSM 'log OpenPGP fingerprint' '
+        echo "D4BE22311AD3131E5EDA29A461092E85B7227189" > expect &&
+        git log -n1 --format="%GP" signed-subkey >actual &&
+        test_cmp expect actual
+'
+
 test_expect_success GPG 'log --graph --show-signature' '
 	git log --graph --show-signature -n1 signed >actual &&
 	grep "^| gpg: Signature made" actual &&
-- 
2.24.0.157.gba9f894af8

