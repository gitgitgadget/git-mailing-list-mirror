Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F25ECAAA1
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 18:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJaSBf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 14:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiJaSB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 14:01:28 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13ACC13DE1
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 11:01:19 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id u2so17711449ljl.3
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 11:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gsi9RDLPC41yXxlCWqE1dKxszf38GiFRuQHDEsSD8fU=;
        b=h5IhB4h+t99r1/wa3T0Vc8y2xah2mmLtlxlyOBkPy75sbhzGqoFRaw1RNpC0zbeZ9c
         BbDOz1vUAIFA5g+uYD1QR/uvCqgivDeff3EldI7wd2hD/7Tm433FMMtGwegW5qTqLjw9
         XwUBmy4ApJXrjFOckLDD5XefEKs+M/QI69m9dmzAaNi3bhPj3M5QyRJ22Fk8xxfrBW7a
         7E3YxSAVma9/MfwHjSDflwTAuyBdEWr79IeT6wfAwj8GFnU9NGUJYvV8/VO7oyl9mkWg
         PA73ABhPqec3MnbyarM884dL59wXIlRdsfdZRVChnDPatlNQtXcYO8elbxfKSRTfGpKd
         k2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gsi9RDLPC41yXxlCWqE1dKxszf38GiFRuQHDEsSD8fU=;
        b=l6PAoA6qe8OOC2uOuHo1Renp+wjLsVP+/c71x6HOMPK6+hiC7X7FUGR1sP31CCliwL
         MKmwyH61pFjTDwJM824VHH5v21gD2wh++SdqcfXWKWTSY5SxT53wI5eEl9SrhGQRCRMU
         F+RDw6nqZ3SK84pT4EvW7Pq43wLS9dMUK9OX0KowEmKPkbFCWIk3zemNhJbJW+BEhqVH
         LWHictx5Ht1NbhyRarsLwOG6GsE67VZKQDmJ55xMErCBkgc3kSgdY3ob2MqjVSas2DWW
         xzCAfO2gZhHjB+QpXRkMEgPRMGn9bUyK4GgJZUG0RvYAfhPhW1+rGHSqNzC/8/RxIGWL
         m7sg==
X-Gm-Message-State: ACrzQf1TvTYu+YLueAIBZCfnuUn1hCnPC1avJxrt2dCpMktVEYW1+naa
        EDJVjV+Ra7JL1cB/cFtxkTOzS/Owyng=
X-Google-Smtp-Source: AMsMyM6T+kT6R8ZJCeFVAtMD4v6LWQYktmgC5u679s85E8z7DNtFz2JqcfhPbwwQjbEWtYzU3peTFQ==
X-Received: by 2002:a2e:a801:0:b0:261:91a3:bc44 with SMTP id l1-20020a2ea801000000b0026191a3bc44mr5722324ljq.497.1667239276887;
        Mon, 31 Oct 2022 11:01:16 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id k9-20020a2eb749000000b002774e7267a7sm1014082ljo.25.2022.10.31.11.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 11:01:15 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] test-lib-functions: drop redundant diagnostic print
Date:   Mon, 31 Oct 2022 19:00:48 +0100
Message-Id: <20221031180048.5766-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.38.1.452.g9c842762fa
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`test_path_is_missing` was introduced back in 2caf20c52b ("test-lib:
user-friendly alternatives to test [-d|-f|-e]", 2010-08-10). It took the
path that was supposed to be missing, as well as an optional "diagnosis"
that would be echoed if the path was found to be alive.

Commit 45a2686441 ("test-lib-functions: remove bug-inducing
"diagnostics" helper param", 2021-02-12) dropped this diagnostic
functionality from several `test_path_is_foo` helpers, but note how it
tweaked the README entry on `test_path_is_missing` without actually
adjusting its implementation.

Commit e7884b353b ("test-lib-functions: assert correct parameter count",
2021-02-12) then followed up by asserting that we get just a single
argument.

This history leaves us in a state where we assert that we have exactly
one argument, then go on to anyway check for arguments, echoing them
all. It's clear that we can simplify this code. We should also note that
we run `ls -ld "$1"`, so printing the filename a second time doesn't
really buy us anything. Thus, we can drop the whole `if` block as
redundant.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 t/test-lib-functions.sh | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 29d914a12b..796093a7b3 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -921,10 +921,6 @@ test_path_is_missing () {
 	then
 		echo "Path exists:"
 		ls -ld "$1"
-		if test $# -ge 1
-		then
-			echo "$*"
-		fi
 		false
 	fi
 }
-- 
2.38.1.452.g9c842762fa

