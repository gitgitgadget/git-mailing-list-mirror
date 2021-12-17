Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C24BC433FE
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 00:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhLQA0f (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 19:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbhLQA0e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 19:26:34 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE13C061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 16:26:33 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v11so916244wrw.10
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 16:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mD1ADEh8sx4q3ET0R/HJXMIivGNzFyhNomPJnoSUOE0=;
        b=cGwwLkiX/F76zHd8ZENyhkwfmo86GsWWlnNRt59XAyFvtp0MoRLxgk94OmKuGz7lPq
         7t5jOOAoDaa39fRsmBvl3/Fmb/AmPAMOhLGcQ7yA8Pq88511PaRJReyM3zpoOOy2K7O7
         dKADikinkNi3Bq5yx4SOT0dP8HwKQGIgciXjOSIDLPf0tSuQv4JlWRL5tUyGid98JTQa
         h+Q9OxXogP0Oct4++P7u6oNvsDDeAPYM3OUbQA+nlGzqntHrSFGHyTQEdjLf1IQTZuw/
         K1xmxtnnqNadbMTHEQTGW0JwfgAS4yIgFtHB7zuYKuiTvrvv12jxdm/JQi5cSz3QZoBk
         809Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mD1ADEh8sx4q3ET0R/HJXMIivGNzFyhNomPJnoSUOE0=;
        b=StrLYLan7TdyKUA7ehVYyHP811N8a0NKLF7btLi1uqru+AfKFLk6cc/oExmRbpdIaq
         9zM8cdQIjPdI2Akd5Z+IuY2Q/E4cGBubac+NlS3mXkDiREPOsqrViL3/Gt+qd0VhaWJ4
         fJmNKrAaldqpKkb+rgnRmp35eeypaJ485oFCnoZPhsCwNHHFxKx7BptL8RWR16Y8K7VH
         46BVasJ12pNDdp0guIAS0thBUqRHYQsmWfpB1YM2S/972zjtJq+o9YPAc+e7Qmb0aO4t
         av8X7SGV5niEh0e/r3rIxzNF5uenUIUbb7HDHwA0dJ5izgLu3G2Ja1gAOy4pHn14RXMa
         qgTQ==
X-Gm-Message-State: AOAM533u3y36HGafD4+bF/vyoJruhyL2CXfSId+EOcamgaal1NjazJKB
        dQicsbsRQtcZN720YSkdGan/51kn1tQxVA==
X-Google-Smtp-Source: ABdhPJzzZiH0eNjBQJ6o+esZHi0/hSPulhhs+8AGRDndl58MXNgR+cVqvBtu3hHpUlDzrZElTR4WJw==
X-Received: by 2002:adf:bb4a:: with SMTP id x10mr330339wrg.269.1639700792077;
        Thu, 16 Dec 2021 16:26:32 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j17sm8127349wmq.41.2021.12.16.16.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:26:31 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/11] Makefile: clean perl/build/ even with NO_PERL=Y
Date:   Fri, 17 Dec 2021 01:26:17 +0100
Message-Id: <patch-01.11-185f5a9a9cf-20211217T002023Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
In-Reply-To: <cover-00.11-00000000000-20211217T002023Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20211217T002023Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a regression in 499c29394ce (Makefile: allow building without
perl, 2009-04-03) where we'd stop cleaning the perl/* directory
because NO_PERL was defined, thus leaving behind litter if the flag at
"clean" time didn't match that of build time.

In 499c29394ce this was done to avoid relying on the perl/Makefile.PL,
but since my 20d2a30f8ff (Makefile: replace perl/Makefile.PL with
simple make rules, 2017-12-10) we can clean things in that directory
unconditionally.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 9c00a793e47..b21ffe25c2a 100644
--- a/Makefile
+++ b/Makefile
@@ -3280,6 +3280,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(HCC)
 	$(RM) -r bin-wrappers $(dep_dirs) $(compdb_dir) compile_commands.json
 	$(RM) -r po/build/
+	$(RM) -r perl/build/
 	$(RM) *.pyc *.pyo */*.pyc */*.pyo $(GENERATED_H) $(ETAGS_TARGET) tags cscope*
 	$(RM) -r .dist-tmp-dir .doc-tmp-dir
 	$(RM) $(GIT_TARNAME).tar.gz
@@ -3288,7 +3289,6 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) Documentation/GIT-EXCLUDED-PROGRAMS
 ifndef NO_PERL
 	$(MAKE) -C gitweb clean
-	$(RM) -r perl/build/
 endif
 	$(MAKE) -C templates/ clean
 	$(MAKE) -C t/ clean
-- 
2.34.1.1119.g7a3fc8778ee

