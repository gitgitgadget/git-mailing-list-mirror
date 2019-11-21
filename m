Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BCBC432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A736920855
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeoAzmuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfKUAqc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 19:46:32 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40100 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfKUAqc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 19:46:32 -0500
Received: by mail-pl1-f194.google.com with SMTP id f9so677075plr.7
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 16:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3+XZymXJRKFhtTpFKHHOmAn563xbiz0Sxk1R6skKSao=;
        b=MeoAzmukOPzUMCm2eGVu5eOU5YUXUV8w0UhJPT3h6cFf7XFCdI5oTROkQ6iklsKfrm
         0US90cVuWU0wsBjHjFC4P0nKT6wQpM2wQIF4vYM8GA+gS6UGcQUsGCZ/HCZkIlHjzwh3
         HW5jTkgkV8541I0w6Ci+L+/TOmasDpa8sUaTZT82m09bHQ9PHIGQ/Tmr8a5kwMKKj6fH
         +AdWqnPFQXJt5aPsJdF4WHhcjwOwiv7jmNtXvL27J0thJKe6mXBPrMU+0+lB64okYUkq
         HW8gyX+XWgUmelMEAYLblggbvRrKngBkv/pastE9/1tP2zw+aSAvi1LwRTqBu2tSUD4I
         nVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3+XZymXJRKFhtTpFKHHOmAn563xbiz0Sxk1R6skKSao=;
        b=Fwc6WfjtBeXHXTGTsrEEH5AtKVCyyjK0xkL4GoHLEqWkpTDeuhFsTicViaqIDUpami
         7HM7S3XVrTT0b/RoQUJCn4XlXc8XfJ6OpDBKjSDHO6Aaeelwyz79ehZzkrYghZqx6fh1
         vXl21Zx5in5GPsEWYc7yZMfscF1CbPBTo0xa2kI+5sf0jxkxe9cUHG0BOqnwH5HlUyxa
         nW8AF3pyLLtE5UfJrPMQDYz2HDWC/nrWTe4Rv8CEsOCvrU2gaqmcUpZeZ7VfvxwY7D5f
         z7paqpW7k1l2/B30ny4E5P/qnoQ40xCas6Vx9P9f6gJYzV2k1ll3HIzVvmduox+0XHpl
         FSeg==
X-Gm-Message-State: APjAAAWnepKwbqhBvHtGqzhhbJMPW5Apr6yTOez7tiX/27xB5G7X0Zuq
        cSsHT+Z0/PpEzGUmNvUoYcaL12WY
X-Google-Smtp-Source: APXvYqx0awPilTUj3xwxfye3osO5EVjvkCJaiX/Zzg7ZImXAL54roPrsPQ9A1/TP9tV6qo1Tr/pYBA==
X-Received: by 2002:a17:902:8f81:: with SMTP id z1mr5587801plo.228.1574297191243;
        Wed, 20 Nov 2019 16:46:31 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id v189sm593205pfv.133.2019.11.20.16.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 16:46:30 -0800 (PST)
Date:   Wed, 20 Nov 2019 16:46:29 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 18/21] t7700: remove spaces after redirect operators
Message-ID: <43f184dbd5f73c118aa2b6b3ecdfa84ae2249ff9.1574296987.git.liu.denton@gmail.com>
References: <cover.1573779465.git.liu.denton@gmail.com>
 <cover.1574296987.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574296987.git.liu.denton@gmail.com>
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
2.24.0.450.g7a9a4598a9

