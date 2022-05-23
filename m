Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC8AC433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 01:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbiEWB17 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 May 2022 21:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349587AbiEWBZo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 May 2022 21:25:44 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4474438782
        for <git@vger.kernel.org>; Sun, 22 May 2022 18:25:43 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id n10so12650594pjh.5
        for <git@vger.kernel.org>; Sun, 22 May 2022 18:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XTF5a4m81wvkd1o5yI0rhcQ6plPOP3CAFOTor+/VGtc=;
        b=Hbpzgg+OlC5kDrXBxjjZ+nk6Jwd+lrmrBNM5bnWWV2l2KnB+hQ+4rvBBzqx/6OZgl+
         hYKbOh1a47cHdFgecahDXYPm+ahwPg7UCtm9anjJ+yKLd0u0KKaly4VX/qM9N8Cf/XUA
         ppNm/dkQrjjAwk2hWd8vD7CJXfK8LMZHn5RPhipjAyYqEy/e467hkzj+M3NGLK8VSJEL
         EkAAck5h50RivtiG2MRDEhxjg8ly62Iq8t2sntEKGHJ6A4eaD7OvoiNfPzierXawWD/P
         xNHuC3WBkYRWu+O+6tOBYEdL7WlQhmGgOiC75UtxY+ooocfxZDiMuRMDnEUKinFn4qH2
         psOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XTF5a4m81wvkd1o5yI0rhcQ6plPOP3CAFOTor+/VGtc=;
        b=oyIc2ydHcKZr07KmqzYqEQWKpDC9OAVqTe/MftnOBUe17pRImG3yLXbmlobGWN/stW
         Ett5nUrdGHj5l6MGve0YOrees8RAUO7NtGLGHJnNsxuvsKQFyvEvAw6HdvxglSQgivaB
         l2Mns/RK0odSi7WFMMnvzh3ynCnbNXSHPkNRbhfLxRbATsvT6kJoOsbbUK0KEh44D3AG
         our/qWkcyZf1qq8fvQGjgyJDo003+u3gAwmZESU+fkktISpgDn53U3iuw6Ps3WKTwNG+
         +qkRMojt3H80k+yW3ApWTceIEDZXCAbklYGRIVIfgmKc8huSo2rckDsBB7muQDKsC3z6
         M/5A==
X-Gm-Message-State: AOAM532BZH418xLtp59wB7P/erT0SY1rmc67wWnaii0rM20M+xdm90C9
        jD/0T9T6D6xlxYT+OowNZk0=
X-Google-Smtp-Source: ABdhPJwZ/PeEVOt9fXTegKGZP4z9Oz2UHdyDgIE5dGjXOmW8LaNDIs00vgzFTnG+pf6fmW2/hzUaEw==
X-Received: by 2002:a17:90b:1e50:b0:1e0:3a08:9b12 with SMTP id pi16-20020a17090b1e5000b001e03a089b12mr5935200pjb.119.1653269142799;
        Sun, 22 May 2022 18:25:42 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id n26-20020aa7985a000000b00518142f8c37sm6027566pfq.171.2022.05.22.18.25.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 May 2022 18:25:42 -0700 (PDT)
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
Subject: [PATCH v3 4/9] i18n CI: stop allowing non-ASCII source messages in po/git.pot
Date:   Mon, 23 May 2022 09:25:26 +0800
Message-Id: <20220523012531.4505-5-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220519081548.3380-1-worldhello.net@gmail.com>
References: <20220519081548.3380-1-worldhello.net@gmail.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile                    | 6 ++++--
 builtin/submodule--helper.c | 2 +-
 ci/run-static-analysis.sh   | 2 ++
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 1962999c18..70d5f41c3f 100644
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
@@ -2795,6 +2794,9 @@ po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO) FORCE
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

