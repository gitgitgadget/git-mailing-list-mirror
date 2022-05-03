Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B35C433EF
	for <git@archiver.kernel.org>; Tue,  3 May 2022 13:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236113AbiECN2E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 09:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236048AbiECN1q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 09:27:46 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B093936E02
        for <git@vger.kernel.org>; Tue,  3 May 2022 06:24:14 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id e24so15312042pjt.2
        for <git@vger.kernel.org>; Tue, 03 May 2022 06:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N9iTIbDX77gmPMRVwJWwI8SkX7/yLK0p73I4Ev/37A8=;
        b=KLLNEHKmqJE6JFxAI8bBR8O5Cnk+Wjy1LjQonNmu8nAaFfhcyLOQOExDYd9g42nJts
         BSmgsWzyYy3YIUjEuZyteBGuBNygrsoAFv5UmcOAG2C9oikWNiS5uxj8XIy/KNctquS4
         QWudj1VeZV1XYn8rVNhXRo9S4lMz9Mc/ddo0joRkRQvdy7z+fHfuDmyf5rbRNrmEFYqp
         UbKjlxgTzuOpa6w6bZxmI96KCcxIvpcTx3YfF4HKYUVobTn34Ckh5Vs+6/B/YqeCOS1C
         /ZoPYmNf/L7EVjm5Dh68Y2Sy2bAQpPBpPBoyzkbXVheo//JhvAMBG8Ur94EPYs2/+DwD
         ecTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N9iTIbDX77gmPMRVwJWwI8SkX7/yLK0p73I4Ev/37A8=;
        b=cfRET7YJblB6Y7JlUCx09mUF6VfQpAyXTAAn8W5KYUb8f1W/IWmSWAuKAOIcC4cQwd
         KzlXFqmWAsLGBluPawIvK/JRrxmrTkUWGxXQzBbO0LqE0vyVq87aw3QZflTyPIDHnUyL
         4sYKy7L9jCxS/qQ9sokOslTuqFujb/J6o9VIocY2gdgSJQtrnI4TgWKayJ5hKTvcRguy
         NNrsv/Il414F3TWawpdAYwCBCzfFL9XIBCrGZ3y8aTstvpibaLez/7pA8QEAHqJqCHWR
         qS8ryORs0N17d/o5/TENcXpbsjiOYQPY/E8e999M1uMVS0Jl1QuOStz3hDLU9ymtn8N7
         Y0EA==
X-Gm-Message-State: AOAM531dJmvozUhExlN3IlZnHsrYHWtYxZkon2umaT7h9j/OkIuQ853U
        amltrHY12oDaS5B+04DMTa4=
X-Google-Smtp-Source: ABdhPJz/bcwRR8Waa0v/yUOG3Cjsr3pvI6serGa1tqxUwcRSx1BeeNogmVuV4mFKEaeSMrbA3kZ0bw==
X-Received: by 2002:a17:90b:33c8:b0:1d9:8cda:fd70 with SMTP id lk8-20020a17090b33c800b001d98cdafd70mr4685548pjb.161.1651584254210;
        Tue, 03 May 2022 06:24:14 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78008000000b0050dc76281b3sm6484950pfi.141.2022.05.03.06.24.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2022 06:24:13 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Cc:     Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Fangyi Zhou <me@fangyi.io>,
        Yi-Jyun Pan <pan93412@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH 4/9] i18n CI: stop allowing non-ASCII source messages in po/git.pot
Date:   Tue,  3 May 2022 21:23:49 +0800
Message-Id: <20220503132354.9567-5-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220503132354.9567-1-worldhello.net@gmail.com>
References: <20220503132354.9567-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

In the preceding commit we moved away from using xgettext(1) to both
generate the po/git.pot, and to merge the incrementally generated
po/git.pot+ file as we sourced translations from C, shell and Perl.

Doing it this way, which dates back to my initial
implementation[1][2][3] was conflating two things: With xgettext(1)
the --from-code both controls what encoding is specified in the
po/git.pot's header, and what encoding we allow in source messages.

We don't ever want to allow non-ASCII in *source messages*, and doing
so has hid e.g. a buggy message introduced in
a6226fd772b (submodule--helper: convert the bulk of cmd_add() to C,
2021-08-10) from us, we'd warn about it before, but only when running
"make pot", but the operation would still succeed. Now we'll error out
on it when running "make pot".

Since the preceding Makefile changes made this easy: let's add a "make
check-pot" target and run it as part of the "static-analysis" CI
target, this will ensure that we catch any such issues in the future.

1. cd5513a7168 (i18n: Makefile: "pot" target to extract messages
   marked for translation, 2011-02-22)
2. adc3b2b2767 (Makefile: add xgettext target for *.sh files,
   2011-05-14)
3. 5e9637c6297 (i18n: add infrastructure for translating Git with
   gettext, 2011-11-18)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 Makefile                    | 6 ++++--
 builtin/submodule--helper.c | 2 +-
 ci/run-static-analysis.sh   | 2 ++
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index c32ac4ca30..4b7cb2be65 100644
--- a/Makefile
+++ b/Makefile
@@ -2708,8 +2708,7 @@ XGETTEXT_FLAGS = \
 	--add-comments=TRANSLATORS: \
 	--msgid-bugs-address="Git Mailing List <git@vger.kernel.org>" \
 	--package-name=Git \
-	--sort-by-file \
-	--from-code=UTF-8
+	--sort-by-file
 XGETTEXT_FLAGS_C = $(XGETTEXT_FLAGS) --language=C \
 	--keyword=_ --keyword=N_ --keyword="Q_:1,2"
 XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
@@ -2788,6 +2787,9 @@ po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO)
 .PHONY: pot
 pot: po/git.pot
 
+.PHONY: check-pot
+check-pot: pot
+
 ifdef NO_GETTEXT
 POFILES :=
 MOFILES :=
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 2c87ef9364..b97f02eed5 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3378,7 +3378,7 @@ static int module_add(int argc, const char **argv, const char *prefix)
 			   N_("reference repository")),
 		OPT_BOOL(0, "dissociate", &dissociate, N_("borrow the objects from reference repositories")),
 		OPT_STRING(0, "name", &add_data.sm_name, N_("name"),
-			   N_("sets the submodule’s name to the given string "
+			   N_("sets the submodule's name to the given string "
 			      "instead of defaulting to its path")),
 		OPT_INTEGER(0, "depth", &add_data.depth, N_("depth for shallow clones")),
 		OPT_END()
diff --git a/ci/run-static-analysis.sh b/ci/run-static-analysis.sh
index 65bcebda41..0d51e5ce0e 100755
--- a/ci/run-static-analysis.sh
+++ b/ci/run-static-analysis.sh
@@ -29,4 +29,6 @@ fi
 make hdr-check ||
 exit 1
 
+make check-pot
+
 save_good_tree
-- 
2.35.1.577.g74cc1aa55f

