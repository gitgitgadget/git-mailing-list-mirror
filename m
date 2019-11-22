Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80864C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 574832071B
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkKi4GXW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKVTAM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:00:12 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33673 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfKVTAM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 14:00:12 -0500
Received: by mail-pl1-f195.google.com with SMTP id ay6so3486239plb.0
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 11:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+qYlY428HaJ13Ml9xvUJ/ji6BAOyjzH8V4gF24nC/5Q=;
        b=kkKi4GXWwca1v1YVGcojFdEB2QJAs4YRkE8EwyJgTHpvu5S+M/IUN7dfyamQtEBMOF
         9B8lRyP2TtH6efH9qXGcdVgzcRVyuaIEuCMIyzuua2V6qHRm5zeDU/J4Il9lnXXOj0H4
         XOgkkj9NVa//xde0Tyw5omEUsxfY7RnbWeO7c/h4N/mpjF6jE04yHJD/GNSEr8/0yMFm
         Bc14tICjsGBLdaslNnYAE6mD6d4C6wzxBzKvA//FRNe2kmeHPIakb/tPE0/1kUgALliv
         iT8AwthQ3nxZwi1hppNp5kFHfE5N7GRMCGPvRLuiyf/OI5Ct2soPvI7ktD7I0to9C4Fd
         V95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+qYlY428HaJ13Ml9xvUJ/ji6BAOyjzH8V4gF24nC/5Q=;
        b=ZB9ePXzprZNzYnJtUdmM2fxCgJn/RpJvTmEedsPPzLb3uc9tLUxzbNirOeT7KbjhCY
         mAve0Y4ZaOsY6F8jnmbSmyzEydS1E8glLJgnovLah0q4Ij0uxoCIwFfs2CqTIhtIFmyp
         LLmIX0FbiClK4ujf8MbPLJokv90ituVsOFI18xcrKQeJkVFwNnJFFfarNUTBnepE/oCf
         EHPzvLjxGctD61Hto2FGLWB/PSSicvzuz5AfT9+flFFMb76OLga7EaQ0d1EY8xtgbYRW
         L5Ju+46Jvqj6a4TWUYmLqvdAdbgZTihYCENjP4YxFiEy4Iqux9BTSU8VOfWv7TWzIOeW
         kLNA==
X-Gm-Message-State: APjAAAUGYyWGeQCvAAAH1SrN03yqqlB2rYYmqk3T/HHPZ1OoPfcL4VZg
        sJ8ljeopGSM1tPxkK8Bwy9TZXlQm
X-Google-Smtp-Source: APXvYqyfMxObC/SlNp0qOrcnPup9YFDlpXqHvmMNjJ1ayF1FMG99SjW9qXXhs0spcUHHPlRZUw1Y+g==
X-Received: by 2002:a17:90a:e28a:: with SMTP id d10mr21474576pjz.116.1574449211263;
        Fri, 22 Nov 2019 11:00:11 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id o15sm7936716pgf.2.2019.11.22.11.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 11:00:10 -0800 (PST)
Date:   Fri, 22 Nov 2019 11:00:08 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 11/22] t4138: stop losing return codes of git commands
Message-ID: <5e88c755edd9648b2263ab3692dcd23856460f17.1574449072.git.liu.denton@gmail.com>
References: <cover.1574296987.git.liu.denton@gmail.com>
 <cover.1574449072.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574449072.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a pipe, only the return code of the last command is used. Thus, all
other commands will have their return codes masked. Rewrite pipes so
that there are no git commands upstream so that we will know if a
command fails.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4138-apply-ws-expansion.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t4138-apply-ws-expansion.sh b/t/t4138-apply-ws-expansion.sh
index 3b636a63a3..b19faeb67a 100755
--- a/t/t4138-apply-ws-expansion.sh
+++ b/t/t4138-apply-ws-expansion.sh
@@ -17,8 +17,8 @@ test_expect_success setup '
 	printf "\t%s\n" 1 2 3 >after &&
 	printf "%64s\n" a b c >>after &&
 	printf "\t%s\n" 4 5 6 >>after &&
-	git diff --no-index before after |
-		sed -e "s/before/test-1/" -e "s/after/test-1/" >patch1.patch &&
+	test_expect_code 1 git diff --no-index before after >patch1.patch.raw &&
+	sed -e "s/before/test-1/" -e "s/after/test-1/" patch1.patch.raw >patch1.patch &&
 	printf "%64s\n" 1 2 3 4 5 6 >test-1 &&
 	printf "%64s\n" 1 2 3 a b c 4 5 6 >expect-1 &&
 
@@ -33,8 +33,8 @@ test_expect_success setup '
 		x=$(( $x + 1 ))
 	done &&
 	printf "\t%s\n" d e f >>after &&
-	git diff --no-index before after |
-		sed -e "s/before/test-2/" -e "s/after/test-2/" >patch2.patch &&
+	test_expect_code 1 git diff --no-index before after >patch2.patch.raw &&
+	sed -e "s/before/test-2/" -e "s/after/test-2/" patch2.patch.raw >patch2.patch &&
 	printf "%64s\n" a b c d e f >test-2 &&
 	printf "%64s\n" a b c >expect-2 &&
 	x=1 &&
@@ -56,8 +56,8 @@ test_expect_success setup '
 		x=$(( $x + 1 ))
 	done &&
 	printf "\t%s\n" d e f >>after &&
-	git diff --no-index before after |
-	sed -e "s/before/test-3/" -e "s/after/test-3/" >patch3.patch &&
+	test_expect_code 1 git diff --no-index before after >patch3.patch.raw &&
+	sed -e "s/before/test-3/" -e "s/after/test-3/" patch3.patch.raw >patch3.patch &&
 	printf "%64s\n" a b c d e f >test-3 &&
 	printf "%64s\n" a b c >expect-3 &&
 	x=0 &&
@@ -84,8 +84,8 @@ test_expect_success setup '
 		printf "\t%02d\n" $x >>after
 		x=$(( $x + 1 ))
 	done &&
-	git diff --no-index before after |
-	sed -e "s/before/test-4/" -e "s/after/test-4/" >patch4.patch &&
+	test_expect_code 1 git diff --no-index before after >patch4.patch.raw &&
+	sed -e "s/before/test-4/" -e "s/after/test-4/" patch4.patch.raw >patch4.patch &&
 	>test-4 &&
 	x=0 &&
 	while test $x -lt 50
-- 
2.24.0.497.g17aadd8971

