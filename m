Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 743941F516
	for <e@80x24.org>; Mon, 25 Jun 2018 16:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754729AbeFYQNZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 12:13:25 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:53470 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752195AbeFYQNX (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 Jun 2018 12:13:23 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5PG9d0K000972;
        Mon, 25 Jun 2018 09:13:10 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2jt01ttdq7-1;
        Mon, 25 Jun 2018 09:13:10 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 18A97226E7F7;
        Mon, 25 Jun 2018 09:13:10 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 0A2A82CDE86;
        Mon, 25 Jun 2018 09:13:10 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood@dunelm.org.uk,
        johannes.schindelin@gmx.de, sunshine@sunshineco.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 0/9] Document/fix/warn about rebase incompatibilities and inconsistencies
Date:   Mon, 25 Jun 2018 09:12:51 -0700
Message-Id: <20180625161300.26060-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.9.g431b2c36d5
In-Reply-To: <20180621150023.23533-1-newren@gmail.com>
References: <20180621150023.23533-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806250187
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-rebase has lots of options that are mutually incompatible.  Even among
aspects of its behavior that is common to all rebase types, it has a number
of inconsistencies.  This series tries to document, fix, and/or warn users
about many of these.

Changes since v3 (range-diff included at the end):
  * Fix many small issues mentioned by Junio and SZEDER, including a fix
    suggested by Eric.
  * Add a new patch (#6) which introduces technical documentation on directory
    rename detection, so that...
  * The more technical portion of the docs from patch 7 (used to be patch 5
    in v3) can be moved from git-rebase.txt to the new
    technical/directory-rename-detection.txt, as suggested by Junio.
  * Also adds a new patch (#8) which adds testcases to demonstrate what the
    new technical doc discusses.

Items of particular note for reviewers:
  * I have left patch 9 (used to be patch 7) in RFC state, but
    expanded the commit message with an in-depth usability rationale
    for the change.
  * It sounded like Junio was slightly unclear about the intent of the
    wording in Patch 1.  Not sure if my answer (in email) was sufficient or
    if there are changes I should make to the patch.
  * On Patch 5 of v3 (which is now patch 7 of v4), Junio suggested a course
    of action to take with --keep-empty.  I counter-proposed with a
    --empty={drop,halt,keep} idea.  Is just deferring this issue to a later
    series okay, or are there changes I should make to the current series to
    handle this?  (If so, what changes should those be?)

Elijah Newren (9):
  git-rebase.txt: document incompatible options
  git-rebase.sh: update help messages a bit
  t3422: new testcases for checking when incompatible options passed
  git-rebase: error out when incompatible options passed
  git-rebase.txt: address confusion between --no-ff vs --force-rebase
  directory-rename-detection.txt: technical docs on abilities and
    limitations
  git-rebase.txt: document behavioral differences between modes
  t3401: add directory rename testcases for rebase and am
  git-rebase: make --allow-empty-message the default

 Documentation/git-rebase.txt                  | 135 ++++++++++++++----
 .../technical/directory-rename-detection.txt  | 115 +++++++++++++++
 git-rebase.sh                                 |  43 +++++-
 t/t3401-rebase-and-am-rename.sh               | 105 ++++++++++++++
 t/t3404-rebase-interactive.sh                 |   7 +-
 t/t3405-rebase-malformed.sh                   |  11 +-
 t/t3422-rebase-incompatible-options.sh        |  88 ++++++++++++
 7 files changed, 462 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/technical/directory-rename-detection.txt
 create mode 100755 t/t3401-rebase-and-am-rename.sh
 create mode 100755 t/t3422-rebase-incompatible-options.sh

 1: 4cdf9130cc !  1: 3f454ebc5e git-rebase.txt: document incompatible options
    @@ -163,7 +163,7 @@
     +implementations:
     +
     + * one based on linkgit:git-am[1] (the default)
    -+ * one based on linkgit:git-merge-recursive[1] (merge backend)
    ++ * one based on git-merge-recursive (merge backend)
     + * one based on linkgit:git-cherry-pick[1] (interactive backend)
     +
     +Flags only understood by the am backend:
 2: e336f76c5e !  2: 31a5a071a6 git-rebase.sh: update help messages a bit
    @@ -6,6 +6,8 @@
         to make like things (e.g. strategy and strategy-option) be near each
         other.
     
    +    Signed-off-by: Elijah Newren <newren@gmail.com>
    +
     diff --git a/git-rebase.sh b/git-rebase.sh
     --- a/git-rebase.sh
     +++ b/git-rebase.sh
 3: 4ab38d8a5f !  3: 5a2b5eec79 t3422: new testcases for checking when incompatible options passed
    @@ -34,8 +34,7 @@
     +	git commit -m A &&
     +
     +	git checkout B &&
    -+	# This is indented with HT SP HT.
    -+	echo "	 	foo();" >>foo &&
    ++	echo "q qfoo();" | q_to_tab >>foo &&
     +	git add foo &&
     +	git commit -m B
     +'
    @@ -48,7 +47,7 @@
     +# being ignored.  Make sure rebase warns the user and aborts instead.
     +#
     +
    -+test_run_rebase () {
    ++test_rebase_am_only () {
     +	opt=$1
     +	shift
     +	test_expect_failure "$opt incompatible with --merge" "
    @@ -78,10 +77,10 @@
     +
     +}
     +
    -+test_run_rebase --whitespace=fix
    -+test_run_rebase --ignore-whitespace
    -+test_run_rebase --committer-date-is-author-date
    -+test_run_rebase -C4
    ++test_rebase_am_only --whitespace=fix
    ++test_rebase_am_only --ignore-whitespace
    ++test_rebase_am_only --committer-date-is-author-date
    ++test_rebase_am_only -C4
     +
     +test_expect_success '--preserve-merges incompatible with --signoff' '
     +	git checkout B^0 &&
 4: 5223954caf !  4: 1e1c83724a git-rebase: error out when incompatible options passed
    @@ -37,7 +37,8 @@
      fi
      
     +if test -n "$git_am_opt"; then
    -+	incompatible_opts=$(echo "$git_am_opt" | sed -e 's/ -q//')
    ++	incompatible_opts=$(echo " $git_am_opt " | \
    ++			    sed -e 's/ -q / /g' -e 's/^ \(.*\) $/\1/')
     +	if test -n "$interactive_rebase"
     +	then
     +		if test -n "$incompatible_opts"
    @@ -85,7 +86,7 @@
     --- a/t/t3422-rebase-incompatible-options.sh
     +++ b/t/t3422-rebase-incompatible-options.sh
     @@
    - test_run_rebase () {
    + test_rebase_am_only () {
      	opt=$1
      	shift
     -	test_expect_failure "$opt incompatible with --merge" "
 5: 96f7ba98bc < --: ---------- git-rebase.txt: document behavioral inconsistencies between modes
 6: 7bb7b380ac !  5: 51023269d3 git-rebase.txt: address confusion between --no-ff vs --force-rebase
    @@ -93,15 +93,3 @@
      INCOMPATIBLE OPTIONS
      --------------------
      
    -@@
    - BEHAVIORAL INCONSISTENCIES
    - --------------------------
    - 
    --  * --no-ff vs. --force-rebase
    --
    --    These options are actually identical, though their description
    --    leads people to believe they might not be.
    --
    -  * empty commits:
    - 
    -     am-based rebase will drop any "empty" commits, whether the
--: ---------- >  6: f017d45dd9 directory-rename-detection.txt: technical docs on abilities and limitations
--: ---------- >  7: 0a359df404 git-rebase.txt: document behavioral differences between modes
--: ---------- >  8: beaadceaef t3401: add directory rename testcases for rebase and am
 7: 3ed07548a6 !  9: 431b2c36d5 git-rebase: make --allow-empty-message the default
    @@ -2,13 +2,85 @@
     
         git-rebase: make --allow-empty-message the default
     
    -    All rebase backends should behave the same with empty commit messages, but
    -    currently do not.  am-based rebases already apply commits with an empty
    -    commit message without stopping or requiring the user to specify an extra
    -    flag.  Since am-based rebases are the default rebase type, and since it
    -    appears no one has ever requested a --no-allow-empty-message flag to
    -    change this behavior, make --allow-empty-message the default so that
    -    merge-based and interactive-based rebases will behave the same.
    +    rebase backends currently behave differently with empty commit messages,
    +    largely as a side-effect of the different underlying commands on which
    +    they are based.  am-based rebases apply commits with an empty commit
    +    message without stopping or requiring the user to specify an extra flag.
    +    (It is interesting to note that am-based rebases are the default rebase
    +    type, and no one has ever requested a --no-allow-empty-message flag to
    +    change this behavior.)  merge-based and interactive-based rebases (which
    +    are ultimately based on git-commit), will currently halt on any such
    +    commits and require the user to manually specify what to do with the
    +    commit and continue.
    +
    +    One possible rationale for the difference in behavior is that the purpose
    +    of an "am" based rebase is solely to transplant an existing history, while
    +    an "interactive" rebase is one whose purpose is to polish a series before
    +    making it publishable.  Thus, stopping and asking for confirmation for a
    +    possible problem is more appropriate in the latter case.  However, there
    +    are two problems with this rationale:
    +
    +      1) merge-based rebases are also non-interactive and there are multiple
    +         types of rebases that use the interactive machinery but are not
    +         explicitly interactive (e.g. when either --rebase-merges or
    +         --keep-empty are specified without --interactive).  These rebases are
    +         also used solely to transplant an existing history, and thus also
    +         should default to --allow-empty-message.
    +
    +      2) this rationale only says that the user is more accepting of stopping
    +         in the case of an explicitly interactive rebase, not that stopping
    +         for this particular reason actually makes sense.  Exploring whether
    +         it makes sense, requires backing up and analyzing the underlying
    +         commands...
    +
    +    If git-commit did not error out on empty commits by default, accidental
    +    creation of commits with empty messages would be a very common occurrence
    +    (this check has caught me many times).  Further, nearly all such empty
    +    commit messages would be considered an accidental error (as evidenced by a
    +    huge amount of documentation across version control systems and in various
    +    blog posts explaining how important commit messages are).  A simple check
    +    for what would otherwise be a common error thus made a lot of sense, and
    +    git-commit gained an --allow-empty-message flag for special case
    +    overrides.  This has made commits with empty messages very rare.
    +
    +    There are two sources for commits with empty messages for rebase (and
    +    cherry-pick): (a) commits created in git where the user previously
    +    specified --allow-empty-message to git-commit, and (b) commits imported
    +    into git from other version control systems.  In case (a), the user has
    +    already explicitly specified that there is something special about this
    +    commit that makes them not want to specify a commit message; forcing them
    +    to re-specify with every cherry-pick or rebase seems more likely to be
    +    infuriating than helpful.  In case (b), the commit is highly unlikely to
    +    have been authored by the person who has imported the history and is doing
    +    the rebase or cherry-pick, and thus the user is unlikely to be the
    +    appropriate person to write a commit message for it.  Stopping and
    +    expecting the user to modify the commit before proceeding thus seems
    +    counter-productive.
    +
    +    Further, note that while empty commit messages was a common error case for
    +    git-commit to deal with, it is a rare case for rebase (or cherry-pick).
    +    The fact that it is rare raises the question of why it would be worth
    +    checking and stopping on this particular condition and not others.  For
    +    example, why doesn't an interactive rebase automatically stop if the
    +    commit message's first line is 2000 columns long, or is missing a blank
    +    line after the first line, or has every line indented with five spaces, or
    +    any number of other myriad problems?
    +
    +    Finally, note that if a user doing an interactive rebase does have the
    +    necessary knowledge to add a message for any such commit and wants to do
    +    so, it is rather simple for them to change the appropriate line from
    +    'pick' to 'reword'.  The fact that the subject is empty in the todo list
    +    that the user edits should even serve as a way to notify them.
    +
    +    As far as I can tell, the fact that merge-based and interactive-based
    +    rebases stop on commits with empty commit messages is solely a by-product
    +    of having been based on git-commit.  It went without notice for a long
    +    time precisely because such cases are rare.  The rareness of this
    +    situation made it difficult to reason about, so when folks did eventually
    +    notice this behavior, they assumed it was there for a good reason and just
    +    added an --allow-empty-message flag.  In my opinion, stopping on such
    +    messages not desirable in any of these cases, even the (explicitly)
    +    interactive case.
     
         Signed-off-by: Elijah Newren <newren@gmail.com>
     
    @@ -16,7 +88,7 @@
     --- a/Documentation/git-rebase.txt
     +++ b/Documentation/git-rebase.txt
     @@
    -     The --keep-empty option exists for interactive rebases to allow
    +     The `--keep-empty` option exists for interactive rebases to allow
          it to keep commits that started empty.
      
     -  * empty commit messages:
    @@ -25,7 +97,7 @@
     -    messages.
     -
     -    merge-based and interactive-based rebases will by default halt
    --    on any such commits.  The --allow-empty-message option exists to
    +-    on any such commits.  The `--allow-empty-message` option exists to
     -    allow interactive-based rebases to apply such commits without
     -    halting.
     -

-- 
2.18.0.9.g678597d97e
