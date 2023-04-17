Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A717DC77B76
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 20:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjDQU5l (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 16:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjDQU5S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 16:57:18 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EADD32C
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 13:55:01 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-54c0c86a436so551833467b3.6
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 13:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681764868; x=1684356868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bKiKbZnJpPrCZn5U+gYXllyRzne0MiR744ovoifmPTo=;
        b=XvoxY06+7tM9Ww4WiB2uSzQmHsgE7AgFXrv1HLQ3AOnyef6gmrMJ3eZM3D/AIuXkYV
         S5D8CXSEs6lnHSB7pyjL/iteaZOw55rNhCNqjm4ygPkTgiEugznjZZbrQ+VArFrR3KsG
         7aXDfkZg0ZJfFH0EsxD5hoKQEjtyjKuaiml6yWZR/dQd9QZZbnlwMgeYh5Ht8Bkj1cLx
         E3NNcYL8T2ivWbCmV/2Rg+Qn/hMczJkFK2KsK7iMc4E9btN1SIl1Ws/yo1t/0wK7+N9v
         yuvjQlDhHyXMbCVKd1CMl0gBKOKvkb6mu1Ngi8WV1Uf2fQqfDXSnaPsV7n9w98M048YD
         bR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764868; x=1684356868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bKiKbZnJpPrCZn5U+gYXllyRzne0MiR744ovoifmPTo=;
        b=VaW7UUO4M9skR+GY7OXzlWxwF7O5Q8c8b6QgD4JVDleK63DT6Y34A2uW9u5cxbRdSN
         pflHY2NTjIqGy/B//xSGdHt9PlfPe7s3wfKKpEi2tBkOzc5Se2ZjBgUmwM9pwydnwSiQ
         95PiiAB2xPqVBPL+LHbqdjgeimdmKnW4zIDdT0/FadqAb/9lCdyj0J/Tgnpq7NnAD4Hi
         OUI8R/fSJJBzLbf0uOqO/cVaqfuxQaTh60v9iy2M+FRoxIq5VQtMtwhz5HP9OXbO86M0
         rx/MDKn9FZR24KWtyktTIXmVBdZc5WX2EsMxIxWZ2aN+8rQuzIR6gpWfWHZfOiRErdeT
         tUdQ==
X-Gm-Message-State: AAQBX9djLCk41nGUzF84oqErX3ZTn44EM9AsaoWzd9g0RGDapNBzJ7B7
        Dpgi4i9uysPWAv06xXGcPv4vKBLOd7Clte3gQG6JqA==
X-Google-Smtp-Source: AKy350ZCclcrWUIiChwS/Bi5qaUKaAu7dxfTFvmOumjwum4GPJN+8YJkOAS/UrOLratkg3pXPycyAw==
X-Received: by 2002:a0d:d644:0:b0:545:62d7:6fac with SMTP id y65-20020a0dd644000000b0054562d76facmr15227307ywd.10.1681764868453;
        Mon, 17 Apr 2023 13:54:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id eq7-20020a05690c2d0700b00545a08184b3sm1826995ywb.67.2023.04.17.13.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:54:28 -0700 (PDT)
Date:   Mon, 17 Apr 2023 16:54:27 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 05/10] t/t9300-fast-import.sh: prepare for `gc --cruft` by
 default
Message-ID: <1b07eb83fe6ab9fcb65d5a4746dec50c0f2cbd9e.1681764848.git.me@ttaylorr.com>
References: <cover.1681764848.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681764848.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a similar fashion as the previous commit, adjust the fast-import
tests to prepare for "git gc" generating a cruft pack by default.

This adjustment is slightly different, however. Instead of relying on us
writing out the objects loose, and then calling `git prune` to remove
them, t9300 needs to be prepared to drop objects that would be moved
into cruft packs.

To do this, we can combine the `git gc` invocation with `git prune` into
one `git gc --prune`, which handles pruning both loose objects, and
objects that would otherwise be written to a cruft pack.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t9300-fast-import.sh | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index aa55b41b9a..ac237a1f90 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -388,9 +388,7 @@ test_expect_success 'B: accept branch name "TEMP_TAG"' '
 
 	INPUT_END
 
-	test_when_finished "rm -f .git/TEMP_TAG
-		git gc
-		git prune" &&
+	test_when_finished "rm -f .git/TEMP_TAG && git gc --prune=now" &&
 	git fast-import <input &&
 	test $(test-tool ref-store main resolve-ref TEMP_TAG 0 | cut -f1 -d " " ) != "$ZERO_OID" &&
 	test $(git rev-parse main) = $(git rev-parse TEMP_TAG^)
@@ -406,8 +404,7 @@ test_expect_success 'B: accept empty committer' '
 	INPUT_END
 
 	test_when_finished "git update-ref -d refs/heads/empty-committer-1
-		git gc
-		git prune" &&
+		git gc --prune=now" &&
 	git fast-import <input &&
 	out=$(git fsck) &&
 	echo "$out" &&
@@ -452,8 +449,7 @@ test_expect_success 'B: accept and fixup committer with no name' '
 	INPUT_END
 
 	test_when_finished "git update-ref -d refs/heads/empty-committer-2
-		git gc
-		git prune" &&
+		git gc --prune=now" &&
 	git fast-import <input &&
 	out=$(git fsck) &&
 	echo "$out" &&
@@ -1778,8 +1774,7 @@ test_expect_success 'P: verbatim SHA gitlinks' '
 	INPUT_END
 
 	git branch -D sub &&
-	git gc &&
-	git prune &&
+	git gc --prune=now &&
 	git fast-import <input &&
 	test $(git rev-parse --verify subuse2) = $(git rev-parse --verify subuse1)
 '
-- 
2.38.1

