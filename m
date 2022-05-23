Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E182C433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 15:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237831AbiEWPV6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 11:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237779AbiEWPVu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 11:21:50 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1066E28992
        for <git@vger.kernel.org>; Mon, 23 May 2022 08:21:49 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id z7-20020a17090abd8700b001df78c7c209so17840484pjr.1
        for <git@vger.kernel.org>; Mon, 23 May 2022 08:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uN6ihJOjm0nsblrTubyqWj5XiCdfpBS8dANdCr3CLt8=;
        b=D0d6swwvZ0DKo+mOjJztLHOgUoQ6c8Ac3f/xCJ7z3OaERe0XRo0bFaCFxkQ0NNonsP
         t/fvwLAzmfjCMmNBjDDyBkXZn8Eo2cZigAZl+H6vLvfBt54f9Ls6ckM7NYgb28LlcFrb
         BLLvn24K1pTlqRnhgOFkA+2nZPIXatxqbT4WO4EOJnWxAfIIh0e1uVx9so7CQUhb/itN
         iL8iRxvMgUijXKS+vFkrqHaOdrQWhwk5dr2mmYPrMVarFR1WcWgqBL/DD3Wm8aE2Nzgl
         bUhCSclBJyLvf68Ie8aFM7QtEujRuP6z3hmTsHuiiZPV1d/eWbCgjPhrJA3BiO5hiRt3
         BMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uN6ihJOjm0nsblrTubyqWj5XiCdfpBS8dANdCr3CLt8=;
        b=m6UhQkblQfFgROQIgyBqrPAFBAaNjye1jb1xvo0ZvMR5QEhurTFJdTjehiEuA08M9D
         Z8P6WVqSsyHqFR79B8noAn8bSmc8x/h6/u6jUyJKwWZvUj+yFdotSH/oVksLg1XJNHj/
         Tw4p0LPjxJf99Ol1+nyFnTXDsz1LiELZPqcpDGXwDJEAvU4sNDMNImpdlnGcN0MSqXSt
         ZMqyMjBMRgDDVwI8ZvVweDtwTUsImwfp7Evk9K0oDjouNxhECM++fNoRNh778F4XtB9e
         QrDFGT/8hM4CRhg2e/EQ8QwDltVd1l+B2hb+zjgd8SI9TKNcPE8SuJW14gLv59U0elVb
         tZIA==
X-Gm-Message-State: AOAM5331DNbHuNUhxDRdSH98O/Deg9e7GAfiqbhAc2IfIy3DEfwRBSEX
        Agl6nfGs8PJIilMoa1TqtQU=
X-Google-Smtp-Source: ABdhPJxqVoswtooR2qRNrtGha8zsJ0cfXAYHUo8YPFG1QoHW3aVZdqCZpWAzngopMqQsOlGxV7IVdg==
X-Received: by 2002:a17:90b:1bd1:b0:1df:b6eb:2b20 with SMTP id oa17-20020a17090b1bd100b001dfb6eb2b20mr26901257pjb.221.1653319308541;
        Mon, 23 May 2022 08:21:48 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id y13-20020a1709027c8d00b0015e8d4eb2cfsm5280287pll.281.2022.05.23.08.21.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 May 2022 08:21:47 -0700 (PDT)
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
Subject: [PATCH v4 6/9] po/git.pot: don't check in result of "make pot"
Date:   Mon, 23 May 2022 23:21:25 +0800
Message-Id: <20220523152128.26380-7-worldhello.net@gmail.com>
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

Remove the "po/git.pot" file from being tracked, which started with
dce37b66fb0 (l10n: initial git.pot for 1.7.10 upcoming release,
2012-02-13).

The reason the po/git.pot started being checked in was because the
po/*.po files were changed a schema where we'd generate them from a
known-good snapshot of po/git.pot, instead of each translator running
"make pot" themselves.

This makes sense, but we don't need to carry this file in-tree just to
achieve that aim, and doing so has resulted in a significant amount of
"diff churn" since this method of doing it was introduced:

    $ git log -p --oneline -- po/git.pot|wc -l
    553743

We can instead let l10n contributors to generate "po/git.pot" in runtime
to update their own "po/XX.po", and the l10n coordinator can check
pull requests using CI pipeline.

This reverts to the schema introduced initially in cd5513a7168 (i18n:
Makefile: "pot" target to extract messages marked for translation,
2011-02-22).

The actual "git rm" of po/git.pot was in preceding commit to make this
change easier to review, and to preempt the mailing list from blocking
it due to it being too large.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 Makefile      | 5 +++--
 po/.gitignore | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 70d5f41c3f..161ebf4ff3 100644
--- a/Makefile
+++ b/Makefile
@@ -2788,8 +2788,8 @@ endef
 	$(call mkdir_p_parent_template)
 	$(QUIET_GEN)$(gen_pot_header)
 
-po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO) FORCE
-	$(QUIET_GEN)$(MSGCAT) $(MSGCAT_FLAGS) $(filter-out FORCE,$^) >$@
+po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO)
+	$(QUIET_GEN)$(MSGCAT) $(MSGCAT_FLAGS) $^ >$@
 
 .PHONY: pot
 pot: po/git.pot
@@ -3332,6 +3332,7 @@ cocciclean:
 
 clean: profile-clean coverage-clean cocciclean
 	$(RM) -r .build
+	$(RM) po/git.pot
 	$(RM) *.res
 	$(RM) $(OBJECTS)
 	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB)
diff --git a/po/.gitignore b/po/.gitignore
index 796b96d1c4..37d1301b32 100644
--- a/po/.gitignore
+++ b/po/.gitignore
@@ -1 +1,2 @@
 /build
+/git.pot
-- 
2.36.0.1.g15c4090757

