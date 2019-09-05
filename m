Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 284B21F461
	for <e@80x24.org>; Thu,  5 Sep 2019 15:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388218AbfIEPrw (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 11:47:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44484 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733016AbfIEPrv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 11:47:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id q21so1999181pfn.11
        for <git@vger.kernel.org>; Thu, 05 Sep 2019 08:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yafn+37hmpZyxStW4G5RncCd900oBQ0qx42ECk7SDas=;
        b=SX6hyarSmtz73puKXLQ6TyKNAcelAmN58uuUkrlVSqPYQFeGrjUXCqE1IrWkqzZzLs
         it+UxK7HlLcgGo6c8DGYigfCApQ/+l1i3w2ANG56IC/dLq18WSVSyDNxl4DgzISPrOsT
         TeuFIDJrJKKYQnIaQkrPvOoZO5QZ45FWE4g7efsOdSLOIeK/iwPohIcKO3gqtVPjim85
         E5w/j1sedzoc6TTxmstuVehrxLFenG+Cshwzvqjy2nBCz8EfzoE4H/5W40fNE/2K2mSw
         yfS6H0Hg5I4RgiQsvMmc95Fi9reaqPy0jG2W2ToBc/8HBn5UPbgDsOYaDR+ZT+OtBBb/
         MT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yafn+37hmpZyxStW4G5RncCd900oBQ0qx42ECk7SDas=;
        b=sfDJR+zh+kJZ4rDYUgyq6RI2EXcD6S/bX/ZQFKEpz1KywT0XGwUBP9g/nxRzSZ3+8y
         n9MgvZDaElH91i7Wpc2NZcG9nKhzom06jD4C2S7xY4tm+dMZgp/mD0teyWUMuPK02avM
         iXOsF2Sz0W2V1OuIQWC+QNNNdyhDO3HbUnuE3IupcliqJbFjlqI/IrlL/1zfIaZ8crqL
         6M8HrngQU3BUfAnMi00Wzi712JoAacnU7bj17fnwg9eA1dgq2/D/hPVuEDusfTKkRLBw
         +EhY5gI2uKTJuKgGydm6519V1/cay0dS48eKP8Lck/0DZWv5kMm+BgJ1Tjig51G/AW4E
         RWZQ==
X-Gm-Message-State: APjAAAVxUdG3EiQb/bAyTQLn6Is5x3xF07R5V9dBp/xefNVCPmo8yKsa
        4hVcqjnX3eHkhRSg/fqlmy7ZPFoR
X-Google-Smtp-Source: APXvYqxkMPxLYmiQU69Mnu4nykXu2sNTl0djjnRqAztSDt2lEoc1rJbvDmmtOjX7zqhfEZal+n6u3A==
X-Received: by 2002:a62:ee0a:: with SMTP id e10mr4731756pfi.197.1567698470733;
        Thu, 05 Sep 2019 08:47:50 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id x16sm2339867pjn.12.2019.09.05.08.47.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Sep 2019 08:47:50 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH v2 10/12] clean: avoid removing untracked files in a nested git repository
Date:   Thu,  5 Sep 2019 08:47:33 -0700
Message-Id: <20190905154735.29784-11-newren@gmail.com>
X-Mailer: git-send-email 2.22.1.11.g45a39ee867
In-Reply-To: <20190905154735.29784-1-newren@gmail.com>
References: <20190825185918.3909-1-szeder.dev@gmail.com>
 <20190905154735.29784-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Users expect files in a nested git repository to be left alone unless
sufficiently forced (with two -f's).  Unfortunately, in certain
circumstances, git would delete both tracked (and possibly dirty) files
and untracked files within a nested repository.  To explain how this
happens, let's contrast a couple cases.  First, take the following
example setup (which assumes we are already within a git repo):

   git init nested
   cd nested
   >tracked
   git add tracked
   git commit -m init
   >untracked
   cd ..

In this setup, everything works as expected; running 'git clean -fd'
will result in fill_directory() returning the following paths:
   nested/
   nested/tracked
   nested/untracked
and then correct_untracked_entries() would notice this can be compressed
to
   nested/
and then since "nested/" is a directory, we would call
remove_dirs("nested/", ...), which would
check is_nonbare_repository_dir() and then decide to skip it.

However, if someone also creates an ignored file:
   >nested/ignored
then running 'git clean -fd' would result in fill_directory() returning
the same paths:
   nested/
   nested/tracked
   nested/untracked
but correct_untracked_entries() will notice that we had ignored entries
under nested/ and thus simplify this list to
   nested/tracked
   nested/untracked
Since these are not directories, we do not call remove_dirs() which was
the only place that had the is_nonbare_repository_dir() safety check --
resulting in us deleting both the untracked file and the tracked (and
possibly dirty) file.

One possible fix for this issue would be walking the parent directories
of each path and checking if they represent nonbare repositories, but
that would be wasteful.  Even if we added caching of some sort, it's
still a waste because we should have been able to check that "nested/"
represented a nonbare repository before even descending into it in the
first place.  Add a DIR_SKIP_NESTED_GIT flag to dir_struct.flags and use
it to prevent fill_directory() and friends from descending into nested
git repos.

With this change, we also modify two regression tests added in commit
91479b9c72f1 ("t7300: add tests to document behavior of clean and nested
git", 2015-06-15).  That commit, nor its series, nor the six previous
iterations of that series on the mailing list discussed why those tests
coded the expectation they did.  In fact, it appears their purpose was
simply to test _existing_ behavior to make sure that the performance
changes didn't change the behavior.  However, these two tests directly
contradicted the manpage's claims that two -f's were required to delete
files/directories under a nested git repository.  While one could argue
that the user gave an explicit path which matched files/directories that
were within a nested repository, there's a slippery slope that becomes
very difficult for users to understand once you go down that route (e.g.
what if they specified "git clean -f -d '*.c'"?)  It would also be hard
to explain what the exact behavior was; avoid such problems by making it
really simple.

Also, clean up some grammar errors describing this functionality in the
git-clean manpage.

Finally, there is one somewhat related bug which this patch does not
fix, coming from the opposite angle.  If the user runs
   git clean -ffd
to force deletion of untracked nested repositories, and within an
untracked nested repo the user has ignored files (according to the inner
OR outer repositories' .gitignore), then not only will those ignored
files be left alone but the .git/ subdirectory of the nested repo will
be left alone too.  I am not completely sure if this should be
considered a bug (though it seems like it since the lack of the
untracked file would result in the .git/ subdirectory being deleted),
but in any event it is very minor compared to accidentally deleting user
data and I did not dive into it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-clean.txt |  6 +++---
 builtin/clean.c             |  2 ++
 dir.c                       | 10 ++++++++++
 dir.h                       |  3 ++-
 t/t7300-clean.sh            | 10 +++++-----
 5 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 3ab749b921..ba31d8d166 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -37,9 +37,9 @@ OPTIONS
 --force::
 	If the Git configuration variable clean.requireForce is not set
 	to false, 'git clean' will refuse to delete files or directories
-	unless given -f or -i. Git will refuse to delete directories
-	with .git sub directory or file unless a second -f
-	is given.
+	unless given -f or -i.  Git will refuse to modify untracked
+	nested git repositories (directories with a .git subdirectory)
+	unless a second -f is given.
 
 -i::
 --interactive::
diff --git a/builtin/clean.c b/builtin/clean.c
index 68d70e41c0..3a7a63ae71 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -946,6 +946,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 
 	if (force > 1)
 		rm_flags = 0;
+	else
+		dir.flags |= DIR_SKIP_NESTED_GIT;
 
 	dir.flags |= DIR_SHOW_OTHER_DIRECTORIES;
 
diff --git a/dir.c b/dir.c
index 3b2fe1701c..7ff79170fc 100644
--- a/dir.c
+++ b/dir.c
@@ -1451,6 +1451,16 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 		return path_none;
 
 	case index_nonexistent:
+		if (dir->flags & DIR_SKIP_NESTED_GIT) {
+			int nested_repo;
+			struct strbuf sb = STRBUF_INIT;
+			strbuf_addstr(&sb, dirname);
+			nested_repo = is_nonbare_repository_dir(&sb);
+			strbuf_release(&sb);
+			if (nested_repo)
+				return path_none;
+		}
+
 		if (dir->flags & DIR_SHOW_OTHER_DIRECTORIES)
 			break;
 		if (exclude &&
diff --git a/dir.h b/dir.h
index 46c238ab49..739aea7c96 100644
--- a/dir.h
+++ b/dir.h
@@ -156,7 +156,8 @@ struct dir_struct {
 		DIR_SHOW_IGNORED_TOO = 1<<5,
 		DIR_COLLECT_KILLED_ONLY = 1<<6,
 		DIR_KEEP_UNTRACKED_CONTENTS = 1<<7,
-		DIR_SHOW_IGNORED_TOO_MODE_MATCHING = 1<<8
+		DIR_SHOW_IGNORED_TOO_MODE_MATCHING = 1<<8,
+		DIR_SKIP_NESTED_GIT = 1<<9
 	} flags;
 	struct dir_entry **entries;
 	struct dir_entry **ignored;
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 530dfdab34..6e6d24c1c3 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -549,7 +549,7 @@ test_expect_failure 'nested (non-empty) bare repositories should be cleaned even
 	test_path_is_missing strange_bare
 '
 
-test_expect_success 'giving path in nested git work tree will remove it' '
+test_expect_success 'giving path in nested git work tree will NOT remove it' '
 	rm -fr repo &&
 	mkdir repo &&
 	(
@@ -561,7 +561,7 @@ test_expect_success 'giving path in nested git work tree will remove it' '
 	git clean -f -d repo/bar/baz &&
 	test_path_is_file repo/.git/HEAD &&
 	test_path_is_dir repo/bar/ &&
-	test_path_is_missing repo/bar/baz
+	test_path_is_file repo/bar/baz/hello.world
 '
 
 test_expect_success 'giving path to nested .git will not remove it' '
@@ -579,7 +579,7 @@ test_expect_success 'giving path to nested .git will not remove it' '
 	test_path_is_dir untracked/
 '
 
-test_expect_success 'giving path to nested .git/ will remove contents' '
+test_expect_success 'giving path to nested .git/ will NOT remove contents' '
 	rm -fr repo untracked &&
 	mkdir repo untracked &&
 	(
@@ -589,7 +589,7 @@ test_expect_success 'giving path to nested .git/ will remove contents' '
 	) &&
 	git clean -f -d repo/.git/ &&
 	test_path_is_dir repo/.git &&
-	test_dir_is_empty repo/.git &&
+	test_path_is_file repo/.git/HEAD &&
 	test_path_is_dir untracked/
 '
 
@@ -671,7 +671,7 @@ test_expect_success 'git clean -d skips untracked dirs containing ignored files'
 	test_path_is_missing foo/b/bb
 '
 
-test_expect_failure 'git clean -d skips nested repo containing ignored files' '
+test_expect_success 'git clean -d skips nested repo containing ignored files' '
 	test_when_finished "rm -rf nested-repo-with-ignored-file" &&
 
 	git init nested-repo-with-ignored-file &&
-- 
2.22.1.11.g45a39ee867

