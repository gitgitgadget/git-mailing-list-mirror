Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E67B21FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 23:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753237AbdC1XJo (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 19:09:44 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:35934 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752735AbdC1XJn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 19:09:43 -0400
Received: by mail-it0-f49.google.com with SMTP id e75so74301134itd.1
        for <git@vger.kernel.org>; Tue, 28 Mar 2017 16:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AdDP8w2m36aTPUQcGL5W5vMV9l/GG4D8XOKXvr3Wv3g=;
        b=ZTq5FO4cyW5x+9cPPVHrj/EJW4ushF3hItfNTSp05vCz45VaU6gsIfjh6XdtkE+yT6
         hjT1IavgGnkfz4gPBF0ps4TIUWxMCusyiCLPsTucssj4ZtPohvucLgkaxi8+Lr/5vmLE
         M/xIDr0wv1JeDPnDGp/qOMcmMxP2QhJs8WDelNZ13UDmobauk1/ZB8EnCJOz94AJKu0x
         6Vi5+YG5k6CzsSAB+RoA2RFyzIOjWih11qUxdGfq7ME/KpTK4BW4CNYsS7jiXOI3salP
         VqSyjYSfTRUcdf0KpIR7nHYNpBN9Sbm9Y45/i8tpQBaUEOHjN4lXNIvCtQFyXZagfaOQ
         +5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AdDP8w2m36aTPUQcGL5W5vMV9l/GG4D8XOKXvr3Wv3g=;
        b=TlhEnWl9UdTrIycKZlSmHVYGoijmf3xLrAb6XhB+RlKzb6y8//PtVvQiCx0HDdJ+nj
         v0PSQ9Cpz07qaI0LcFGeu/zsozRtbqZX79XnRh51SatvnkL5q0v59DS1d1JI55wTL0Jf
         3z+Vv5gcWlCo3YZJu2w4nb16DnWAw0dzjcVfyr2dFJQfFaZVw5Tsy6Tv97tNvJoNQPbo
         AA6naLG30xTgbLekeL5zv7H5cnwmzkW6u4jPMVujosfVcnSD7XzD+1nKlB/rWkNkLjBd
         mnFCVvC0vzpyCjX5w8xTAqgsqho2jDEZ52z8pjDnhwM6hVC8wgNgy8mjvEpiDWNrSwUG
         5BaQ==
X-Gm-Message-State: AFeK/H1b04a52YqDhjaP5WkgAPzMQkfXaaiplNP0uxFlSrpB+rItbyQeVpFUYwJ7a/rDF9kV
X-Received: by 10.36.80.85 with SMTP id m82mr19644295itb.23.1490742581453;
        Tue, 28 Mar 2017 16:09:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:29b8:aa7b:3641:fc6b])
        by smtp.gmail.com with ESMTPSA id j2sm2346551itj.30.2017.03.28.16.09.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 28 Mar 2017 16:09:40 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH v8 0/7] short status: improve reporting for submodule changes
Date:   Tue, 28 Mar 2017 16:09:36 -0700
Message-Id: <20170328230938.9887-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.1.438.g67623a8358
In-Reply-To: <20170325003610.15282-1-sbeller@google.com>
References: <20170325003610.15282-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v8:
* This is a resend of the last two patches, i.e. these two patches apply
  at 5c896f7c3ec (origin/sb/submodule-short-status^^)
* below is a diff of this patch series against origin/sb/submodule-short-status
* add tests showing the subtle bug fix in case of nesting.
* add a bit of documentation

v7:
previous work at
https://public-inbox.org/git/20170325003610.15282-1-sbeller@google.com/

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 01b457c322..452c6eb875 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -187,6 +187,8 @@ Submodules have more state and instead report
 		m    the submodule has modified content
 		?    the submodule has untracked files
 
+Note that 'm' and '?' are applied recursively, e.g. if a nested submodule
+in a submodule contains an untracked file, this is reported as '?' as well.
 
 If -b is used the short-format status is preceded by a line
 
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index ab822c79e6..4d6d8f6817 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -327,20 +327,65 @@ test_expect_success 'setup superproject with untracked file in nested submodule'
 		git add sub1 &&
 		git commit -a -m "update sub1 to contain nested sub"
 	) &&
-	echo untracked >super/sub1/sub2/untracked
+	echo "{ \$7=\"HASH\"; \$8=\"HASH\"; print }" >suppress_hashes.awk &&
+	echo "suppress_hashes.awk" >>.git/info/exclude &&
+	echo "output2" >>.git/info/exclude &&
+	echo content >super/sub1/sub2/file &&
+	echo content >super/sub2/file
 '
 
 test_expect_success 'status with untracked file in nested submodule (porcelain)' '
 	git -C super status --porcelain >output &&
 	diff output - <<-\EOF
 	 M sub1
+	 M sub2
+	EOF
+'
+
+test_expect_success 'status with untracked file in nested submodule (porcelain=2)' '
+	git -C super status --porcelain=2 >output &&
+	awk -f suppress_hashes.awk output >output2 &&
+	diff output2 - <<-\EOF
+	1 .M S..U 160000 160000 160000 HASH HASH sub1
+	1 .M S..U 160000 160000 160000 HASH HASH sub2
 	EOF
 '
 
 test_expect_success 'status with untracked file in nested submodule (short)' '
 	git -C super status --short >output &&
 	diff output - <<-\EOF
-	 ? sub1
+	 m sub1
+	 ? sub2
+	EOF
+'
+
+test_expect_success 'setup superproject with modified file in nested submodule' '
+	git -C super/sub1/sub2 add file &&
+	git -C super/sub2 add file
+'
+
+test_expect_success 'status with added file in nested submodule (porcelain)' '
+	git -C super status --porcelain >output &&
+	diff output - <<-\EOF
+	 M sub1
+	 M sub2
+	EOF
+'
+
+test_expect_success 'status with added file in nested submodule (porcelain=2)' '
+	git -C super status --porcelain=2 >output &&
+	awk -f suppress_hashes.awk output >output2 &&
+	diff output2 - <<-\EOF
+	1 .M S.M. 160000 160000 160000 HASH HASH sub1
+	1 .M S.M. 160000 160000 160000 HASH HASH sub2
+	EOF
+'
+
+test_expect_success 'status with added file in nested submodule (short)' '
+	git -C super status --short >output &&
+	diff output - <<-\EOF
+	 m sub1
+	 m sub2
 	EOF
 '
 
