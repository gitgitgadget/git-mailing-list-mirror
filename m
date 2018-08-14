Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBF241F404
	for <e@80x24.org>; Tue, 14 Aug 2018 11:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbeHNOfV (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 10:35:21 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43568 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729445AbeHNOfU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 10:35:20 -0400
Received: by mail-ed1-f65.google.com with SMTP id j21-v6so9936724edp.10
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 04:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SlLcLWSgekV7ONSEZqabCYhH9zDB/xmcJO/B9Eg+I2E=;
        b=vN9nLADL7RqXDir4kOaNMm2XwUJtZoy8PyJxaiC3tHMxt9swJ7Q3MmS2awFIwunOyX
         1SwZjhN6f3+WN/FhEfCsYj4X4BOu2UdXRhWsc0DsmgTkb3HDoWe125XtdspwM4wNS5nL
         Dumwm4dqs0ub+pEJ+uQZ/W1hvHKEhk4hmmBcGdlWGpEHc9paVH9zj4KpoIeCGk+3duMh
         78cL0nUsobeaUY1Wjuz4vKmga4RPEYF62ifIwW758Bb6TtVXKc/IoRe5JOoRu8MDoXZs
         6tKiYNzyTRquK7Csrfg8P+O/vihfgCg1UmRyZXQX12yeNuBTJH7r6iVa1Ytvr1C2UZPy
         vX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SlLcLWSgekV7ONSEZqabCYhH9zDB/xmcJO/B9Eg+I2E=;
        b=aCDIuI1G1lf2acPaU1EX7GTX0YjnRVcZFh0OMJ+rgaWPR9b4TRyG4AIs4fAU34RpyO
         UslvjQbSQ5KhbbxRgrE7N4RcHby3GXNtu8u7uW6p5YkXOJCnrbEhTRD/HLGAWlRgafxE
         3qXiVXW42z001QHtRVC7O9cTgKLhjI371N6JjhFJPDKC+xbCdvpCMPi+Lwde9e0NyHLK
         YOg8Y4bI421uNTJ3jAfokvUJa8aOXtfIPjreWC5B6ZGr8PMj2Beo/GGLqw4iPmevsDC2
         QGnYU6Px1TaNtiZv9iUgwKv7eAsLW9h+SvC6nPKseCGyU6ylz34jjMIkuTF3nyT4hmJw
         an0g==
X-Gm-Message-State: AOUpUlFYRy2U+B90ECJuEKIG540UQlNNzMlfJtZb2iWtYLY32vhUs+36
        Oe9F1NIQaLlybkBi7GGrZig=
X-Google-Smtp-Source: AA+uWPwUgHJM4hFurR9YGiWj8Olf1A4VevU4gAY88TO+WiK23FCu8ndhk+KPqy6JqW7Z/1kGaqA0Mw==
X-Received: by 2002:a50:96c4:: with SMTP id z4-v6mr27021639eda.14.1534247310392;
        Tue, 14 Aug 2018 04:48:30 -0700 (PDT)
Received: from localhost.localdomain (x590d91ad.dyn.telefonica.de. [89.13.145.173])
        by smtp.gmail.com with ESMTPSA id u25-v6sm12927377edm.45.2018.08.14.04.48.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 14 Aug 2018 04:48:29 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Kirill Smelkov <kirr@nexedi.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] t5310-pack-bitmaps: fix bogus 'pack-objects to file can use bitmap' test
Date:   Tue, 14 Aug 2018 13:47:21 +0200
Message-Id: <20180814114721.25577-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.720.g1f300496fc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test 'pack-objects to file can use bitmap' added in 645c432d61
(pack-objects: use reachability bitmap index when generating
non-stdout pack, 2016-09-10) is silently buggy and doesn't check what
it's supposed to.

In 't5310-pack-bitmaps.sh', the 'list_packed_objects' helper function
does what its name implies by running:

  git show-index <"$1" | cut -d' ' -f2

The test in question invokes this function like this:

  list_packed_objects <packa-$packasha1.idx >packa.objects &&
  list_packed_objects <packb-$packbsha1.idx >packb.objects &&
  test_cmp packa.objects packb.objects

Note how these two callsites don't specify the name of the pack index
file as the function's parameter, but redirect the function's standard
input from it.  This triggers an error message from the shell, as it
has no filename to redirect from in the function, but this error is
ignored, because it happens upstream of a pipe.  Consequently, both
invocations produce empty 'pack{a,b}.objects' files, and the
subsequent 'test_cmp' happily finds those two empty files identical.

Fix these two 'list_packed_objects' invocations by specifying the pack
index files as parameters.  Furthermore, eliminate the pipe in that
function by replacing it with an &&-chained pair of commands using an
intermediate file, so a failure of 'git show-index' or the shell
redirection will fail the test.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t5310-pack-bitmaps.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 6ee4d3f2d9..557bd0d0c0 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -9,7 +9,8 @@ objpath () {
 
 # show objects present in pack ($1 should be associated *.idx)
 list_packed_objects () {
-	git show-index <"$1" | cut -d' ' -f2
+	git show-index <"$1" >object-list &&
+	cut -d' ' -f2 object-list
 }
 
 # has_any pattern-file content-file
@@ -204,8 +205,8 @@ test_expect_success 'pack-objects to file can use bitmap' '
 	# verify equivalent packs are generated with/without using bitmap index
 	packasha1=$(git pack-objects --no-use-bitmap-index --all packa </dev/null) &&
 	packbsha1=$(git pack-objects --use-bitmap-index --all packb </dev/null) &&
-	list_packed_objects <packa-$packasha1.idx >packa.objects &&
-	list_packed_objects <packb-$packbsha1.idx >packb.objects &&
+	list_packed_objects packa-$packasha1.idx >packa.objects &&
+	list_packed_objects packb-$packbsha1.idx >packb.objects &&
 	test_cmp packa.objects packb.objects
 '
 
-- 
2.18.0.720.g1f300496fc

