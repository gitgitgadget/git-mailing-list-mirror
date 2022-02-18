Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572BDC433F5
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 17:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbiBRRLU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 12:11:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbiBRRLU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 12:11:20 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D42C53B59
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 09:11:03 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id x5so10806603wrg.13
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 09:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wJevBzooktxUjmnNILAY743f9t+P1mcxh3v384VaHUM=;
        b=qA0G7jW5aENm3YtoSakwfR8cr5Az+hqTjysW2TTbXSkOLoKL/nKBqDfJOssPwSWg74
         I4w8MqwQ0fp8Vkxl1RZ4tvee7rikGWzBywiRDPTSeM1bLbE/TVQWlVCoS29YhOGaa7zf
         Kr851SxWsNSkrz5OHShIkDMJHlHhMlhklJPz3l3FlOuOO4EeUIyJZlr5LxKA4BZ97w5H
         /htnHraqSXA2mkfHkAXE9Uec9BDvWxuUHMV8MaHlKzwvvVtnoqOL+UQw3RLsEWkY0VRG
         0mXhdy1M450phhIZaWqRoqkMSlIww6ciuR59FkdbT4EimyJxy4BFMuwDRzoemf2mzT62
         4fUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wJevBzooktxUjmnNILAY743f9t+P1mcxh3v384VaHUM=;
        b=35HKvw2wB/fVPv2H7/GLeDIFYuPiZZXJSnfYxg5GZ4TTMBFB3QxbQkBxZnO5XgIOoo
         gG9JQ505Axw/J7CnqLg822OWNXTi5jAfF1FcwaeNMgKWXfwyOTGNvS3JCWI81py7e3/M
         xVVK/KNgI0fVOd+g0DIzBk9+GSMxH/OKkCqdg/LAMtZcocf4i3ffvcVleArGC0Ik11Nd
         9BobVwE/8EvAsfkKABtt7cpZAZUPcbx4gwRccRewlROIabXw1gSjn8KxPL83ovcMdZwU
         7iUjzl4fWLk0v5o4YCcCwr9kfvbiDzwwik/MjktwmJqI2Bn69mXCh70NwySJ1FFtaPKd
         l8lA==
X-Gm-Message-State: AOAM5303vKdIYrvkT/X07u7PIKrKMmL9N9l0ClDtrXiXzPbl7gvhrdgf
        POpj+GdiJRRPKr/ShOiEY00=
X-Google-Smtp-Source: ABdhPJxh3tWNSadoyF3vtwp0HZjQJwOxpK8DsYyCdybv39fjp3MwLKwqAwsSmpKmc5zVUUh4B5AvJw==
X-Received: by 2002:a5d:5850:0:b0:1e2:86fd:5aa6 with SMTP id i16-20020a5d5850000000b001e286fd5aa6mr6429235wrf.553.1645204261809;
        Fri, 18 Feb 2022 09:11:01 -0800 (PST)
Received: from localhost.localdomain (176.248.7.93.rev.sfr.net. [93.7.248.176])
        by smtp.gmail.com with ESMTPSA id 14sm12237892wrb.34.2022.02.18.09.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 09:11:01 -0800 (PST)
From:   COGONI Guillaume <cogoni.guillaume@gmail.com>
To:     avarab@gmail.com
Cc:     cogoni.guillaume@gmail.com, git.jonathan.bressat@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, guillaume.cogoni@gmail.com,
        matthieu.moy@univ-lyon1.fr
Subject: [PATCH v2 0/2] replace test [-f|-d] with more verbose functions
Date:   Fri, 18 Feb 2022 18:10:47 +0100
Message-Id: <20220218171049.262341-1-cogoni.guillaume@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <220215.86a6erwzee.gmgdl@evledraar.gmail.com>
References: <220215.86a6erwzee.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On 02/11/2022 at 7:02 PM, Junio ​​C Hamano wrote:

> * introduce test_path_is_symlink and use it appropriately.  This
>   will be a more verbose version of "test -h".

> * introduce test_path_is_file_not_symlink and use it here.

Replace test [-f|-d] in t/t3903-stash.sh by test_path_is_*
Add new functions like test_path_is_* to cover more specifics cases like
symbolic link or file that we explicitly refuse to be symbolic link.

COGONI Guillaume (2):
  t/t3903-stash.sh: replace test [-d|-f] with test_path_is_*
  Add new tests functions like test_path_is_*

 t/t3903-stash.sh        | 21 +++++++++------------
 t/test-lib-functions.sh | 20 ++++++++++++++++++++
 2 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index e8e933dc4e..0ec19a4499 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -390,10 +390,9 @@ test_expect_success SYMLINKS 'stash file to symlink' '
        rm file &&
        ln -s file2 file &&
        git stash save "file to symlink" &&
-       test_path_is_file file &&
+       test_path_is_file_not_symlink file &&
        test bar = "$(cat file)" &&
-       git stash apply &&
-       case "$(ls -l file)" in *" file -> file2") :;; *) false;; esac
+       git stash apply
 '
 
 test_expect_success SYMLINKS 'stash file to symlink (stage rm)' '
@@ -401,10 +400,9 @@ test_expect_success SYMLINKS 'stash file to symlink (stage rm)' '
        git rm file &&
        ln -s file2 file &&
        git stash save "file to symlink (stage rm)" &&
-       test_path_is_file file &&
+       test_path_is_file_not_symlink file &&
        test bar = "$(cat file)" &&
-       git stash apply &&
-       case "$(ls -l file)" in *" file -> file2") :;; *) false;; esac
+       git stash apply
 '
 
 test_expect_success SYMLINKS 'stash file to symlink (full stage)' '
@@ -413,10 +411,9 @@ test_expect_success SYMLINKS 'stash file to symlink (full stage)' '
        ln -s file2 file &&
        git add file &&
        git stash save "file to symlink (full stage)" &&
-       test_path_is_file file &&
+       test_path_is_file_not_symlink file &&
        test bar = "$(cat file)" &&
-       git stash apply &&
-       case "$(ls -l file)" in *" file -> file2") :;; *) false;; esac
+       git stash apply
 '
 
 # This test creates a commit with a symlink used for the following tests
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 85385d2ede..61fc5f37e3 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -856,6 +856,16 @@ test_path_is_file () {
        fi
 }
 
+test_path_is_file_not_symlink () {
+       test "$#" -ne 1 && BUG "1 param"
+       test_path_is_file "$1" &&
+       if ! test ! -h "$1"
+       then
+               echo "$1 is a symbolic link"
+               false
+       fi
+}
+
 test_path_is_dir () {
        test "$#" -ne 1 && BUG "1 param"
        if ! test -d "$1"
@@ -865,6 +875,16 @@ test_path_is_dir () {
        fi
 }
 
+test_path_is_dir_not_symlink () {
+       test "$#" -ne 1 && BUG "1 param"
+       test_path_is_dir "$1" &&
+       if ! test ! -h "$1"
+       then
+               echo "$1 is a symbolic link"
+               false
+       fi
+}
+
 test_path_exists () {
        test "$#" -ne 1 && BUG "1 param"
        if ! test -e "$1"
-- 
2.25.1

