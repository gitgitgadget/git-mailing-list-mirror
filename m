Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAF7C07E97
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 11:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79A1A6162C
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 11:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhGCLVh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 07:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhGCLVh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 07:21:37 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64E8C061762
        for <git@vger.kernel.org>; Sat,  3 Jul 2021 04:19:03 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id j199so11168563pfd.7
        for <git@vger.kernel.org>; Sat, 03 Jul 2021 04:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ogMiUjyfI5eTNFWTL7be9KmtetmP0VxFwIr4TwbTtlc=;
        b=gfrMMxAhXHucRlQ2HBBmmN/A6j2oKFNK+HsEZvWKiuWVkbYvfU2CIYL7mUUB4+/5NS
         Svvo13cHPcxEi5HaGj3To9Jw8fXuV9PdNGjkk5bz+3HvbkQJT76R+u7Z1oZFFGatULg8
         Rh7f43KT+sWkv/zxFHY853WGVVhKZdILmT2i8HwPBZq0WxVnnF+2F3RK8D22jkDWYKF9
         vQAeakoNEIYuwSIc5fidAc9qsbYW7c6m/O0KQMxSmFrX0J1df0jzUPgYHZlbyneLtQsj
         HdZN1Q/2jKrWEQEGCxsUuiyJecHcx/lruAkbc0nWQpNXgkkmVBbLCDe/mJJmuJ9K2hC5
         PDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ogMiUjyfI5eTNFWTL7be9KmtetmP0VxFwIr4TwbTtlc=;
        b=spHeLgN4YfqH91qKBZoQov0oMhAYQLOSY/YkIeZun9JSWtR+g4lWoZ9LwafcTOa6hb
         sTDFLuWECYSzdG2olpeXeAtCrjf0rb+kTQ90UUAxqAkIslVaL2O9pHTFLYQl6/JtJIRH
         tcpK4BHq3Mgd31VCWebhNYl23fQNpROOW4b0Klsojher8vPwV4ddMmitff/Gl/ofNsKw
         K22DnVj/yFRKejBJhY2PtN9ZJDR27/PmQiMvjkNioK3YvdmTllnopUEIh6pcdVC3OOk8
         p5ijAp7G7KSByyqwgXL+HgMLHkRLL79GfHpTref4nu116q/Ko/k2Ttlxip3R5etwpnqv
         sFLw==
X-Gm-Message-State: AOAM531nonvm3oVN4Lfte0qr5GV5XIOitKUAXy2uxUIm2TNFfrZqSwLY
        +aJyKRnMeaqHmfZd2/eZIMQ=
X-Google-Smtp-Source: ABdhPJyIwSfOYLT5BTCk/c+CX54gajxpkEK0s2qZvuEUA8HLwIRW6lbrFJgaZ0SMgC/EZOpR/Gyt3g==
X-Received: by 2002:a63:c1e:: with SMTP id b30mr4902968pgl.118.1625311143127;
        Sat, 03 Jul 2021 04:19:03 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id k19sm5203937pji.32.2021.07.03.04.19.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Jul 2021 04:19:02 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Peter Krefting <peter@softwolves.pp.se>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        Daniel Santos <hello@brighterdan.com>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Yi-Jyun Pan <pan93412@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jimmy Angelakos <vyruss@hellug.gr>,
        Arusekk <arek_koz@o2.pl>, Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [L10N] fixed mismatched variable names
Date:   Sat,  3 Jul 2021 19:18:37 +0800
Message-Id: <20210703111837.14894-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <alpine.DEB.2.21.2106212034050.12899@perkele.intern.softwolves.pp.se>
References: <alpine.DEB.2.21.2106212034050.12899@perkele.intern.softwolves.pp.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Peter Krefting <peter@softwolves.pp.se>

On Tue, Jun 22 2021, Peter Krefting wrote:

> Andrei also pointed out another typo in the Swedish translation, where
> a configuration option had been copied incorrectly. Could you please
> amend your patch to contain both these changes?
>
> ... ...
>
> @@ -2734,7 +2734,7 @@ msgstr "Felaktigt %s: \"%s\""
>   #: config.c:2512
>   #, c-format
>   msgid "splitIndex.maxPercentChange value '%d' should be between 0 and 100"
> -msgstr "värdet \"%d\" för splitIndex.maxPercentage borde vara mellan 0 och 100"
> +msgstr "värdet \"%d\" för splitIndex.maxPercentChange borde vara mellan 0 och 100"
> 
>   #: config.c:2558
>   #, c-format

There are definitely more typos like this! In order to find mismatched
git config variables and other mismatched variable names in the po file,
I implemented a checker for such typos in the "git-po-helper" in commit:

 * https://github.com/git-l10n/git-po-helper/commit/e44df847abb91227771560aca56719031f280068

To find typos, run:

    git-po-helper check-po XX.po

All easy-to-fix typos can be fixed using the following patch, but there
are still some typos need to be fixed by l10n team leaders for the
following languages:

 + bg.po 
 + id.po
 + tr.po

Patch for easy-to-fix typos, cut here -- 8< --

Subject: [PATCH] l10n: fixed mismatched config variables

Andrei pointed out a typo in the Swedish translation, where a config
variable name had been copied incorrectly.

By introducing typo detection function in "git-po-helper", more typos
were found. All easy-to-fix typos were fixed in this commit.

Reported-by: Andrei Rybak <rybak.a.v@gmail.com>
Signed-off-by: Peter Krefting <peter@softwolves.pp.se>
Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 po/ca.po    |  6 +++---
 po/de.po    |  2 +-
 po/es.po    |  6 +++---
 po/fr.po    | 12 ++++++------
 po/it.po    |  4 ++--
 po/ko.po    |  6 +++---
 po/pt_PT.po |  2 +-
 po/sv.po    |  4 ++--
 po/tr.po    |  4 ++--
 po/vi.po    |  6 +++---
 po/zh_CN.po | 12 ++++++------
 po/zh_TW.po |  8 ++++----
 12 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/po/ca.po b/po/ca.po
index 4c451706a9..2353eefae0 100644
--- a/po/ca.po
+++ b/po/ca.po
@@ -5023,13 +5023,13 @@ msgstr "(comissió errònia)\n"
 #: merge-recursive.c:379
 #, c-format
 msgid "add_cacheinfo failed for path '%s'; merge aborting."
-msgstr "addinfo_cache ha fallat per al camí «%s»; interrompent la fusió."
+msgstr "add_cacheinfo ha fallat per al camí «%s»; interrompent la fusió."
 
 #: merge-recursive.c:388
 #, c-format
 msgid "add_cacheinfo failed to refresh for path '%s'; merge aborting."
 msgstr ""
-"addinfo_cache ha fallat al refrescar el camí «%s»; interrompent la fusió."
+"add_cacheinfo ha fallat al refrescar el camí «%s»; interrompent la fusió."
 
 #: merge-recursive.c:876
 #, c-format
@@ -15141,7 +15141,7 @@ msgstr "git fetch --all [<opcions>]"
 
 #: builtin/fetch.c:122
 msgid "fetch.parallel cannot be negative"
-msgstr "fetch.paral·lelisme no pot ser negatiu"
+msgstr "fetch.parallel no pot ser negatiu"
 
 #: builtin/fetch.c:145 builtin/pull.c:185
 msgid "fetch from all remotes"
diff --git a/po/de.po b/po/de.po
index 20d720b1d0..101ee1d1f2 100644
--- a/po/de.po
+++ b/po/de.po
@@ -3395,7 +3395,7 @@ msgstr ""
 #: diff.c:410
 #, c-format
 msgid "Unknown value for 'diff.submodule' config variable: '%s'"
-msgstr "Unbekannter Wert in Konfigurationsvariable 'diff.dirstat': '%s'"
+msgstr "Unbekannter Wert in Konfigurationsvariable 'diff.submodule': '%s'"
 
 #: diff.c:470
 #, c-format
diff --git a/po/es.po b/po/es.po
index ea15180c65..cd4f0ce9fa 100644
--- a/po/es.po
+++ b/po/es.po
@@ -15267,7 +15267,7 @@ msgid ""
 "partialclone"
 msgstr ""
 "--filter solo puede ser usado con el remoto configurado en extensions."
-"partialClone"
+"partialclone"
 
 #: builtin/fetch.c:2083
 msgid "--atomic can only be used when fetching from one remote"
@@ -15684,7 +15684,7 @@ msgstr "reempaquetar todos los otros paquetes excepto el paquete más grande"
 #: builtin/gc.c:576
 #, c-format
 msgid "failed to parse gc.logexpiry value %s"
-msgstr "falló al analizar valor %s de gc.logexpirity"
+msgstr "falló al analizar valor %s de gc.logexpiry"
 
 #: builtin/gc.c:587
 #, c-format
@@ -16890,7 +16890,7 @@ msgstr "%s: modo cover from description inválido"
 
 #: builtin/log.c:850
 msgid "format.headers without value"
-msgstr "formate.headers. sin valor"
+msgstr "format.headers sin valor"
 
 #: builtin/log.c:979
 #, c-format
diff --git a/po/fr.po b/po/fr.po
index 6c3630cbd4..851b93858c 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -4719,12 +4719,12 @@ msgstr "(mauvais commit)\n"
 #: merge-recursive.c:379
 #, c-format
 msgid "add_cacheinfo failed for path '%s'; merge aborting."
-msgstr "échec de addinfo_cache pour le chemin '%s' ; abandon de la fusion."
+msgstr "échec de add_cacheinfo pour le chemin '%s' ; abandon de la fusion."
 
 #: merge-recursive.c:388
 #, c-format
 msgid "add_cacheinfo failed to refresh for path '%s'; merge aborting."
-msgstr "échec de addinfo_cache pour le chemin '%s' ; abandon de la fusion."
+msgstr "échec de add_cacheinfo pour le chemin '%s' ; abandon de la fusion."
 
 #: merge-recursive.c:876
 #, c-format
@@ -5994,12 +5994,12 @@ msgid "Refresh index"
 msgstr "Rafraîchir l'index"
 
 #: read-cache.c:1700
-#, c-format
+#, c-format, fuzzy
 msgid ""
 "index.version set, but the value is invalid.\n"
 "Using version %i"
 msgstr ""
-"version d'index renseignée, mais la valeur est invalide.\n"
+"index.version renseignée, mais la valeur est invalide.\n"
 "Utilisation de la version %i"
 
 #: read-cache.c:1710
@@ -8275,7 +8275,7 @@ msgstr "nom de sous-module suspicieux %s ignoré"
 
 #: submodule-config.c:304
 msgid "negative values not allowed for submodule.fetchjobs"
-msgstr "les valeurs négatives ne sont pas permises pour submodule.fetchJobs"
+msgstr "les valeurs négatives ne sont pas permises pour submodule.fetchjobs"
 
 #: submodule-config.c:402
 #, c-format
@@ -14645,7 +14645,7 @@ msgstr "Le protocole ne prend pas en charge --negotiate-only, abandon."
 
 #: builtin/fetch.c:2079
 msgid "--filter can only be used with the remote configured in extensions.partialclone"
-msgstr "--filter ne peut être utilisé qu'avec le dépôt distant configuré dans extensions.partialClone"
+msgstr "--filter ne peut être utilisé qu'avec le dépôt distant configuré dans extensions.partialclone"
 
 #: builtin/fetch.c:2083
 msgid "--atomic can only be used when fetching from one remote"
diff --git a/po/it.po b/po/it.po
index 8f793659f5..089a44b5fe 100644
--- a/po/it.po
+++ b/po/it.po
@@ -14953,7 +14953,7 @@ msgid ""
 "--filter can only be used with the remote configured in extensions."
 "partialclone"
 msgstr ""
-"--filter può essere usato solo con il remoto configurato nelle estensioni."
+"--filter può essere usato solo con il remoto configurato nelle extensions."
 "partialclone"
 
 #: builtin/fetch.c:1891
@@ -21746,7 +21746,7 @@ msgid "could not generate diff %s^!."
 msgstr "impossibile generare il diff %s^!"
 
 #: builtin/stash.c:422
-msgid "conflicts in index.Try without --index."
+msgid "conflicts in index. Try without --index."
 msgstr "ci sono conflitti nell'indice. Prova senza --index."
 
 #: builtin/stash.c:428
diff --git a/po/ko.po b/po/ko.po
index dcfe21c223..0e6ecf97fb 100644
--- a/po/ko.po
+++ b/po/ko.po
@@ -1702,7 +1702,7 @@ msgid ""
 "Found errors in 'diff.dirstat' config variable:\n"
 "%s"
 msgstr ""
-"'diff.submodule' 설정 변수에 오류:\n"
+"'diff.dirstat' 설정 변수에 오류:\n"
 "%s'"
 
 #: diff.c:3823
@@ -2261,12 +2261,12 @@ msgstr "(잘못된 커밋)\n"
 #: merge-recursive.c:320
 #, c-format
 msgid "add_cacheinfo failed for path '%s'; merge aborting."
-msgstr "'%s' 경로에 대해 addinfo_cache 실패. 병합 중지."
+msgstr "'%s' 경로에 대해 add_cacheinfo 실패. 병합 중지."
 
 #: merge-recursive.c:328
 #, c-format
 msgid "add_cacheinfo failed to refresh for path '%s'; merge aborting."
-msgstr "'%s' 경로에 대해 addinfo_cache 새로 고침 실패. 병합 중지."
+msgstr "'%s' 경로에 대해 add_cacheinfo 새로 고침 실패. 병합 중지."
 
 #: merge-recursive.c:410
 msgid "error building trees"
diff --git a/po/pt_PT.po b/po/pt_PT.po
index f068d0e0ba..3b15fccf9a 100644
--- a/po/pt_PT.po
+++ b/po/pt_PT.po
@@ -14610,7 +14610,7 @@ msgstr "Referência remota HEAD não encontrada"
 #: builtin/fetch.c:677
 #, c-format
 msgid "configuration fetch.output contains invalid value %s"
-msgstr "a configuração fetch.ouput contém o valor inválido %s"
+msgstr "a configuração fetch.output contém o valor inválido %s"
 
 #: builtin/fetch.c:775
 #, c-format
diff --git a/po/sv.po b/po/sv.po
index d5bf6f530e..facfdca7b5 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -2734,7 +2734,7 @@ msgstr "Felaktigt %s: \"%s\""
 #: config.c:2512
 #, c-format
 msgid "splitIndex.maxPercentChange value '%d' should be between 0 and 100"
-msgstr "värdet \"%d\" för splitIndex.maxPercentage borde vara mellan 0 och 100"
+msgstr "värdet \"%d\" för splitIndex.maxPercentChange borde vara mellan 0 och 100"
 
 #: config.c:2558
 #, c-format
@@ -4910,7 +4910,7 @@ msgstr "(felaktig incheckning)\n"
 #, c-format
 msgid "add_cacheinfo failed for path '%s'; merge aborting."
 msgstr ""
-"add_cahceinfo misslyckades för sökvägen \"%s\"; avslutar sammanslagningen."
+"add_cacheinfo misslyckades för sökvägen \"%s\"; avslutar sammanslagningen."
 
 #: merge-recursive.c:388
 #, c-format
diff --git a/po/tr.po b/po/tr.po
index e26ca7d551..13a82ad6cc 100644
--- a/po/tr.po
+++ b/po/tr.po
@@ -12344,7 +12344,7 @@ msgstr ""
 "\tgit checkout --track origin/<ad>\n"
 "\n"
 "Eğer her zaman belirsiz <ad> çıkışlarının bir uzak konumu tercih etmesini\n"
-"isterseniz, örn. 'origin', yapılandırmanızda checkout.defaultsRemote=origin\n"
+"isterseniz, örn. 'origin', yapılandırmanızda checkout.defaultRemote=origin\n"
 "ayarını yapmayı düşünün."
 
 #: builtin/checkout.c:1201
@@ -24179,7 +24179,7 @@ msgstr "uzak sunucu durumsuz ayırıcı gönderdi"
 #: remote-curl.c:724
 msgid "unable to rewind rpc post data - try increasing http.postBuffer"
 msgstr ""
-"rpc sonrası verisi geri sarılamıyor - https.postBuffer'ı artırmayı deneyin"
+"rpc sonrası verisi geri sarılamıyor - http.postBuffer'ı artırmayı deneyin"
 
 #: remote-curl.c:754
 #, c-format
diff --git a/po/vi.po b/po/vi.po
index ccdabfa2c8..483aa75468 100644
--- a/po/vi.po
+++ b/po/vi.po
@@ -4907,13 +4907,13 @@ msgstr "(commit sai)\n"
 #: merge-recursive.c:379
 #, c-format
 msgid "add_cacheinfo failed for path '%s'; merge aborting."
-msgstr "addinfo_cache gặp lỗi đối với đường dẫn “%s”; việc hòa trộn bị bãi bỏ."
+msgstr "add_cacheinfo gặp lỗi đối với đường dẫn “%s”; việc hòa trộn bị bãi bỏ."
 
 #: merge-recursive.c:388
 #, c-format
 msgid "add_cacheinfo failed to refresh for path '%s'; merge aborting."
 msgstr ""
-"addinfo_cache gặp lỗi khi làm mới đối với đường dẫn “%s”; việc hòa trộn bị "
+"add_cacheinfo gặp lỗi khi làm mới đối với đường dẫn “%s”; việc hòa trộn bị "
 "bãi bỏ."
 
 #: merge-recursive.c:876
@@ -8585,7 +8585,7 @@ msgstr "đang lờ đi tên mô-đun-con mập mờ: %s"
 
 #: submodule-config.c:304
 msgid "negative values not allowed for submodule.fetchjobs"
-msgstr "không cho phép giá trị âm ở submodule.fetchJobs"
+msgstr "không cho phép giá trị âm ở submodule.fetchjobs"
 
 #: submodule-config.c:402
 #, c-format
diff --git a/po/zh_CN.po b/po/zh_CN.po
index d6f61eae5c..668bbacf9d 100644
--- a/po/zh_CN.po
+++ b/po/zh_CN.po
@@ -142,7 +142,7 @@ msgstr ""
 "Project-Id-Version: Git\n"
 "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
 "POT-Creation-Date: 2021-05-17 16:02+0800\n"
-"PO-Revision-Date: 2021-06-05 22:10+0800\n"
+"PO-Revision-Date: 2021-07-01 16:01+0800\n"
 "Last-Translator: Jiang Xin <worldhello.net@gmail.com>\n"
 "Language-Team: GitHub <https://github.com/jiangxin/git/>\n"
 "Language: zh_CN\n"
@@ -3060,7 +3060,7 @@ msgstr "关闭 rev-list 的标准输入失败"
 #: convert.c:183
 #, c-format
 msgid "illegal crlf_action %d"
-msgstr "非法的 crlf 动作 %d"
+msgstr "非法的 crlf_action %d"
 
 #: convert.c:196
 #, c-format
@@ -5373,7 +5373,7 @@ msgstr "不能创建 lazy_name 线程：%s"
 #: name-hash.c:570
 #, c-format
 msgid "unable to join lazy_name thread: %s"
-msgstr "不能加入 lasy_name 线程：%s"
+msgstr "不能加入 lazy_name 线程：%s"
 
 #: notes-merge.c:277
 #, c-format
@@ -15034,7 +15034,7 @@ msgstr "协议不支持 --negotiate-only，退出。"
 msgid ""
 "--filter can only be used with the remote configured in extensions."
 "partialclone"
-msgstr "只可以将 --filter 用于在 extensions.partialClone 中配置的远程仓库"
+msgstr "只可以将 --filter 用于在 extensions.partialclone 中配置的远程仓库"
 
 #: builtin/fetch.c:2083
 msgid "--atomic can only be used when fetching from one remote"
@@ -17726,7 +17726,7 @@ msgstr "错误：标签输入未通过 fsck：%s"
 #: builtin/mktag.c:41
 #, c-format
 msgid "%d (FSCK_IGNORE?) should never trigger this callback"
-msgstr "%d（忽略 FSCK?）不应该触发这个调用"
+msgstr "%d (FSCK_IGNORE?) 永远不应该触发这个回调"
 
 #: builtin/mktag.c:56
 #, c-format
@@ -22356,7 +22356,7 @@ msgstr "不能识别 submodule.alternateErrorStrategy 的取值 '%s'"
 #: builtin/submodule--helper.c:1799
 #, c-format
 msgid "Value '%s' for submodule.alternateLocation is not recognized"
-msgstr "不能识别 submodule.alternateLocaion 的取值 '%s'"
+msgstr "不能识别 submodule.alternateLocation 的取值 '%s'"
 
 #: builtin/submodule--helper.c:1823
 msgid "where the new submodule will be cloned to"
diff --git a/po/zh_TW.po b/po/zh_TW.po
index cb5db0abfa..521292e390 100644
--- a/po/zh_TW.po
+++ b/po/zh_TW.po
@@ -3199,7 +3199,7 @@ msgstr "關閉 rev-list 的標準輸入失敗"
 #: convert.c:183
 #, c-format
 msgid "illegal crlf_action %d"
-msgstr "非法的 crlf 動作 %d"
+msgstr "非法的 crlf_action %d"
 
 #: convert.c:196
 #, c-format
@@ -5502,7 +5502,7 @@ msgstr "不能建立 lazy_name 執行緒：%s"
 #: name-hash.c:570
 #, c-format
 msgid "unable to join lazy_name thread: %s"
-msgstr "不能加入 lasy_name 執行緒：%s"
+msgstr "不能加入 lazy_name 執行緒：%s"
 
 #: notes-merge.c:277
 #, c-format
@@ -15156,7 +15156,7 @@ msgstr "協定不支援 --negotiate-only，結束。"
 msgid ""
 "--filter can only be used with the remote configured in extensions."
 "partialclone"
-msgstr "只可以將 --filter 用於在 extensions.partialClone 中設定的遠端版本庫"
+msgstr "只可以將 --filter 用於在 extensions.partialclone 中設定的遠端版本庫"
 
 #: builtin/fetch.c:2083
 msgid "--atomic can only be used when fetching from one remote"
@@ -22482,7 +22482,7 @@ msgstr "不能識別 submodule.alternateErrorStrategy 的取值 '%s'"
 #: builtin/submodule--helper.c:1799
 #, c-format
 msgid "Value '%s' for submodule.alternateLocation is not recognized"
-msgstr "不能識別 submodule.alternateLocaion 的取值 '%s'"
+msgstr "不能識別 submodule.alternateLocation 的取值 '%s'"
 
 #: builtin/submodule--helper.c:1823
 msgid "where the new submodule will be cloned to"
-- 
2.32.0.rc0.27.g7b1e85181b

