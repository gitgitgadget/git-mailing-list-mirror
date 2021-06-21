Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25B6C48BDF
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 02:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFA07611C0
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 02:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhFUCKG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 22:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhFUCKF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 22:10:05 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B7CC061574
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 19:07:51 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id i4so3974112plt.12
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 19:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k8LLbCmZ+rW7W8lu0Y9R2lUusRHpT/63ItPaIPbV7MI=;
        b=sD9O7LxBTgzZ4bUZFq/nBaKCQ+pl/jX5HoM83m7Tj9FgwzTL5e87z0lZVXA6sJJdol
         P7RkFFug3ONcGQRRoWs+i81UFtvjs7Nl6/1MJu0cuyDKFe3qPWqmbAu2i6bmSLvsPnpC
         Z/aKcUoA09RzO87zL0Wb4YR5iM0C93OCdGEYFRQcoGMu8gAdbvp+HWciabX0P5E327+8
         /Q8AIlqCa2HB2eYahmiUCO5/NSaClX1UdSzz+KmlGLuBF/GYKvVhXpCbo2RURDPYepO7
         9QKQkWARgPzgGVT/8CCgzlCXd8Wl/nwh+sR+fX21FJBgd2nvEjyU+7goFgc6CQR0LKX6
         qr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k8LLbCmZ+rW7W8lu0Y9R2lUusRHpT/63ItPaIPbV7MI=;
        b=UL4wyKACmBXGtkGpSq+Bclrfhs/BFba83cGEm9R+C8ijk8T+CetbRd76EzzY/uchOg
         GsjDWmBkEoSMpO+rf0RvvJYm1OjOx9SeT45TVfI9Yxw1KP56hxGMZWBnV5bqfiYcwUGM
         gvxFc9inAlaN58aJveCw5qPSp98jKhIpThnoR8ebnkvmR16lkeNJS4X93Ld8L+B3+m23
         xdxJgqF48VVkakvwb+8jsXyyS29qvQiMiGggAU/oZ8OzaIn/vsGXk5Zthxf48Kn2ARs3
         btEgd8RrMyMyYkwTwo8uA9SdBmqF3VY1HaL37+/kuDAGNohOiN+bvQzBmRZBFnYwhxy5
         fDCg==
X-Gm-Message-State: AOAM530zlDmJh9XjPPiJ8XoYJGeka494dFpaezc0M7X24v0AdwJV/2Lv
        Nu1qGI09+ZrPcGvTN3s0BjY=
X-Google-Smtp-Source: ABdhPJzBOJWMi9z08iay1JrCnHXmUk61YPhmDj6tOxonkI+x862PNSvzeFQ3PFCgLcLU3AW8xeEmRA==
X-Received: by 2002:a17:902:bd03:b029:11c:d504:c1ce with SMTP id p3-20020a170902bd03b029011cd504c1cemr15547405pls.7.1624241271134;
        Sun, 20 Jun 2021 19:07:51 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.104])
        by smtp.gmail.com with ESMTPSA id a9sm13336800pfo.69.2021.06.20.19.07.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jun 2021 19:07:50 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Peter Krefting <peter@softwolves.pp.se>,
        Yi-Jyun Pan <pan93412@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <worldhello.net@gmail.com>
Subject: [L10N] l10n: fixed tripple-letter typos
Date:   Mon, 21 Jun 2021 10:07:40 +0800
Message-Id: <20210621020740.25577-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.27.g7b1e85181b
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei found that the word "shallow" has an extra letter "l" in
"po/zh_CN.po". There are similar typos in other l10n files.

Reported-by: Andrei Rybak <rybak.a.v@gmail.com>
Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 po/README.md | 2 +-
 po/es.po     | 4 ++--
 po/fr.po     | 2 +-
 po/sv.po     | 2 +-
 po/zh_CN.po  | 6 +++---
 po/zh_TW.po  | 6 +++---
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/po/README.md b/po/README.md
index 2fd92cca04..a7e6f2014c 100644
--- a/po/README.md
+++ b/po/README.md
@@ -392,7 +392,7 @@ additional conventions:
         git-po-helper init --core <your-language>
 
 3. Add a new entry in the "po/TEAMS" file with proper format, and check
-   the syntax of "po/TEAMS" by runnning the following command:
+   the syntax of "po/TEAMS" by running the following command:
 
         git-po-helper team --check
 
diff --git a/po/es.po b/po/es.po
index c1c26138f0..ea15180c65 100644
--- a/po/es.po
+++ b/po/es.po
@@ -14897,7 +14897,7 @@ msgstr "extraer de todos los remotos"
 
 #: builtin/fetch.c:147 builtin/pull.c:245
 msgid "set upstream for git pull/fetch"
-msgstr "configurar upstream para git pulll/fetch"
+msgstr "configurar upstream para git pull/fetch"
 
 #: builtin/fetch.c:149 builtin/pull.c:188
 msgid "append to .git/FETCH_HEAD instead of overwriting"
@@ -19567,7 +19567,7 @@ msgstr "recibir programa de paquete"
 
 #: builtin/push.c:573
 msgid "set upstream for git pull/status"
-msgstr "configurar upstream para git pulll/status"
+msgstr "configurar upstream para git pull/status"
 
 #: builtin/push.c:576
 msgid "prune locally removed refs"
diff --git a/po/fr.po b/po/fr.po
index 336dc606b2..6c3630cbd4 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -25124,7 +25124,7 @@ msgid ""
 "    * Saying \"./%s\" if you mean a file; or\n"
 "    * Giving --format-patch option if you mean a range.\n"
 msgstr ""
-"Le fichier '%s' existe mais ce pourrait aussi être la plage de commmits\n"
+"Le fichier '%s' existe mais ce pourrait aussi être la plage de commits\n"
 "pour lequel les patches sont à produire. Veuillez préciser...\n"
 "\n"
 "    * en indiquant \"./%s\" si vous désignez un fichier, ou\n"
diff --git a/po/sv.po b/po/sv.po
index 4a9f2f3aca..d5bf6f530e 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -17352,7 +17352,7 @@ msgstr "kopiera Message-ID till slutet av incheckningsmeddelandet"
 
 #: builtin/mailinfo.c:64
 msgid "re-code metadata to i18n.commitEncoding"
-msgstr "koda om metadata till i18n.commmitEncoding"
+msgstr "koda om metadata till i18n.commitEncoding"
 
 #: builtin/mailinfo.c:67
 msgid "disable charset re-coding of metadata"
diff --git a/po/zh_CN.po b/po/zh_CN.po
index 446c601a70..d6f61eae5c 100644
--- a/po/zh_CN.po
+++ b/po/zh_CN.po
@@ -4162,7 +4162,7 @@ msgstr "服务器支持 %s"
 
 #: fetch-pack.c:1029
 msgid "Server does not support shallow clients"
-msgstr "服务器不支持 shalllow 客户端"
+msgstr "服务器不支持浅客户端"
 
 #: fetch-pack.c:1089
 msgid "Server does not support --shallow-since"
@@ -4204,7 +4204,7 @@ msgstr "服务器不支持算法 '%s'"
 
 #: fetch-pack.c:1279
 msgid "Server does not support shallow requests"
-msgstr "服务器不支持 shalllow 请求"
+msgstr "服务器不支持浅克隆请求"
 
 #: fetch-pack.c:1286
 msgid "Server supports filter"
@@ -23864,7 +23864,7 @@ msgstr "预期仍然需要 %d 个字节的正文"
 
 #: remote-curl.c:1132
 msgid "dumb http transport does not support shallow capabilities"
-msgstr "哑 http 传输不支持 shalllow 能力"
+msgstr "哑 http 传输不支持浅克隆能力"
 
 #: remote-curl.c:1147
 msgid "fetch failed."
diff --git a/po/zh_TW.po b/po/zh_TW.po
index 77a5d57ed8..cb5db0abfa 100644
--- a/po/zh_TW.po
+++ b/po/zh_TW.po
@@ -4291,7 +4291,7 @@ msgstr "伺服器支援 %s"
 
 #: fetch-pack.c:1029
 msgid "Server does not support shallow clients"
-msgstr "伺服器不支援 shalllow 用戶端"
+msgstr "伺服器不支援 shallow 用戶端"
 
 #: fetch-pack.c:1089
 msgid "Server does not support --shallow-since"
@@ -4333,7 +4333,7 @@ msgstr "伺服器不支援「%s」算法"
 
 #: fetch-pack.c:1279
 msgid "Server does not support shallow requests"
-msgstr "伺服器不支援 shalllow 請求"
+msgstr "伺服器不支援 shallow 請求"
 
 #: fetch-pack.c:1286
 msgid "Server supports filter"
@@ -23992,7 +23992,7 @@ msgstr "預期仍要有 %d 位元組的本文 (body)"
 
 #: remote-curl.c:1132
 msgid "dumb http transport does not support shallow capabilities"
-msgstr "啞 http 傳輸不支援 shalllow 能力"
+msgstr "啞 http 傳輸不支援 shallow 能力"
 
 #: remote-curl.c:1147
 msgid "fetch failed."
-- 
2.32.0.rc0.27.g7b1e85181b

