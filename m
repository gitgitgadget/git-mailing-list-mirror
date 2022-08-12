Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BC9C25B08
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 13:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238617AbiHLNwf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 09:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238192AbiHLNwa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 09:52:30 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7986FA9257
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 06:52:28 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o3-20020a17090a0a0300b001f7649cd317so8458948pjo.0
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 06:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc;
        bh=EVsgDIJoUM2KStRWL8g4r0RMnhSC3VAh7si1cEX8iIk=;
        b=kfAUIuXe2mFKHQY5i1/yhVBUdkZ76PIgq+LNq854vJHS4s2jD2SsCqjtSW91N6cc1F
         a8+tjKJWxXip1vKow1T6/krH/DlN/2VXiiO6bpr6AnIiBuKEogm1XiGrUabyFNNMvaht
         afBMJKXVkXCbaSBu+k953XtPGGqcDAd0QbkPZQ7SVhGOHc+QjBrMwhBUMf7jI8ntBCJv
         pTxVepCmb145ht8uBkN1bHX3gvhPakct0QxUIh69+dky2xikBPooyeuBlHRU/8WwWjhB
         DXISKeWqECbjdsmFqmXedYiKi1oQmmBb0kO1Gxpbk9spm08MutPDIo4Q6fE6Oua+z/rX
         pkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=EVsgDIJoUM2KStRWL8g4r0RMnhSC3VAh7si1cEX8iIk=;
        b=B3a8lKEaKwJ/YA9QXPG3M1I+ir264Cntnl5uJNITl0K398FtDDvs7nXi+kZxJeh80+
         1wcHZabBJ5LwxZAocB90ieF6idy2mG9WcLrYVE91ukAwn6u3QXzOddON/Ii+2lqFBNf/
         yfyuJGxJPjD3ggMZHqGvpEfWTAvm51YF2qLzrtvAF1UO07HYB8YH9yMS13/i29Fgj1KM
         yLX5M2nT0DzIjiN8VHupEuCBugkUGSmOJfd7eJWH5YT4fl6EHtRW0Se/KgDErfjob7xo
         B3hcDJPQda90i+glEPpRKuH8DbjM33g9fHQwdCrmwDCjMc35mEB4dLZWhx1jfe82wqV9
         HtQQ==
X-Gm-Message-State: ACgBeo1FVky9E70j/rSXJXvrH4knyVA7gt3Ps2X2yh2b1y1Omk95lPRg
        6e7/g+F5ImItbxKqvZhgKWCv9D5fPlI=
X-Google-Smtp-Source: AA6agR6oQJEWr+de4m0X2IAKO3ilA8eJN4mmzrWEhWEu1485wlRXFb02BSKkWq4y+EC5yX1vSkhpow==
X-Received: by 2002:a17:903:200c:b0:16d:bc14:67e6 with SMTP id s12-20020a170903200c00b0016dbc1467e6mr4111395pla.128.1660312347569;
        Fri, 12 Aug 2022 06:52:27 -0700 (PDT)
Received: from localhost ([113.172.46.62])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902680700b0016cd74dae66sm1767034plk.28.2022.08.12.06.52.26
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 06:52:27 -0700 (PDT)
Date:   Fri, 12 Aug 2022 20:52:24 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Subject: t7527 intermittent failure on macOS APFS and possible fix
Message-ID: <YvZbGAf+82WtNXcJ@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Running t7527 on macOS with encrypted APFS filesystem.
I observes intermittent failure, however, when I manually check the
test cases, they're all passed.

I suspected fileystem caching issue.
I added those sync-s into test steps and the test pass.
I'm not sure if this is the intending "fix" for the tests
since we're testing the fsmonitor with t7527.

Please advise!

P/S: When debugging, I also found out that:
"test-tool fsmonitor-client query" doesn't write the final newline
character, thus making the output harder to read. The diff also have
the final newline added.

----- 8< -------
diff --git a/t/helper/test-fsmonitor-client.c b/t/helper/test-fsmonitor-client.c
index 54a4856c48..98d6cf1440 100644
--- a/t/helper/test-fsmonitor-client.c
+++ b/t/helper/test-fsmonitor-client.c
@@ -55,6 +55,7 @@ static int do_send_query(const char *token)
 
 	write_in_full(1, answer.buf, answer.len);
 	strbuf_release(&answer);
+	write_in_full(1, "\n", 1);
 
 	return 0;
 }
@@ -77,6 +78,7 @@ static int do_send_flush(void)
 
 	write_in_full(1, answer.buf, answer.len);
 	strbuf_release(&answer);
+	write_in_full(1, "\n", 1);
 
 	return 0;
 }
diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 56c0dfffea..3f2cef251d 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -430,6 +430,7 @@ test_expect_success 'edit some files' '
 	edit_files &&
 
 	test-tool fsmonitor-client query --token 0 &&
+	sync &&
 
 	grep "^event: dir1/modified$"  .git/trace &&
 	grep "^event: dir2/modified$"  .git/trace &&
@@ -445,6 +446,7 @@ test_expect_success 'create some files' '
 	create_files &&
 
 	test-tool fsmonitor-client query --token 0 &&
+	sync &&
 
 	grep "^event: dir1/new$" .git/trace &&
 	grep "^event: dir2/new$" .git/trace &&
@@ -459,6 +461,7 @@ test_expect_success 'delete some files' '
 	delete_files &&
 
 	test-tool fsmonitor-client query --token 0 &&
+	sync &&
 
 	grep "^event: dir1/delete$" .git/trace &&
 	grep "^event: dir2/delete$" .git/trace &&
@@ -473,6 +476,7 @@ test_expect_success 'rename some files' '
 	rename_files &&
 
 	test-tool fsmonitor-client query --token 0 &&
+	sync &&
 
 	grep "^event: dir1/rename$"  .git/trace &&
 	grep "^event: dir2/rename$"  .git/trace &&
@@ -490,6 +494,7 @@ test_expect_success 'rename directory' '
 	mv dirtorename dirrenamed &&
 
 	test-tool fsmonitor-client query --token 0 &&
+	sync &&
 
 	grep "^event: dirtorename/*$" .git/trace &&
 	grep "^event: dirrenamed/*$"  .git/trace
@@ -503,6 +508,7 @@ test_expect_success 'file changes to directory' '
 	file_to_directory &&
 
 	test-tool fsmonitor-client query --token 0 &&
+	sync &&
 
 	grep "^event: delete$"     .git/trace &&
 	grep "^event: delete/new$" .git/trace
@@ -516,6 +522,7 @@ test_expect_success 'directory changes to a file' '
 	directory_to_file &&
 
 	test-tool fsmonitor-client query --token 0 &&
+	sync &&
 
 	grep "^event: dir1$" .git/trace
 '
---- >8 --------------

-- 
Danh
