Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9911C76196
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 22:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbjDCWd5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 18:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbjDCWdt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 18:33:49 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B36422C
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 15:33:44 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id l27so30893005wrb.2
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 15:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680561223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHlsklKDtGHBtdf2RNlEwL2fSwX7wLVYtDR4NomFA70=;
        b=J0iSRHOvciPashI0IHar4dccbDwcf3O84EPeF/jaVhIpPp/6mfSkyoFX0ewRUrGWQW
         /MEEida0PUDb7mOxqpZH6dkZ7cteTVIyxbQWaTr2y+tG4ZFbKS85z78POryFTjAqyagY
         jDZjeJm2ii5hqbBky9jMLQCrIz7nNS6U0IaNrInRJ8nz9uLoh8ErfDoO/3HoJ9OHcFWY
         +UMm0P94uyCPY/FBuD0O0z/hdmneueYAHoJPpaOv4gzB7NgVDGgU3lBgDk0gHU2jBEnF
         pFSvRkT4hVfIrFGjcNmLBM6NCdSYaUds+I3veOuXCMUmI+E4jIBLcgrdzhmqF21odQh+
         bVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680561223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHlsklKDtGHBtdf2RNlEwL2fSwX7wLVYtDR4NomFA70=;
        b=tPvwcauG8B84UIFbJ3fpQ8Wv12MKKtibgNMH1O6l8pzChF1GOm6M90/SfbIITnbbm1
         VhmOixgtTMqumqEL5udplBOSahUsnfV1FeyL8HPXaHldSNisDVi9dMnEu8dD5wYONEvw
         8+fBdXVsD5UoZSEuVnkXjS5dA46MN4xs+P5qlQJAtGwB7qQGuFIgg8p8gsedGW8zcYXe
         jHdtkWq5+DavCJWmv8Kkz6fisl6p7bvf6GLefl3Rhc9G66ZiATocU3DKp8V6Ueu58ijf
         TETbyazeN4C+LlBZmR+JswgAG8hidnmhjqptxk+nVzo3DiR1DXZgTUJsxbzF9ZbKf7I6
         Dh3Q==
X-Gm-Message-State: AAQBX9eqcOKI2VKMhwdYeUrRBTfkMKpLPXQgB8Oe0q6xcaoVpswyMik2
        ST/7ooV1gV5bP8bMCoBgVx1yPv4PXL3uPE7NZeE=
X-Google-Smtp-Source: AKy350aLGozItR+nzAhk/Ri9DyVhlDPM1Z313PKGEtHslWfQIjgpIGSyrDJEt3cX186reNe5b2a3jg==
X-Received: by 2002:adf:facb:0:b0:2e5:5f89:3386 with SMTP id a11-20020adffacb000000b002e55f893386mr81365wrs.23.1680561222918;
        Mon, 03 Apr 2023 15:33:42 -0700 (PDT)
Received: from titov.fritz.box ([212.102.57.24])
        by smtp.gmail.com with ESMTPSA id m17-20020adfe0d1000000b002d1e49cff35sm10697453wri.40.2023.04.03.15.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 15:33:42 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/6] t1300: don't create unused files
Date:   Tue,  4 Apr 2023 00:33:35 +0200
Message-Id: <20230403223338.468025-4-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230403223338.468025-1-rybak.a.v@gmail.com>
References: <20230401212858.266508-1-rybak.a.v@gmail.com>
 <20230403223338.468025-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Three tests in t1300-config.sh check that "git config --get" barfs when
syntax errors are present in the config file.  The tests redirect
standard output and standard error of "git config --get" to files,
"actual" and "error" correspondingly.  They assert presence of an error
message in file "error".  However, these tests don't use file "actual"
for assertions.

Don't redirect standard output of "git config --get" to file "actual" in
t1300-config.sh to avoid creating unnecessary files.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t1300-config.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index d566729d74..8ac4531c1b 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1575,7 +1575,7 @@ test_expect_success 'barf on syntax error' '
 	[section]
 	key garbage
 	EOF
-	test_must_fail git config --get section.key >actual 2>error &&
+	test_must_fail git config --get section.key 2>error &&
 	test_i18ngrep " line 3 " error
 '
 
@@ -1585,7 +1585,7 @@ test_expect_success 'barf on incomplete section header' '
 	[section
 	key = value
 	EOF
-	test_must_fail git config --get section.key >actual 2>error &&
+	test_must_fail git config --get section.key 2>error &&
 	test_i18ngrep " line 2 " error
 '
 
@@ -1595,7 +1595,7 @@ test_expect_success 'barf on incomplete string' '
 	[section]
 	key = "value string
 	EOF
-	test_must_fail git config --get section.key >actual 2>error &&
+	test_must_fail git config --get section.key 2>error &&
 	test_i18ngrep " line 3 " error
 '
 
-- 
2.40.0

