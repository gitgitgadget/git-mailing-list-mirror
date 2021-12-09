Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3CDC4332F
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 05:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbhLIFQB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbhLIFPw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 00:15:52 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B32CC0617A2
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 21:12:19 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id h16so4298732ila.4
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 21:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ua7VrwBCMNmR9Jsmwcketb5DGlZFQ2af8zn1DsyiYGs=;
        b=HK/hAtMmE9f073CMHYmzjdi1bpMjWhSl1ifkcbvC0QYQNjLCSadE6tM6P3Bz+7AtOV
         6s8SAd5zpRuo0WQGXtZB9RYoJGPuObrhy8D+pcuU3IDj4vedGyA90nb4IBfEg5xKGbxM
         6FdgAGUN1+zTNcdHd1rH1JP2zhBddruBLEmDqffePd+txyYJvoZ+Pszwt6qjOrTuRlzm
         7wGej2z7IOkmhYWMR+iBJ7UXgEoyfh4A4OJ4YMyDpAZkMQJIhmGXRcpfy+V5k8yPlLHU
         qaK7L9wmJmoyHDFtL5xl38QKJ634/2RGyztoTjgJxobItmhIeLRzYVZPH4jGEVCst9MQ
         ZZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Ua7VrwBCMNmR9Jsmwcketb5DGlZFQ2af8zn1DsyiYGs=;
        b=HqOjaESYMi8Q8GDgZx4elkOJeQze2K8IRrvDgs5Hwv0PO0f5wgfqtJiJFBeyFMmN9Q
         C+JIvhVbQ5/3u+6NErIXqu0K2kAvfMkdSQYr3PxbmItaITzs7/ayI9zipisVPzsXIrpW
         pHTmvutZQzCuWH/K4n11dXQQ6tqpstPUikZebn0dvF368lBjk49Ed7HgAV62NqWY5vDI
         KUdBQSRy0oHtcJGJSPyy7Ont7mFwDxlA3hjqV8z8Xt2iks5aifOl8jbA4FpAMPpjhJXK
         qwMVTChWBw4CmXRdDAquosvfRycC+2c/54HUpLMwTFtWR4tzG9c0DCIErSWEkSJHeIxd
         qIDg==
X-Gm-Message-State: AOAM5318Xal0wOlMoA1A5MGyhLFVYe8C+ASJDFGJnZ22zKyqm54iysTy
        pUFGi7R0UhNnrueJV1YwzaTdYY984tSpjQ==
X-Google-Smtp-Source: ABdhPJwRVJwAjVKVwXrQzYo4ka3TLNfdvhu+PkXTesLrNrdl7Mu5sYj2bA+aH++iHhKP+51cee1IHw==
X-Received: by 2002:a92:c54d:: with SMTP id a13mr12186618ilj.143.1639026738482;
        Wed, 08 Dec 2021 21:12:18 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id b8sm3127401iow.2.2021.12.08.21.12.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Dec 2021 21:12:18 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <ericsunshine@gmail.com>
Subject: [PATCH 14/19] tests: apply modern idiom for exiting loop upon failure
Date:   Thu,  9 Dec 2021 00:11:10 -0500
Message-Id: <20211209051115.52629-15-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd
In-Reply-To: <20211209051115.52629-1-sunshine@sunshineco.com>
References: <20211209051115.52629-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rather than maintaining a flag indicating a failure within a loop and
aborting the test when the loop ends if the flag is set, modern practice
is to signal the failure immediately by exiting the loop early via
`return 1` (or `exit 1` if inside a subshell). Simplify these loops by
following the modern idiom.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t1050-large.sh                | 26 ++++++++------------------
 t/t5505-remote.sh               |  6 ++----
 t/t9400-git-cvsserver-server.sh |  5 ++---
 3 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 99ff2866b7..0e4267c723 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -51,27 +51,21 @@ EOF
 test_expect_success 'add a large file or two' '
 	git add large1 huge large2 &&
 	# make sure we got a single packfile and no loose objects
-	bad= count=0 idx= &&
+	count=0 idx= &&
 	for p in .git/objects/pack/pack-*.pack
 	do
 		count=$(( $count + 1 )) &&
-		if test_path_is_file "$p" &&
-		   idx=${p%.pack}.idx && test_path_is_file "$idx"
-		then
-			continue
-		fi
-		bad=t
+		test_path_is_file "$p" &&
+		idx=${p%.pack}.idx &&
+		test_path_is_file "$idx" || return 1
 	done &&
-	test -z "$bad" &&
 	test $count = 1 &&
 	cnt=$(git show-index <"$idx" | wc -l) &&
 	test $cnt = 2 &&
 	for l in .git/objects/$OIDPATH_REGEX
 	do
-		test_path_is_file "$l" || continue
-		bad=t
+		test_path_is_missing "$l" || return 1
 	done &&
-	test -z "$bad" &&
 
 	# attempt to add another copy of the same
 	git add large3 &&
@@ -79,14 +73,10 @@ test_expect_success 'add a large file or two' '
 	for p in .git/objects/pack/pack-*.pack
 	do
 		count=$(( $count + 1 )) &&
-		if test_path_is_file "$p" &&
-		   idx=${p%.pack}.idx && test_path_is_file "$idx"
-		then
-			continue
-		fi
-		bad=t
+		test_path_is_file "$p" &&
+		idx=${p%.pack}.idx &&
+		test_path_is_file "$idx" || return 1
 	done &&
-	test -z "$bad" &&
 	test $count = 1
 '
 
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index e6e3c8f552..5ef8db481c 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -1332,7 +1332,6 @@ test_expect_success 'unqualified <dst> refspec DWIM and advice' '
 	(
 		cd test &&
 		git tag -a -m "Some tag" some-tag main &&
-		exit_with=true &&
 		for type in commit tag tree blob
 		do
 			if test "$type" = "blob"
@@ -1348,9 +1347,8 @@ test_expect_success 'unqualified <dst> refspec DWIM and advice' '
 				push origin $oid:dst 2>err &&
 			test_i18ngrep "error: The destination you" err &&
 			test_i18ngrep ! "hint: Did you mean" err ||
-			exit_with=false
-		done &&
-		$exit_with
+			exit 1
+		done
 	)
 '
 
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 17f988edd2..a6a73effde 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -350,10 +350,9 @@ test_expect_success 'cvs update (subdirectories)' \
 	test_cmp "$dir/$filename" "../$dir/$filename"; then
         :
       else
-        echo >failure
+        exit 1
       fi
-    done) &&
-   test ! -f failure'
+    done)'
 
 cd "$WORKDIR"
 test_expect_success 'cvs update (delete file)' \
-- 
2.34.1.307.g9b7440fafd

