Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96501C33CB7
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 18:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC23206F0
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 18:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyBDRqJd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgAaSbd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:31:33 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45267 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgAaSbc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 13:31:32 -0500
Received: by mail-wr1-f68.google.com with SMTP id a6so9762369wrx.12
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 10:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iq2ko/D0E2T0iw7zwvGTylFyA5ql/qdBhFDqfKBbr7o=;
        b=jyBDRqJdChXN41ZEo4kBdlGNbHNeUBQ73baJV93Ns6+JrvmL4T8JXwDXdY6NvQrCzA
         FeOhMCR3HkVRjc3S5RnMlefJMHGI+PWvfe7KuAUIK/Nk1DWHv5kStFOak2/j5FCU7Wlq
         sz84KH7XmDwOmDIGPJ9ToZ6lpGtASak5vafvWwV4zHM3bvgwDna4vE7++snLgORzc5uY
         7Rsr6cVvarAOJx89GqxYgkWo2FaKtVFZveWbubsuIz/8bDkg9t/SLubLtoQnyJbA4d5M
         Xkg44SSjuhqffDWE6bqaXd6uxPARh1iyqR6GsN9qVzd7B1AXOIRGEKlAhFaMJy25Wyvu
         EMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iq2ko/D0E2T0iw7zwvGTylFyA5ql/qdBhFDqfKBbr7o=;
        b=gO54AuH6VCyw0SWxuPZ3FdR+j+GCzhwYVCtc63IBXHrHNycDAljuZCC0YKep9WJW4j
         avdGM2CRmHtN5RSiZs/ZTtrmEdk57HTzUfQWw4p3LN8jsJ7zuc0hvpZWJdRv2t2ky+I6
         OBuN9EzSjQpZ8yh0SBQOCp+nbozbMaS35PLOSHj/7BMhm3zFbhig10iIBqai4cxnmOUj
         Tt7uBcu9d7llt4h/6bCF3oI8Vcpx/K9kynMssf5k1MXwFPhU53sJHyw+tvK/sEWJ7rRl
         dY4ijzu5KaP0FXj2C/+Yk5IqaPqy95w+NRlzkOg82ewKE/sF96EDZB+NN4BNGcg59Mrt
         SSGQ==
X-Gm-Message-State: APjAAAUjdgC7UPj3wqFZQjnxTkEjFXkBnYeKQPC0HmCjzaVldfeBcgge
        eU2xhuEiQlTOtrFZu8ZU7vv7nIxn
X-Google-Smtp-Source: APXvYqz/aE/EnkqURqGX6eFQsH1409TRG3TcZnTT4sZ1bFu+MOlKUNGcwZsMoToNtqj0CpqVu+w0vg==
X-Received: by 2002:a5d:4c88:: with SMTP id z8mr13428364wrs.395.1580495487842;
        Fri, 31 Jan 2020 10:31:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y12sm11566815wmj.6.2020.01.31.10.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 10:31:27 -0800 (PST)
Message-Id: <pull.700.v2.git.git.1580495486.gitgitgadget@gmail.com>
In-Reply-To: <pull.700.git.git.1580335424.gitgitgadget@gmail.com>
References: <pull.700.git.git.1580335424.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jan 2020 18:31:20 +0000
Subject: [PATCH v2 0/6] Avoid multiple recursive calls for same path in read_directory_recursive()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Martin Melka <martin.melka@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series builds on en/fill-directory-fixes-more. This series should
be considered an RFC because of the untracked-cache changes (see the last
two commits), for which I'm hoping to get an untracked-cache expert to
comment. This series does provide some modest speedups (see second to last
commit message), and should allow 'git status --ignored' to complete in a
more reasonable timeframe for Martin Melka (see 
https://lore.kernel.org/git/CANt4O2L_DZnMqVxZzTBMvr=BTWqB6L0uyORkoN_yMHLmUX7yHw@mail.gmail.com/
)

Changes since v1:

 * Replaced patch 4 with improved version from Stolee (with additional
   improvement of my own)
 * Clarifications, wording fixes, and more about linear perf in commit
   message to patch 5
 * More detail in patch 5 about why "whackamole" particularly makes me
   uneasy for dir.c

Stuff clearly still missing from v2:

 * I didn't make the DIR_KEEP_UNTRACKED_CONTENTS changes I mentioned in 
   https://lore.kernel.org/git/CABPp-BEQ5s=+6Rnb-A+pdEaoPXxfo-hMSegSe1eai=RE74A3Og@mail.gmail.com/ 
   which I think would make the code cleaner & clearer.
 * I still have not addressed the untracked-cache issue mentioned in the
   last two commits. I looked at it very, very briefly, but I was really
   close to doing something similar to [1] and just dropping my patches in
   this series before even submitting them on Wednesday[2] (dir.c is a
   really unpleasant to work in). Other than wording fixes, I just need a
   week or two off from this area before I dig further, unless someone else
   wants to dive in and needs me to provide pointers on what I've done so
   far.

[1] 
https://lore.kernel.org/git/pull.676.v3.git.git.1576571586.gitgitgadget@gmail.com/
[2] I was inches from doing that Wednesday morning. I had done several
rounds of "Okay, I fixed all the tests that broke with my changes last time,
let's re-run the testsuite -- wow, four totally different tests from
testfiles I hadn't looked at before now break", and decided that I would
only do one more before dropping it an maybe coming back in a month or two.
That time happened to work, minus the untracked-cache, so I decided to put
it in front of other eyeballs.

Derrick Stolee (1):
  dir: refactor treat_directory to clarify control flow

Elijah Newren (5):
  dir: consolidate treat_path() and treat_one_path()
  dir: fix broken comment
  dir: fix confusion based on variable tense
  dir: replace exponential algorithm with a linear one
  t7063: blindly accept diffs

 dir.c                             | 331 +++++++++++++++++-------------
 t/t7063-status-untracked-cache.sh |  50 ++---
 2 files changed, 208 insertions(+), 173 deletions(-)


base-commit: 0cbb60574e741e8255ba457606c4c90898cfc755
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-700%2Fnewren%2Ffill-directory-exponential-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-700/newren/fill-directory-exponential-v2
Pull-Request: https://github.com/git/git/pull/700

Range-diff vs v1:

 1:  27bc135796 = 1:  27bc135796 dir: consolidate treat_path() and treat_one_path()
 2:  2ceb64ae61 = 2:  2ceb64ae61 dir: fix broken comment
 3:  e6d21228d1 = 3:  e6d21228d1 dir: fix confusion based on variable tense
 4:  3b2ec5eaf6 ! 4:  f73f0d66d1 dir: move setting of nested_repo next to its actual usage
     @@ -1,26 +1,73 @@
     -Author: Elijah Newren <newren@gmail.com>
     +Author: Derrick Stolee <dstolee@microsoft.com>
      
     -    dir: move setting of nested_repo next to its actual usage
     +    dir: refactor treat_directory to clarify control flow
      
     +    The logic in treat_directory() is handled by a multi-case
     +    switch statement, but this switch is very asymmetrical, as
     +    the first two cases are simple but the third is more
     +    complicated than the rest of the method. In fact, the third
     +    case includes a "break" statement that leads to the block
     +    of code outside the switch statement. That is the only way
     +    to reach that block, as the switch handles all possible
     +    values from directory_exists_in_index();
     +
     +    Extract the switch statement into a series of "if" statements.
     +    This simplifies the trivial cases, while clarifying how to
     +    reach the "show_other_directories" case. This is particularly
     +    important as the "show_other_directories" case will expand
     +    in a later change.
     +
     +    Helped-by: Elijah Newren <newren@gmail.com>
     +    Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       diff --git a/dir.c b/dir.c
       --- a/dir.c
       +++ b/dir.c
      @@
     - 	const char *dirname, int len, int baselen, int excluded,
       	const struct pathspec *pathspec)
       {
     --	int nested_repo = 0;
     -+	int nested_repo;
     - 
     + 	int nested_repo = 0;
     +-
       	/* The "len-1" is to strip the final '/' */
     - 	switch (directory_exists_in_index(istate, dirname, len-1)) {
     -@@
     +-	switch (directory_exists_in_index(istate, dirname, len-1)) {
     +-	case index_directory:
     +-		return path_recurse;
     ++	enum exist_status status = directory_exists_in_index(istate, dirname, len-1);
     + 
     +-	case index_gitdir:
     ++	if (status == index_directory)
     ++		return path_recurse;
     ++	if (status == index_gitdir)
       		return path_none;
     ++	if (status != index_nonexistent)
     ++		BUG("Unhandled value for directory_exists_in_index: %d\n", status);
     + 
     +-	case index_nonexistent:
     +-		if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
     +-		    !(dir->flags & DIR_NO_GITLINKS)) {
     +-			struct strbuf sb = STRBUF_INIT;
     +-			strbuf_addstr(&sb, dirname);
     +-			nested_repo = is_nonbare_repository_dir(&sb);
     +-			strbuf_release(&sb);
     +-		}
     +-		if (nested_repo)
     +-			return ((dir->flags & DIR_SKIP_NESTED_GIT) ? path_none :
     +-				(excluded ? path_excluded : path_untracked));
     ++	if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
     ++		!(dir->flags & DIR_NO_GITLINKS)) {
     ++		struct strbuf sb = STRBUF_INIT;
     ++		strbuf_addstr(&sb, dirname);
     ++		nested_repo = is_nonbare_repository_dir(&sb);
     ++		strbuf_release(&sb);
     ++	}
     ++	if (nested_repo)
     ++		return ((dir->flags & DIR_SKIP_NESTED_GIT) ? path_none :
     ++			(excluded ? path_excluded : path_untracked));
       
     - 	case index_nonexistent:
     -+		nested_repo = 0;
     - 		if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
     - 		    !(dir->flags & DIR_NO_GITLINKS)) {
     - 			struct strbuf sb = STRBUF_INIT;
     +-		if (dir->flags & DIR_SHOW_OTHER_DIRECTORIES)
     +-			break;
     ++	if (!(dir->flags & DIR_SHOW_OTHER_DIRECTORIES)) {
     + 		if (excluded &&
     + 		    (dir->flags & DIR_SHOW_IGNORED_TOO) &&
     + 		    (dir->flags & DIR_SHOW_IGNORED_TOO_MODE_MATCHING)) {
 5:  40b378e7ad ! 5:  d3136ef52f dir: replace exponential algorithm with a linear one
     @@ -20,26 +20,29 @@
               and report all the ignored entries and then report the directory as
               untracked -- UNLESS all the entries under the directory are
               ignored, in which case we don't print any of the entries under the
     -         directory and just report the directory itself as ignored.
     +         directory and just report the directory itself as ignored.  (Note
     +         that although this forces us to walk all untracked files underneath
     +         the directory as well, we strip them from the output, except for
     +         users like 'git clean' who also set DIR_KEEP_TRACKED_CONTENTS.)
      
             * For 'git clean', we may need to recurse into a directory that
               doesn't match any specified pathspecs, if it's possible that there
               is an entry underneath the directory that can match one of the
               pathspecs.  In such a case, we need to be careful to omit the
     -         directory itself from the list of paths (see e.g. commit
     -         404ebceda01c ("dir: also check directories for matching pathspecs",
     -         2019-09-17))
     +         directory itself from the list of paths (see commit 404ebceda01c
     +         ("dir: also check directories for matching pathspecs", 2019-09-17))
      
          Part of the tension noted above is that the treatment of a directory can
     -    changed based on the files within it, and based on the various settings
     +    change based on the files within it, and based on the various settings
          in dir->flags.  Trying to keep this in mind while reading over the code,
     -    it is easy to (accidentally?) think in terms of "treat_directory() tells
     -    us what to do with a directory, and read_directory_recursive() is the
     -    thing that recurses".  Since we need to look into a directory to know
     -    how to treat it, though, it was quite easy to decide to recurse into the
     +    it is easy to think in terms of "treat_directory() tells us what to do
     +    with a directory, and read_directory_recursive() is the thing that
     +    recurses".  Since we need to look into a directory to know how to treat
     +    it, though, it is quite easy to decide to (also) recurse into the
          directory from treat_directory() by adding a read_directory_recursive()
     -    call.  Adding such a call is actually fine, IF we didn't also cause
     -    read_directory_recursive() to recurse into the same directory again.
     +    call.  Adding such a call is actually fine, IF we make sure that
     +    read_directory_recursive() does not also recurse into that same
     +    directory.
      
          Unfortunately, commit df5bcdf83aeb ("dir: recurse into untracked dirs
          for ignored files", 2017-05-18), added exactly such a case to the code,
     @@ -58,10 +61,12 @@
          Since dir.c is somewhat complex, extra cruft built up around this over
          time.  While trying to unravel it, I noticed several instances where the
          first call to read_directory_recursive() would return e.g.
     -    path_untracked for a some directory and a later one would return e.g.
     -    path_none, and the code relied on the side-effect of the first adding
     -    untracked entries to dir->entries in order to get the correct output
     -    despite the supposed override in return value by the later call.
     +    path_untracked for some directory and a later one would return e.g.
     +    path_none, despite the fact that the directory clearly should have been
     +    considered untracked.  The code happened to work due to the side-effect
     +    from the first invocation of adding untracked entries to dir->entries;
     +    this allowed it to get the correct output despite the supposed override
     +    in return value by the later call.
      
          I am somewhat concerned that there are still bugs and maybe even
          testcases with the wrong expectation.  I have tried to carefully
     @@ -74,9 +79,40 @@
          but the rules of existing behavior had so many special cases that I had
          a hard time coming up with some overarching rules about what correct
          behavior is for all cases, forcing me to hope that the regression tests
     -    are correct and sufficient.  (I'll note that this turmoil makes working
     -    with dir.c extremely unpleasant for me; I keep hoping it'll get better,
     -    but it never seems to.)
     +    are correct and sufficient.  Such a hope seems likely to be ill-founded,
     +    given my experience with dir.c-related testcases in the last few months:
     +
     +      Examples where the documentation was hard to parse or even just wrong:
     +       * 3aca58045f4f (git-clean.txt: do not claim we will delete files with
     +                       -n/--dry-run, 2019-09-17)
     +       * 09487f2cbad3 (clean: avoid removing untracked files in a nested git
     +                       repository, 2019-09-17)
     +       * e86bbcf987fa (clean: disambiguate the definition of -d, 2019-09-17)
     +      Examples where testcases were declared wrong and changed:
     +       * 09487f2cbad3 (clean: avoid removing untracked files in a nested git
     +                       repository, 2019-09-17)
     +       * e86bbcf987fa (clean: disambiguate the definition of -d, 2019-09-17)
     +       * a2b13367fe55 (Revert "dir.c: make 'git-status --ignored' work within
     +                       leading directories", 2019-12-10)
     +      Examples where testcases were clearly inadequate:
     +       * 502c386ff944 (t7300-clean: demonstrate deleting nested repo with an
     +                       ignored file breakage, 2019-08-25)
     +       * 7541cc530239 (t7300: add testcases showing failure to clean specified
     +                       pathspecs, 2019-09-17)
     +       * a5e916c7453b (dir: fix off-by-one error in match_pathspec_item,
     +                       2019-09-17)
     +       * 404ebceda01c (dir: also check directories for matching pathspecs,
     +                       2019-09-17)
     +       * 09487f2cbad3 (clean: avoid removing untracked files in a nested git
     +                       repository, 2019-09-17)
     +       * e86bbcf987fa (clean: disambiguate the definition of -d, 2019-09-17)
     +       * 452efd11fbf6 (t3011: demonstrate directory traversal failures,
     +                       2019-12-10)
     +       * b9670c1f5e6b (dir: fix checks on common prefix directory, 2019-12-19)
     +      Examples where "correct behavior" was unclear to everyone:
     +        https://lore.kernel.org/git/20190905154735.29784-1-newren@gmail.com/
     +      Other commits of note:
     +       * 902b90cf42bc (clean: fix theoretical path corruption, 2019-09-17)
      
          However, on the positive side, it does make the code much faster.  For
          the following simple shell loop in an empty repository:
     @@ -111,27 +147,14 @@
              24: 274.45
              25: 551.15
      
     -    After this fix, those drop to:
     -
     -        10: 0.00
     -        11: 0.00
     -        12: 0.00
     -        13: 0.00
     -        14: 0.00
     -        15: 0.00
     -        16: 0.00
     -        17: 0.00
     -        18: 0.00
     -        19: 0.00
     -        20: 0.00
     -        21: 0.00
     -        22: 0.00
     -        23: 0.00
     -        24: 0.00
     -        25: 0.00
     +    For the above run, using strace I can look for the number of untracked
     +    directories opened and can verify that it matches the expected
     +    2^($depth+1)-2 (the sum of 2^1 + 2^2 + 2^3 + ... + 2^$depth).
      
     -    In fact, it isn't until a depth of 190 nested directories that it
     -    sometimes starts reporting a time of 0.01 seconds and doesn't
     +    After this fix, with strace I can verify that the number of untracked
     +    directories that are opened drops to just $depth, and the timings all
     +    drop to 0.00.  In fact, it isn't until a depth of 190 nested directories
     +    that it sometimes starts reporting a time of 0.01 seconds and doesn't
          consistently report 0.01 seconds until there are 240 nested directories.
          The previous code would have taken
            17.55 * 2^220 / (60*60*24*365) = 9.4 * 10^59 YEARS
     @@ -152,17 +175,17 @@
       	const char *dirname, int len, int baselen, int excluded,
       	const struct pathspec *pathspec)
       {
     --	int nested_repo;
     +-	int nested_repo = 0;
      +	/*
      +	 * WARNING: From this function, you can return path_recurse or you
      +	 *          can call read_directory_recursive() (or neither), but
      +	 *          you CAN'T DO BOTH.
      +	 */
      +	enum path_treatment state;
     -+	int nested_repo, old_ignored_nr, stop_early;
     - 
     ++	int nested_repo = 0, old_ignored_nr, stop_early;
       	/* The "len-1" is to strip the final '/' */
     - 	switch (directory_exists_in_index(istate, dirname, len-1)) {
     + 	enum exist_status status = directory_exists_in_index(istate, dirname, len-1);
     + 
      @@
       
       	/* This is the "show_other_directories" case */
     @@ -292,9 +315,9 @@
      -	 * updates in treat_leading_path().  See the commit message for the
      -	 * commit adding this warning as well as the commit preceding it
      -	 * for details.
     -+	 * WARNING: Do NOT call recurse unless path_recurse is returned
     -+	 *          from treat_path().  Recursing on any other return value
     -+	 *          results in exponential slowdown.
     ++	 * WARNING: Do NOT recurse unless path_recurse is returned from
     ++	 *          treat_path().  Recursing on any other return value
     ++	 *          can result in exponential slowdown.
       	 */
      -
       	struct cached_dir cdir;
 6:  7fb8063541 = 6:  9a3f20656e t7063: blindly accept diffs

-- 
gitgitgadget
