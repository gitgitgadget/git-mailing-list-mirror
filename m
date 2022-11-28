Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F38C43217
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 13:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbiK1NDg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 08:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiK1NDa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 08:03:30 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AF1BF6A
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 05:03:29 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id a9so6933262pfr.0
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 05:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v44BqyfDcpvXQa5cOlaYTVEOf5kEy1Gt6E6KyvkgiKk=;
        b=ZF01ghtlz31Hg+lcuSI1UjLokETH2gIYIK4RTesnzKVYU49HuFgjZano6kVDRsPC2B
         izvEOk+06X3eURroh0nWRvn6Mjc4utwcN2cJbpKFJ35TzGbS2GZKwqEj6RAB0b5fk4wx
         JvwmxZ90y10PVK3ETeSOQqMa4u6/7cwHz2icl8CRi9NJ3oCbx3ChiRZ52IF+h1/QUun/
         Gk/xU7fv7kjp6edRbJZXAl54hrqeqIETxwXfFm8T7WI+o05WDbD561uC+EgXGAQmapsb
         aHee+eU+Y9iuXWHCCIlOF+pNRzUmx83GHS6ZC6+q6XMF3AadgnpZeIhBXFQP5kGTb6w3
         ojrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v44BqyfDcpvXQa5cOlaYTVEOf5kEy1Gt6E6KyvkgiKk=;
        b=YyJufKGwFDfuoM9GChMUv/Pz/FsAu9TxOrlQFS+g5I+xEy266I6okNT983991q72b/
         7R6y5VUZik12cNnc59wGXgEf7F0s8ToQJuxfmZ5zhO2DgIB+Xo7cR0kGncv8eGa2Drlm
         4sXyDpj3zBDE3DX3u0sgWXmUz/aGtTPuH1q+jZ/yE90ikgtO2UAhHueEMD6TC6LDGN63
         UEI5GN4mwpe/J2AH+VQDVqHkdmpPyYDKfCh5B4RiQ4m726sxq0+NxV7I/2616X4VOynd
         PzfOVScjGy+fsULmqwIqpo/mdUqQjFFnc0vDQ6olrbvgsMtBWFKAotZNGOUFQMojaab+
         8+Qw==
X-Gm-Message-State: ANoB5pmlx3lEfTYq4p564/vL+x2AmG6IMrb1QlbZsJUi4iMLhxtm2J6i
        0djb2UzhbENZSIVh5C/EY9i4/MeGrZs=
X-Google-Smtp-Source: AA0mqf4hWwwQPAQPvA32/tv5X8hn24uyRIlPgMrM7RczjXECCW9NsMiVguFhID+7UThMn0Um8cN/MA==
X-Received: by 2002:a63:e712:0:b0:477:7f69:2749 with SMTP id b18-20020a63e712000000b004777f692749mr28009440pgi.372.1669640608710;
        Mon, 28 Nov 2022 05:03:28 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id x127-20020a626385000000b0057409583c09sm7977301pfb.163.2022.11.28.05.03.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2022 05:03:28 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 3/3] t1301: do not change $CWD in "shared=all" test case
Date:   Mon, 28 Nov 2022 21:03:23 +0800
Message-Id: <20221128130323.8914-4-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20221127145130.16155-1-worldhello.net@gmail.com>
References: <20221127145130.16155-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

In test case "shared=all", the working directory is permanently changed
to the "sub" directory. This leads to a strange behavior that the
temporary repositories created by subsequent test cases are all in this
"sub" directory, such as "sub/new", "sub/child.git". If we bypass this
test case, all subsequent test cases will have different working
directory.

Besides, all subsequent test cases assuming they are in the "sub"
directory do not run any destructive operations in their parent
directory (".."), and will not make damage out side of $TRASH_DIRECTORY.

So it is a safe change for us to run the test case "shared=all" in
current repository instead of creating and changing to "sub".

For the next test case, we no longer run it in the "sub" repository
which is initialized from an empty template, we should not assume the
path ".git/info" is missing. So add option "-p" to mkdir.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t1301-shared-repo.sh | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 1225abbb6d..fd10c139f5 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -46,8 +46,6 @@ do
 done
 
 test_expect_success 'shared=all' '
-	mkdir sub &&
-	cd sub &&
 	git init --template= --shared=all &&
 	test 2 = $(git config core.sharedrepository)
 '
@@ -57,7 +55,7 @@ test_expect_success POSIXPERM 'update-server-info honors core.sharedRepository'
 	git add a1 &&
 	test_tick &&
 	git commit -m a1 &&
-	mkdir .git/info &&
+	mkdir -p .git/info &&
 	umask 0277 &&
 	git update-server-info &&
 	actual="$(ls -l .git/info/refs)" &&
-- 
2.39.0.rc0

