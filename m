Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA11AC4332B
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 12:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 836282072E
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 12:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBNX/xAt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgCVMqo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 08:46:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33341 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgCVMqn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 08:46:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id j1so3343827pfe.0
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 05:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L5A7V8NpNh0ZBjrGfvUO9prVNz/uYfVOA6gCKG/XqGE=;
        b=aBNX/xAt6dlRVp/qPoMQOF4aU6CragetJtoU/OR/QB2Ykx89WPH2ua0eNQrM5BfF58
         QhI0CPbLrSQnYkKMCaNbe64izkzRwhW6Jnx0jNTsHOAM8r5+cB6R9AFM+9Fg6JuxgkG6
         g1U+kdviEfFaZYHA3Ia/TYw2AgHp7JH4VRc1d1cVRPznNzHCFX6Ve1nHtlSLliUrxq2h
         tgWrJagxZydzZxl960LukWxcaMsttzEijs1nRPwjNg6T4EePaxTJ1SJALoIn8Wf2mDyo
         BpNShqXEThdlxxWKwwUhHDg2zQfZsXf+wXOb1AL8yFPd9qZ+M55e216TRwx9fhX2Iuav
         Qa/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L5A7V8NpNh0ZBjrGfvUO9prVNz/uYfVOA6gCKG/XqGE=;
        b=UyjYO7QF7PtKqMYLuNw+Sanouaq47sn+f0NaHu5Cl0+zTm6RkxYsTSUwWwB4P+zRQk
         uXnV5wpzN67r18obZMLB4jynJZnKLtetgVOMkr9ItuEbccJf6FwlCZWSr1yDuoe0ApLf
         ijds19HptlXUehEBi7fFr8uivpy/G64zJPuqZWPyxL2exp5MOkVDl5rpIx/LZtHe3Y/U
         FfTALCuybN9U7GbOVlR8dhCZHfPJnD0aI4aubtCoYyqEl7nF+tRhaqqeUzHhv/U35wRL
         hPH0Jnc7OvXyvOgtJLKg3X1Y/djrK9GUQFzBl4I0NIQmRG61XOkTrD7q4Y60vXdnhIdo
         pMow==
X-Gm-Message-State: ANhLgQ1YkIQu9e/MitfrtdlBlHqnAJJNrqytttN1akVQshi5fnIvB/jV
        FQ8CSoaqxw5f9UJKYp85D3ZV8j/k0kk=
X-Google-Smtp-Source: ADFU+vs7X8lG41iyIj8yvnB0REjA5T+RIg1Rp0hRYRPLBPsCPTqYqktG0HD1gKdczyZeC9E9KVaIGA==
X-Received: by 2002:a63:2447:: with SMTP id k68mr17010482pgk.368.1584881200406;
        Sun, 22 Mar 2020 05:46:40 -0700 (PDT)
Received: from localhost.localdomain ([2409:4071:2285:47f0:d986:c5b7:2058:d4bd])
        by smtp.gmail.com with ESMTPSA id o65sm4129211pfg.187.2020.03.22.05.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 05:46:39 -0700 (PDT)
From:   Shanthanu <shanthanu.s.rai9@gmail.com>
To:     git@vger.kernel.org
Cc:     Shanthanu <shanthanu.s.rai9@gmail.com>
Subject: [GSoC][PATCH 1/1] t9116: avoid using pipes
Date:   Sun, 22 Mar 2020 18:16:19 +0530
Message-Id: <20200322124619.30853-2-shanthanu.s.rai9@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.28.g7fcb965970
In-Reply-To: <20200322124619.30853-1-shanthanu.s.rai9@gmail.com>
References: <20200322124619.30853-1-shanthanu.s.rai9@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit de26f02db1 (t9001, t9116: avoid pipes, 2020-02-14) noticed that
when grepping through the output of a command, there is always a
chance that something could go wrong.

So, redirect the output into a file and grep that file. Thus the log
can be inspected easily if the grep fails.

Signed-off-by: Shanthanu <shanthanu.s.rai9@gmail.com>
---

In test 'test ascending revision range with --show-commit (sha1)',
'out1' variable is used since 'out' variable was already in use. 

 t/t9116-git-svn-log.sh | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/t/t9116-git-svn-log.sh b/t/t9116-git-svn-log.sh
index 0a9f1ef366..d82aa0fab9 100755
--- a/t/t9116-git-svn-log.sh
+++ b/t/t9116-git-svn-log.sh
@@ -61,12 +61,14 @@ printf 'r1 \nr2 \nr4 \n' > expected-range-r1-r2-r4
 
 test_expect_success 'test ascending revision range' "
 	git reset --hard origin/trunk &&
-	git svn log -r 1:4 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r1-r2-r4 -
+	git svn log -r 1:4 >out &&
+	grep '^r[0-9]' out | cut -d'|' -f1 | test_cmp expected-range-r1-r2-r4 -
 	"
 
 test_expect_success 'test ascending revision range with --show-commit' "
 	git reset --hard origin/trunk &&
-	git svn log --show-commit -r 1:4 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r1-r2-r4 -
+	git svn log --show-commit -r 1:4 >out &&
+	grep '^r[0-9]' out | cut -d'|' -f1 | test_cmp expected-range-r1-r2-r4 -
 	"
 
 test_expect_success 'test ascending revision range with --show-commit (sha1)' "
@@ -74,7 +76,8 @@ test_expect_success 'test ascending revision range with --show-commit (sha1)' "
 	git svn find-rev r2 >>expected-range-r1-r2-r4-sha1 &&
 	git svn find-rev r4 >>expected-range-r1-r2-r4-sha1 &&
 	git reset --hard origin/trunk &&
-	git svn log --show-commit -r 1:4 | grep '^r[0-9]' | cut -d'|' -f2 >out &&
+	git svn log --show-commit -r 1:4 >out1 &&
+	grep '^r[0-9]' out1 | cut -d'|' -f2 >out &&
 	git rev-parse \$(cat out) >actual &&
 	test_cmp expected-range-r1-r2-r4-sha1 actual
 	"
@@ -83,45 +86,52 @@ printf 'r4 \nr2 \nr1 \n' > expected-range-r4-r2-r1
 
 test_expect_success 'test descending revision range' "
 	git reset --hard origin/trunk &&
-	git svn log -r 4:1 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r4-r2-r1 -
+	git svn log -r 4:1 >out &&
+	grep '^r[0-9]' out | cut -d'|' -f1 | test_cmp expected-range-r4-r2-r1 -
 	"
 
 printf 'r1 \nr2 \n' > expected-range-r1-r2
 
 test_expect_success 'test ascending revision range with unreachable revision' "
 	git reset --hard origin/trunk &&
-	git svn log -r 1:3 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r1-r2 -
+	git svn log -r 1:3 >out &&
+	grep '^r[0-9]' out | cut -d'|' -f1 | test_cmp expected-range-r1-r2 -
 	"
 
 printf 'r2 \nr1 \n' > expected-range-r2-r1
 
 test_expect_success 'test descending revision range with unreachable revision' "
 	git reset --hard origin/trunk &&
-	git svn log -r 3:1 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r2-r1 -
+	git svn log -r 3:1 >out &&
+	grep '^r[0-9]' out | cut -d'|' -f1 | test_cmp expected-range-r2-r1 -
 	"
 
 printf 'r2 \n' > expected-range-r2
 
 test_expect_success 'test ascending revision range with unreachable upper boundary revision and 1 commit' "
 	git reset --hard origin/trunk &&
-	git svn log -r 2:3 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r2 -
+	git svn log -r 2:3 >out &&
+	grep '^r[0-9]' out | cut -d'|' -f1 | test_cmp expected-range-r2 -
 	"
 
 test_expect_success 'test descending revision range with unreachable upper boundary revision and 1 commit' "
 	git reset --hard origin/trunk &&
-	git svn log -r 3:2 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r2 -
+	git svn log -r 3:2 >out &&
+	grep '^r[0-9]' out | cut -d'|' -f1 | test_cmp expected-range-r2 -
 	"
 
 printf 'r4 \n' > expected-range-r4
 
 test_expect_success 'test ascending revision range with unreachable lower boundary revision and 1 commit' "
 	git reset --hard origin/trunk &&
-	git svn log -r 3:4 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r4 -
+	git svn log -r 3:4 >out &&
+	grep '^r[0-9]' out | cut -d'|' -f1 | test_cmp expected-range-r4 -
 	"
 
 test_expect_success 'test descending revision range with unreachable lower boundary revision and 1 commit' "
 	git reset --hard origin/trunk &&
-	git svn log -r 4:3 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r4 -
+	git svn log -r 4:3 >out &&
+	grep '^r[0-9]' out | cut -d'|' -f1 | test_cmp expected-range-r4 -
 	"
 
 printf -- '------------------------------------------------------------------------\n' > expected-separator
@@ -138,12 +148,14 @@ test_expect_success 'test descending revision range with unreachable boundary re
 
 test_expect_success 'test ascending revision range with unreachable boundary revisions and 1 commit' "
 	git reset --hard origin/trunk &&
-	git svn log -r 3:5 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r4 -
+	git svn log -r 3:5 >out &&
+	grep '^r[0-9]' out | cut -d'|' -f1 | test_cmp expected-range-r4 -
 	"
 
 test_expect_success 'test descending revision range with unreachable boundary revisions and 1 commit' "
 	git reset --hard origin/trunk &&
-	git svn log -r 5:3 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r4 -
+	git svn log -r 5:3 >out &&
+	grep '^r[0-9]' out | cut -d'|' -f1 | test_cmp expected-range-r4 -
 	"
 
 test_done
-- 
2.26.0.rc2.28.g7fcb965970

