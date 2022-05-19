Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19502C433FE
	for <git@archiver.kernel.org>; Thu, 19 May 2022 08:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235165AbiESIQR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 04:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235281AbiESIQN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 04:16:13 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4800E36B46
        for <git@vger.kernel.org>; Thu, 19 May 2022 01:16:10 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id q4so4120056plr.11
        for <git@vger.kernel.org>; Thu, 19 May 2022 01:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r5ENdVESNu7zRCLq3Rlcdq7dFr9wWw5huob7zlnYrA0=;
        b=cXw3JQE72jP1ugLYwtco86z5nZKL/w9KMpADekraH1J/QWNtu8FyF7rEoEWoXeUrSy
         bR0h2S7Gq/dDmQHNG6weh/DyjAQEXoqF8bfQdPWWMVRmRWIgqTqlTPztHy4aeb95Qsao
         WTH0u2EVTUoX3R4Y2mKCiC9VxTrwoaPVEVLfdMpP84klvPKPA8xCjydh+SQ/e5OjukHL
         K80acF0J6o/roiXKAoBKq7gx61WTOQz8OvImr0SZ2/VN9VrIbm2JuNA6TGAJlBqTAjoi
         igZjzl45F0dRV1fjNyCwWRUC2Fy4R7KcVg8HsiviT2afkgCkaPFb/T7wvDleVJbdDzYn
         nEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r5ENdVESNu7zRCLq3Rlcdq7dFr9wWw5huob7zlnYrA0=;
        b=FdXVmn/Mgzd48pZhoBMc9Tp0etl41L8TSJN8pqpy7ZGiqtXcqd/H+WoDMyC3CUK7Z9
         R96uS6fxlydaDgmhjSk2Gd/yWZ3po433uqSdbPp9/O1EFkNKJAcR70xcgbWlpUa51FWp
         0pp8gcW9Xy9JeZ8rJfdC8qD7peDfX5ZQtPUnKRqWZO6T7HgPPzmxhMiwwzcmFc6GfMQ2
         xPK1zf5LyWbUxsjstiPCTSW5cJWbS0qwAvKF3mPAzp/YOv7zjnBULr3aWV9hMlwYdO9b
         s3H5VGhZbyWytx86EKt1Yp1Xd2Wzs3MXWoTAVYsSu4fX0FtS/IpBd7xnqXtTJzfSeX1X
         UcIA==
X-Gm-Message-State: AOAM530nD3qFrL01ribNu+NeXimX8aemvQCcIeXYx7neIGZWotZgkvug
        91yV3Ti4BC8pjyIUprkFIqU=
X-Google-Smtp-Source: ABdhPJy9vuKdrouJu4qd0EB/hraw8UDN6KEsLYU5aA8DFvjcz307KDFRdd81x87vQFYnTEKwCyctGw==
X-Received: by 2002:a17:90a:408f:b0:1d1:d1ba:2abb with SMTP id l15-20020a17090a408f00b001d1d1ba2abbmr4522346pjg.152.1652948169651;
        Thu, 19 May 2022 01:16:09 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id u127-20020a627985000000b0050dc76281d3sm3576687pfc.173.2022.05.19.01.16.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 May 2022 01:16:08 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Alexander Shopov <ash@kambanaria.org>,
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
        Yi-Jyun Pan <pan93412@gmail.com>
Subject: [PATCH v2 0/9] Incremental po/git.pot update and new l10n workflow
Date:   Thu, 19 May 2022 16:15:39 +0800
Message-Id: <20220519081548.3380-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220503132354.9567-1-worldhello.net@gmail.com>
References: <20220503132354.9567-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

A workflow change for translators are being proposed.

Changes since v1:

* Patch 4/9: When running "make check-pot", do not update "po/git.pot".
* Patch 6/9: reword: the removal of "po/git.pot" is in preceding commit.
* Patch 7/9 and 8/9: Add new funciton "check_po_file_envvar" for reuse in both
  po-update and po-init targets.


Range-diff vs v1:

 1:  15c4090757 =  1:  15c4090757 Makefile: sort "po/git.pot" by file location
 2:  846a9e72c5 =  2:  846a9e72c5 Makefile: generate "po/git.pot" from stable LOCALIZED_C
 3:  b5cf2836ea =  3:  b5cf2836ea Makefile: have "make pot" not "reset --hard"
 4:  a508f6e18b !  4:  8b30e332df i18n CI: stop allowing non-ASCII source messages in po/git.pot
    @@ Commit message
         on it when running "make pot".
     
         Since the preceding Makefile changes made this easy: let's add a "make
    -    check-pot" target and run it as part of the "static-analysis" CI
    -    target, this will ensure that we catch any such issues in the future.
    +    check-pot" target with the same prerequisites as the "po/git.pot"
    +    target, but without changing the file "po/git.pot". Running it as part
    +    of the "static-analysis" CI target will ensure that we catch any such
    +    issues in the future. E.g.:
    +
    +        $ make check-pot
    +            XGETTEXT .build/pot/po/builtin/submodule--helper.c.po
    +        xgettext: Non-ASCII string at builtin/submodule--helper.c:3381.
    +                  Please specify the source encoding through --from-code.
    +        make: *** [.build/pot/po/builtin/submodule--helper.c.po] Error 1
     
         1. cd5513a7168 (i18n: Makefile: "pot" target to extract messages
            marked for translation, 2011-02-22)
    @@ Makefile: po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO)
      pot: po/git.pot
      
     +.PHONY: check-pot
    -+check-pot: pot
    ++check-pot: $(LOCALIZED_ALL_GEN_PO)
     +
      ifdef NO_GETTEXT
      POFILES :=
 5:  720a00b348 =  5:  65f87c5503 po/git.pot: this is now a generated file
 6:  f97113a370 !  6:  fe5f27a88b po/git.pot: don't check in result of "make pot"
    @@ Commit message
         Makefile: "pot" target to extract messages marked for translation,
         2011-02-22).
     
    -    The actual "git rm" of po/git.pot is deferred until the subsequent
    -    commit, to make this change easier to review, and to preempt the
    -    mailing list from blocking it due to it being too large.
    +    The actual "git rm" of po/git.pot was in preceding commit to make this
    +    change easier to review, and to preempt the mailing list from blocking
    +    it due to it being too large.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
 7:  be23a1c8b0 !  7:  710aff9d66 Makefile: add "po-update" rule to update po/XX.po
    @@ Makefile: po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO)
      .PHONY: pot
      pot: po/git.pot
      
    ++define check_po_file_envvar
    ++	$(if $(PO_FILE), \
    ++		$(if $(filter po/%.po,$(PO_FILE)), , \
    ++			$(error PO_FILE should match pattern: "po/%.po")), \
    ++		$(error PO_FILE is not defined))
    ++endef
    ++
    ++.PHONY: po-update
     +po-update: po/git.pot
    -+ifndef PO_FILE
    -+	$(error not define variable "PO_FILE")
    -+else
    -+ifeq ($(filter po/%.po,$(PO_FILE)),)
    -+	$(error PO_FILE should match pattern: "po/%.po")
    -+endif
    -+endif
    ++	$(check_po_file_envvar)
     +	@if test ! -e $(PO_FILE); then \
     +		echo >&2 "error: $(PO_FILE) does not exist"; \
     +		exit 1; \
    @@ Makefile: po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO)
     +	$(QUIET_MSGMERGE)$(MSGMERGE) $(MSGMERGE_FLAGS) $(PO_FILE) po/git.pot
     +
      .PHONY: check-pot
    - check-pot: pot
    + check-pot: $(LOCALIZED_ALL_GEN_PO)
      
     
      ## shared.mak ##
 8:  176a80587a !  8:  fc9d3f5603 Makefile: add "po-init" rule to initialize po/XX.po
    @@ Commit message
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## Makefile ##
    -@@ Makefile: endif
    - endif
    +@@ Makefile: po-update: po/git.pot
    + 	$(check_po_file_envvar)
      	@if test ! -e $(PO_FILE); then \
      		echo >&2 "error: $(PO_FILE) does not exist"; \
     +		echo >&2 'To create an initial po file, use: "make po-init PO_FILE=po/XX.po"'; \
      		exit 1; \
      	fi
      	$(QUIET_MSGMERGE)$(MSGMERGE) $(MSGMERGE_FLAGS) $(PO_FILE) po/git.pot
    -@@ Makefile: endif
    +@@ Makefile: po-update: po/git.pot
      .PHONY: check-pot
    - check-pot: pot
    + check-pot: $(LOCALIZED_ALL_GEN_PO)
      
     +### TODO FIXME: Translating everything in these files is a bad
     +### heuristic for "core", as we'll translate obscure error() messages
    @@ Makefile: endif
     +
     +.PHONY: po-init
     +po-init: po/git-core.pot
    -+ifndef PO_FILE
    -+	$(error not define variable "PO_FILE")
    -+else
    -+ifeq ($(filter po/%.po,$(PO_FILE)),)
    -+	$(error PO_FILE should match pattern: "po/%.po")
    -+endif
    -+endif
    ++	$(check_po_file_envvar)
     +	@if test -e $(PO_FILE); then \
     +		echo >&2 "error: $(PO_FILE) exists already"; \
     +		exit 1; \
 9:  f2491b96ab =  9:  10fafa5bf9 l10n: Document the new l10n workflow

---

Jiang Xin (3):
  Makefile: sort "po/git.pot" by file location
  Makefile: generate "po/git.pot" from stable LOCALIZED_C
  Makefile: add "po-update" rule to update po/XX.po

Junio C Hamano (1):
  po/git.pot: this is now a generated file

Ævar Arnfjörð Bjarmason (5):
  Makefile: have "make pot" not "reset --hard"
  i18n CI: stop allowing non-ASCII source messages in po/git.pot
  po/git.pot: don't check in result of "make pot"
  Makefile: add "po-init" rule to initialize po/XX.po
  l10n: Document the new l10n workflow

 .gitignore                  |     1 +
 Makefile                    |   144 +-
 builtin/submodule--helper.c |     2 +-
 ci/run-static-analysis.sh   |     2 +
 po/.gitignore               |     2 +
 po/README.md                |   191 +-
 po/git.pot                  | 25151 ----------------------------------
 shared.mak                  |     2 +
 8 files changed, 217 insertions(+), 25278 deletions(-)
 delete mode 100644 po/git.pot

-- 
2.36.0.1.g15c4090757

