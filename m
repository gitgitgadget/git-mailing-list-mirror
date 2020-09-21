Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA95C4727C
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3661A23A60
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHVO/olD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgIUWBb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 18:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgIUWBa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 18:01:30 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598A6C061755
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 15:01:30 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z1so14599649wrt.3
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 15:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=p+jX8CtO7hM2YBjI+HYzkcaV5mTz2Dp3wCfXtbCV+ac=;
        b=jHVO/olDYnbu5QTe3ZXz2fVX9clOfHbzFTKlSsJD2QcrkKhrgnRMpunjCVfGsRixp4
         M7/ftzvn80x85bxJvOF2aZDe/xsdbpjXclK86eF+iV9rVEjn6FMUjIW1V6p0jPCiUn3n
         s7+x+XjGbWgeLPMuRh7miou6If2Uc2Svp40ktbYjBE7XFvP5zQmT7bhCFvF2fRafQjoc
         eejku1XPoXcUn1ixFh/Xqd8XlUwfVMx2rQxLJtjZgegmk4yQLU4ARvh2YxlPrvX/zWHz
         CwudanHEvoym12/voc5Olcu0KBRNunNDdDwSFW9nruTqDkYicgdWmATwjO48cIGZ94q8
         jobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=p+jX8CtO7hM2YBjI+HYzkcaV5mTz2Dp3wCfXtbCV+ac=;
        b=gFCxe2Pl8/qDMhBelWeTJJHmjkvsfCs85J7zxYia1EOKmnUybA8dwYDeKAvZOcKdY5
         QADCrj79AhwNd6O2YWxdW8bbtfhzLu4bmLBWEoR2UurIMGD7m8eoSpXDYe3Vhhm8F9L6
         YAoZymSCZm/gGDm74NRcystkfoJyEXtzch2JcEX/W7mUrPRATUJIZNaOrvui9U7PwT9L
         Vj3wW5FORhRJzQBkVEFH4rbTsIqdy59JnmusFY9ZrJTljwqTM/uAUqYLcHCPmjgqx6TU
         23IKcROm6udJIkDa5Yvu1GG5HYWQymuQCbQjxBjMtqWLe8yfUf8yGQFLicOkK0L7bNAY
         5NRg==
X-Gm-Message-State: AOAM5333Rb6Gj2eBAdhW3yFolgeIMzlt5JEd6iiicBb9YIXcTKmA6ooF
        PSu4fHLM0Vy2tRJnq7TpsyVukivc+Cc=
X-Google-Smtp-Source: ABdhPJyw5gRg16bI3iLEmXP6UrIjxGSPAaISsNx1A0dxFEc3ZiUQT+dHAlPY++WdJjUuBA4h/PEApA==
X-Received: by 2002:adf:ffca:: with SMTP id x10mr1985619wrs.342.1600725688421;
        Mon, 21 Sep 2020 15:01:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t15sm22316974wrp.20.2020.09.21.15.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 15:01:27 -0700 (PDT)
Message-Id: <pull.734.v2.git.1600725687.gitgitgadget@gmail.com>
In-Reply-To: <pull.734.git.1600279853.gitgitgadget@gmail.com>
References: <pull.734.git.1600279853.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Sep 2020 22:01:21 +0000
Subject: [PATCH v2 0/5] Inclusive naming, part II
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series represents the logical next step on the journey begun with
introducing init.defaultBranch: in these patches, we avoid a couple
unnecessary mentions of the branch name "master".

This patch series does not try to change the default branch name, although I
have that patch series ready to go. You can see the overall idea here: 
https://github.com/gitgitgadget/git/pull/655. Concretely, I plan on
submitting three more patch series after this one:

 1. a relatively small patch series to avoid using the branch name main in
    the test suite. This is necessary because my plan is to change the
    default branch name to that name, therefore it cannot be used as the
    name of a topic branch any longer.
 2. a relatively large patch series (currently consisting of 18 patches) to
    change the default branch name to main. Most of the patches provide
    non-trivial (read: non-scriptable) adjustments to the test suite in an
    incremental fashion, with a big patch toward the end that reflects a
    fully-automated search-and-replace of all the trivial cases.
 3. a very small patch series with fall-out patches that are not necessary
    to pass the test suite, but are still required to complete the rename
    (adjusted code comment, file rename).

(Note: I am still debating whether I should move one or two patches from the
second to the third patch series)

Changes since v1:

 * Instead of using the name primary for the adjustments to 
   t/test-terminal.perl, we follow Python's lead (which uses the
   parent/child nomenclature).
 * The changes to t3200 no longer use variations of the name main as branch
   names; Instead, the renamed branches are independent from any current or
   future default branch name.

Johannes Schindelin (5):
  fast-export: avoid using unnecessary language in a code comment
  t/test-terminal: avoid non-inclusive language
  t3200: avoid variations of the `master` branch name
  tests: avoid variations of the `master` branch name
  t9902: avoid using the branch name `master`

 builtin/fast-export.c        |  2 +-
 t/t3200-branch.sh            | 34 ++++++++++++++---------------
 t/t3427-rebase-subtree.sh    | 42 ++++++++++++++++++------------------
 t/t4150-am.sh                |  8 +++----
 t/t5515-fetch-merge-logic.sh |  6 +++---
 t/t5523-push-upstream.sh     | 20 ++++++++---------
 t/t6018-rev-list-glob.sh     |  6 +++---
 t/t6040-tracking-info.sh     | 20 ++++++++---------
 t/t6409-merge-subtree.sh     | 14 ++++++------
 t/t9902-completion.sh        | 10 ++++-----
 t/test-terminal.perl         | 32 +++++++++++++--------------
 11 files changed, 97 insertions(+), 97 deletions(-)


base-commit: 54e85e7af1ac9e9a92888060d6811ae767fea1bc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-734%2Fdscho%2Favoid-unnecessary-branch-name-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-734/dscho/avoid-unnecessary-branch-name-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/734

Range-diff vs v1:

 1:  587ddca42a = 1:  587ddca42a fast-export: avoid using unnecessary language in a code comment
 2:  3b4ae48d4a ! 2:  80e1d46cce t/test-terminal: avoid non-inclusive language
     @@ Commit message
          least we can get rid of the usage of the word `master` and hope that
          IO::Pty will be eventually adjusted, too.
      
     +    Guessing that IO::Pty might follow Python's lead, we replace the name
     +    `master` by `parent` (hoping that IO::Pty will adopt the parent/child
     +    nomenclature, too).
     +
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## t/test-terminal.perl ##
     @@ t/test-terminal.perl: sub copy_stdio {
      -close $master_err->slave;
      -my $in_pid = copy_stdin($master_in);
      -copy_stdio($master_out, $master_err);
     -+my $primary_in = new IO::Pty;
     -+my $primary_out = new IO::Pty;
     -+my $primary_err = new IO::Pty;
     -+$primary_in->set_raw();
     -+$primary_out->set_raw();
     -+$primary_err->set_raw();
     -+$primary_in->slave->set_raw();
     -+$primary_out->slave->set_raw();
     -+$primary_err->slave->set_raw();
     -+my $pid = start_child(\@ARGV, $primary_in->slave, $primary_out->slave, $primary_err->slave);
     -+close $primary_in->slave;
     -+close $primary_out->slave;
     -+close $primary_err->slave;
     -+my $in_pid = copy_stdin($primary_in);
     -+copy_stdio($primary_out, $primary_err);
     ++my $parent_in = new IO::Pty;
     ++my $parent_out = new IO::Pty;
     ++my $parent_err = new IO::Pty;
     ++$parent_in->set_raw();
     ++$parent_out->set_raw();
     ++$parent_err->set_raw();
     ++$parent_in->slave->set_raw();
     ++$parent_out->slave->set_raw();
     ++$parent_err->slave->set_raw();
     ++my $pid = start_child(\@ARGV, $parent_in->slave, $parent_out->slave, $parent_err->slave);
     ++close $parent_in->slave;
     ++close $parent_out->slave;
     ++close $parent_err->slave;
     ++my $in_pid = copy_stdin($parent_in);
     ++copy_stdio($parent_out, $parent_err);
       my $ret = finish_child($pid);
       # If the child process terminates before our copy_stdin() process is able to
      -# write all of its data to $master_in, the copy_stdin() process could stall.
     -+# write all of its data to $primary_in, the copy_stdin() process could stall.
     ++# write all of its data to $parent_in, the copy_stdin() process could stall.
       # Send SIGTERM to it to ensure it terminates.
       kill 'TERM', $in_pid;
       finish_child($in_pid);
 3:  2f1d0a2df4 ! 3:  8d8e9abfe2 t3200: avoid variations of the `master` branch name
     @@ Commit message
          The `t3200-branch.sh` script uses variations of this name for branches
          other than the default one. So let's change those names, as
          "lowest-hanging fruits" in the effort to use more inclusive naming
     -    throughout Git's source code.
     +    throughout Git's source code. While at it, make those branch names
     +    independent from the default branch name.
      
     -    In this particular instance, this requires a couple of non-trivial
     -    adjustments, as the aligned output depends on the maximum length of the
     -    displayed branches (which we now changed), and also on the alphabetical
     -    order (which we now changed, too).
     +    In this particular instance, this rename requires a couple of
     +    non-trivial adjustments, as the aligned output depends on the maximum
     +    length of the displayed branches (which we now changed), and also on the
     +    alphabetical order (which we now changed, too).
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ t/t3200-branch.sh: test_expect_success 'git branch -M master master should work
       '
       
      -test_expect_success 'git branch -M master2 master2 should work when master is checked out' '
     -+test_expect_success 'git branch -M main2 main2 should work when master is checked out' '
     ++test_expect_success 'git branch -M topic topic should work when master is checked out' '
       	git checkout master &&
      -	git branch master2 &&
      -	git branch -M master2 master2
     -+	git branch main2 &&
     -+	git branch -M main2 main2
     ++	git branch topic &&
     ++	git branch -M topic topic
       '
       
       test_expect_success 'git branch -v -d t should work' '
     @@ t/t3200-branch.sh: test_expect_success 'git branch --list -v with --abbrev' '
       	cat >expect <<\EOF &&
      -  a/b/c     bam       foo       l       * master    mb        o/o       q
      -  abc       bar       j/k       m/m       master2   n         o/p       r
     -+  a/b/c    bam      foo      l        main2    mb       o/o      q
     -+  abc      bar      j/k      m/m    * master   n        o/p      r
     ++  a/b/c    bam      foo      l      * master   n        o/p      r
     ++  abc      bar      j/k      m/m      mb       o/o      q        topic
       EOF
       	test_cmp expect actual
       '
      @@ t/t3200-branch.sh: test_expect_success 'git branch --column with an extremely long branch name' '
     -   j/k
         l
         m/m
     -+  main2
       * master
      -  master2
         mb
         n
         o/o
     +   o/p
     +   q
     +   r
     ++  topic
     +   $long
     + EOF
     + 	test_cmp expect actual
      @@ t/t3200-branch.sh: test_expect_success 'git branch with column.*' '
       	git config --unset column.branch &&
       	git config --unset column.ui &&
       	cat >expect <<\EOF &&
      -  a/b/c   bam   foo   l   * master    mb   o/o   q
      -  abc     bar   j/k   m/m   master2   n    o/p   r
     -+  a/b/c   bam   foo   l     main2    mb   o/o   q
     -+  abc     bar   j/k   m/m * master   n    o/p   r
     ++  a/b/c   bam   foo   l   * master   n     o/p   r
     ++  abc     bar   j/k   m/m   mb       o/o   q     topic
       EOF
       	test_cmp expect actual
       '
     @@ t/t3200-branch.sh: test_expect_success 'git branch --column -v should fail' '
       	cat >expect <<\EOF &&
         a/b/c
      @@ t/t3200-branch.sh: test_expect_success 'git branch -v with column.ui ignored' '
     -   j/k
         l
         m/m
     -+  main2
       * master
      -  master2
         mb
         n
         o/o
     +   o/p
     +   q
     +   r
     ++  topic
     + EOF
     + 	test_cmp expect actual
     + '
      @@ t/t3200-branch.sh: test_expect_success 'git branch -C master master should work when master is chec
       	git branch -C master master
       '
     @@ t/t3200-branch.sh: test_expect_success 'deleting a self-referential symref' '
      -	git symbolic-ref refs/heads/master2 refs/heads/master &&
      -	test_must_fail git branch -m master2 master3 &&
      -	git symbolic-ref refs/heads/master2 &&
     -+	git symbolic-ref refs/heads/main2 refs/heads/master &&
     -+	test_must_fail git branch -m main2 main3 &&
     -+	git symbolic-ref refs/heads/main2 &&
     ++	git symbolic-ref refs/heads/topic refs/heads/master &&
     ++	test_must_fail git branch -m topic new-topic &&
     ++	git symbolic-ref refs/heads/topic &&
       	test_path_is_file .git/refs/heads/master &&
      -	test_path_is_missing .git/refs/heads/master3
     -+	test_path_is_missing .git/refs/heads/main3
     ++	test_path_is_missing .git/refs/heads/new-topic
       '
       
       test_expect_success SYMLINKS 'git branch -m u v should fail when the reflog for u is a symlink' '
 4:  a532053e60 = 4:  8f59e19b95 tests: avoid variations of the `master` branch name
 5:  d135a8423b = 5:  c2c1238b5d t9902: avoid using the branch name `master`

-- 
gitgitgadget
