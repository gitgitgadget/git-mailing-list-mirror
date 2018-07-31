Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D1A6208E9
	for <e@80x24.org>; Tue, 31 Jul 2018 23:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732758AbeHABPi (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 21:15:38 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32936 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732749AbeHABPi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 21:15:38 -0400
Received: by mail-ed1-f67.google.com with SMTP id x5-v6so5976009edr.0
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 16:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R7hA7S9/l2g5KawWLC6IoFAZEBHFvaWHPJ1WANI+7XY=;
        b=TNBILL/ehaeGXu6g1kLC7PUP3ntW4Gg1L39IO4MLYaVYFSv0LDAtxQDrHR9u+Dl/nm
         A9jE1/zpdei6TkzQ5vsFuPPz3e9bvJ0nm/IMzzo47pzz+4KILruX3FkrnGk2x4z581Oq
         7hRHB1uK0APPmkuMhxTcPup/fIzf8SiE8kJ7Th5v3USkAzGPuTcxYXdQAMucbrtuCy2U
         Hlzt0kPpl8YI62BTzk2RfiBdNGtvaIdD/h9Jeg7vPjt6o/wBs6SkieX0XLLvLxqWVuB8
         /f3ABkYAhW8/JPLRlVQAipjPZfYVnAxzf5CVOoFKov4vt3RNFvu7azA/WsVDpC0B5CD5
         tXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R7hA7S9/l2g5KawWLC6IoFAZEBHFvaWHPJ1WANI+7XY=;
        b=G7Zho/7+bcZPFCeemCzI3dGyA7k6nRDMnqgEwgCHRJSJDaD+RiCNrNZ7QAAMi3ILJX
         1YvGBnH1VsGuxVU7kLto0gQx71ywJtAtJGeHaH2SKVVEzmkwIVH8wN3YEbr6jpMY6Kt/
         oVWt2ElMwABj9d3RoITl65FZeyNfYqU6VKvSrrkdVo7yj8pEyHWTrm99KQA5tzSzdOJu
         Vz90jz7CijEDyrurmtUAx7bxGgol8rD95mzUbL9lP6f6b0KBGbZ0CQS4j8xjwBsT3Ai4
         b7tFYoMtPJFPphsMYeID6vj7cF8JYOl+dlTPym1sGAPUFBtgpP2EsLAx0wiUlyYGR4mm
         UUfA==
X-Gm-Message-State: AOUpUlHMc2wGzdZ1RYl6lVMXqSm+YxQIm/qTGXy7/w6rqP5BhnyMphoz
        pcciRwcBfQO01XBv1YaJ6UvaoAL2
X-Google-Smtp-Source: AAOMgpdADwxGc7Q+qaYKEzFCB6I/ALnJOSwvq3Y8a5LbgKsZJdrjsZv8eihg91zhcZWuH+R5Rer83w==
X-Received: by 2002:a50:8b25:: with SMTP id l34-v6mr1395083edl.265.1533079976891;
        Tue, 31 Jul 2018 16:32:56 -0700 (PDT)
Received: from localhost.localdomain (x590cfeaf.dyn.telefonica.de. [89.12.254.175])
        by smtp.gmail.com with ESMTPSA id s23-v6sm4014969edm.74.2018.07.31.16.32.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 31 Jul 2018 16:32:56 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] t1404: increase core.packedRefsTimeout to avoid occasional test failure
Date:   Wed,  1 Aug 2018 01:32:48 +0200
Message-Id: <20180731233248.25482-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.408.g42635c01bc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test 'no bogus intermediate values during delete' in
't1404-update-ref-errors.sh', added in 6a2a7736d8 (t1404: demonstrate
two problems with reference transactions, 2017-09-08), tries to catch
undesirable side effects of deleting a ref, both loose and packed, in
a transaction.  To do so it is holding the packed refs file locked
when it starts 'git update-ref -d' in the background with a 3secs
'core.packedRefsTimeout' value.  After performing a few checks it is
then supposed to unlock the packed refs file before the background
'git update-ref's attempt to acquire the lock times out.

While 3secs timeout seems plenty, and indeed is sufficient in most
cases, on rare occasions it's just not quite enough: I saw this test
fail in Travis CI build jobs two, maybe three times because 'git
update-ref' timed out.

Increase that timeout by an order of magnitude to 30s to make such an
occasional failure even more improbable.  This won't make the test run
any longer under normal circumstances, because 'git update-ref' will
acquire the lock and resume execution as soon as it can.  And if it
turns out that even this increased timeout is still not enough, then
there are most likely bigger problems, e.g. the Travis CI build job
will exceed its time limit anyway, or the lockfile module is broken.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t1404-update-ref-errors.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
index 3a887b5113..372f0b1fbb 100755
--- a/t/t1404-update-ref-errors.sh
+++ b/t/t1404-update-ref-errors.sh
@@ -559,9 +559,9 @@ test_expect_success 'no bogus intermediate values during delete' '
 	{
 		# Note: the following command is intentionally run in the
 		# background. We increase the timeout so that `update-ref`
-		# attempts to acquire the `packed-refs` lock for longer than
-		# it takes for us to do the check then delete it:
-		git -c core.packedrefstimeout=3000 update-ref -d $prefix/foo &
+		# attempts to acquire the `packed-refs` lock for much longer
+		# than it takes for us to do the check then delete it:
+		git -c core.packedrefstimeout=30000 update-ref -d $prefix/foo &
 	} &&
 	pid2=$! &&
 	# Give update-ref plenty of time to get to the point where it tries
-- 
2.18.0.408.g42635c01bc

