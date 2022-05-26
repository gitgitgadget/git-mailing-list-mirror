Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78C7C433FE
	for <git@archiver.kernel.org>; Thu, 26 May 2022 14:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347821AbiEZOvS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 10:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347844AbiEZOuq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 10:50:46 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D2456FB8
        for <git@vger.kernel.org>; Thu, 26 May 2022 07:50:44 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id t28so1501024pga.6
        for <git@vger.kernel.org>; Thu, 26 May 2022 07:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rNh1K0IrCoKLiC64vnp3Wd4li3ZP35FqM4O6mSbQAxQ=;
        b=JVn7f+QEqLDSTJ2CMzLTq9nDieJF5SU7I/eTn7QbNuWVouGPriFUCl+CiYedLQJAXR
         iOIzWK5gsVZAKN3fIR8n123MkB1iYeqe007nJVTsGYRl/pb/u7Ssuu+NRw4xXy/RoY6p
         yCAhKviIav1dEUCHdBAFfrNWvkGDcZ91bpvTH3clnBOQYtnVfuiUZIvKChyvffN/nv3r
         uOrNli6extAuMGb2LzwxULuBkXn2IyYSOBpmvovTZ//0lmoz+Mz3R638JtqTxSzuaeVB
         t9qi79c8WuMG6CokGq43AczQbZj64qbMNynNmqX1V2nIOsv6v2n+673/QQAQEqqaYlSY
         4L2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rNh1K0IrCoKLiC64vnp3Wd4li3ZP35FqM4O6mSbQAxQ=;
        b=1sfev48/C98nKmrArC5Zr9QRvdqD0Vci3beDjJfs5kOsC5qyVlk/y3LtdDfQr/fWb/
         00FJByFFI1wo5BqDgwPo/xgtBoXiSG9I0k0aztWTxuDjC2KuGbksRXrBpuGiXuauldRD
         sOBtc4+rumoZKGY6CVjfkBfX0hn4aTMz3DaYSHvthhZszqxW0fIYQJq4U79vUgocxz5v
         BhBVumDO5FPQaNw9T/f83D8fSOi5YGFlWg+hm+zsfIL9JXvwE/lc5LuE6W9lGUa4lT1G
         6e1adhc4PniJ+tRl6OVlBhEllahidrNkaAq2e7EzVzdp+/VQcjPMTT5GEZfvY+ElG5f+
         UH0A==
X-Gm-Message-State: AOAM530F0cQ5bvBumRm4Pm/d7fN57U+PB9eh9OoJ6IVs5ncd8F1rlJpK
        qVlJ83qHeL72RlHVZPmVhJw=
X-Google-Smtp-Source: ABdhPJxmOUqjMQ2Ao/0cXa7NvHevlVfdTLXsI3e6NcDkLOD9k+CK98aMQdS1iUYlTNDSUY2r/uCWcg==
X-Received: by 2002:a63:8448:0:b0:3fa:cc62:d51f with SMTP id k69-20020a638448000000b003facc62d51fmr8820353pgd.417.1653576643946;
        Thu, 26 May 2022 07:50:43 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id i16-20020a056a00005000b00518382bceaesm1597480pfk.57.2022.05.26.07.50.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 May 2022 07:50:43 -0700 (PDT)
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
        Jiang Xin <worldhello.net@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v5 04/10] i18n CI: stop allowing non-ASCII source messages in po/git.pot
Date:   Thu, 26 May 2022 22:50:29 +0800
Message-Id: <20220526145035.18958-5-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220523152128.26380-1-worldhello.net@gmail.com>
References: <20220523152128.26380-1-worldhello.net@gmail.com>
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
check-pot" target with the same prerequisites as the "po/git.pot"
target, but without changing the file "po/git.pot". Running it as part
of the "static-analysis" CI target will ensure that we catch any such
issues in the future. E.g.:

    $ make check-pot
        XGETTEXT .build/pot/po/builtin/submodule--helper.c.po
    xgettext: Non-ASCII string at builtin/submodule--helper.c:3381.
              Please specify the source encoding through --from-code.
    make: *** [.build/pot/po/builtin/submodule--helper.c.po] Error 1

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
index 49176822ad..72a3ddaed4 100644
--- a/Makefile
+++ b/Makefile
@@ -2708,8 +2708,7 @@ XGETTEXT_FLAGS = \
 	--force-po \
 	--add-comments=TRANSLATORS: \
 	--msgid-bugs-address="Git Mailing List <git@vger.kernel.org>" \
-	--package-name=Git \
-	--from-code=UTF-8
+	--package-name=Git
 XGETTEXT_FLAGS_C = $(XGETTEXT_FLAGS) --language=C \
 	--keyword=_ --keyword=N_ --keyword="Q_:1,2"
 XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
@@ -2793,6 +2792,9 @@ po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO) FORCE
 .PHONY: pot
 pot: po/git.pot
 
+.PHONY: check-pot
+check-pot: $(LOCALIZED_ALL_GEN_PO)
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
2.36.0.1.g15c4090757

