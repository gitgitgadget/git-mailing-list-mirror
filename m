Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366F0C433F5
	for <git@archiver.kernel.org>; Tue,  3 May 2022 13:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbiECN2C (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 09:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236054AbiECN1s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 09:27:48 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A050A36E02
        for <git@vger.kernel.org>; Tue,  3 May 2022 06:24:16 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id cq17-20020a17090af99100b001dc0386cd8fso1978814pjb.5
        for <git@vger.kernel.org>; Tue, 03 May 2022 06:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=afudddGVnz4akZ8BjU0LTiYNH4Wl6DS2m4iEQF4MNTk=;
        b=LS8fAgUvmXEjZFCSsXcYAGVzH5yA7bpis5hCxsk04RCNSlzyCxZH8Yv5z1zl/Y6K39
         eJj4xZcWH+CdAR428MZ1TSsCJDewwTZaCGqUXVHPOHRl320XgDu2nomc/10485Zd0KOs
         m+HAOmly5ACEDg0DFhr9XK6q/iSEuZNPDXLwkkx+wHjXFK1NXOSTMupCvFn8xwyXlKkm
         zRZFlPMUR0CnOrfKGP5RGBp0sDLU+z1KbsDlziUUPecJ1XMW2wtRq3HldLlqVFJuaBR3
         rnNbQUdFZePSoAZMOLXf5SoSgcuHcOWgfQ2n9UG7YfKmk2M6A/fCeUGjUb2w92+TJWXe
         UtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=afudddGVnz4akZ8BjU0LTiYNH4Wl6DS2m4iEQF4MNTk=;
        b=NGgkEIWoTEuhWe0vhVvUd/RsPY0vkXy/QQQpSzg4oDfaVXNMu2PBLhEfI7N2Ucp12p
         9iGSuixRTSmkTCHTKrVA1HJ7vEug0Cmgf5W4qxEtEhyLOWDtyqf3JoULyP7tWMSQB2By
         VyemgMEh/swA899TvlZnYffxYzTLU0OM5rJwBZRNMUQKYt3Og24sCxNE1Ky3r7BLcd4K
         7midU1ZGvBIIh1FI/MaFv+tJl3VWBoUnPc1RQjlul1AUajXYWLaxkehHoub3mD6AS3yt
         HiHMFjzeBfH1AMTMo/nf/i9djPDhbkLp1kk/QeR4EvZB+w1QoYcdpCNuO12m2pCdx+1c
         Z28A==
X-Gm-Message-State: AOAM531DV++Ge6tfvxp26HXZdwyXpxrC9tEIgC7AUH9oRgpbofJ1Cimu
        Bll6wMlZ3DFaXqAQQTIJyao=
X-Google-Smtp-Source: ABdhPJwqrOyacSBU/UDUaf6oT8rM4cy1qjLQOA9wCKE/rdVdFbEyk/Fzo7oRYcgcu9EEhioM8r9fOQ==
X-Received: by 2002:a17:90a:1f4f:b0:1d8:23d9:de1e with SMTP id y15-20020a17090a1f4f00b001d823d9de1emr4674986pjy.42.1651584256126;
        Tue, 03 May 2022 06:24:16 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78008000000b0050dc76281b3sm6484950pfi.141.2022.05.03.06.24.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2022 06:24:15 -0700 (PDT)
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
Subject: [PATCH 5/9] po/git.pot: don't check in result of "make pot"
Date:   Tue,  3 May 2022 21:23:50 +0800
Message-Id: <20220503132354.9567-6-worldhello.net@gmail.com>
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

The actual "git rm" of po/git.pot is deferred until the subsequent
commit, to make this change easier to review, and to preempt the
mailing list from blocking it due to it being too large.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 Makefile      | 1 +
 po/.gitignore | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index 4b7cb2be65..2f28648900 100644
--- a/Makefile
+++ b/Makefile
@@ -3312,6 +3312,7 @@ dist-doc: git$X
 
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
2.35.1.577.g74cc1aa55f

