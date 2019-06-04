Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AE551F462
	for <e@80x24.org>; Tue,  4 Jun 2019 07:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfFDH0W (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 03:26:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46889 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfFDH0W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 03:26:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id v9so9801791pgr.13
        for <git@vger.kernel.org>; Tue, 04 Jun 2019 00:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kGfWifIbiTUVarhtG1j5WL3SOB5f48KJzQLW2HyyV5Q=;
        b=BuYVqy4lHEVXjaDZVZGrHJ7TQ4Q1tH2kFI0LGRUI64ApVHrS+odMWB/X4kg9LMW17s
         tOi5ps25wKDYNQRr/Hpa96IvnxJhJleYbsDvW19elZC25cOCqxtTc7gYJCKdrhR/u9LL
         CNhQnFowv4iBQEjn5jPo8uKiNPub8rwLUdmVNb6BxAvgT9NPd5q1VeR+taWBfLVeA35i
         +aXBy9riexxYM/OobKDCz+riFI/0NmE/Nz4iK/D13yyeyDc6m49Qj5XPWSUtJc+N1q8G
         yGMFXySkX9b/SL1/9tEaRPrAEXfgyCGHedN/v2ACGdDSd/MkVwNDqtv4QvWt6nOnTr/g
         ZEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kGfWifIbiTUVarhtG1j5WL3SOB5f48KJzQLW2HyyV5Q=;
        b=HLSA+HT0YEiRVdoAkxDr6WPsWm2/Nar5yPV5dO4VrQGQVxYXs+cMC+CIKo7rLydYvu
         DlQUDqwfiEvk1jxIxHoQWCFXM/uFN5FpTcbScb7qDtNYVkzcdPhyV+QfuA7WMp9PDVLF
         Rd8Dj/JH6jW8LOfZLw9pedauf1brQZUrGCt4rPTUipqq+y+5dPKUBgvXHlQMKn4uunhs
         65O5Dy4hN2Vw+iJKn4w7ArOsu66nyqOiOniVVxqYVd7ulZ717PVv+WJPCgui1esP4JNo
         j3OtPxZNfWfJqgErJuetclpLIFG6QpOnOiR8DhAIx/N8PSHFrIiI8k0PoAkHrP+jtVf4
         Sn2Q==
X-Gm-Message-State: APjAAAV6zibgnkoUA0Vp9pMHl9/05AGLSVVUkwUOw9Eow9A5/o6MPpve
        DIlTvQwQfwwqCoXZEhL19rk=
X-Google-Smtp-Source: APXvYqyxkv14LC05Iec8XruaymwHPMyCUosi3t4pOoQq4KDEqJXs/VzuRTYMvXYYkeMxFr6d9zVi2Q==
X-Received: by 2002:a63:81c2:: with SMTP id t185mr34054660pgd.257.1559633181084;
        Tue, 04 Jun 2019 00:26:21 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id 10sm2264460pfh.179.2019.06.04.00.26.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Jun 2019 00:26:20 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        ben.humphreys@atlassian.com, Elijah Newren <newren@gmail.com>,
        Ben Humphreys <behumphreys@atlassian.com>
Subject: [PATCH] merge-recursive: restore accidentally dropped setting of path
Date:   Tue,  4 Jun 2019 00:26:14 -0700
Message-Id: <20190604072614.26885-1-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.rc3.1.ga9f0f4db9e
In-Reply-To: <20190604023039.GR951@szeder.dev>
References: <20190604023039.GR951@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 3, 2019 at 7:30 PM SZEDER Gábor <szeder.dev@gmail.com> wrote:
>
> On Tue, Jun 04, 2019 at 11:32:24AM +1000, Ben Humphreys wrote:
> > Hi folks,
> >
> > I’m one of the Bitbucket Server developers and I just wanted to let
> > you know of one of our test cases that is now failing on the 2.22.0
> > release candidates (tested rc2 and rc3). I’m still looking into it,
> > but figure the release is probably imminent so worth reporting sooner
> > than later.
> >
> > The problem seems to be related to some recent changes in
> > merge-recursive.c. I’ve made available our test dataset and the
> > following steps will reproduce the problem:
> >
> > $ git --version
> > git version 2.22.0.rc3
> >
> > $ git clone https://bitbucket.org/ben_humphreys/merge-dataset.git
> > $ cd merge-dataset
> > $ git checkout branch_that_has_rename_add_triggering_content_conflict_trgt
> > $ git merge origin/branch_that_has_rename_add_triggering_content_conflict_src
> > Assertion failed: (a->path && b->path), function merge_3way, file
> > merge-recursive.c, line 1044.
> > Abort trap: 6
> >
> > The assertion is failing because b->path is null:
> >
> > (lldb) print a->path
> > (char *const) $2 = 0x00007f8e177025f8 "count.txt"
> > (lldb) print b->path
> > (char *const) $3 = 0x0000000000000000 <no value available>
>
> merge_3way() is called from merge_mode_and_contents(), which in turn
> is called from handle_rename_add(), which was modified in 8daec1df03
> (merge-recursive: switch from (oid,mode) pairs to a diff_filespec,
> 2019-04-05) like this:
>
> > diff --git a/merge-recursive.c b/merge-recursive.c
> > index ada1c19ed2..1d2c9e1772 100644
> > --- a/merge-recursive.c
> > +++ b/merge-recursive.c
> >
> > @@ -1654,7 +1625,6 @@ static int handle_rename_add(struct merge_options *opt,
> >       /* a was renamed to c, and a separate c was added. */
> >       struct diff_filespec *a = ci->ren1->pair->one;
> >       struct diff_filespec *c = ci->ren1->pair->two;
> > -     struct diff_filespec tmp;
> >       char *path = c->path;
> >       char *prev_path_desc;
> >       struct merge_file_info mfi;
> > @@ -1669,23 +1639,21 @@ static int handle_rename_add(struct merge_options *opt,
> >              a->path, c->path, rename_branch,
> >              c->path, add_branch);
> > 
> > -     filespec_from_entry(&tmp, ci->ren1->src_entry, other_stage);
> > -     tmp.path = a->path;
>
> Note that 'tmp.path' used to be set ...
>
> > -
> >       prev_path_desc = xstrfmt("version of %s from %s", path, a->path);
> > -     if (merge_mode_and_contents(opt, a, c, &tmp,
>
> ... and that this 'tmp' used to become 'b' in
> merge_mode_and_contents() and then in merge_3way().
>
> > +     if (merge_mode_and_contents(opt, a, c,
> > +                                 &ci->ren1->src_entry->stages[other_stage],
> >                                   prev_path_desc,
> >                                   opt->branch1, opt->branch2,
> >                                   1 + opt->call_depth * 2, &mfi))
> >               return -1;
> >       free(prev_path_desc);
>
>
> This one-liner patch below the issue, the merge fails with conflicts
> as expected, but, honestly, I have no idea what I am doing :)  At
> least the test suite still passes, but that might not mean all that
> much since it missed this issue in the first place...
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index a7bcfcbeb4..d2e380b7ed 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1660,6 +1660,7 @@ static int handle_rename_add(struct merge_options *opt,
>                c->path, add_branch);
>
>         prev_path_desc = xstrfmt("version of %s from %s", path, a->path);
> +       ci->ren1->src_entry->stages[other_stage].path = a->path;
>         if (merge_mode_and_contents(opt, a, c,
>                                     &ci->ren1->src_entry->stages[other_stage],
>                                     prev_path_desc,
>
>

This analysis and patch are correct; I somehow deleted the setting of the
path here in what should have been a straightforward conversion.

I've tried to look through every other callsite to merge_3way to see
if any others fail to set the paths; there's a dozen or two of them.
I think this was the only one that was missed, but honestly I'm
exhausted right now and not sure I'm thinking straight.  So I'll
recheck tomorrow and do a bunch more testing.

Of course, this wasn't the only bug; it also showed we had a glaring
whole in our test coverage -- there's a dearth of tests for rename/add
conflicts, and in particular none involving content merges for the
rename side.  So, I created a patch which adds some tests for that
(which triggered the assertion error).  I pulled SZEDER's fix into the
same patch and added a commit message explaining the issue, using a
Based-on-patch-by tag for the fix.  SZEDER: if you'd like to see this
in a different format (maybe I add tests which show the error and then
in a separate patch authored by you we introduce your fix?), just let
me know.

Since we're at -rc3 already, even if it is a trivial patch, I'm going to
try to re-analyze it all tomorrow to make sure I didn't miss anything and
see if I can find more tests to throw at it.

Ben: Could you rerun all your special testcases to make sure things
are good with this patch too?  It'd be much appreciated.

Thanks Ben for reporting and SZEDER for jumping on and analyzing and
cc'ing me.

Sorry for the headache folks,
Elijah


-- 8< --
Subject: [PATCH] merge-recursive: restore accidentally dropped setting of path

In commit 8daec1df03de ("merge-recursive: switch from (oid,mode) pairs
to a diff_filespec", 2019-04-05), we actually switched from
(oid,mode,path) triplets to a diff_filespec -- but most callsites in the
patch only needed to worry about oid and mode so the commit message
focused on that.  The oversight in the commit message apparently spilled
over to the code as will; one of the dozen or so callsites accidentally
dropped the setting of the path in the conversion.  Restore the path
setting in that location.

Also, this pointed out that our testsuite was lacking a good rename/add
test, at least one that involved the need for merge content with the
rename.  Add such a test, and since rename/add vs. add/rename could
possibly be important, redo the merge the opposite direction to make
sure we don't have issues with the direction of the merge.  These
testcases failed before restoring the setting of path, but with the
paths appropriately set the testcases both pass.

Reported-by: Ben Humphreys <behumphreys@atlassian.com>
Based-on-patch-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                    |   1 +
 t/t6042-merge-rename-corner-cases.sh | 118 +++++++++++++++++++++++++++
 2 files changed, 119 insertions(+)

diff --git a/merge-recursive.c b/merge-recursive.c
index a7bcfcbeb4..d2e380b7ed 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1660,6 +1660,7 @@ static int handle_rename_add(struct merge_options *opt,
 	       c->path, add_branch);
 
 	prev_path_desc = xstrfmt("version of %s from %s", path, a->path);
+	ci->ren1->src_entry->stages[other_stage].path = a->path;
 	if (merge_mode_and_contents(opt, a, c,
 				    &ci->ren1->src_entry->stages[other_stage],
 				    prev_path_desc,
diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index 09dfa8bd92..0793f64099 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -411,6 +411,124 @@ test_expect_success 'disappearing dir in rename/directory conflict handled' '
 	)
 '
 
+# Test for basic rename/add-dest conflict, with rename needing content merge:
+#   Commit O: a
+#   Commit A: rename a->b, modifying b too
+#   Commit B: modify a, add different b
+
+test_expect_success 'setup rename-with-content-merge vs. add' '
+	test_create_repo rename-with-content-merge-and-add &&
+	(
+		cd rename-with-content-merge-and-add &&
+
+		test_seq 1 5 >a &&
+		git add a &&
+		git commit -m O &&
+		git tag O &&
+
+		git checkout -b A O &&
+		git mv a b &&
+		test_seq 0 5 >b &&
+		git add b &&
+		git commit -m A &&
+
+		git checkout -b B O &&
+		echo 6 >>a &&
+		echo hello world >b &&
+		git add a b &&
+		git commit -m B
+	)
+'
+
+test_expect_success 'handle rename-with-content-merge vs. add' '
+	(
+		cd rename-with-content-merge-and-add &&
+
+		git checkout A^0 &&
+
+		test_must_fail git merge -s recursive B^0 >out &&
+		test_i18ngrep "CONFLICT (rename/add)" out &&
+
+		git ls-files -s >out &&
+		test_line_count = 2 out &&
+		git ls-files -u >out &&
+		test_line_count = 2 out &&
+		git ls-files -u b >out &&
+		test_line_count = 2 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
+
+		test_path_is_missing a &&
+		test_path_is_file b &&
+
+		test_seq 0 6 >tmp &&
+		git hash-object tmp >expect &&
+		git rev-parse B:b >>expect &&
+		git rev-parse >actual  \
+			:2:b    :3:b   &&
+		test_cmp expect actual &&
+
+		# Test that the two-way merge in b is as expected
+		git cat-file -p :2:b >>ours &&
+		git cat-file -p :3:b >>theirs &&
+		>empty &&
+		test_must_fail git merge-file \
+			-L "HEAD" \
+			-L "" \
+			-L "B^0" \
+			ours empty theirs &&
+		git hash-object b >actual &&
+		git hash-object ours >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'handle rename-with-content-merge vs. add, merge other way' '
+	(
+		cd rename-with-content-merge-and-add &&
+
+		git reset --hard &&
+		git clean -fdx &&
+
+		git checkout B^0 &&
+
+		test_must_fail git merge -s recursive A^0 >out &&
+		test_i18ngrep "CONFLICT (rename/add)" out &&
+
+		git ls-files -s >out &&
+		test_line_count = 2 out &&
+		git ls-files -u >out &&
+		test_line_count = 2 out &&
+		git ls-files -u b >out &&
+		test_line_count = 2 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
+
+		test_path_is_missing a &&
+		test_path_is_file b &&
+
+		test_seq 0 6 >tmp &&
+		git rev-parse B:b >expect &&
+		git hash-object tmp >>expect &&
+		git rev-parse >actual  \
+			:2:b    :3:b   &&
+		test_cmp expect actual &&
+
+		# Test that the two-way merge in b is as expected
+		git cat-file -p :2:b >>ours &&
+		git cat-file -p :3:b >>theirs &&
+		>empty &&
+		test_must_fail git merge-file \
+			-L "HEAD" \
+			-L "" \
+			-L "A^0" \
+			ours empty theirs &&
+		git hash-object b >actual &&
+		git hash-object ours >expect &&
+		test_cmp expect actual
+	)
+'
+
 # Test for all kinds of things that can go wrong with rename/rename (2to1):
 #   Commit A: new files: a & b
 #   Commit B: rename a->c, modify b
-- 
2.22.0.rc3.1.g617c1f72bf

