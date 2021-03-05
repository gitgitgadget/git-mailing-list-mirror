Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA045C433E0
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 15:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7835E65090
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 15:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhCEPWL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 10:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhCEPVl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 10:21:41 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2328C061574
        for <git@vger.kernel.org>; Fri,  5 Mar 2021 07:21:40 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id w6so1955569qti.6
        for <git@vger.kernel.org>; Fri, 05 Mar 2021 07:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yxu++oTaPW9TpZXN2sKeiBmTS3Ujf/7mqu1jVuZQlSo=;
        b=iOmrpg32W0QsiIQZhzw7QqBO2MFjpkRL4xg7GtXwzG5uVEiBfFGQGe1PIn9EA635wg
         di0AnTAwWZhTEboijG4W4GR4NZ2IfZquYj13sdmn40DF7AisRWiK1LfcqWa2UgLLEhdL
         DKADxFonf/mYwVIjJn80Lt/naBEbsUWKDY0SVx2j88e9X4CH/GqOxnerZDZLiVUqgafH
         EunddHYWKXu2c9gUWxwwVwkgDwGac6XDXWLUidvgVJI5NHQF6om/aB0ny2O293XDi3GR
         RCLbNwCMy/Hed5RYLoHDjSB5zXk2bHj2Lksn7u3KT96MpCj+R3BEWF9rJjaPR9LQf/n5
         SPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yxu++oTaPW9TpZXN2sKeiBmTS3Ujf/7mqu1jVuZQlSo=;
        b=Jl04NuBde6RVA1/T1ikFeTecX1Yhw1ZKm/D5aB3Ga2D0cPxw+Zpe5AkbKlwpiyMzgH
         cLQuQlaACnG1cTK+GN3kQT0lHq9rDo33iWHyYO84wUwPbe922b5aFxdQ16m7uPJ4oanL
         CMmBuwjlsTMQyCSRHa1xRPGXwH5NY1BOCcZoJwns0ctC0inaottTnEauaK6BbEqbk0pX
         Mh/IOl2YrWOGG5rjUaozO4t6KR5ViUk25MokgdmByfBZ9U6xbqmINvn3hUnsYI5Ct5yD
         3K63I7dZHgdh7ax8paD6ZrTx6F80sBeyfmKRmOulFyIjjoN0Dc7mcPFDnwWJb8Oedi9Z
         PBMw==
X-Gm-Message-State: AOAM533xHuqPiPYTPV+Oohxs7er0svZelmugX4wCyOCeF2Cubqj6jxc1
        +LUkB8p6CNQdvxhm23KEYTWo0iD/gfiRYSia
X-Google-Smtp-Source: ABdhPJwbcPAr4TS88wr3pqTPP4DorznsIhSl/53SfpVEJG29Ta0Sz5IDoUPmCZpHJuvkOcoOxseHLg==
X-Received: by 2002:a05:622a:102:: with SMTP id u2mr9170398qtw.37.1614957699903;
        Fri, 05 Mar 2021 07:21:39 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:4ce8:219:f731:dbf5])
        by smtp.gmail.com with ESMTPSA id 46sm2063401qte.7.2021.03.05.07.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 07:21:39 -0800 (PST)
Date:   Fri, 5 Mar 2021 10:21:37 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net
Subject: [PATCH 1/5] builtin/repack.c: do not repack single packs with
 --geometric
Message-ID: <80bc7fa8397491d015b80a39168813d2019e262d.1614957681.git.me@ttaylorr.com>
References: <cover.1614957681.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1614957681.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 0fabafd0b9 (builtin/repack.c: add '--geometric' option, 2021-02-22),
the 'git repack --geometric' code aborts early when there is zero or one
pack.

When there are no packs, this code does the right thing by placing the
split at "0". But when there is exactly one pack, the split is placed at
"1", which means that "git repack --geometric" (with any factor)
repacks all of the objects in a single pack.

This is wasteful, and the remaining code in split_pack_geometry() does
the right thing (not repacking the objects in a single pack) even when
only one pack is present.

Loosen the guard to only stop when there aren't any packs, and let the
rest of the code do the right thing. Add a test to ensure that this is
the case.

Noticed-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c            |  2 +-
 t/t7703-repack-geometric.sh | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index bcf280b10d..4ca2f647b4 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -351,7 +351,7 @@ static void split_pack_geometry(struct pack_geometry *geometry, int factor)
 	uint32_t split;
 	off_t total_size = 0;
 
-	if (geometry->pack_nr <= 1) {
+	if (!geometry->pack_nr) {
 		geometry->split = geometry->pack_nr;
 		return;
 	}
diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index 96917fc163..4a1952a054 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -20,6 +20,21 @@ test_expect_success '--geometric with no packs' '
 	)
 '
 
+test_expect_success '--geometric with one pack' '
+	git init geometric &&
+	test_when_finished "rm -fr geometric" &&
+	(
+		cd geometric &&
+
+		test_commit "base" &&
+		git repack -d &&
+
+		git repack --geometric 2 >out &&
+
+		test_i18ngrep "Nothing new to pack" out
+	)
+'
+
 test_expect_success '--geometric with an intact progression' '
 	git init geometric &&
 	test_when_finished "rm -fr geometric" &&
-- 
2.30.0.667.g81c0cbc6fd

