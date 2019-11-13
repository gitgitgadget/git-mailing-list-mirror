Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCB441F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 18:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfKMS4C (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 13:56:02 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46904 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbfKMS4B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 13:56:01 -0500
Received: by mail-lj1-f194.google.com with SMTP id e9so3758604ljp.13
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 10:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VY4OGchn4ttzxkTbz7bR4pwBhl0Mc2MoXTOBIK/hNjk=;
        b=bhqF1TG3fR3f1gJ0gzQ5iJebplbI9HOSiu9r1K3L4bHgA+YgdOP3VIpLv8jh0PqlXJ
         jaHcEvhWUDsUPWz5YTHNXN4qfe1V42bMtLG5uDZQcJgQFU08Tn2KUPBcqGc5v7ilPOmK
         Aq4LM7u5zJidCw6vNNkCgLdqGK+TaRBEj4l8R20C3wmDtGiOsKQPbgvLNq7DNMxBbPul
         0rnL5hSJnJjXYfIOM+aa40dybJQYDSGD/O74k0OXYJ+OtQn11kSRg413LTyzjeMqVx2U
         Eyh/2s+82hxmBGCKmhVFuezEnt7EcLkc1cgxJtOGYW8BGQM0QFscIHA2hzEgiYQjq+RA
         qL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VY4OGchn4ttzxkTbz7bR4pwBhl0Mc2MoXTOBIK/hNjk=;
        b=jPinVADL9rqu5YrztwBLrVHxPfzr4IWBK0egs3xT/mI8TItfM7SchjJRwCjgCkjqbD
         XCdOHfmSXiC78UrszjjxKYD9U2UC6QjdqjqJkSSAyKkfabblxgvP88yhQv8AhO6LE2nQ
         uIfdSowVF1ZNYxMng4Zaybt2UtV5tVlD+aClje8khqBBKdNYr6Fuc3oXkwF2XccpPC2t
         rTW27bUSxavj9BMQMHpcDKzvjbLrLPa7WlOlz5ACCbZ2OxGHsHeCOsOyjTNsmtnMXM6R
         3cfNke4zQT9LqQTZNA2VHXBgOPPSoHwfojaW5wpU0VbagpNnFs+Ww7MCV1M2D1TIGbLr
         e1Jw==
X-Gm-Message-State: APjAAAW4ONmSPPPOZlqhDDX4WaNGqbcpPK6/hPGTeMBf4Ipx+j0GPhTu
        R7P/gznHUDSrrs71Zi/sBtYSOQle
X-Google-Smtp-Source: APXvYqzM+1gbaLtoy5QVKh7UuvGwWB/gNqMYlbxMUH5R8xyt8n2AaDMXnkqSz4XvlQVXvCC5AsaAsQ==
X-Received: by 2002:a2e:9f4c:: with SMTP id v12mr3272790ljk.167.1573671359316;
        Wed, 13 Nov 2019 10:55:59 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id c24sm1422765lfm.20.2019.11.13.10.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 10:55:58 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 8/8] builtin/config: die if "value_regex" doesn't canonicalize as boolean
Date:   Wed, 13 Nov 2019 19:55:07 +0100
Message-Id: <309960f7d4bd790a11c31b727475134368eb6a10.1573670565.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1573670565.git.martin.agren@gmail.com>
References: <cover.1573670565.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This completes the transition from handling a "value_regexp" with
`--type=bool` as a regex, to handling it on the assumption that it
canonicalizes to a boolean value.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-config.txt | 5 ++---
 builtin/config.c             | 4 ++--
 t/t1300-config.sh            | 5 +----
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 43310ca3c0..598915eac6 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -43,11 +43,10 @@ outgoing values are canonicalize-able under the given <type>.  If no
 `--type=<type>` is given, no canonicalization will be performed. Callers may
 unset an existing `--type` specifier with `--no-type`.
 
-With `--type=bool` or `--type=bool-or-int`, if `value_regex` is given
+With `--type=bool-or-int`, if `value_regex` is given
 and canonicalizes to a boolean value, it matches all entries
 that canonicalize to the same boolean value.
-The support for non-canonicalizing values of `value_regex` with
-`--type=bool` is deprecated.
+With `--type=bool`, `value_regex` (if given) must canonicalize.
 
 When reading, the values are read from the system, global and
 repository local configuration files by default, and options
diff --git a/builtin/config.c b/builtin/config.c
index 2af62b95f8..837766cfb3 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -303,8 +303,8 @@ static int handle_value_regex(const char *regex_)
 			cmd_line_value.boolean = boolval;
 			return 0;
 		}
-		warning(_("value_regex '%s' cannot be canonicalized "
-			  "to a boolean value"), regex_);
+		die(_("value_regex '%s' cannot be canonicalized "
+		      "to a boolean value"), regex_);
 	}
 
 	if (type == TYPE_BOOL_OR_INT) {
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 3e067c211d..9eccc255db 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -465,11 +465,8 @@ test_expect_success '--get canonicalizes integer value_regex with --type=bool' '
 '
 
 test_expect_success '--type=bool with "non-bool" value_regex' '
-	echo true >expect &&
-	git config --type=bool --get foo.y4 "t.*" >output 2>err &&
-	test_cmp expect output &&
+	test_must_fail git config --type=bool --get foo.y4 t >output 2>err &&
 	test_i18ngrep "cannot be canonicalized" err &&
-	test_must_fail git config --type=bool --get foo.y4 "T.*" >output &&
 	test_must_be_empty output
 '
 
-- 
2.24.0

