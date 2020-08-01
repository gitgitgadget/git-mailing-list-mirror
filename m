Return-Path: <SRS0=89BL=BL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D15C433DF
	for <git@archiver.kernel.org>; Sat,  1 Aug 2020 19:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5D672072A
	for <git@archiver.kernel.org>; Sat,  1 Aug 2020 19:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/pH5T1y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgHAT12 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Aug 2020 15:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgHAT12 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Aug 2020 15:27:28 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68A6C06174A
        for <git@vger.kernel.org>; Sat,  1 Aug 2020 12:27:27 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v4so26035487ljd.0
        for <git@vger.kernel.org>; Sat, 01 Aug 2020 12:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4yW6gJkB3a8rrRlVeHWvw0l8F2SXDllsg6KXQ/DhtNM=;
        b=I/pH5T1yDm/B7nzJYNPhm0Yf14yb1qZhhV/nkLKjUzt0Vu/qxOonRsiJda/+0ZvltY
         s9PNmiubZx3ecGl9YLxJbAq/JIlSxT41Pg/0S1mgnzYjqtnoAZGJFS01adnTXhJtDwZj
         dOoa6Yux0JRsr1NlE4i+ohQbu33FkT3C/wSgUjt4xwAUSbrIfouoXgwhvYV91aehs+X+
         xW2x8yg8drHHCP//XZoj75WOdjRX96KPiYrXX5QsPg1U9zowOKeqQjKKWuoWrBi+6jtq
         82poxhIZYuQ82t2jVGbp0S/rjY4TsTyRf5Z8DVeCV5r0Pb5UaAnMLu4h07Q9Qgs602AS
         hkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4yW6gJkB3a8rrRlVeHWvw0l8F2SXDllsg6KXQ/DhtNM=;
        b=THxXJSr1vLZu2+EVRqawB1qNuYZc+p6ed5SQkVZ2TYnyHVM8iFL9cYDnXpVIYAxWoE
         t/VLUX7fR10bTouG9omPuq86R+IK3Bq5TDojHA0z6Y96wfmc116sjV990B0f5DP951fU
         1Q8cSwIYdZwI8uqSlC7gWUOfntrZXXvJV8oGOR/g4+G/5lrOhNmD6rPRTZf/pUszeML0
         /VeyFu2cO7j87n91uBQ317mU/U9j6TMJxK9k99ttT526dVKDY67AoyarwQKapBVyyPor
         wG3OoIFbobja/+4bL8Tajy5H+xnFJ7dzxdf6vxKynhgxUlNaQZ7QLC6EtiGcTwqI8DB0
         FWKw==
X-Gm-Message-State: AOAM5314Tai3Txk5M3pDUOr4OadBI8oh3tCtojKKYXb/6G2+yklLVbNQ
        MNbQvGZTD20hLH8NvzRlSGfLAmpL
X-Google-Smtp-Source: ABdhPJyCbWG/yJtJOWmvsSyw5xkbBa/CKHZUIoKaQR2uUMcRuyd0dKYsSa085r3guNpFmMHVfXKWzw==
X-Received: by 2002:a2e:9888:: with SMTP id b8mr4699828ljj.383.1596310046167;
        Sat, 01 Aug 2020 12:27:26 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id b26sm3006349lji.36.2020.08.01.12.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 12:27:25 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Aaron Lipman <alipman88@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 4/4] bisect: consistent style for git bisect run tests
Date:   Sat,  1 Aug 2020 21:27:17 +0200
Message-Id: <20200801192717.17278-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.81.ge8ab941b67
In-Reply-To: <20200801175840.1877-5-alipman88@gmail.com>
References: <20200801175840.1877-5-alipman88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 1 Aug 2020 at 20:03, Aaron Lipman <alipman88@gmail.com> wrote:
> Subject: bisect: consistent style for git bisect run tests

Nit: this could be 't6030: modernize "git bisect run" tests' to tighten
the area a bit and to begin with a verb.

> Enforce consistent styling for tests on "git bisect run":
> - Use "write_script" to abstract away platform-specific details.
> - Favor current whitespace conventions.
> ---

Missing sign-off.

I think this should come earlier in the series, probably already as
patch 1/4. Some reasons for that:

 * If this effort doesn't go any further (let's hope it does!), at
   least the initial cleanup can be merged, so that later endeavours can
   find a slightly cleaner table to start with.

 * Revisiting your other patches in `git log` after they've been merged,
   it will be obvious that they follow other tests, so one can focus on
   what they do and not on how they differ.

 * Let's first tidy up, then build shiny new things. ;-)

>  # We want to automatically find the commit that
> -# introduced "Another" into hello.
> -test_expect_success \
> -    '"git bisect run" simple case' \
> -    'echo "#"\!"/bin/sh" > test_script.sh &&
[...]
> +# added "Another" into hello.
> +test_expect_success '"git bisect run" simple case' '
> +       write_script test_script.sh <<-\EOF &&
[...]

All of these look like correct, worthwhile modifications. The
s/introduced/added/ changes aren't mentioned in the proposed log
message. They have been discussed up-thread, but it might still be
good to add something like

  While at it, change "introduced" to "added" in the comments to make
  them read better.

FWIW, I guess there's some minor added value in doing that change and
since you're doing other changes anyway, it might actually be worth the
churn.

You change two tests like this, but there are other "git bisect run"
tests that look like they're in need of some modernizing. Looking for
"chmod" I spotted the ones I'm tweaking below. Looking for "git bisect
run" you might find more that may contain some funny indentation. I'll
leave it to you where to stop going down that rabbit-hole but if you do
re-roll, it might make sense to squash in the diff below, maybe with
some modifications to the commit message. (Signed-off-by: Martin Ågren
<martin.agren@gmail.com>, FWIW.)

Martin

-- >8 --

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 63661c5e3d..66c12bc665 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -293,24 +293,17 @@ HASH6=
 test_expect_success 'bisect run & skip: cannot tell between 2' '
 	add_line_into_file "6: Yet a line." hello &&
 	HASH6=$(git rev-parse --verify HEAD) &&
-	echo "#"\!"/bin/sh" > test_script.sh &&
-	echo "sed -ne \\\$p hello | grep Ciao > /dev/null && exit 125" >> test_script.sh &&
-	echo "grep line hello > /dev/null" >> test_script.sh &&
-	echo "test \$? -ne 0" >> test_script.sh &&
-	chmod +x test_script.sh &&
+	write_script test_script.sh <<-\EOF &&
+	sed -ne \$p hello | grep Ciao >/dev/null && exit 125
+	! grep line hello >/dev/null
+	EOF
 	git bisect start $HASH6 $HASH1 &&
-	if git bisect run ./test_script.sh > my_bisect_log.txt
-	then
-		echo Oops, should have failed.
-		false
-	else
-		test $? -eq 2 &&
-		grep "first bad commit could be any of" my_bisect_log.txt &&
-		! grep $HASH3 my_bisect_log.txt &&
-		! grep $HASH6 my_bisect_log.txt &&
-		grep $HASH4 my_bisect_log.txt &&
-		grep $HASH5 my_bisect_log.txt
-	fi
+	test_expect_code 2 git bisect run ./test_script.sh >my_bisect_log.txt &&
+	grep "first bad commit could be any of" my_bisect_log.txt &&
+	! grep $HASH3 my_bisect_log.txt &&
+	! grep $HASH6 my_bisect_log.txt &&
+	grep $HASH4 my_bisect_log.txt &&
+	grep $HASH5 my_bisect_log.txt
 '
 
 HASH7=
@@ -318,14 +311,13 @@ test_expect_success 'bisect run & skip: find first bad' '
 	git bisect reset &&
 	add_line_into_file "7: Should be the last line." hello &&
 	HASH7=$(git rev-parse --verify HEAD) &&
-	echo "#"\!"/bin/sh" > test_script.sh &&
-	echo "sed -ne \\\$p hello | grep Ciao > /dev/null && exit 125" >> test_script.sh &&
-	echo "sed -ne \\\$p hello | grep day > /dev/null && exit 125" >> test_script.sh &&
-	echo "grep Yet hello > /dev/null" >> test_script.sh &&
-	echo "test \$? -ne 0" >> test_script.sh &&
-	chmod +x test_script.sh &&
+	write_script test_script.sh <<-\EOF &&
+	sed -ne \$p hello | grep Ciao >/dev/null && exit 125
+	sed -ne \$p hello | grep day >/dev/null && exit 125
+	! grep Yet hello >/dev/null
+	EOF
 	git bisect start $HASH7 $HASH1 &&
-	git bisect run ./test_script.sh > my_bisect_log.txt &&
+	git bisect run ./test_script.sh >my_bisect_log.txt &&
 	grep "$HASH6 is the first bad commit" my_bisect_log.txt
 '
 
-- 
2.28.0.81.ge8ab941b67

