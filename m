Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4269C1F453
	for <e@80x24.org>; Wed, 19 Sep 2018 21:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732521AbeITClh (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 22:41:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36514 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731366AbeITClh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 22:41:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id e1-v6so7205135wrt.3
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 14:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fuYnho7BceixiccGG2Tef7UB9DhvI4SCd6j5PSMifHE=;
        b=t9K1AT1WeQ0Gf2kNg6oTpTgmnkQifFbMKwHyqNI1gr8vAsctDyeGXzoWsIA2SG8/in
         3zftN7c/XjR9f/4h7ztvED/SFLN6gSfEMHypBNSfu/19yrvYDzNNfqoyp5mSgLVfbalc
         JfaNWCVvSRIlU9NBAmSF0tXFXZTHuRcP/BNJneMQwuz7fID0Ti3YpLqY1ju2bqns0ebE
         EGRtvH7ohDo2WoLHanezjOl5veX4Zu2VVq1toTPVOBulJnwcPY7LwBqO9PnujCOqYmXk
         IekJcUyLzad7jITth24SQhJsQnHiECnsCnZnKZwl/R4nxZW23IiWBYtUR8zi0pY5WfrX
         ywkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fuYnho7BceixiccGG2Tef7UB9DhvI4SCd6j5PSMifHE=;
        b=s8QKGkmXek3S7cKkw+ZA5OyN1Jv8Vf751faLwlNUcr/EHQZ+3U0/Ki34b4KrAC5kh8
         2/sCb7kW3IreeQ6ZQP0eQOg9JtrNJAtPkGRWN3BH5yfylwgf2SBhmUZ7E9InaCpyMH4U
         9cZMJX70KdBU3LjBjj7wXwlSrMFjOQUao2a7oLNxpfxRxWm3vedw7AgjmSfw3DbZWGIX
         AJ0X6qdA0Fvv7BrquFpA/3K0lITAtPkwYyOSufxsqXI1SN5FTmOrCEzwug19wAIqtlp/
         KLQNZz4oct3U/Fx6jIb6w5z011jIKvlim9dJTyqAIzcqP652EqUWlwUblRgJ5X1g+0M/
         nCOQ==
X-Gm-Message-State: APzg51CetT3T156Nipty8EKBEzK333J3JIhudrMA3z5gbkn3J8dTZeHe
        mvBzeVEwYwE5HvoqwMRj3Dpknz0J4kE=
X-Google-Smtp-Source: ANB0VdbPkwYXt1IdApY7+P0Y1+jSMY4alIBRSjSdiXGWIdyZhAZ7sKyRugCrmBGew502LyXVkL2pFQ==
X-Received: by 2002:a5d:428a:: with SMTP id k10-v6mr31875480wrq.225.1537390913465;
        Wed, 19 Sep 2018 14:01:53 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e141-v6sm9068131wmd.32.2018.09.19.14.01.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 14:01:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] gc: fix regression in 7b0f229222 impacting --quiet
Date:   Wed, 19 Sep 2018 21:01:38 +0000
Message-Id: <20180919210138.31940-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a regression in my recent 7b0f229222 ("commit-graph write: add
progress output", 2018-09-17), the newly added progress output for
"commit-graph write" didn't check the --quiet option.

Do so, and add a test asserting that this works as expected. Since the
TTY perquisite isn't available everywhere let's add a version of this
that both requires and doesn't require that. This test might be overly
specific and will break if new progress output is added, but I think
it'll serve as a good reminder to test the undertested progress
mode(s).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c  |  2 +-
 t/t6500-gc.sh | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 06ddd3aea5..91ffb1a803 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -647,7 +647,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 
 	if (gc_write_commit_graph)
 		write_commit_graph_reachable(get_object_directory(), 0,
-					     !daemonized);
+					     !quiet && !daemonized);
 
 	if (auto_gc && too_many_loose_objects())
 		warning(_("There are too many unreachable loose objects; "
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 818435f04e..6183702c30 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -4,6 +4,7 @@ test_description='basic git gc tests
 '
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
 
 test_expect_success 'setup' '
 	# do not let the amount of physical memory affects gc
@@ -99,6 +100,26 @@ test_expect_success 'auto gc with too many loose objects does not attempt to cre
 	test_line_count = 2 new # There is one new pack and its .idx
 '
 
+test_expect_success 'gc --no-quiet' '
+	git -c gc.writeCommitGraph=true gc --no-quiet >stdout 2>stderr &&
+	! test -s stdout &&
+	test_line_count = 1 stderr &&
+	test_i18ngrep "Computing commit graph generation numbers" stderr
+'
+
+test_expect_success TTY 'with TTY: gc --no-quiet' '
+	test_terminal git -c gc.writeCommitGraph=true gc --no-quiet >stdout 2>stderr &&
+	! test -s stdout &&
+	test_i18ngrep "Enumerating objects" stderr &&
+	test_i18ngrep "Computing commit graph generation numbers" stderr
+'
+
+test_expect_success 'gc --quiet' '
+	git -c gc.writeCommitGraph=true gc --quiet >stdout 2>stderr &&
+	! test -s stdout &&
+	! test -s stderr
+'
+
 run_and_wait_for_auto_gc () {
 	# We read stdout from gc for the side effect of waiting until the
 	# background gc process exits, closing its fd 9.  Furthermore, the
-- 
2.19.0.444.g18242da7ef

