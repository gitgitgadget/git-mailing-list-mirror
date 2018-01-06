Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69EE31F428
	for <e@80x24.org>; Sat,  6 Jan 2018 00:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753399AbeAFAWX (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 19:22:23 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37799 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753071AbeAFAWW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 19:22:22 -0500
Received: by mail-wm0-f67.google.com with SMTP id f140so5224761wmd.2
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 16:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SqHS8y4DalTO6PwCOfz6I7iToiV2Aw+u/iXav2ijltE=;
        b=UqGNEeYVnDOxZTZqD1kyKOax9pcirv4p3w1LN6tlrHRcxUFueESqNeGmFjvxmpAwvh
         56TyiWInYpbVhKVgV+3W3ozVEL9+pGIdTMZ3OzzgwX4jYes2+4sxfmP3LV8U/7XpZZJ7
         tSGUzXQpwgMeDd2rujn1tzc5tBapgEw2tKqJ+CbedEyKzinQZOOFFabRFKsYxoFO2BYu
         M6100ly02Dx7s1Wc88Gk9+EY8scSNi3ruvZ9sGqvBG2fDvFBRlRla/NorHpywYdEcB+4
         sIETve+rJoCNjc2vGHJNRU3VY6d9OKPOGTaE2/jqQEy+AtBLwdarjlttrRoIVJjjdNVv
         MMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SqHS8y4DalTO6PwCOfz6I7iToiV2Aw+u/iXav2ijltE=;
        b=EX5KzoSWZlJzafNDs2/NkMqBXWDJ5yjzDO5Hs9tip06lGyPYFqNF3wcjsDWq//Zp/M
         JnjiuPs2kAa8N5ALC7y1HvtYz99Fv96qj9diqd4vnBs4r+x4j2asenQqpd9ckQzTphGl
         GA26oIp0bcGVXzxEqw+d6VgqgLHlGwkdXJ9TbrgGkplAG172vSm4Ov1bRqYVIuZoSJr7
         xOxR2+lY5T8S8oDO+YHxM0KJbhnZvE/1sE8BTYh6Ca3ykp5e/ySvlZzZxVzlGdaFnLpr
         KRJ6iQLf46clITideWJtiiRqs/7UaFMH+AFtlZW4ju0OGnsl+XxhTIwm3ENLzp9SAEK9
         kZRg==
X-Gm-Message-State: AKGB3mIVHq/gW4/y1uHs6wp6RH4qxQFkRu2ngc8fxj93eB7+JqID0E1C
        3QJn3jV3ubuGCj6RWg2yUpI=
X-Google-Smtp-Source: ACJfBovjnsjUwHd5Wd96slcrLlaSSgnL+ROKNl6XnXsHOTO+qsswx1SSkXX2NXF8gliGITGExYAYyA==
X-Received: by 10.28.130.1 with SMTP id e1mr3230559wmd.55.1515198140857;
        Fri, 05 Jan 2018 16:22:20 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id m127sm4372009wmm.48.2018.01.05.16.22.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 16:22:19 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Reid Price <reid.price@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2] stash: don't delete untracked files that match pathspec
Date:   Sat,  6 Jan 2018 00:24:20 +0000
Message-Id: <20180106002420.10467-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670
In-Reply-To: <20180105200313.GF2641@hank>
References: <20180105200313.GF2641@hank>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently when 'git stash push -- <pathspec>' is used, untracked files
that match the pathspec will be deleted, even though they do not end up
in a stash anywhere.

This is because the original commit introducing the pathspec feature in
git stash push (df6bba0937 ("stash: teach 'push' (and 'create_stash') to
honor pathspec", 2017-02-28)) used the sequence of 'git reset <pathspec>
&& git ls-files --modified <pathspec> | git checkout-index && git clean
<pathspec>'.

The intention was to emulate what 'git reset --hard -- <pathspec>' would
do.  The call to 'git clean' was supposed to clean up the files that
were unstaged by 'git reset'.  This would work fine if the pathspec
doesn't match any files that were untracked before 'git stash push --
<pathspec>'.  However if <pathspec> matches a file that was untracked
before invoking the 'stash' command, all untracked files matching the
pathspec would inadvertently be deleted as well, even though they
wouldn't end up in the stash, and are therefore lost.

This behaviour was never what was intended, only blobs that also end up
in the stash should be reset to their state in HEAD, previously
untracked files should be left alone.

To achieve this, first match what's in the index and what's in the
working tree by adding all changes to the index, ask diff-index what
changed between HEAD and the current index, and then apply that patch in
reverse to get rid of the changes, which includes removal of added
files and resurrection of removed files.

Reported-by: Reid Price <reid.price@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
> Thanks, I'll fill in the gaps, and send a new patch, hopefully over
> the weekend.

Here it is :)

Changes since the previous version:
 - handle binary files correctly and add a test for that
 - updated commit message
 - took back authorship, and added Helped-by: Junio as he mentioned
   would be the best way earlier in the thread.

 git-stash.sh     |  5 ++---
 t/t3903-stash.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 1114005ce2..fc8f8ae640 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -322,10 +322,9 @@ push_stash () {
 
 		if test $# != 0
 		then
-			git reset -q -- "$@"
-			git ls-files -z --modified -- "$@" |
+			git add -u -- "$@" |
 			git checkout-index -z --force --stdin
-			git clean --force -q -d -- "$@"
+			git diff-index -p --cached --binary HEAD -- "$@" | git apply --index -R
 		else
 			git reset --hard -q
 		fi
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 39c7f2ebd7..aefde7b172 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1064,4 +1064,36 @@ test_expect_success 'stash -k -- <pathspec> leaves unstaged files intact' '
 	test foo,bar = $(cat foo),$(cat bar)
 '
 
+test_expect_success 'stash -- <subdir> leaves untracked files in subdir intact' '
+	git reset &&
+	>subdir/untracked &&
+	>subdir/tracked1 &&
+	>subdir/tracked2 &&
+	git add subdir/tracked* &&
+	git stash -- subdir/ &&
+	test_path_is_missing subdir/tracked1 &&
+	test_path_is_missing subdir/tracked2 &&
+	test_path_is_file subdir/untracked &&
+	git stash pop &&
+	test_path_is_file subdir/tracked1 &&
+	test_path_is_file subdir/tracked2 &&
+	test_path_is_file subdir/untracked
+'
+
+test_expect_success 'stash -- <subdir> works with binary files' '
+	git reset &&
+	>subdir/untracked &&
+	>subdir/tracked &&
+	cp "$TEST_DIRECTORY"/test-binary-1.png subdir/tracked-binary &&
+	git add subdir/tracked* &&
+	git stash -- subdir/ &&
+	test_path_is_missing subdir/tracked &&
+	test_path_is_missing subdir/tracked-binary &&
+	test_path_is_file subdir/untracked &&
+	git stash pop &&
+	test_path_is_file subdir/tracked &&
+	test_path_is_file subdir/tracked-binary &&
+	test_path_is_file subdir/untracked
+'
+
 test_done
-- 
2.15.1.620.gb9897f4670

