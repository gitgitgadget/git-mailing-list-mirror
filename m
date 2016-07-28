Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA52D1F858
	for <e@80x24.org>; Thu, 28 Jul 2016 17:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161013AbcG1R0x (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 13:26:53 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33547 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758990AbcG1R0v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 13:26:51 -0400
Received: by mail-pf0-f181.google.com with SMTP id y134so23954803pfg.0
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 10:26:51 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pGDXlcTnqIfvI7qoNEV6VQVkSoR0pRyqYlUTgCBSR60=;
        b=K3hwLSWNRXGDkAViK0bn05LJsAjdYJ4efpnyvJrKzuwwBMT2foD/89FFFrVEMuB7x8
         UB45q9ankv+fvjip8vjUFsSIu1f/mY1AI0ieFoJptksOTVjSMtdobykRN7OHQ6l2kfkL
         jarP35gkNv8sib0UafveX3rlbw9/eLUnyFi9ieGGta3ZJqQ1gJSqdslfqSfbJq3MZOKa
         0gg26PTzMcKdBe5e57XfFkhhi95/yhmgu4Ng/3mFQHn7b4z3MMyxRB+/7BoCU4+TWhXI
         rjErkclqHfqpQRrClvY5LDPXnb+PWn8nEGLy6f0KIaSfC2nbK4hu4ZFu9GkNs9H2RG9L
         AYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pGDXlcTnqIfvI7qoNEV6VQVkSoR0pRyqYlUTgCBSR60=;
        b=KqUZ91WHqTbmbzvkQT/KnZGwA8AogrqSaXwHIpsizcLb3OuNQ9+NJLGrLc4BQC+wq3
         u8UecxnGzFD036S/GOzIvxebwPe9BtbVvx5hqD14JZxU90jUDoatsE/92eXvziF/Adlc
         ReiMbkZ1T9cbPokIUgY9yu3i0+v2QBnFeIOhz2Ad2OqJ2qU6sPKC3tf9fHbRRrqEQiWc
         L5Qz50rNdFJMAC8AFe4ziaTCmNbe4A4mbR6smEwknI32HMq2SJoLy9R8VmuLJYiCbJby
         u/pm3BTWamR6H9G7tovIg1QJHGEbVtMSUfKoBjhoFd33wMT63n0ROR+sDOgQyg2RsTJm
         7seg==
X-Gm-Message-State: AEkoouv66DYhSfbIH0wpe88C06jQ4W3qcO340t7VjwbHdLKbzfV77p/N9BhArmCblmPdmMI3
X-Received: by 10.98.50.2 with SMTP id y2mr61021590pfy.138.1469726810443;
        Thu, 28 Jul 2016 10:26:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:6dbf:17d9:7b5c:47ec])
        by smtp.gmail.com with ESMTPSA id d72sm18682683pfj.15.2016.07.28.10.26.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 28 Jul 2016 10:26:49 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de, jrnieder@gmail.com,
	Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] t7406: correct depth test in shallow test
Date:	Thu, 28 Jul 2016 10:26:40 -0700
Message-Id: <20160728172641.8376-2-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.466.g8c6d1f9.dirty
In-Reply-To: <20160728172641.8376-1-sbeller@google.com>
References: <20160728172641.8376-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

We used to ask for 3 changes and tested for having 1, so the test
seems broken.

Correct the test by using test_line_count that exists in the test suite.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7406-submodule-update.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 88e9750..bd261ac 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -846,9 +846,10 @@ test_expect_success 'submodule update clone shallow submodule' '
 	(cd super3 &&
 	 sed -e "s#url = ../#url = file://$pwd/#" <.gitmodules >.gitmodules.tmp &&
 	 mv -f .gitmodules.tmp .gitmodules &&
-	 git submodule update --init --depth=3
+	 git submodule update --init --depth=2
 	 (cd submodule &&
-	  test 1 = $(git log --oneline | wc -l)
+	  git log --oneline >lines
+	  test_line_count = 2 lines
 	 )
 )
 '
-- 
2.9.2.466.g8c6d1f9.dirty

