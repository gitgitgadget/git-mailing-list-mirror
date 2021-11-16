Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E900BC433FE
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD45661B31
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbhKPMFl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 07:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235815AbhKPMEd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 07:04:33 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D114BC06121E
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:39 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d5so37076226wrc.1
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vzWaOCkAyT1oTOILPGPWZBp90e8wv/Ne5RQ32RxgOAM=;
        b=axaYZPpEQhW05nTanvasnipKYq727puFWQVfpnLwwZ/NMuezzCQrytJ+kiqjX0f900
         fjIeLtn6lY/rwYMXJff/MKECcg8xG/wWauMsJf7ztHx1xQJ5xVgG8EUayU4Uiil936br
         SM1HkWgW4zmdtqENGxqskp7x9AFs6Jd+uAEZ4jvyQvmO0mMZoNhCHl4vWpYKtkwP1QoM
         2gxRk9K0V4V0+8tMToDZRIohvx/gDhWJzGqltDYRSjDZ1voqXBU2Us2kbyzlzcneLxxt
         VhUURqhA8U3RojQFN1jO2C7R+4k6Mn/3Du91W0IksmsaCoOJikq7b/RVLKEQKvq1hGdr
         ZWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vzWaOCkAyT1oTOILPGPWZBp90e8wv/Ne5RQ32RxgOAM=;
        b=cCi7NR/qERsYYMk0YgAok3F2Ux923at63UaiREppe6v5GhUhoQDw5g8UTdZNQ/TXPe
         J32mIDtqK5EygQgPSyQP7E/NMCfHIxSnjOyWZvljrnVaZa4o9Rv3PZ6dcsgOxXlIOsW5
         6FsW3ZEwB/ffYOw6LPj880uQRLZmoBGyw57tiWzgZpS5i8OWpOMePX2wsL0+jCpJpFxO
         qzAo7qgyAla/pVizPJZruXSO0b/Ix/Im990/uEEkUO8F0CaEPygX5lysBkZyP7hJpgaK
         bz/0Ryy0TAHgOCLeiAT+aLLPfCdWF+Hj5eIKxLGCBa3Mm3u3zPEDYbpfUb265UQCyLCF
         tsPQ==
X-Gm-Message-State: AOAM530xWbetQcHUoQFZpX6d+TiebbdJQBxcUy70jmbJDDz2Mpw1ORly
        W8tC1121QAgEhVE+RplWCvNsZ5fo4l4hug==
X-Google-Smtp-Source: ABdhPJyYi5fjuSS4TzinQdb7kxNXgFqlYrGAPyfUEEF6lMPdr21R8ivm9jd5F9+KEoL2or9IdZ5Ofg==
X-Received: by 2002:a5d:59ab:: with SMTP id p11mr8432535wrr.340.1637064038236;
        Tue, 16 Nov 2021 04:00:38 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k37sm2427922wms.21.2021.11.16.04.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 04:00:37 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 04/23] Makefile: clean perl/build/ even with NO_PERL=Y
Date:   Tue, 16 Nov 2021 13:00:04 +0100
Message-Id: <patch-v3-04.23-37f3591bcca-20211116T114334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.795.g1e9501ab396
In-Reply-To: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
References: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com> <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
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
index 6b77702e102..a71fba15e30 100644
--- a/Makefile
+++ b/Makefile
@@ -3234,6 +3234,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(HCC)
 	$(RM) -r bin-wrappers $(dep_dirs) $(compdb_dir) compile_commands.json
 	$(RM) -r po/build/
+	$(RM) -r perl/build/
 	$(RM) *.pyc *.pyo */*.pyc */*.pyo $(GENERATED_H) $(ETAGS_TARGET) tags cscope*
 	$(RM) -r .dist-tmp-dir .doc-tmp-dir
 	$(RM) $(GIT_TARNAME).tar.gz
@@ -3242,7 +3243,6 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) Documentation/GIT-EXCLUDED-PROGRAMS
 ifndef NO_PERL
 	$(MAKE) -C gitweb clean
-	$(RM) -r perl/build/
 endif
 	$(MAKE) -C templates/ clean
 	$(MAKE) -C t/ clean
-- 
2.34.0.795.g1e9501ab396

