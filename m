Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21E2C433FE
	for <git@archiver.kernel.org>; Thu, 19 May 2022 08:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbiESIQk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 04:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbiESIQY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 04:16:24 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39355606EF
        for <git@vger.kernel.org>; Thu, 19 May 2022 01:16:23 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q76so4385753pgq.10
        for <git@vger.kernel.org>; Thu, 19 May 2022 01:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6A+8uQqoeD8LT4h1aOSylyIFdtORsLqKG/IApnzuj8c=;
        b=EG1keqE8QSi67dBPt08mb9YjxBeHcZUAD+xu5caAQ0TSuq/uc8RnM2i1aKu0jL8cXG
         FzgQqaHxW7tmbiq+8am2JhPZU94H/4FKf8xzThjNx9EZOpZmUvnu/z1/bKcWglqWKKEN
         0//9uE7dsAd484Q31ZyvjA5BVOCHmjYpVLVIxXj3zn+s5uR4ZS+BxEhZHledwbF6mdEy
         f7QUZMCjmUgVT+g3irVTiGyanCBjg3GXVJarUdZevW12lGNkDcArRQ/ESGq9dT0RNtl5
         nBlmmlT2C40qAgXueHzlnYxY5yo6xt91hisFwTlW5G7ZFEsAoqODmDsXt5gFdQbTtYpB
         Ws8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6A+8uQqoeD8LT4h1aOSylyIFdtORsLqKG/IApnzuj8c=;
        b=i9esOUm4gCfP5QWWT7KFcMz6bPQsEQQkWaD3KC7AaQLiM8a/uNRA3KTDwVWyzIy+D/
         Hkc9j79a8xnglHqqAlkA3rNAck34oYSIK6K8L3MauWDkODMqdqnjvzi8idmo+kJNGl67
         vGz25VG0m7VTBoCO+x4riHAlmBdcfMkPGyWLsDTeGjgta4qSAub835K+3vVBFzPVH7Wr
         m2E3SfSws+Wy6k/yXQL/H2PjxABXylRpwB/M7SofVUQmJa3eb5nzyTGyjhLXRXvbqX3g
         1pB5OSU0VDlZnJxymsAxVfrJ8OvSJwutq9OVD0N9fm8VsNPChI8yowu2UiLN86e8nv2+
         kpAw==
X-Gm-Message-State: AOAM5305r5uQZZO6t4l2rbrHDOEHdYN6asYjAPCsIHhkLIbZccCP9Eb7
        u3ZA9Mndl8aawHfsxncWJ9o=
X-Google-Smtp-Source: ABdhPJzpjBmJskQRvA1r326nWWnvOrfNHISVpdEKmeZzuUo8Jt1rAM7UHGhkCBTHLtQoaDk0qRzjVA==
X-Received: by 2002:a65:6751:0:b0:3c6:42ca:ceb8 with SMTP id c17-20020a656751000000b003c642caceb8mr3013732pgu.565.1652948182610;
        Thu, 19 May 2022 01:16:22 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id u127-20020a627985000000b0050dc76281d3sm3576687pfc.173.2022.05.19.01.16.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 May 2022 01:16:22 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
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
        Yi-Jyun Pan <pan93412@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v2 6/9] po/git.pot: don't check in result of "make pot"
Date:   Thu, 19 May 2022 16:15:45 +0800
Message-Id: <20220519081548.3380-7-worldhello.net@gmail.com>
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

The actual "git rm" of po/git.pot was in preceding commit to make this
change easier to review, and to preempt the mailing list from blocking
it due to it being too large.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile      | 1 +
 po/.gitignore | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index 304cd03276..34904b90d2 100644
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
2.36.0.1.g15c4090757

