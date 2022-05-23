Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01CBC433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 01:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbiEWB1z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 May 2022 21:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351807AbiEWBZs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 May 2022 21:25:48 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC03C38782
        for <git@vger.kernel.org>; Sun, 22 May 2022 18:25:47 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id h13so6077727pfq.5
        for <git@vger.kernel.org>; Sun, 22 May 2022 18:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=52FnXr+dJ7zVwbxWSujnMzbLmi9uays4ouHWeuOf8nQ=;
        b=gQcDGa3sKI+/Ms41LARrJAFqApnVinMMZ7kR862iUEacQH/oLVtOlornYf7Oyj7G1/
         2Efh1c7y6Ixi21WB1Cil3Gi8P8xud/E+/yJSaZ3GHdvKpgBmncB4f0LKpuMIGyAcr/6R
         S2lu0DhHeKxfXugCX8SWhGZF0nyg8bVSlWV6uwYU6c6jV6WMSWJCsfZG+YWZgwM/a8IT
         Uzl+IDqS32vB9U+AFioXBRJCnEaZLgW7INoCZgumYq9np/T8VN8nn/CnNjCuq3fmGtw/
         G1jkbl6VfGuvUE69ubYvwi0pJ7SzgNS0iWAgb+DkvWyE7Aj9epn0vNOynZufdKIR91Hd
         5tjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=52FnXr+dJ7zVwbxWSujnMzbLmi9uays4ouHWeuOf8nQ=;
        b=D2QItoZl7N0rbq17lPblE7eE+7W6dzxPS4tfSJIQz89Blb3YK0jBayi6ro+g3qUMxr
         jROy4L96cUdTpwROxmZCUwW/QkTEoQt+YK2QHqP+wgzEhuu5bk32Rqrnf8Olu33wdKEn
         zIeOiaNg1+uP06hJULEOuOjm/Jj/sTXDvt4OUvJBDmE50HS4eWdxZ9eVcpBYk4E5peDw
         zmDlG3ItYQKdA/D34kNciVuI4wXyyYgSNyvXZX2DKEK4dUNOFmStY7HR/Rksg+JAnlhV
         SVVlH5O5pqIfoe4YAHHm9lrKHcHJhkPVi6D9gZBOA78/jcmccAwkuDVgFPcnMv4xBDZZ
         mSZA==
X-Gm-Message-State: AOAM5321svkeSx5S3cWoMUM2tcBD6MKCpotI06EvbO5iplhmcH2/GCQZ
        3GbwxwwZ+JfZSz/HqzyUhk4=
X-Google-Smtp-Source: ABdhPJzy88qUzmevSmrgPVutQAWNQZpYm2QeRG27yWb/kbAlnUrnNHjnsRrsHvqUC/ubTA9pv6MPKg==
X-Received: by 2002:a63:4401:0:b0:3fa:df3:4201 with SMTP id r1-20020a634401000000b003fa0df34201mr6547640pga.65.1653269147695;
        Sun, 22 May 2022 18:25:47 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id n26-20020aa7985a000000b00518142f8c37sm6027566pfq.171.2022.05.22.18.25.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 May 2022 18:25:47 -0700 (PDT)
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
Subject: [PATCH v3 6/9] po/git.pot: don't check in result of "make pot"
Date:   Mon, 23 May 2022 09:25:28 +0800
Message-Id: <20220523012531.4505-7-worldhello.net@gmail.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile      | 5 +++--
 po/.gitignore | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 70d5f41c3f..3122672263 100644
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
@@ -3319,6 +3319,7 @@ dist-doc: git$X
 
 distclean: clean
 	$(RM) configure
+	$(RM) po/git.pot
 	$(RM) config.log config.status config.cache
 	$(RM) config.mak.autogen config.mak.append
 	$(RM) -r autom4te.cache
diff --git a/po/.gitignore b/po/.gitignore
index 796b96d1c4..37d1301b32 100644
--- a/po/.gitignore
+++ b/po/.gitignore
@@ -1 +1,2 @@
 /build
+/git.pot
-- 
2.36.0.1.g15c4090757

