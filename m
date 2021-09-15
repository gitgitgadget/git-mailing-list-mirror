Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951D9C433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 08:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CA6F61212
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 08:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237110AbhIOIMk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 04:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236942AbhIOILh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 04:11:37 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8CDC0613E2
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 01:10:05 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id m21so2476967qkm.13
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 01:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NY7uCMi5cPY9K6nWHX9/3YVKLVG9oWje/gUm5AtEnRs=;
        b=NHGuAxCVfmS6G3ncrcK29+WVe0mtCbadGP4kWSzvfnZStSdIjRoUQKE4TOEYKrcks4
         pO+RkjrQ2fcYOfHz9MZcka2HxmkCzCeA0Verm31zS0OUgOl4AW6caVa5K9V7Qfb2hvxt
         DSE4Upi5F59cahPk26WtLBaJaIAcm7+AI83+VPHKkrS1p1OxxdY1o/wXwymEO97vuMyr
         I6zr29ZItQfOGHUbSXsjMjxCkgvZL/Z6r6vD0vj5yLQu9IVruEA9dECyfjGspv+hnPmd
         r7qJZlqdS/ErB6Vr7y6pes2tgvITCf04VS+uKlMXQS0jD09fpmMVFJ+gd3P8gkbixYg2
         +ydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NY7uCMi5cPY9K6nWHX9/3YVKLVG9oWje/gUm5AtEnRs=;
        b=O3jhwjoNe+e8GoEnNn1DJ6x8o/GXUme2q6WLRm6PDflHxGmIljF4bQ/jcQQknytMNr
         D4iW+fe9wuSKAmibUiLGOBLEvRSQ4SF44RwYlZ56yUnR3V3PJwZ4w0Rdkf1dxpI+aFua
         ihV8S3WT+lDC2yJhjOwhBzgSL+DseNfGna7AAuIpONdKx7I6x+dK8NtyAGJ4pDz6zsHt
         MctRvtUHAkYG/7K4P4p9DDYJWy+3mtYU1Mm91nmFzLmrSnviVBP+KduAyOviAguWtlkm
         t8L35cs2K7SkBzBoZEjR2xkzVW9JEDSyhPIDpyAvUPqtce9UDDjPgLF0iQLtSbBweMEf
         yWEQ==
X-Gm-Message-State: AOAM5316D7kuyueeR8/eaz4mDo3mgXxhrUA5xL8wpwe2oCq5dxKA/D3a
        GiytYvtF1cEhNrC0M4WKvOwwZKxr/GU=
X-Google-Smtp-Source: ABdhPJxNVBQUttlqGUEx96ALdScTUAvf5Zf11nRCQOBOTdrc7PjoPiriDdMRjlNNbIF1QamgYy7Dew==
X-Received: by 2002:a37:6451:: with SMTP id y78mr8627944qkb.427.1631693403903;
        Wed, 15 Sep 2021 01:10:03 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id 20sm9661435qkn.31.2021.09.15.01.10.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Sep 2021 01:10:03 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     sam@vilain.net, avarab@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 2/3] git-cvsserver: protect against NULL in crypt(3)
Date:   Wed, 15 Sep 2021 01:09:47 -0700
Message-Id: <20210915080948.11891-3-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <20210915080948.11891-1-carenas@gmail.com>
References: <20210915080948.11891-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some versions of crypt(3) will return NULL when passed an unsupported
hash type (ex: OpenBSD with DES), so check for undef instead of using
it directly.

Also use this to probe the system and select a better hash function in
the tests, so it can pass successfully.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 git-cvsserver.perl              | 7 ++++---
 t/t9400-git-cvsserver-server.sh | 7 ++++++-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 4c93b5d099..8e7c34a235 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -222,10 +222,11 @@
         open my $passwd, "<", $authdb or die $!;
         while (<$passwd>) {
             if (m{^\Q$user\E:(.*)}) {
-                if (crypt(descramble($password), $1) eq $1) {
-                    $auth_ok = 1;
+                my $hash = crypt(descramble($password), $1);
+                if (defined $hash) {
+                    $auth_ok = 1 if $hash eq $1;
                 }
-            };
+            }
         }
         close $passwd;
 
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 59b40359c7..17f988edd2 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -36,7 +36,12 @@ CVSWORK="$PWD/cvswork"
 CVS_SERVER=git-cvsserver
 export CVSROOT CVS_SERVER
 
-PWDHASH='lac2ItudM3.KM'
+if perl -e 'exit(1) if not defined crypt("", "cv")'
+then
+	PWDHASH='lac2ItudM3.KM'
+else
+	PWDHASH='$2b$10$t8fGvE/a9eLmfOLzsZme2uOa2QtoMYwIxq9wZA6aBKtF1Yb7FJIzi'
+fi
 
 rm -rf "$CVSWORK" "$SERVERDIR"
 test_expect_success 'setup' '
-- 
2.33.0.481.g26d3bed244

