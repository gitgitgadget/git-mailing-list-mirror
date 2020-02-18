Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D833C34047
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 20:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E662067D
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 20:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAxR67//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgBRUgH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:36:07 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33088 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgBRUgG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 15:36:06 -0500
Received: by mail-wr1-f67.google.com with SMTP id u6so25665561wrt.0
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 12:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dH0yFjIJsmADdqUgo4nlXg/G6GLOCGFqPEzKkGJ2AA8=;
        b=dAxR67//dHHsNB0hlhaVaGFaVoX/l+eoEf5dtgSh/OWeWEeXVSmAJh6uBoKBSWaunA
         EixvFcnz68AeD6lAuq/YDWPS0DjYmvV3hbWFPtlOxkdxbLVEtZI+gV7nit/sskPio6kc
         La6Diraxd+1MP9sb3yDUqGuoHSojdiKFY8inWWVFZhCB48EHmvSQsk+T5UzmdOKLakmf
         t+Lw2/PYmkWRojpXudduqKFyiSEV1nkit2PzbYD/arx0SUrSZF8nwnbRt0BAifRg6ZRi
         0WE9TwuS0mbIIX8jSkWBmEoUkqqMtzmPzpG7L7T2geHetT4rENeUzKIkws0eIZW2u0p0
         5j7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dH0yFjIJsmADdqUgo4nlXg/G6GLOCGFqPEzKkGJ2AA8=;
        b=db6qo0YO4X44Znutnwcdoc535kAYiGE6JveseVuboVstQ6zaUBmMhc6IYjHzUSEurI
         HFW5pQxkz9bnqHyq+d41zaRcaP1uGE72oujyZvM8YbElDj/SLXOKwQH2cA9uRXcjMQYY
         5l4c8TFXt1HGqLu8dJcw0aNQ3PiM91pxOjL1ppYtZuZFTlTvLhax8uyOq6bBhQKCFyeD
         XuSpMnJ3kpHmgsnqwAqiabVhiN+9iTWhrD8usBEnX7sBr8jAi9sSqcT5RIni/EiSaKsX
         Pei6TClPFEOs7KJoY4sPVSfVIfgyrY5IM+9Z2FeFbVGYEEOhdMpwAh128a022CyE4Qu/
         5waQ==
X-Gm-Message-State: APjAAAXDyg3WBUjVMc3vy43PqZYfMO0NE6Xs0KGrd6+BpLVnsClJKS7Q
        wbc8L+sRugW9GXy6gDsEw1fcl79C
X-Google-Smtp-Source: APXvYqwCsBkK0f9LfuAGrSGwXMC0xS3ZXRkw9x3SIb/3mg3LGc/+QjYR+iYXrev84IG4+I9A6rnJ6g==
X-Received: by 2002:adf:f310:: with SMTP id i16mr31848439wro.326.1582058163241;
        Tue, 18 Feb 2020 12:36:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g19sm4226311wmh.36.2020.02.18.12.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 12:36:02 -0800 (PST)
Message-Id: <pull.711.v2.git.git.1582058162095.gitgitgadget@gmail.com>
In-Reply-To: <pull.711.git.git.1581956106255.gitgitgadget@gmail.com>
References: <pull.711.git.git.1581956106255.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 Feb 2020 20:36:01 +0000
Subject: [PATCH v2] check-ignore: fix documentation and implementation to
 match
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

check-ignore has two different modes, and neither of these modes has an
implementation that matches the documentation.  These modes differ in
whether they just print paths or whether they also print the final
pattern matched by the path.  The fix is different for both modes, so
I'll discuss both separately.

=== First (default) mode ===

The first mode is documented as:

    For each pathname given via the command-line or from a file via
    --stdin, check whether the file is excluded by .gitignore (or other
    input files to the exclude mechanism) and output the path if it is
    excluded.

However, it fails to do this because it did not account for negated
patterns.  Commands other than check-ignore verify exclusion rules via
calling

   ... -> treat_one_path() -> is_excluded() -> last_matching_pattern()

while check-ignore has a call path of the form:

   ... -> check_ignore()                    -> last_matching_pattern()

The fact that the latter does not include the call to is_excluded()
means that it is susceptible to to messing up negated patterns (since
that is the only significant thing is_excluded() adds over
last_matching_pattern()).  Unfortunately, we can't make it just call
is_excluded(), because the same codepath is used by the verbose mode
which needs to know the matched pattern in question.  This brings us
to...

=== Second (verbose) mode ===

The second mode, known as verbose mode, references the first in the
documentation and says:

    Also output details about the matching pattern (if any) for each
    given pathname. For precedence rules within and between exclude
    sources, see gitignore(5).

The "Also" means it will print patterns that match the exclude rules as
noted for the first mode, and also print which pattern matches.  Unless
more information is printed than just pathname and pattern (which is not
done), this definition is somewhat ill-defined and perhaps even
self-contradictory for negated patterns: A path which matches a negated
exclude pattern is NOT excluded and thus shouldn't be printed by the
former logic, while it certainly does match one of the explicit patterns
and thus should be printed by the latter logic.

=== Resolution ==

Since the second mode exists to find out which pattern matches given
paths, and showing the user a pattern that begins with a '!' is
sufficient for them to figure out whether the pattern is excluded, the
existing behavior is desirable -- we just need to update the
documentation to match the implementation (i.e. it is about printing
which pattern is matched by paths, not about showing which paths are
excluded).

For the first or default mode, users just want to know whether a pattern
is excluded.  As such, the existing documentation is desirable; change
the implementation to match the documented behavior.

Finally, also adjust a few tests in t0008 that were caught up by this
discrepancy in how negated paths were handled.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    check-ignore: fix handling with negated patterns
    
    Overhauled the commit message to clarify that there are multiple modes
    for check-ignore and how they require different handling.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-711%2Fnewren%2Ffix-check-ignore-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-711/newren/fix-check-ignore-v2
Pull-Request: https://github.com/git/git/pull/711

Range-diff vs v1:

 1:  3fbcc93e8bc ! 1:  1c289cb4d9a check-ignore: fix handling with negated patterns
     @@ -1,13 +1,25 @@
      Author: Elijah Newren <newren@gmail.com>
      
     -    check-ignore: fix handling with negated patterns
     +    check-ignore: fix documentation and implementation to match
      
     -    check-ignore was meant to check ignore rules the same way git status and
     -    other commands would, and to report whether a path is excluded.  It
     -    failed to do this (and generated a few bug reports), however, because it
     -    did not account for negated patterns.
     +    check-ignore has two different modes, and neither of these modes has an
     +    implementation that matches the documentation.  These modes differ in
     +    whether they just print paths or whether they also print the final
     +    pattern matched by the path.  The fix is different for both modes, so
     +    I'll discuss both separately.
      
     -    Commands other than check-ignore verify exclusion rules via calling
     +    === First (default) mode ===
     +
     +    The first mode is documented as:
     +
     +        For each pathname given via the command-line or from a file via
     +        --stdin, check whether the file is excluded by .gitignore (or other
     +        input files to the exclude mechanism) and output the path if it is
     +        excluded.
     +
     +    However, it fails to do this because it did not account for negated
     +    patterns.  Commands other than check-ignore verify exclusion rules via
     +    calling
      
             ... -> treat_one_path() -> is_excluded() -> last_matching_pattern()
      
     @@ -19,20 +31,41 @@
          means that it is susceptible to to messing up negated patterns (since
          that is the only significant thing is_excluded() adds over
          last_matching_pattern()).  Unfortunately, we can't make it just call
     -    is_excluded(), because is_excluded doesn't return the pattern in
     -    question and part of check-ignore's functionality is not just checking
     -    whether one of the patterns matches but returning which one does.
     -
     -    Further, check_ignore() is supposed to handle a --verbose mode, which
     -    was ill-defined for the case of negated patterns: check-ignore was
     -    documented to print just the excluded paths, whereas the --verbose mode
     -    was there to document which patterns were matched by paths.  A path
     -    which matches a negated exclude pattern is NOT excluded and thus
     -    shouldn't be printed by the former logic, while it certainly does match
     -    one of the explicit patterns and thus should be printed by the latter
     -    logic.  Adjust the definition of --verbose to state that it is about
     -    matching patterns INSTEAD of about showing which paths are excluded in
     -    order to resolve this discrepancy.
     +    is_excluded(), because the same codepath is used by the verbose mode
     +    which needs to know the matched pattern in question.  This brings us
     +    to...
     +
     +    === Second (verbose) mode ===
     +
     +    The second mode, known as verbose mode, references the first in the
     +    documentation and says:
     +
     +        Also output details about the matching pattern (if any) for each
     +        given pathname. For precedence rules within and between exclude
     +        sources, see gitignore(5).
     +
     +    The "Also" means it will print patterns that match the exclude rules as
     +    noted for the first mode, and also print which pattern matches.  Unless
     +    more information is printed than just pathname and pattern (which is not
     +    done), this definition is somewhat ill-defined and perhaps even
     +    self-contradictory for negated patterns: A path which matches a negated
     +    exclude pattern is NOT excluded and thus shouldn't be printed by the
     +    former logic, while it certainly does match one of the explicit patterns
     +    and thus should be printed by the latter logic.
     +
     +    === Resolution ==
     +
     +    Since the second mode exists to find out which pattern matches given
     +    paths, and showing the user a pattern that begins with a '!' is
     +    sufficient for them to figure out whether the pattern is excluded, the
     +    existing behavior is desirable -- we just need to update the
     +    documentation to match the implementation (i.e. it is about printing
     +    which pattern is matched by paths, not about showing which paths are
     +    excluded).
     +
     +    For the first or default mode, users just want to know whether a pattern
     +    is excluded.  As such, the existing documentation is desirable; change
     +    the implementation to match the documented behavior.
      
          Finally, also adjust a few tests in t0008 that were caught up by this
          discrepancy in how negated paths were handled.


 Documentation/git-check-ignore.txt | 12 ++++++---
 builtin/check-ignore.c             |  3 +++
 t/t0008-ignores.sh                 | 39 ++++++++++++++++++------------
 3 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
index 8b2d49c79e1..85ef46e2eff 100644
--- a/Documentation/git-check-ignore.txt
+++ b/Documentation/git-check-ignore.txt
@@ -30,9 +30,15 @@ OPTIONS
 	valid with a single pathname.
 
 -v, --verbose::
-	Also output details about the matching pattern (if any)
-	for each given pathname. For precedence rules within and
-	between exclude sources, see linkgit:gitignore[5].
+	Instead of printing the paths that are excluded, for each path
+	that matches an exclude pattern print the exclude pattern
+	together with the path.  (Matching an exclude pattern usually
+	means the path is excluded, but if the pattern begins with '!'
+	then it is a negated pattern and matching it means the path is
+	NOT excluded.)
++
+For precedence rules within and between exclude sources, see
+linkgit:gitignore[5].
 
 --stdin::
 	Read pathnames from the standard input, one per line,
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 5a4f92395f3..ea5d0ae3a6a 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -108,6 +108,9 @@ static int check_ignore(struct dir_struct *dir,
 			int dtype = DT_UNKNOWN;
 			pattern = last_matching_pattern(dir, &the_index,
 							full_path, &dtype);
+			if (!verbose && pattern &&
+			    pattern->flags & PATTERN_FLAG_NEGATIVE)
+				pattern = NULL;
 		}
 		if (!quiet && (pattern || show_non_matching))
 			output_pattern(pathspec.items[i].original, pattern);
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 1744cee5e99..370a389e5c5 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -424,9 +424,24 @@ test_expect_success 'local ignore inside a sub-directory with --verbose' '
 	)
 '
 
-test_expect_success_multi 'nested include' \
-	'a/b/.gitignore:8:!on*	a/b/one' '
-	test_check_ignore "a/b/one"
+test_expect_success 'nested include of negated pattern' '
+	expect "" &&
+	test_check_ignore "a/b/one" 1
+'
+
+test_expect_success 'nested include of negated pattern with -q' '
+	expect "" &&
+	test_check_ignore "-q a/b/one" 1
+'
+
+test_expect_success 'nested include of negated pattern with -v' '
+	expect "a/b/.gitignore:8:!on*	a/b/one" &&
+	test_check_ignore "-v a/b/one" 0
+'
+
+test_expect_success 'nested include of negated pattern with -v -n' '
+	expect "a/b/.gitignore:8:!on*	a/b/one" &&
+	test_check_ignore "-v -n a/b/one" 0
 '
 
 ############################################################################
@@ -460,7 +475,6 @@ test_expect_success 'cd to ignored sub-directory' '
 	expect_from_stdin <<-\EOF &&
 		foo
 		twoooo
-		../one
 		seven
 		../../one
 	EOF
@@ -543,7 +557,6 @@ test_expect_success 'global ignore' '
 		globalthree
 		a/globalthree
 		a/per-repo
-		globaltwo
 	EOF
 	test_check_ignore "globalone per-repo globalthree a/globalthree a/per-repo not-ignored globaltwo"
 '
@@ -586,17 +599,7 @@ EOF
 cat <<-\EOF >expected-default
 	one
 	a/one
-	a/b/on
-	a/b/one
-	a/b/one one
-	a/b/one two
-	"a/b/one\"three"
-	a/b/two
 	a/b/twooo
-	globaltwo
-	a/globaltwo
-	a/b/globaltwo
-	b/globaltwo
 EOF
 cat <<-EOF >expected-verbose
 	.gitignore:1:one	one
@@ -696,8 +699,12 @@ cat <<-EOF >expected-all
 	$global_excludes:2:!globaltwo	../b/globaltwo
 	::	c/not-ignored
 EOF
+cat <<-EOF >expected-default
+../one
+one
+b/twooo
+EOF
 grep -v '^::	' expected-all >expected-verbose
-sed -e 's/.*	//' expected-verbose >expected-default
 
 broken_c_unquote stdin >stdin0
 

base-commit: bfdd66e72fffd18235757bedbf355fd4176d6019
-- 
gitgitgadget
