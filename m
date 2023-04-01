Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EE3C77B71
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 21:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjDAV3L (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 17:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjDAV3G (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 17:29:06 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4ED93C2
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 14:29:04 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so15916499wmq.3
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 14:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680384543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHlsklKDtGHBtdf2RNlEwL2fSwX7wLVYtDR4NomFA70=;
        b=HE+wkz6bvcwtHL2FhuP3BKjC+XBy+f6s25fabYBrSfjtStrb/RE5zHR5J8KuC7GR9G
         Zc/sl/yroElQ/xsKZNZeFkQCfGeRRkCJpewQhnBUkWLWmkSkCBf9aSkI+xxxsdmV2soD
         FpAlHnD8OapbpfuRnbeYj0gdQINZhpj9PxxTdojb6Jr7AQhXsXzfCJjfr0zeuVHiHgsK
         vK/5dBKtXhC23bgmVxdJZbNnanXeIRew4gtGOsMgdsXzC+KCrIvEXB0w0BMdVuIF2gYQ
         tcHXqMJMrMFCrKekez/WXP+PAm9CcJLDxVVCaipLP0+EmgK82jqQx0OcZTMt/Tqf31nY
         o+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680384543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHlsklKDtGHBtdf2RNlEwL2fSwX7wLVYtDR4NomFA70=;
        b=pAQd459qUpkbYYDlXkKla+tF686Y6DhUnw7PkCnuDbR8NN2UU9RrEdYH4g/QxEp4qG
         tBp+VITM1c2rCKnebkLD/zFODesJP7TybjmvfunONBzzMDIKGbZ+40wRbj8791CX41I1
         sfvaArg4j92M1E6WpgKKTwqmy6xEcx6y+nwOgrs/fnXo8oFVcolFaLAg3pakiRI6BjMy
         Yh7mxteEL2iNWvJbRnAdWOZmY769yfBqSuaVd0frKr4bXskFMW0Vv5mme6dHVausN6Hm
         zerM9ucX07s5Pqwd9l3M0DY/y1mia2dfQR9Cm0duWs0n3cDGfwHfUky+IoyNQpiT1TCJ
         ApTA==
X-Gm-Message-State: AAQBX9fDACWlCys63Q624qrE9elaeCPoPc09SAvpTvqeUtu8PKYbrJKk
        0zrym4aW1051SV8Bg31q+uMEi+uUwwIpny+N
X-Google-Smtp-Source: AKy350Yfg3S5oioFi39u8PCYckFmAuvFkejZg4qCAsJ4RhOGsjthW27CD5BrdCiCPVYKbZ47gdaFmg==
X-Received: by 2002:a05:600c:cc:b0:3f0:3049:b216 with SMTP id u12-20020a05600c00cc00b003f03049b216mr9937192wmm.28.1680384542818;
        Sat, 01 Apr 2023 14:29:02 -0700 (PDT)
Received: from titov.fritz.box ([212.102.57.24])
        by smtp.gmail.com with ESMTPSA id i12-20020a5d55cc000000b002c3f81c51b6sm5738364wrw.90.2023.04.01.14.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 14:29:02 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Martin Stenberg <martin@gnutiken.se>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v1 3/6] t1300: don't create unused files
Date:   Sat,  1 Apr 2023 23:28:55 +0200
Message-Id: <20230401212858.266508-4-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230401212858.266508-1-rybak.a.v@gmail.com>
References: <20230401212858.266508-1-rybak.a.v@gmail.com>
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

