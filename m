Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDA9C432C3
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88B62068F
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bi3aqgA5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfKZBSf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 20:18:35 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43893 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfKZBSe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 20:18:34 -0500
Received: by mail-pl1-f195.google.com with SMTP id q16so3156070plr.10
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 17:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TTGArOLNSDO/W+ec6Zao4SyPEJrHIiSW7J0frH7zG98=;
        b=Bi3aqgA5p+PP1cLVm2HaOI4Su0eRZGjmWnjpvzAqIIAv2odCa+x3W4mOy4kT7Pk3dQ
         exJIfF4msHsee0oaDzZHEZ9Ubt1MFDyfoyP5mIH7PcaFiSOh/KTncAektKusUsTsXLAT
         gUls2tN9078hU/SbwANcvhM2Av0Qel6khIi41ZZpqXECZVHd/sl4eKU2HdDuuV6qR+Td
         0zV/ZGyh+jqFfZ4uMoKgpmc8Y5KsBOhs2kr9N67UwFnAc4Rjm09Rjcg8AbQP6pt3g7xx
         XVo0CU3YSbo65AaMtEge2HZI8GXPFZ8eR+3T/NzYF+mBXvhL6MfL9KN+c8ibZHRAYYxO
         mp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TTGArOLNSDO/W+ec6Zao4SyPEJrHIiSW7J0frH7zG98=;
        b=PQ9OerfaATuYNfyujKMGuUxMBvfgcTpPE3Na58MDyfLa0yKHYGygiH4p7q3LGIzYOm
         yxV5dBqEisuMDkR7BlgUCmlcpFq+Af7rVxuW9ezgOfEBjGFdmQzsRS/cm0Raw31cEWZV
         ctJwO5ymD4tM8zba2/sCu3luwNgZ/bQqjI88XtivZnJr5StflGAiMHFAq/Cg7oZP2LJJ
         48dwkGI4Zr1MnO9EeBUTv/AtldVn4c99cooR2tEdT7fIRXCy/Ai+T4BWYIVsuHbHchIL
         HWuv7ZaD9Su827NLdKiCritHxWfzusC/FVD+TNSH7tpBWzTZ4Umer9/oWVa2M+7wWQCT
         KV8Q==
X-Gm-Message-State: APjAAAVBeC6aRTiXTnXZ89U785wc5LOi+wrBjMcWJOaQf4G8AE+a7iDX
        x6xW5sM0j5Db2Jj3bWuzKyMw7MY0
X-Google-Smtp-Source: APXvYqyqx3nv+jvrJUy4uJ8UzDQS+Ta3EdJ9rTjAtvfNZG+6pmsB4yauzc/Yhw2Muogf4UUxRbf/bw==
X-Received: by 2002:a17:902:8649:: with SMTP id y9mr30751635plt.337.1574731112167;
        Mon, 25 Nov 2019 17:18:32 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id 82sm9749236pfa.115.2019.11.25.17.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 17:18:31 -0800 (PST)
Date:   Mon, 25 Nov 2019 17:18:30 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 19/27] t7700: remove spaces after redirect operators
Message-ID: <58ae066d12144a226ceb7617a3597c5799a2cd58.1574731022.git.liu.denton@gmail.com>
References: <cover.1574449072.git.liu.denton@gmail.com>
 <cover.1574731022.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574731022.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For shell scripts, the usual convention is for there to be no space
after redirection operators, (e.g. `>file`, not `> file`). Remove these
spaces wherever they appear.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7700-repack.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index e1a689d6a9..8936928387 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -11,8 +11,8 @@ commit_and_pack() {
 }
 
 test_expect_success 'objects in packs marked .keep are not repacked' '
-	echo content1 > file1 &&
-	echo content2 > file2 &&
+	echo content1 >file1 &&
+	echo content2 >file2 &&
 	git add . &&
 	test_tick &&
 	git commit -m initial_commit &&
@@ -75,8 +75,8 @@ test_expect_success 'writing bitmaps via config can duplicate .keep objects' '
 
 test_expect_success 'loose objects in alternate ODB are not repacked' '
 	mkdir alt_objects &&
-	echo $(pwd)/alt_objects > .git/objects/info/alternates &&
-	echo content3 > file3 &&
+	echo $(pwd)/alt_objects >.git/objects/info/alternates &&
+	echo content3 >file3 &&
 	objsha1=$(GIT_OBJECT_DIRECTORY=alt_objects git hash-object -w file3) &&
 	git add file3 &&
 	test_tick &&
@@ -111,7 +111,7 @@ test_expect_success 'packed obs in alt ODB are repacked even when local repo is
 
 test_expect_success 'packed obs in alt ODB are repacked when local repo has packs' '
 	rm -f .git/objects/pack/* &&
-	echo new_content >> file1 &&
+	echo new_content >>file1 &&
 	git add file1 &&
 	test_tick &&
 	git commit -m more_content &&
@@ -169,12 +169,12 @@ test_expect_success 'packed unreachable obs in alternate ODB are not loosened' '
 	mv pack-* .git/objects/pack/ &&
 	test 0 = $(git verify-pack -v -- .git/objects/pack/*.idx |
 		egrep "^$csha1 " | sort | uniq | wc -l) &&
-	echo > .git/objects/info/alternates &&
+	echo >.git/objects/info/alternates &&
 	test_must_fail git show $csha1
 '
 
 test_expect_success 'local packed unreachable obs that exist in alternate ODB are not loosened' '
-	echo $(pwd)/alt_objects > .git/objects/info/alternates &&
+	echo $(pwd)/alt_objects >.git/objects/info/alternates &&
 	echo "$csha1" | git pack-objects --non-empty --all --reflog pack &&
 	rm -f .git/objects/pack/* &&
 	mv pack-* .git/objects/pack/ &&
@@ -186,7 +186,7 @@ test_expect_success 'local packed unreachable obs that exist in alternate ODB ar
 	mv pack-* .git/objects/pack/ &&
 	test 0 = $(git verify-pack -v -- .git/objects/pack/*.idx |
 		egrep "^$csha1 " | sort | uniq | wc -l) &&
-	echo > .git/objects/info/alternates &&
+	echo >.git/objects/info/alternates &&
 	test_must_fail git show $csha1
 '
 
@@ -196,7 +196,7 @@ test_expect_success 'objects made unreachable by grafts only are kept' '
 	H0=$(git rev-parse HEAD) &&
 	H1=$(git rev-parse HEAD^) &&
 	H2=$(git rev-parse HEAD^^) &&
-	echo "$H0 $H2" > .git/info/grafts &&
+	echo "$H0 $H2" >.git/info/grafts &&
 	git reflog expire --expire=$test_tick --expire-unreachable=$test_tick --all &&
 	git repack -a -d &&
 	git cat-file -t $H1
-- 
2.24.0.504.g3cd56eb17d

