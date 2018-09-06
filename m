Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EFA61F404
	for <e@80x24.org>; Thu,  6 Sep 2018 15:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbeIFTuH (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 15:50:07 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36397 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730178AbeIFTuH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 15:50:07 -0400
Received: by mail-qk1-f193.google.com with SMTP id 93-v6so7552137qks.3
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 08:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QUf6pXVEl0LAthOaveSYJdOgXGAAslgNRnDjnT74dfE=;
        b=T4+qR+Yk6cps0FO4V0woQlg+I+/1Fyzvf9/xkuoPiYlUJlxJ5mmHRKSYDKnsx4n0ys
         STqeg8eyBN2R2inIY2dxBjX9NuLBF0MgJZhQv4wWhJ20qQfoY8fz2Gl3kKq5gX1ZxaNp
         08cSmcZrwAQg531QfChIhL5yMGisool46x/OpbbgRaj4N0CzNKYCP8g3Xe3CJ0mRKipW
         pnWA+UZVnUHTZu1BQaTxWwwLplOn94pX0pQJkW4N7E85If8LgYqdNkpsABdvRk2ZSibU
         1uJEKg8lSIn9beyr505ABialqpQwJHrljQKsGa88eTXGikz3feMdnjay/x8QMlvxXA6Q
         2Cgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QUf6pXVEl0LAthOaveSYJdOgXGAAslgNRnDjnT74dfE=;
        b=sP6zofzXHuI/Pb/oBo8T1oa7+NthDmuNYJVSxeikKFHTGJyIEznCQiVfxOlc/vdixO
         fmRc9RxZmr/fSIJKAG2+xt017KAk68Cj6dNyxJ/lZhIW0V9VWxWVsXXyXdAvuZp3EDpl
         +MOru83XhR3/gN5Wgctjl+znf/K+P2xkRkL7MGO6EZJjhWSO8aIsnR8DHj0artGubrS0
         nvYc546D/soss5oeRQ4Kk1pn/u+Opvh/DJxJ2Vyn/XlY1fQD5RRGHFW1rUrDgcNY6Lx2
         5xUGekkV0GcCXw0siJj/8q1uRvXsLrdXzxN9z5/WDREwWQHF+/DN0iDKArOhIRMdhwrb
         1phA==
X-Gm-Message-State: APzg51CyqopKwp5Nt9kB4CrKG/TiuEYox6vPBp7T3RYfMkSQej+GkRp4
        gnFMn9+707QoajlW6mMU85cPbg0g
X-Google-Smtp-Source: ANB0VdaHf7TwJCJKyFxDx9s/0AyIijmuCDtjgNmOGLdURxubF6HbPvwn5Fw6ueXe8iXWZx5cXXQnhg==
X-Received: by 2002:a37:60c4:: with SMTP id u187-v6mr2287800qkb.143.1536246847707;
        Thu, 06 Sep 2018 08:14:07 -0700 (PDT)
Received: from linux.mshome.net ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id z3-v6sm2752030qkc.55.2018.09.06.08.13.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 08:14:01 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, stolee@gmail.com, gitster@pobox.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [RFC PATCH 5/6] test-lib: add run_and_check_trace2
Date:   Thu,  6 Sep 2018 15:13:08 +0000
Message-Id: <20180906151309.66712-6-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180906151309.66712-1-dstolee@microsoft.com>
References: <2ba9d81a-5578-a81c-a7d9-179864cb4277@gmail.com>
 <20180906151309.66712-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The trace2 facility allows tracing category-key-value triples that
we can use to communicate runtime information to a side channel.
One use is to track the number of commits that are walked by a
graph algorithm.

Add run_and_check_trace2 test function to run a given command with
GIT_TR2_PERFORMANCE running. Then, check the output for the
expected category-key-value triple.

Use this function in t6600-test-reach.sh to verify can_all_from_reach
only visits 11 commits in the example.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t6600-test-reach.sh |  6 ++++++
 t/test-lib.sh         | 14 ++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index d139a00d1d..98ad25bb45 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -183,6 +183,12 @@ test_expect_success 'can_all_from_reach:hit' '
 	test_three_modes can_all_from_reach
 '
 
+test_expect_success 'can_all_from_reach:perf' '
+	cp commit-graph-full .git/objects/info/commit-graph &&
+	run_and_check_trace2 can_all_from_reach_with_flag num_walked 40 input \
+		"test-tool reach can_all_from_reach"
+'
+
 test_expect_success 'can_all_from_reach:miss' '
 	cat >input <<-\EOF &&
 	X:commit-2-10
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 8bb0f4348e..9b9f68f324 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1231,3 +1231,17 @@ test_lazy_prereq CURL '
 test_lazy_prereq SHA1 '
 	test $(git hash-object /dev/null) = e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
 '
+
+# Useage: run_and_check_trace2 <category> <key> <value> <file> <command>
+# Run "command <file" with GIT_TR2_PERFORMANCE logging to a file and
+# check that file for a data output matching category.key = value.
+run_and_check_trace2 () {
+	CATEGORY=$1
+	KEY=$2
+	VALUE=$3
+	INPUT=$4
+	COMMAND=$5
+	# GIT_TR2_PERFORMANCE="$(pwd)/perf-log.txt"
+	GIT_TR2_PERFORMANCE="$(pwd)/perf-log.txt" $COMMAND <$INPUT &&
+	cat perf-log.txt | grep "category:$CATEGORY key:$KEY value:$VALUE"
+}
-- 
2.19.0.rc2

