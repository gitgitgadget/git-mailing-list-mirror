Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A43C433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 15:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBBAC2078A
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 15:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmuNEwqk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbgFOP1X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbgFOP1V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 11:27:21 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EE1C061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 08:27:21 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id p18so11819021eds.7
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 08:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZrX+Dt0KPYWSuEllOWN8kosqvxbgzPs2WJV86YfTYzk=;
        b=JmuNEwqk9cDH8pTE23XB5SIce+L670MecRfGQvrkM3DEoIVnxTy4yGeaCEJSOz171L
         Cd5XuJ6A2ds5DZMI/JbLbeOOynT4GHUr/yM54RhXLHmscoDJb8kVbDv3JFHBnyvyRUlD
         4qA4iknzRuPq8uK2nQ7RE4m0JB987pqahR+MyLtVzqEfRnC8HhMiQ524DeUy6jcaJUFh
         eNB2BhOTG7oGqtkg9cj0EejHDp6AOVOITNhwa81LD3Iq332T+omc7hu24vROnEMIfdAt
         1jpwG9NmMscE3Rdj6V1DMBRAQkCMCa6mWzIqv5LmdknBdgDGXKztyrFYisknaUgJjUjI
         k8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZrX+Dt0KPYWSuEllOWN8kosqvxbgzPs2WJV86YfTYzk=;
        b=GdH59/0HU6WZ+lRYFxTyPUpiSQgGmRIFewzbIfhzdfy/jI9PQqSBnj2FSdt6Yp41HU
         zBEvEItBZJWiJY9PNpSsEi3OxJHjc9b3ymmdV+bxj57g2gG2hDTj10ksa4leWhWaCHAe
         Qd2VtXhTbF1K9qwNzVl5I3CN6AaFxMvUj4AZgkoQm16zPYDaynK/acsRStS4Kc1UTYRy
         hB41dY7oPB0uXMwlLcsH+guhtSImacdz4guZP0Yi9pUeZ/bxNGH028oM8aCgQwHbnlFb
         ESnchVaAKeEeX+rnj9yR7uMnOGxWUL9W9egHuo6CWmIg27iEwd1WKy86dfZDyqjsRcCb
         6VhA==
X-Gm-Message-State: AOAM533UTTf4VCyBw/0+edh3TgqFY9tvl7/VI3p8gBSdpzkKLxuva3+I
        0rGnINQPowFEFIYFjC0hpLw=
X-Google-Smtp-Source: ABdhPJzL/Z0gke9uLUR6SBQLDGBY0n9xEDiDivhSAMyeogKscXcXR50vAeLVvhLrTUZDLy7448s1lg==
X-Received: by 2002:a05:6402:699:: with SMTP id f25mr24397233edy.281.1592234838944;
        Mon, 15 Jun 2020 08:27:18 -0700 (PDT)
Received: from szeder.dev (62-165-236-99.pool.digikabel.hu. [62.165.236.99])
        by smtp.gmail.com with ESMTPSA id op5sm9124197ejb.56.2020.06.15.08.27.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2020 08:27:18 -0700 (PDT)
Date:   Mon, 15 Jun 2020 17:27:15 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v1 0/6] stash: drop usage of a second index
Message-ID: <20200615152715.GD2898@szeder.dev>
References: <20200505104849.13602-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200505104849.13602-1-alban.gruin@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 05, 2020 at 12:48:43PM +0200, Alban Gruin wrote:
> The old scripted `git stash' used to create a second index to save
> modified and untracked files, and restore untracked files, without
> affecting the main index.  This behaviour was carried on when it was
> rewritten in C, and here, most operations performed on the second index
> are done by forked commands (ie. `read-tree' instead of reset_tree(),
> etc.).  This works most of the time, except in some edge case with the
> split-index when the split file has expired and is deleted by a forked
> command: the main index may still contain a reference to the now-deleted
> file, and subsequent operations on the index will fail [0].
> 
> The goal of this series is to modernise (a bit) builtin/stash.c, and to
> fix the aforementionned edge case.

While this patch series does fix this edge case, it doesn't fix the
root cause, which is not specific to 'git stash', but is more general
issue when using split index with an alternate index.  More on this in
the notes attached to the patch below.

Having said that, and without actually looking at your patches, I
think removing the second index from the builtin stash is a good idea
nonetheless.

> I have to admit that I don't really know how to test this.
> GIT_TEST_SPLIT_INDEX failed on me (gdb showed me that it does not enable
> the split-index at all, at least in `git stash' and its forks)

You are right, as it turns out GIT_TEST_SPLIT_INDEX=1 has been broken
for a while now.  The patch below fixes this, but there is a bit of a
fallout of test failures, which it doesn't fix, because I'm not quite
sure how to fix one of them.  Again, more on this in the attached
notes.

  ---  >8  ---

Subject: [PATCH] [RFH] read-cache: fix GIT_TEST_SPLIT_INDEX

Setting GIT_TEST_SPLIT_INDEX=1 is supposed to turn on the split-index
feature in the test suite and trigger index splitting (mostly)
randomly.  Alas, this has been broken since 6e37c8ed3c (read-cache.c:
fix writing "link" index ext with null base oid, 2019-02-13), and no
index splitting has been performed at all since then.

There are two places where we check the value of GIT_TEST_SPLIT_INDEX,
and before 6e37c8ed3c they worked like this:

  1) In the lower-level do_write_index(), where, if
     GIT_TEST_SPLIT_INDEX is enabled, we call init_split_index().
     This call merely allocates and zero-initializes
     'istate->split_index', but does nothing else (i.e. doesn't fill
     the base/shared index with cache entries, doesn't actually write
     a shared index file, etc.).  Pertinent to this issue, the hash of
     the base index remains all zeroed out.

  2) In the higher-level write_locked_index(), where, if
     GIT_TEST_SPLIT_INDEX is enabled _and_ 'istate->split_index' has
     already been initialized, it randomly sets the flag that triggers
     index splitting later in this function.  This randomness comes
     from the first byte of the hash of the base index via an 'if
     ((first_byte & 15) < 6)' condition.

     However, if 'istate->split_index' hasn't been initialized (i.e.
     still NULL), then it calls do_write_locked_index(), which
     internally calls do_write_index() mentioned above, and then a
     'goto out' skips right over this second GIT_TEST_SPLIT_INDEX
     check.

This means that while GIT_TEST_SPLIT_INDEX=1 usually triggered index
splitting randomly, the first two index writes were always
deterministic, though I suspect this was unintentional (this is still
before 6e37c8ed3c):

  - The initial index write never splits the index.
    During the first index write write_locked_index() is called with
    'istate->split_index' still uninitialized, so the check in 2) is
    not executed.  It still calls do_write_index(), though, which then
    executes the check in 1).  The resulting all zero base index hash
    then leads to the 'link' extension being written to '.git/index',
    though a shared index file is not written:

      $ rm .git/index
      $ GIT_TEST_SPLIT_INDEX=1 git update-index --add file
      $ test-tool dump-split-index .git/index
      own c6ef71168597caec8553c83d9d0048f1ef416170
      base 0000000000000000000000000000000000000000
      100644 d00491fd7e5bb6fa28c517a0bb32b8b506539d4d 0 file
      replacements:
      deletions:
      $ ls -l .git/sharedindex.*
      ls: cannot access '.git/sharedindex.*': No such file or directory

  - The second index write always splits the index.
    When the index written in the previous point is read,
    'istate->split_index' is initialized because of the presence of
    the 'link' extension.  So during the second write
    write_locked_index() does run the check in 2), and the first byte
    of the all zero base index hash always fulfills the randomness
    condition, which in turn always triggers the index splitting.

  - Subsequent index writes will find the 'link' extension with a real
    non-zero base index hash, so from then on the check in 2) is
    executed and the first byte of the base index hash is as random as
    it gets (coming from the SHA-1 of index data including timestamps
    and inodes...).

All this worked until 6e37c8ed3c came along, and stopped writing the
'link' extension if the hash of the base index was all zero:

  $ rm .git/index
  $ GIT_TEST_SPLIT_INDEX=1 git update-index --add file
  $ test-tool dump-split-index .git/index
  own abbd6f6458d5dee73ae8e210ca15a68a390c6fd7
  not a split index
  $ ls -l .git/sharedindex.*
  ls: cannot access '.git/sharedindex.*': No such file or directory

Since there is no 'link' extension, in the second index write
'istate->split_index' remains uninitialized, and the check in 2) is
not executed, and ultimately the index is never split.

Fix this by modifying write_locked_index() to make sure to check
GIT_TEST_SPLIT_INDEX even if 'istate->split_index' is still
uninitialized, and initialize it if necessary.  The check for
GIT_TEST_SPLIT_INDEX and separate init_split_index() call in
do_write_index() thus becomes unnecessary, so remove it.  Furthermore,
add a test to 't1700-split-index.sh' to make sure that
GIT_TEST_SPLIT_INDEX=1 will keep working (though only check the
index splitting on the first index write, because after that it will
be random).

Note that this change does not restore the pre-6e37c8ed3c behaviour,
as it will deterministically split the index already on the first
index write.  Since GIT_TEST_SPLIT_INDEX is purely a developer aid,
there is no backwards compatibility issue here.  The new behaviour
does trigger test failures in 't0003-attributes.sh' and
't1600-index.sh', though, which should be fixed in preparatory patches
first.
---

Notes:
    The failures in 't1600-index.sh' are easy: those tests check how bogus
    values in $GIT_INDEX_VERSION or 'index.version' are handled, and all
    failures look like this:
    
      --- expect.err  2020-06-14 17:28:21.043527044 +0000
      +++ actual.err  2020-06-14 17:28:21.043527044 +0000
      @@ -1,2 +1,4 @@
       warning: index.version set, but the value is invalid.
       Using version
      +warning: index.version set, but the value is invalid.
      +Using version
    
    We get one such warning when writing any index file, and since we now
    split the index on the first write, we get one warning when writing
    the shared index and a second warning when writing '.git/index'.  A
    simple 'sane_unset GIT_TEST_SPLIT_INDEX' fixes these failures, and
    since this test script is about some intricacies of the index, I think
    this is the right thing to do in this case.
    
    The failure in 't0003-attributes.sh' is tricky, because it does this:
    
      # The previous tests wrote the split and shared shared index files
      # in '$TRASH_DIRECTORY/.git'.
      (
            cd bare.git &&
            GIT_INDEX_FILE=../.git/index \
            git check-attr --cached ....
      )
    
    which fails with:
    
      fatal: ./sharedindex.3e9b03a8e3e1533d2bb2e22c77d4784ce2e7b108: index file open failed: No such file or directory
    
    Unsetting GIT_TEST_SPLIT_INDEX in the test script fixes this failure
    as well, of course, though I don't think this is the right thing to do
    in this case.  Worse, this failure raises some serious questions:
    
      - Where to look for and where to write the shared index file when
        using an alternate index location?
    
        Currently it's read from / written to gitdir.  This might be fine
        as long as both cwd and the alternate index are in the same
        repository while writing and reading.  However, as this failing
        test shows, if the shared index was written in one repository,
        then an attempt to read it while in another repository using
        GIT_INDEX_FILE will fail.
    
        I think it would be more sensible to write the shared index next
        to the (alternate) index file in the same directory, wherever that
        might be.  But what about backwards compatibility?  IOW can there
        be a sensible use case that relies on GIT_INDEX_FILE pointing to
        somewhere, but its shared index file is still being written to the
        current repository?
    
      - What about expiring shared index files while using an alternate
        index?
    
        We must be careful not to expire any sharedindex.<sha1> files that
        are used by '.git/index' or any existing alternate index files.
        Unfortunately, we are not that careful, and I think this is the
        root cause of the issue that Alban is trying to fix.  The failing
        test below demonstrates this using basically only 'git
        update-index', without all the complexity of 'git stash'.
    
        test_expect_failure 'split index expiration vs. alternate index' '
            >file1 &&
            >file2 &&
    
            git update-index --split-index --add file1 &&
            # debug: this should print .git/index and .git/sharedindex.<sha1>.
            echo .git/*index* &&
    
            GIT_INDEX_FILE=.git/otherindex \
            git -c splitIndex.sharedIndexExpire=now \
            update-index --split-index --add file2 &&
            # debug: this should print .git/index, .git/otherindex and _two_
            # .git/sharedindex.<sha1> files, but, alas, it prints only one
            # shared index, because the other got expired.
            echo .git/*index* &&
    
            git diff --cached --name-only >actual1 &&
            echo file1 >expect1 &&
            test_cmp expect1 actual1 &&
    
            GIT_INDEX_FILE=.git/otherindex git diff --cached --name-only >actual2 &&
            echo file2 >expect2 &&
            test_cmp expect2 actual2
        '
    
        Now, not expiring the shared index used by '.git/index' while
        writing to an alternate split index is easy, because we do know
        about '.git/index', of course, and thus can check it to exclude
        its shared index.  But how could a git process expiring shared
        indexes know whether a shared index file belongs to an alternate
        index?!  I'm afraid it can't, which leads to the next question...
    
      - Should we even allow writing a split index when using an alternate
        index file?
    
        If we don't do that, then there is no risk of expiring the shared
        index of an alternate index, because there will be no such shared
        index to begin with.  Furthermore, if we don't write a shared
        index while using an alternate index, then we won't trigger
        expiration while using an alternate index, so we won't
        accidentally expire the shared index used by '.git/index'.
    
        Note, however, that we should still support _reading_ the shared
        index of an alternate index, as that alternate index might be the
        "real" '.git/index' of a different repository, like in the failing
        test in t0003.
    
      - Should we even allow 'splitIndex.sharedIndexExpire=now'?
    
        I believe, though haven't confirmed, that it can cause trouble
        even without using an alternate index.  Consider the following
        sequence of events:
    
          - Git process A reads '.git/index', finds the 'link' extension,
            and reads the SHA1 recorded there that determines the filename
            of its shared index.
    
          - The scheduler steps in, and puts process A to sleep.
    
          - Git process B updates the index, decides that it's time to
            write a new shared index, does so, and then because of
            'splitIndex.sharedIndexExpire=now' it removes all other shared
            index files.
    
          - The scheduler wakes process A, which now tries to open the
            shared index file it just learned about, but fails because
            that file has just been removed by process B.
    
        This is similar to the issue we have with 'git gc --prune=now',
        except that 'git gc's documentation explicitly warns about the
        risks of using '--prune=now', while the description of
        'splitIndex.sharedIndexExpire' doesn't have any such warning.
    
        I think that 'splitIndex.sharedIndexExpire=now' should be allowed,
        for those who hopefully know what they are doing, just as we allow
        'git gc --prune=now', but the documentation should clearly warn
        against its potential pitfalls.

 read-cache.c           | 22 +++++++++++++---------
 t/t1700-split-index.sh | 10 ++++++++++
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index aa427c5c17..b888c5df44 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2801,11 +2801,8 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		}
 	}
 
-	if (!istate->version) {
+	if (!istate->version)
 		istate->version = get_index_format_default(the_repository);
-		if (git_env_bool("GIT_TEST_SPLIT_INDEX", 0))
-			init_split_index(istate);
-	}
 
 	/* demote version 3 to version 2 when the latter suffices */
 	if (istate->version == 3 || istate->version == 2)
@@ -3222,7 +3219,7 @@ static int too_many_not_shared_entries(struct index_state *istate)
 int write_locked_index(struct index_state *istate, struct lock_file *lock,
 		       unsigned flags)
 {
-	int new_shared_index, ret;
+	int new_shared_index, ret, test_split_index_env;
 	struct split_index *si = istate->split_index;
 
 	if (git_env_bool("GIT_TEST_CHECK_CACHE_TREE", 0))
@@ -3237,7 +3234,9 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 	if (istate->fsmonitor_last_update)
 		fill_fsmonitor_bitmap(istate);
 
-	if (!si || alternate_index_output ||
+	test_split_index_env = git_env_bool("GIT_TEST_SPLIT_INDEX", 0);
+
+	if ((!si && !test_split_index_env) || alternate_index_output ||
 	    (istate->cache_changed & ~EXTMASK)) {
 		if (si)
 			oidclr(&si->base_oid);
@@ -3245,10 +3244,15 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 		goto out;
 	}
 
-	if (git_env_bool("GIT_TEST_SPLIT_INDEX", 0)) {
-		int v = si->base_oid.hash[0];
-		if ((v & 15) < 6)
+	if (test_split_index_env) {
+		if (!si) {
+			si = init_split_index(istate);
 			istate->cache_changed |= SPLIT_INDEX_ORDERED;
+		} else {
+			int v = si->base_oid.hash[0];
+			if ((v & 15) < 6)
+				istate->cache_changed |= SPLIT_INDEX_ORDERED;
+		}
 	}
 	if (too_many_not_shared_entries(istate))
 		istate->cache_changed |= SPLIT_INDEX_ORDERED;
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 12a5568844..e0c9e16a8a 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -507,4 +507,14 @@ test_expect_success 'do not refresh null base index' '
 	)
 '
 
+test_expect_success 'GIT_TEST_SPLIT_INDEX works' '
+	test_create_repo git-test-split-index &&
+	(
+		cd git-test-split-index &&
+		>file &&
+		GIT_TEST_SPLIT_INDEX=1 git update-index --add file &&
+		verbose test $(ls -l .git/sharedindex.* |wc -l) = 1
+	)
+'
+
 test_done
-- 
2.27.0.278.g0bed8b425d

