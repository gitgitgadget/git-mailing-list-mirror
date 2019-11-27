Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF8BC432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7328A2084D
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deNUXGSW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfK0TyD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:54:03 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38612 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfK0TyC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 14:54:02 -0500
Received: by mail-pf1-f196.google.com with SMTP id c13so11628239pfp.5
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 11:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1JomHC6LB2LqdeWqVL7bdOCmbQ9QjDWk8FVTfc3HdNU=;
        b=deNUXGSWLR+RHlYzTpNT9WdQrxCS2j1UX0LrTJUYUaZN2A3muXZXBH0rh/h7WM5lJt
         jl+z2nvco0gX95cdToy2llGk2p1/F5/popZX5kcR1A4WeG3uCzG+fiaHvnEmBV/bmqgJ
         /SUuCA776XO9+v70OWq7TOQOef2UmV/VLNjFsiNMeb4EPx7TeyOaLcedcg5UIDpyHId2
         iLgdheiDbpFtsrnhuoNccGQ3VTDgi0FN70jyS/WB5ncRIyigprU/1rnixFT1iZ21pO7w
         vJQm+wjUT90Dc7gDzEBFPo7+ZeYTgmXeC8Ix1gICeWfyCdAlZyzMsxcas2TuB0/TbQw8
         IiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1JomHC6LB2LqdeWqVL7bdOCmbQ9QjDWk8FVTfc3HdNU=;
        b=CVpRV1V8qTYIsYYx/5k5Uk0Ow8rdSxZW7aQ2P/jTyA6AWQ9jfrwg1TY1BwCHOayOsf
         5R7Jso0ogNpV6bAba1jLXIDTzfNq1d+edXUHv/oIfYyWCuqFXBM/HeSeFlVgip8djavj
         HNIP/Tol6KhikPH4C4PLbuWgSLylihQtVIKcOT2LOJxuCXfjnM3EqC1qmS5QQUyzdZki
         Lc3mq99RauQ1gcPUVWL8A62lhsi1cpwLygsGf66j1rHxC0kRtGaTv7fXtLThhjgG3gsx
         MuEw1b5G9eEdmJj86snW9lAnjGGcdmtQi/WGdK332upDW8UmKgZCub30WEfM3Mk4FAgn
         tw3g==
X-Gm-Message-State: APjAAAUFzsCQdgbzqkNcvlnnH2z6f4dN6oMuOn/C9Skl6cmkfvKslIrv
        ZuUWJKplNk9CL9mTK1AuKnjsGkQW
X-Google-Smtp-Source: APXvYqyZVyNKTTmE1yw/aJP/6F1bdPi9lygdwiUEJZ3g8xeA5F3hD/NiZx/XwaKqUL+6vHm8cKQwow==
X-Received: by 2002:a63:36c4:: with SMTP id d187mr7016685pga.108.1574884441629;
        Wed, 27 Nov 2019 11:54:01 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id b5sm7731538pjp.13.2019.11.27.11.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 11:54:01 -0800 (PST)
Date:   Wed, 27 Nov 2019 11:53:59 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 24/26] t7700: replace egrep with grep
Message-ID: <632a62f6e9cdd58bebe7203ded8bbb9aea7c4c62.1574884302.git.liu.denton@gmail.com>
References: <cover.1574731022.git.liu.denton@gmail.com>
 <cover.1574884302.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574884302.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The egrep expressions in this test suite were of the form `^$variable`.
Although egrep works just fine, it's overkill since we're not using any
extended regex. Replace egrep invocations with grep so that we aren't
swatting flies with a sledgehammer.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7700-repack.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 5bbed02fe5..2493cc4e9b 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -30,7 +30,7 @@ test_has_duplicate_object () {
 		idx=$(basename $p)
 		test "pack-$packsha1.idx" = "$idx" && continue
 		git verify-pack -v $p >packlist || return $?
-		if egrep "^$objsha1" packlist
+		if grep "^$objsha1" packlist
 		then
 			found_duplicate_object=true
 			echo "DUPLICATE OBJECT FOUND"
@@ -135,7 +135,7 @@ test_expect_success 'packed unreachable obs in alternate ODB are not loosened' '
 	rm -f .git/objects/pack/* &&
 	mv pack-* .git/objects/pack/ &&
 	test 0 = $(git verify-pack -v -- .git/objects/pack/*.idx |
-		egrep "^$csha1 " | sort | uniq | wc -l) &&
+		grep "^$csha1 " | sort | uniq | wc -l) &&
 	echo >.git/objects/info/alternates &&
 	test_must_fail git show $csha1
 '
@@ -152,7 +152,7 @@ test_expect_success 'local packed unreachable obs that exist in alternate ODB ar
 	rm -f .git/objects/pack/* &&
 	mv pack-* .git/objects/pack/ &&
 	test 0 = $(git verify-pack -v -- .git/objects/pack/*.idx |
-		egrep "^$csha1 " | sort | uniq | wc -l) &&
+		grep "^$csha1 " | sort | uniq | wc -l) &&
 	echo >.git/objects/info/alternates &&
 	test_must_fail git show $csha1
 '
-- 
2.24.0.504.g3cd56eb17d

