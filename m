Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 532FF20D12
	for <e@80x24.org>; Fri,  2 Jun 2017 11:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751135AbdFBLYo (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 07:24:44 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33466 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751125AbdFBLYn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 07:24:43 -0400
Received: by mail-it0-f65.google.com with SMTP id l145so10595238ita.0
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 04:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B2iZ5I1N4zm1FkVzHT4N3U0QkqpVO8tCoL2qx4Q4DZ0=;
        b=OdfFuXDIca18uTF56GB2dkzWLqVLnso4VUv61H6lcdwPhG2QVXtPb+0GvbXGKyyUbb
         QlMGPGZCBzhy6s0nqqa4dL5fAhhlCMtP6fNTPsnIx9TrZyPGlImmbhJ/qS0U1K190IQu
         3WejJll46xi23byZ3cYHuqOfJw2ygrzwdPmgzVAk6IXCOlS7jY+iGuc6NIxQ0fDLKh2x
         aKqLe4LJEJriZmkGDeBknolekHr1Lggy7cL/VcDA1OsJvg0ZYzMyhzG82YPL296Obq8V
         JB9KHDjAJMmZWw/O2fiIULDjzt9kEvGmkDP3Q0KtxR94YeHHUMvQS2R7eQZijSqHjc4l
         1GCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B2iZ5I1N4zm1FkVzHT4N3U0QkqpVO8tCoL2qx4Q4DZ0=;
        b=dwZ1ep97CysdcKj+sBGrJv/p4o8PscX/aOb//3Cv9dGqe89PUqLXOmsg5qmAUM27BK
         NQzXUjwnP6QQQbLN1HIC4nnDUupd0Bz1C4YzAjVc4VNWVpxVaH69mDjDiYWr/oIqRTXH
         1T/4/Nv5pNUCR3FLn9xzBbKwvA0r2zAKId7oj2RP+47XKpMtVs2ok/QWV1d54qUBFkg4
         hMzUMteapH6C8+bVYYJUtR4eTNWDajG6ZwvRox22bJVmRdGzvakfkvh2M++rlK7ovh52
         XgYAoVEbKouI6mQD4xTCFLe+YyMoumJQB4okeBOF1GcgPUkQiNCAtU5oEhwU3pwPnQoq
         YVWQ==
X-Gm-Message-State: AODbwcAiQM4huh8KQnjw0rjF7zosCCHtoXqobLjNi+bc9Fl2OEDQXevs
        xu+M+PxHnN8rFg==
X-Received: by 10.84.198.3 with SMTP id o3mr102790421pld.60.1496402682404;
        Fri, 02 Jun 2017 04:24:42 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.73.225])
        by smtp.gmail.com with ESMTPSA id a69sm6096063pfg.7.2017.06.02.04.24.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Jun 2017 04:24:41 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, j6t@kdbg.org, christian.couder@gmail.com,
        ramsay@ramsayjones.plus.com, Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH v6 1/2] submodule: fix buggy $path and $sm_path variable's value
Date:   Fri,  2 Jun 2017 16:54:27 +0530
Message-Id: <20170602112428.11131-1-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <48149a4a-c7e3-d70e-7894-369681587372@ramsayjones.plus.com>
References: <48149a4a-c7e3-d70e-7894-369681587372@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to the documentation about git-submodule foreach subcommand's
$path variable:
$path is the name of the submodule directory relative to the superproject

But it was observed when the value of the $path value deviates from this
for the nested submodules when the <command> is run from a subdirectory.
This patch aims for its correction.

Additional test cases added to the submodule-foreach test suite in t7407,
to check the submodule foreach --recursive behavior from a subdirectory
as this was missing from the test suite.

Helped-by: Brandon Williams <bmwill@google.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
 git-submodule.sh             |  2 +-
 t/t7407-submodule-foreach.sh | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index c0d0e9a4c..ea6f56337 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -344,9 +344,9 @@ cmd_foreach()
 				prefix="$prefix$sm_path/"
 				sanitize_submodule_env
 				cd "$sm_path" &&
-				sm_path=$(git submodule--helper relative-path "$sm_path" "$wt_prefix") &&
 				# we make $path available to scripts ...
 				path=$sm_path &&
+				sm_path=$displaypath &&
 				if test $# -eq 1
 				then
 					eval "$1"
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 6ba5daf42..f4e07eee3 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -197,6 +197,39 @@ test_expect_success 'test messages from "foreach --recursive" from subdirectory'
 	test_i18ncmp expect actual
 '
 
+sub1sha1=$(cd clone2/sub1 && git rev-parse HEAD)
+sub2sha1=$(cd clone2/sub2 && git rev-parse HEAD)
+sub3sha1=$(cd clone2/sub3 && git rev-parse HEAD)
+nested1sha1=$(cd clone2/nested1 && git rev-parse HEAD)
+nested2sha1=$(cd clone2/nested1/nested2 && git rev-parse HEAD)
+nested3sha1=$(cd clone2/nested1/nested2/nested3 && git rev-parse HEAD)
+submodulesha1=$(cd clone2/nested1/nested2/nested3/submodule && git rev-parse HEAD)
+
+cat >expect <<EOF
+Entering '../nested1'
+$pwd/clone2-nested1-../nested1-$nested1sha1
+Entering '../nested1/nested2'
+$pwd/clone2/nested1-nested2-../nested1/nested2-$nested2sha1
+Entering '../nested1/nested2/nested3'
+$pwd/clone2/nested1/nested2-nested3-../nested1/nested2/nested3-$nested3sha1
+Entering '../nested1/nested2/nested3/submodule'
+$pwd/clone2/nested1/nested2/nested3-submodule-../nested1/nested2/nested3/submodule-$submodulesha1
+Entering '../sub1'
+$pwd/clone2-foo1-../sub1-$sub1sha1
+Entering '../sub2'
+$pwd/clone2-foo2-../sub2-$sub2sha1
+Entering '../sub3'
+$pwd/clone2-foo3-../sub3-$sub3sha1
+EOF
+
+test_expect_success 'test "submodule foreach --recursive" from subdirectory' '
+	(
+		cd clone2/untracked &&
+		git submodule foreach --recursive "echo \$toplevel-\$name-\$sm_path-\$sha1" >../../actual
+	) &&
+	test_i18ncmp expect actual
+'
+
 cat > expect <<EOF
 nested1-nested1
 nested2-nested2
-- 
2.13.0

