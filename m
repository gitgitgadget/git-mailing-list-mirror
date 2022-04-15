Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0053CC433EF
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 02:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348992AbiDOCvA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 22:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348988AbiDOCuV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 22:50:21 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08EAB6449
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 19:47:44 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id v15so8502503edb.12
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 19:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RSuimEDAosFtS10Yfs9huUCawiyZfdk/qguGrwfZMGs=;
        b=KZxFHXCCUE0RM/oBW5KadeQ/ltJ0VMxvkz7244IKK58WcI1Jbc80vfntKAIDyfCvAR
         bgrag+SZUJxs6RX8SOahXVYx28sd2Ik5M3U0wECxJqAn9RL40z9D5E/6sNCG6GhPdSh0
         FsCPzeUs7KnZaprzlRkgU180ijlUpE37IhX4B933KXFbw4vxr3n6X5L5SUltd272CAqv
         YrEcMCTw+QZyHEOJGUOHgD5YqvA8bohZzOZHGEUtJNBFotv0xZC1/UAt6lVfBNye8stB
         QOChn+xf/mQG1ftrP1lXiPWvEzw/bFke8B1DgdNxnhFsBKIZyIAlshYb9Txn3G9y7yzu
         aLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RSuimEDAosFtS10Yfs9huUCawiyZfdk/qguGrwfZMGs=;
        b=W6k/OgNwPf6viW2IVgbfVnViTlVdHs33azxfW9E3Qo1ciTgyQGH6iTHZT9VxXiXA9D
         UoZCOp5nHg55F2a2ujtuiR5myc0Ng3992yeQUhnSRZdEmaAzBzV97JN9aRZ20E6YbaIa
         ANAFvpzjJEe9Ov3zptuRPgVWXtrNLfJ4Q+MudtZPyJexqE/4ITCw0n7u1EoXGZrJHonI
         wvb8Ah+qSgknvV6kKdq38CIA1oou14VfzMJAUukPNe1usawCL5+ENVF92SMiKExKdJtE
         Dp5HM6mlY0JWm57eZkqeDR3hDrMNv3yJLfjNJM+/5KroWoz6uGxheoDl3xJ4lay04mmG
         0JKA==
X-Gm-Message-State: AOAM530FlrQ3wKXZ0N24IJKP3hkmTsksa4Yvvkmn0tACQHMf0WKJvyQc
        M4wLyJenrzKQRB0HxvMV5QOR1nBhbvI=
X-Google-Smtp-Source: ABdhPJypzdhn6jr6htlo/veYALiRZTU/sZIPuSWYcXYMjVB0vO4pFowQHeNMrxRftjPX2mN/OIbVEQ==
X-Received: by 2002:a05:6402:350d:b0:41d:675f:ea96 with SMTP id b13-20020a056402350d00b0041d675fea96mr6203952edd.297.1649990863059;
        Thu, 14 Apr 2022 19:47:43 -0700 (PDT)
Received: from fedora35.example.com ([151.27.151.62])
        by smtp.gmail.com with ESMTPSA id lb26-20020a170907785a00b006ea4d2928e5sm1212561ejc.218.2022.04.14.19.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 19:47:42 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH v4 1/1] Makefile: add a prerequisite to the coverage-report target
Date:   Fri, 15 Apr 2022 02:47:38 +0000
Message-Id: <20220415024738.9239-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Directly invoking make coverage-report as a target results in an error because
its prerequisites are missing,

This patch adds the compile-test prerequisite, which is run only once each time
the compile-report target is invoked. In practice, the developer may decide to
review the coverage-report results without necessarily rerunning for this
coverage-test, if it has already been run.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
This is the fourth revision of the patch. Compared to the third:

- @make -> $ (MAKE)
- drop touch coverage-test.made from the coverage-test.made target

 Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index f8bccfab5e..3740a3a4e7 100644
--- a/Makefile
+++ b/Makefile
@@ -3407,6 +3407,7 @@ coverage-clean-results:
 	$(RM) coverage-untested-functions
 	$(RM) -r cover_db/
 	$(RM) -r cover_db_html/
+	$(RM) coverage-test.made
 
 coverage-clean: coverage-clean-results
 	$(RM) $(addsuffix *.gcno,$(object_dirs))
@@ -3421,13 +3422,17 @@ coverage-compile:
 coverage-test: coverage-clean-results coverage-compile
 	$(MAKE) CFLAGS="$(COVERAGE_CFLAGS)" LDFLAGS="$(COVERAGE_LDFLAGS)" \
 		DEFAULT_TEST_TARGET=test -j1 test
+	touch coverage-test.made
+
+coverage-test.made:
+	$(MAKE) coverage-test
 
 coverage-prove: coverage-clean-results coverage-compile
 	$(MAKE) CFLAGS="$(COVERAGE_CFLAGS)" LDFLAGS="$(COVERAGE_LDFLAGS)" \
 		DEFAULT_TEST_TARGET=prove GIT_PROVE_OPTS="$(GIT_PROVE_OPTS) -j1" \
 		-j1 test
 
-coverage-report:
+coverage-report: coverage-test.made
 	$(QUIET_GCOV)for dir in $(object_dirs); do \
 		$(GCOV) $(GCOVFLAGS) --object-directory=$$dir $$dir*.c || exit; \
 	done
-- 
2.35.1

