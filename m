Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769F6E9270B
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 14:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbjJEOZ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 10:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjJEOXh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 10:23:37 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF682768B
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 00:11:42 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-690b7cb71aeso538092b3a.0
        for <git@vger.kernel.org>; Thu, 05 Oct 2023 00:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696489902; x=1697094702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jqDwfNI603jx7zFqckgWroISo8H1HYm067y3jA6R7SE=;
        b=LQ89AgmJJeWbHwDkmaooI8tbT4YbOKvO+EVmxUplbbWAFcto/6D+nftQoN/CLjg3/9
         8hlhz0ZLZVow0Nl5t127dGO/7snSKKaOyR3k6FhalYdA1HjHd7dUQsWE3HLaMl4cQdA9
         75BkT/STmnbc2EK81qv39jfmdw9SiBRftrSsIfdiGEjl6mwmRgGAMtifjcgNTk9EaOO0
         ec73IAT9QBB43oHwJBSefqnkOiT0xEpIoNnxa316bAFbp0C3QWb8t+8+mdF6wDhw9XZJ
         D9Vszk9aYmJm5OcvCtsniT8T8TcM5ZK9hIhFU9kuEXUgKeUQxdFC3NSwSyrThnbcC7ps
         P2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696489902; x=1697094702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jqDwfNI603jx7zFqckgWroISo8H1HYm067y3jA6R7SE=;
        b=oVqZnzASF+hM5ie1ER9rCV+vKB6oz2FuxECT4ieQT4LWT5Xyu+xKnpkMcxxE4J9hmy
         AIdWauXRw4xX3AwRrunv/+7FEDNR0O0jIFp0IhQCSt8vbf0/ARzndhdBoGRyJjioF0mu
         idMqlVggk5EBoKAhWWUl6Fe3jNOxOT+5DLO/iyrqsJZmUJRA8wThY+H7UgIKqY5COEeZ
         klH0epp+LNSv6/3JOm65AFDTyOwu5ZMBju+o/VCQ3WcVDTItzbGcu91MrNsPsWG/Izg+
         z2Ij0ytIzyBTvek59VlPkLHMBQXlt79NA+rr+M3VTO92ORzbLsE7EHSOQD4jkci2CetW
         PCtw==
X-Gm-Message-State: AOJu0YwYZVPs06YZEzGaeNFEtSTYNE3KboR+mMiml8h4gpK4YefuRuBv
        iDbQ5rkM+QnhjPXzjIAbLYaklQDmI1k=
X-Google-Smtp-Source: AGHT+IF7LtlynCKDlnn2kTHE7ExdzfkPvNmOYmiyvpJv489MakI0CAxpkkrQHIDPSLApbtSXCl0q5A==
X-Received: by 2002:a05:6a00:a1b:b0:68f:cbd3:5b01 with SMTP id p27-20020a056a000a1b00b0068fcbd35b01mr883292pfh.13.1696489901764;
        Thu, 05 Oct 2023 00:11:41 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:6805:207c:11d5:b720:d5d4:b9ba])
        by smtp.gmail.com with ESMTPSA id x27-20020a056a00271b00b006934704bf56sm669730pfv.64.2023.10.05.00.11.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Oct 2023 00:11:41 -0700 (PDT)
From:   Vinayak Dev <vinayakdev.sci@gmail.com>
To:     git@vger.kernel.org
Cc:     Vinayak Dev <vinayakdev.sci@gmail.com>
Subject: [PATCH] t4014: replace "test -f" with "test_path_is_file"
Date:   Thu,  5 Oct 2023 12:41:34 +0530
Message-ID: <20231005071134.43747-1-vinayakdev.sci@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Vinayak Dev <vinayakdev.sci@gmail.com>

Many tests in the codebase use test -[e|f|d].. commands
to check for various conditions. However, the test command
upon failure simply exits with a non-zero exit code(usually 1).
Therefore, replace instances of "test -f" from t/t4014-format-patch.sh
with the function test_path_is_file() defined in t/test-lib-functions.sh
that exits with a debugging-friendly diagnostic message upon failure.

Signed-off-by: Vinayak Dev <vinayakdev.sci@gmail.com>
---
 t/t4014-format-patch.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 0a4ab36c3a..5f7d0836d6 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -763,7 +763,7 @@ test_expect_success 'format-patch from a subdirectory (1)' '
 		false
 		;;
 	esac &&
-	test -f "$filename"
+	test_path_is_file "$filename"
 '
 
 test_expect_success 'format-patch from a subdirectory (2)' '
@@ -782,7 +782,7 @@ test_expect_success 'format-patch from a subdirectory (2)' '
 		;;
 	esac &&
 	basename=$(expr "$filename" : ".*/\(.*\)") &&
-	test -f "sub/$basename"
+	test_path_is_file "sub/$basename"
 '
 
 test_expect_success 'format-patch from a subdirectory (3)' '
@@ -794,7 +794,7 @@ test_expect_success 'format-patch from a subdirectory (3)' '
 		git format-patch -1 -o "$TRASH_DIRECTORY"
 	) &&
 	basename=$(expr "$filename" : ".*/\(.*\)") &&
-	test -f "$basename"
+	test_path_is_file "$basename"
 '
 
 test_expect_success 'format-patch --in-reply-to' '

base-commit: d0e8084c65cbf949038ae4cc344ac2c2efd77415
-- 
2.41.0

