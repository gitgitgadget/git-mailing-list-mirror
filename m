Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EBCC54EE9
	for <git@archiver.kernel.org>; Sun, 11 Sep 2022 14:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiIKOPD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Sep 2022 10:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiIKOPA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2022 10:15:00 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A98D10550
        for <git@vger.kernel.org>; Sun, 11 Sep 2022 07:14:58 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id az24-20020a05600c601800b003a842e4983cso5386697wmb.0
        for <git@vger.kernel.org>; Sun, 11 Sep 2022 07:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject:from:to:cc
         :subject:date;
        bh=sUSbIDxzLaT4Waplfn8k914/3QxRpQtwaGUzn0mGZxw=;
        b=mCwb7n204ugSo3K0x5nl7vpAGUg+3ooz2KZDweONv/JMec33goJZ+9Lrdx7nqLcijJ
         tG2XfmPgX4quCEbS0oJL8vonQF79Mox5t/cOHTgAlBGpd9Su47E6G1SSgL1//7SGAYvA
         hWBXSVtIzQlf1tQzL2lHrgcP267RWP0cdP1KJYUyNx/WR5RwuKXUDmHhuEbN4PJ1fQs8
         xa1WYDW7YNO4y+Q8JKcTT7dmhPgegtRoTKz4xRRRAHC4PLnvpEYjl0AS8sxSBwYgrpJY
         8IGpLi3zGK/dZgZDApxtiJ/z5NbisymW9mDeZaUED/UMJjqQUC5ng6tGo//aouRwzU4s
         kU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date;
        bh=sUSbIDxzLaT4Waplfn8k914/3QxRpQtwaGUzn0mGZxw=;
        b=HaEvOBQdbquXqxtIRNuaKOFazctHfol5Y8vJENTP6yl4TTxCKEZcJkzbPujshW0wgE
         ACwOAoUm3CrdTVlPzFgKzSOUEEzmS1/mfj+ZphCi/CmtorAqJKYABvfQ7REeASkwXiqF
         2IoFjf8RpmNpjHhbVIlm+NCXxfEf+IBx3+YXvAGYdvZ1Hwyiyi4uk2wXCxJ1IBOTs3vv
         nqgvg0qFB17eIU2U3ImNWper/SE98/ie3MBumjWkHeo/xvKt/7bI2X2Mwjq5OB4EBgsI
         MTySbZUYlQBxbwLUGqIeqkXteyV9O445knUejXClmX23QvOveYNJQiKVBK4aeb7gqeKG
         yoNA==
X-Gm-Message-State: ACgBeo3qu3ylm1QJlTX7VoFqJ8psAFGeSuq45sYUrwrW6ulXzqTIeXtH
        VroP8PUJc8EcYJFCUx57GdI=
X-Google-Smtp-Source: AA6agR6Eo9LENmF2g/p/pzi1+nxSQdQr5hOoJMGFOOKuy06vMI1kc8Ikraq3TsNriQthkODmGKTVMw==
X-Received: by 2002:a05:600c:34c2:b0:3b4:76f2:9c3b with SMTP id d2-20020a05600c34c200b003b476f29c3bmr2462140wmq.179.1662905696960;
        Sun, 11 Sep 2022 07:14:56 -0700 (PDT)
Received: from [192.168.2.52] (5.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.5])
        by smtp.gmail.com with ESMTPSA id r17-20020a05600c425100b003b32aa0fabcsm6488759wmm.4.2022.09.11.07.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Sep 2022 07:14:56 -0700 (PDT)
Subject: [PATCH v4] branch: allow "-" as a shortcut for "previous branch"
To:     git@vger.kernel.org
References: <pull.1315.git.1659910949556.gitgitgadget@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Erlend E. Aasland" <erlend.aasland@innova.no>,
        Ivan Tham <pickfire@riseup.net>,
        Aaron Greenberg <p@aaronjgreenberg.com>,
        Elena Petrashen <elena.petrashen@gmail.com>,
        Dinesh <dpdineshp2@gmail.com>,
        Kenny Lee Sin Cheong <kenny.lee28@gmail.com>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <dbc0b0d8-4b0a-8d4c-1bfa-8bdcd99310e7@gmail.com>
Date:   Sun, 11 Sep 2022 16:14:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <pull.1315.git.1659910949556.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach "git branch" the use of "-" as a shortcut for "@{-1}", like in "checkout
-", "merge -" and other commands.

Usage examples:

	$ git branch -d -              # git branch -d @{-1}
	$ git branch -M some-branch -  # git branch -M some-branch @{-1}
	$ git branch -c - new-branch   # git branch -c @{-1} new-branch

Possible workflow:

	$ git checkout work_to_review
	$ git checkout -
	$ git merge -  # or git rebase -
	$ git branch -d -


This change will be unnecessary if "-" ends up being supported globally as a
shortcut for "previous branch".  The usage examples and the tests will remain
valid.

Previous-work-by: Kenny Lee Sin Cheong <kenny.lee28@gmail.com>
Previous-work-by: Dinesh <dpdineshp2@gmail.com>
Previous-work-by: Elena Petrashen <elena.petrashen@gmail.com>
Previous-work-by: Aaron Greenberg <p@aaronjgreenberg.com>
Previous-work-by: Ivan Tham <pickfire@riseup.net>
Previous-work-by: Erlend E. Aasland <erlend.aasland@innova.no>
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Reviewed-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Rubén Justo <rjusto@gmail.com>
---

Let's recap this.

We have discussed two topics, related but somewhat different:
  1.- teach "git branch" to support "-" as a shortcut of "previous-branch"
  2.- teach "git" to support "-" as a shortcut of "previous-branch" _anywhere a
      branch is expected_

I'll refer to the former as "local support" and the latter as "global support".

Teach "git branch -d" about "-" as a shortcut of "previous-branch" is the main
intention of the patch that originates this thread.

Teach "git" about the shortcut makes unnecessary, at first, the change in "git
branch".  It makes "-" work in "git branch" and everywhere else as well.   And
this is what makes tempting to skip the "local support" and go for the "global
support".

Attempts of "global support" can be tracked back to Jan 2009 [2], just days
after the syntax "@{-1}" was presented [1] or the "git checkout -" (the real
originator of all of this) patch was committed.  Each of this attempts has
received some concerns and not many reviews and/or iterations to allow the
curation and integration of the change.  Meanwhile, since "checkout -" was
introduced: "merge -", "cherry-pick -", "rebase -" and "worktree -", have
gained support for "-" on its own, via a local: if (!strcmp(argv[i], "-"))
argv[i] = "@{-1}".

Since 2016 there have been, at least, five patch series (see below) to make a
similar (some equal) change in "git branch -d".  The motivations suggested each
time have been the same: fulfill the intuitive use of "-" when deleting
branches, following the path of, initially, "cd -" and then "checkout -", 
"merge -",.. not any other function of "git branch".  As well as the attempts 
for the "global support", each of this attempts has also received some
concerns, reviews and done some iterations.

Let's have a look at the reviews and/or concerns about the "local support" 
first, and then the ones about the "global support".

Reviews and/or concerns about "git branch -d -":

 * /if (!strcmp(argv[i], "-")) argv[i] = "@{-1}/ is somewhat of a hack
 
   https://lore.kernel.org/git/7s9s8p38-r22n-opnn-9219-0p49onrro70s@tzk.qr/
 
   > Sure, we can accept one more one-off hack to support a single `-` argument
   > to refer to the previous branch. The sum of those hacks, however, becomes
   > a burden.
 
   Do we want a more elaborated way of the hack? ie:

        +       const char* handle_dash_alias_argv(const char* arg)
        +       {
        +           if (arg && !strcmp(argv[i], "-"))
        +                   return "@{-1}";
        +
        +               return arg;
        +       }
        ...
        -       if (!strcmp(arg, "-"))
        -               arg = "@{-1}";
        +       arg = handle_dash_alias_argv(arg);
        ...
        -       } else if (argc == 1 && !strcmp(argv[0], "-")) {
        -               argv[0] = "@{-1}";
        +       } else if (argc == 1) {
        +               argv[0] = handle_dash_alias(argv[0]);

   Or, do we want to keep it simple and expect that the "global support" will
   allow this hacks vanish easily?

   The "global support" resolves automatically this.  Will make all of this
   hacks unnecessary.  So, isn't this more of an argument to defend the work
   in the "global support" than a concern for this patch?

 
 * The patch only considers "git branch -d/-D", not any other options like
 * "-m", "-c", "-u", "--unset-upstream", "--edit-description"

   First things first.  This review has already been productive: some of those
   uncovered options by the patch weren't even supporting "@{-N}", which is 
   documented to be supported everywhere.  So, thank you.  A patch to fix this
   has already been submitted [E].

   On the other hand, an argument can be used here: the operations that
   currently support the shortcut (ie: merge, rebase, workdir...) do not do it
   in all of its capabilities, and this can considered a good thing.  Allowing
   the previously commented hack to stay simple by not covering the
   corner-cases no one has needed yet (maybe never will).  Eventually,
   if the "global support" is achieved, there would be no need to do
   anything to complete that currently missing support.  Will be completed
   automatically.
 

 * "git branch -d -" is a destructive operation unlike the other operations
 * currently supporting the "-" alias (ie: checkout, merge,...)
  
   There is a reasonable twist for this argument: is this a concern for this
   patch or a spark to think about the destructive aspects of "git branch -d"?
   Maybe the reflog can be gc'ed and not deleted [F]? Better or new advices [7]?
   ...

   Also an interesting argument to consider:
 
   https://lore.kernel.org/git/xmqqvadidbo7.fsf@gitster-ct.c.googlers.com/
 
   >     $ git checkout somelongtopicname
   >     $ work work work
   >     $ git checkout master && git merge -
   >     $ git branch -d -
   >
   > would be a lot less error-prone than the user being forced to write
   > last step in longhand
   >
   >     $ git branch -d someotherlongtopicname
   >
   > and destroying an unrelated but similarly named branch.

   More about this, below in the concerns about "global support" where
   isolated "-" in the command line are described.

 
 * Confusing error message: "error: branch "@{-1}" not found." received, but
 * "-" was specified.
 
   This is a legit concern and can be argued that it is already happening in
   the commands that already support the shortcut:
 
       $ git merge -
       merge: @{-1} - not something we can merge

   This can be reasoned because solving it will require /dig deeper/ in the
   hack discussed above and shouldn't be creating a lot of confusion.

   Current WIP patches for "global support" show that this problem will vanish
   along with the hacks.  So, again, this becomes more of an argument for
   having "global support" than a complain about this patch.  Thought in this
   case, it is not just the _burden in the code_ but the experience of the
   user, which has repercussion so it requires special consideration.


Reviews and/or concerns about global support of the shortcut:

 * '-' is also known as a synonym for stdin

   https://lore.kernel.org/git/20200429190013.GG83442@syl.local/
    
   > > > +To delete the previous branch::
   > > > ++
   > > > +------------
   > > > +$ git branch -D -
   > >
   > > ... so this suggests that the command, when used like this:
   > >
   > > $ echo "branch_name" | git branch -D -
   > >
   > > will delete "branch_name" rather than some "previous" branch, whatever
   > > that means.
   > >
   > > Is this short-cut /that/ important to create yet another confusion?
   >
   > I think that it may be causing more confusion now than it would be after
   > Ivan's patch. 'git checkout', for example, also treats '-' as a synonym
   > for '@{-1}'.
   >
   > In my opinion, it is fairly clear that 'git branch -D -' means "delete
   > the last branch", and not "delete a list of branches from stdin.


 * Isolated "-" is a risk when misspelling command lines

   https://lore.kernel.org/git/20200429195745.GC3920@syl.local/
   
   > > BTW, what about mistyping:
   > >
   > > $ git branch -d - f my_branch
   > >
   > > for
   > >
   > > $ git branch -d -f my_branch
   > >
   > > or some such?
   > >
   > > No, it still doesn't look like a good idea to use isolated '-' as
   > > suggested by the patch.
   >
   > Frankly, I do not find this compelling. Does that mean that '/' as a
   > directory separator is dangerous, too, because you can accidentally
   > write 'rm -rf / foo/bar/baz'?


 * "-" must be a synonym of "@{-1}", but not making "-^2~15" a synonym of
   "@{-1}^2~15"
   
   https://lore.kernel.org/git/5194s6qn-570s-6053-2104-9s22qo1874sn@tzk.qr/

   > To illustrate what I mean: `-` should not be idempotent to `@{-1}` because
   > we want to allow things like `@{-1}^2~15` but we do not want `-^2~15` to
   > be a synonym for that.

   I cannot find any argument for this.  "-" should or shouldn't be idempotent
   to "@{-1}", for me it needs more thought and exploration.  But an agreement
   to left it restricted but open to consideration sounds plausible.


After all of this, if you are still here, sounds reasonable to say:
    - there is no clear concern or review that justifies why "git branch"
      hasn't been taught to support the "-" shortcut
    - "global support" of "-" as a shortcut for "@{-1}" or "previous-branch"
      deserves some work


This is the v4 of the patch to support the shortcut "-" in "branch -d".  The
changes are:
   - Handle "-" when deleting multiple branches
   - Add support for -m/-c.
   - New tests
   - Commit message, to reflect changes and include names of people
     who previously worked on this.

The switches "--edit-description", "--set-upstream-to" and "--unset-upstream"
can adopt the hack, if necessary, whenever the patch [E] that fixes supporting
"@{-1}" is merged.  It is not necessary, and it is better this way, to link 
the fix with the support of "-", which is not clear if it will be.


I won't send a v5, promise :-)... but an RFC v1 for the "global support"?:

    diff --git a/setup.c b/setup.c
    index cefd5f63c4..de86bb2d98 100644
    --- a/setup.c
    +++ b/setup.c
    @@ -266,8 +266,6 @@ void verify_filename(const char *prefix,
                         const char *arg,
    ?                    int diagnose_misspelt_rev)
     {
    ?       if (*arg == '-')
    ?               die(_("option '%s' must come before non-option arguments"), arg);
            if (looks_like_pathspec(arg) || check_filename(prefix, arg))


Thank you all for making this not only useful but also interesting and enriching.


Pd. A chronology:

15 Jan 2009 -      [1] - Patch to introduce "checkout '-'" that itself
                         introduces the notation @{-N}

17 Jan 2009 - ae5a6c36 - checkout: implement "@{-N}" shortcut name for N-th
                         last branch

17 Jan 2009 - 696acf45 - checkout: implement "-" abbreviation, add docs and
                         tests

13 Feb 2009 - 8415d5c7 - Teach the "@{-1} syntax to "git branch"

13 Feb 2009 - c9717ee9 - Teach @{-1} to git merge

21 Mar 2009 -      [2] - 1st attempt to have "-" as an universal alias of
                         @{-1}

 7 Apr 2011 - 4e8115ff - merge: allow "-" as a short-hand for "previous
                         branch"

 5 Sep 2013 - 182d7dc4 - cherry-pick: allow "-" as abbreviation of '@{-1}'

19 Jul 2013 -      [3] - [RFC] Delete current branch

19 Mar 2014 - 4f407407 - rebase: allow "-" short-hand for the previous branch

10 Mar 2015 -      [4] - [JFF] "-" and "@{-1}" on various program

16 Mar 2015 -      [5] - [PATCH/RFC 0/2][GSoC] revision.c: Allow "-" as
                         stand-in for "@{-1}" everywhere a branch is allowed

 5 Mar 2016 -      [6] - [PATCH] branch.c: Allow "-" as a short-hand for
                         "@{-1}" in "git branch -d @{-1}"

18 Mar 2016 -      [7] - [PATCH][Outreachy] branch: allow - as abbreviation of
                         '@{-1}'

27 May 2016 - 1a450e2f - worktree: allow "-" short-hand for @{-1} in add
                         command

 5 Feb 2017 -      [8] - [PATCH/RFC] WIP: log: allow "-" as a short-hand for
                         "previous branch"

 8 Mar 2017 -      [9] - [PATCH] diff: allow "-" as a short-hand for "last
                         branch"

21 Mar 2018 -      [A] - [PATCH] branch: implement shortcut to delete last
                         branch

29 Abr 2020 -      [B] - [PATCH] branch: add '-' to delete previous branch

16 Feb 2022 -      [C] - [PATCH] branch: delete now accepts '-' as branch name

 8 Ago 2022 -      [D] - [PATCH] branch: allow "-" as a short-hand for
                         "previous branch"


[1] 1231977976-8739-1-git-send-email-trast@student.ethz.ch
[2] 7vskl69xw3.fsf_-_@gitster.siamese.dyndns.org
[3] CALkWK0=8q4J2yi2to_+41kJSA5E59CBwkG69Hj7MmTPgUnSh5Q@mail.gmail.com
[4] xmqqy4n4zjst.fsf@gitster.dls.corp.google.com
[5] 1426518703-15785-1-git-send-email-kenny.lee28@gmail.com
[6] 1457176366-14952-1-git-send-email-dpdineshp2@gmail.com
[7] 1458305231-2333-1-git-send-email-elena.petrashen@gmail.com
[8] 1486299439-2859-1-git-send-email-kannan.siddharth12@gmail.com
[9] 1clZj4-0006vN-9q@crossperf.com
[A] 1521770966-18383-1-git-send-email-p@aaronjgreenberg.com
[B] 20200429130133.520981-1-pickfire@riseup.net
[C] pull.1217.git.git.1645020495014.gitgitgadget@gmail.com
[D] pull.1315.git.1659910949556.gitgitgadget@gmail.com
[E] 7abdb5a9-5707-7897-4196-8d2892beeb81@gmail.com
[F] 20120719213225.GA20311@sigill.intra.peff.net



 builtin/branch.c                      | 11 +++++++++++
 t/t3204-branch-name-interpretation.sh | 19 ++++++++++++++-----
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 55cd9a6e99..66503d18d1 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -245,6 +245,9 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		char *target = NULL;
 		int flags = 0;
 
+		if (argv[i] && !strcmp(argv[i], "-"))
+			argv[i] = "@{-1}";
+
 		strbuf_branchname(&bname, argv[i], allowed_interpret);
 		free(name);
 		name = mkpathdup(fmt, bname.buf);
@@ -527,6 +530,14 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 			die(_("cannot rename the current branch while not on any."));
 	}
 
+	if (oldname && !strcmp(oldname, "-")) {
+		oldname = "@{-1}";
+	}
+
+	if (newname && !strcmp(newname, "-")) {
+		newname = "@{-1}";
+	}
+
 	if (strbuf_check_branch_ref(&oldref, oldname)) {
 		/*
 		 * Bad name --- this could be an attempt to rename a
diff --git a/t/t3204-branch-name-interpretation.sh b/t/t3204-branch-name-interpretation.sh
index 993a6b5eff..84b646e1f7 100755
--- a/t/t3204-branch-name-interpretation.sh
+++ b/t/t3204-branch-name-interpretation.sh
@@ -57,14 +57,15 @@ test_expect_success 'create branch with pseudo-qualified name' '
 	expect_branch refs/heads/refs/heads/qualified two
 '
 
-test_expect_success 'delete branch via @{-1}' '
-	git branch previous-del &&
+test_expect_success 'delete branch via @{-N} and -' '
+	git checkout -b previous-one-del &&
+	git checkout -b previous-two-del &&
 
-	git checkout previous-del &&
 	git checkout main &&
 
-	git branch -D @{-1} &&
-	expect_deleted previous-del
+	git branch -D - @{-2} &&
+	expect_deleted previous-one-del &&
+	expect_deleted previous-two-del
 '
 
 test_expect_success 'delete branch via local @{upstream}' '
@@ -133,4 +134,12 @@ test_expect_success 'checkout does not treat remote @{upstream} as a branch' '
 	expect_branch HEAD one
 '
 
+test_expect_success 'rename and copy branches via -' '
+	git checkout -b one-branch &&
+	git checkout - &&
+	git branch -c - two-branch &&
+	git branch -m - three-branch &&
+	git branch -m three-branch -
+'
+
 test_done
-- 
2.36.1
