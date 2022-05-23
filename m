Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFC2C433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 15:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237856AbiEWPWA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 11:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237828AbiEWPVo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 11:21:44 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A560328739
        for <git@vger.kernel.org>; Mon, 23 May 2022 08:21:42 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gg20so14381911pjb.1
        for <git@vger.kernel.org>; Mon, 23 May 2022 08:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p1MkEcOJYE0qwAbRsjrySvpgtKBR9qGhYIv/1dHrJ1w=;
        b=UD9xj/7XUxM7VVLUpmFXd7jLQw6KgkXX+qfCt/NHT7R51salAt7gxS/2DnCT6LSVX4
         ShWAjjvO0V5H+gLANDxMA5t437XgPfoQafVbPlr4OIsckbNjF0UxQ60zI4sYDljPN5Lr
         fR17Re744PiWoLE1UK+BkwmJ2HArBA9fQHLyqqW/wM6zBfO59inoZ20YlvXoS0oiiPo2
         pMFWUF6B9mJmfXi+ykStBaZCgga43DQFClCSTEh1rPgituUOysh7Tb4wlhjnKiiorqcW
         p215hwvtvNkXSm4r4LH0DSJky6wAWbVGLkS6d7r/R0wNEy9X4QmUYWFaqsQIBqCQhh+x
         IP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p1MkEcOJYE0qwAbRsjrySvpgtKBR9qGhYIv/1dHrJ1w=;
        b=ic6H+aQ4MhyKI9nfctJ06/Sv8dNc7mwJr8k9K5fwklf8R0+0dAJSNJHVz8xwSUDTUP
         tkQBEgk1aYS94VyW0eNpHbLnlYTUjs9LLEx1ZaAG0RXDf0Nh8JOmmHvp0LTgpBA4r3X4
         Whl8gnvY4VepMgMmhDzVQs9p8wpczzoOSaeObyqyRtipxpZpgr3mF0G2IX7noK4zE3GL
         Ee7o3HrLsjKH+GN4z4xK0NXL5j/B6cuaq2fyM6P2WgjKifO5rb8EoY69lm6xMwBe2bXA
         8G783nKNkoe+qozd4iJIFqPGNzQwtbzLkrZV0NxWHYe22R7QS/Updeb6K4FqfIwRUyB9
         LixA==
X-Gm-Message-State: AOAM5334pdRkk7VdiFpRyjJEuUziXrX9DQyVH7pTFGio510A07tIjqyI
        8XGWKqPdBebIfOWEhHK3Vj4=
X-Google-Smtp-Source: ABdhPJzVbj+z2gKuevifvBtV0yhNUVee/J/sPA41Izr2lFlT3uy4LwAjwvBlA8x1/jMhavrWSAkZpA==
X-Received: by 2002:a17:90b:33c8:b0:1df:aaf7:5822 with SMTP id lk8-20020a17090b33c800b001dfaaf75822mr12176290pjb.9.1653319302150;
        Mon, 23 May 2022 08:21:42 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id y13-20020a1709027c8d00b0015e8d4eb2cfsm5280287pll.281.2022.05.23.08.21.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 May 2022 08:21:41 -0700 (PDT)
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
Subject: [PATCH v4 4/9] i18n CI: stop allowing non-ASCII source messages in po/git.pot
Date:   Mon, 23 May 2022 23:21:23 +0800
Message-Id: <20220523152128.26380-5-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220523012531.4505-1-worldhello.net@gmail.com>
References: <20220523012531.4505-1-worldhello.net@gmail.com>
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

