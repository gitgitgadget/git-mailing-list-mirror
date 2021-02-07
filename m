Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDF7C433E0
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 20:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 869BC64E3F
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 20:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhBGUZs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 15:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhBGUZr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 15:25:47 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F8CC06174A
        for <git@vger.kernel.org>; Sun,  7 Feb 2021 12:25:06 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4DYgcN4vSMzQlB2
        for <git@vger.kernel.org>; Sun,  7 Feb 2021 21:24:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maddes.net; s=MBO0001;
        t=1612729474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1kPxbzlt6oAPYsFFocFCTSk/pMt9Z/ExUVRQLeDL6Fs=;
        b=X+3uEhHL+4568BaZN8WXhVQBBfgSgAC/SE0Vm2c8OBlmsNV6OTSiFHekNffQEe26RX4YG8
        vLYR6IA13Bw2qHFCKiVzZquvzRD9PmzkGHSkPLL6KkzcU18SXlzSh1hT3AUGsaxj7IJvEG
        gc/s+SWEfokEvbY5loVig7MJN+ZIIs/4HtPEwyOeSqBIMyy2KylEptAdDnyIiVKaNLLp7y
        66MxQsQ4EfJktU2c9OfcF5DV8vvtKNaZrliYP5OuFRNbWAzrTzMgJ8gMBQpaMrzgcjh69Z
        mZD357Fhdg4cRaYGbYnuZKspaTy3K8MjsbvO3pJ149TC8SSMEouIA7rs+TWvGw==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id h98ImerYREBE for <git@vger.kernel.org>;
        Sun,  7 Feb 2021 21:24:32 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sun, 07 Feb 2021 21:24:31 +0100
From:   "M. Buecher" <maddes+git@maddes.net>
To:     git@vger.kernel.org
Subject: Re: [bug] git svn fetch: defect history - missing merges and wrong
 tag ancestors - third-party tool found
In-Reply-To: <84b991e2c08c8d0d2154d2f0a2b1b3c5@mailbox.org>
References: <8d48309d968019307915432395e226fc@mailbox.org>
 <84b991e2c08c8d0d2154d2f0a2b1b3c5@mailbox.org>
Message-ID: <483432d14bc272cf362fd8b722a09ede@mailbox.org>
X-Sender: maddes+git@maddes.net
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -8.12 / 15.00 / 15.00
X-Rspamd-Queue-Id: 70E1B1857
X-Rspamd-UID: 5b2bfa
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2021-01-03 19:12, M. Buecher wrote:
> On 2020-12-25 23:24, M. Buecher wrote:
>> Dear all,
>> 
>> I finally had the time to start converting some older Subversion
>> repositories to git repositiers and run into issues with repos using
>> "parallel" branches, so-called vendor branches [1] in Subversion to
>> track upstream changes via snapshots in a separate branch and merge
>> them into the custom build on trunk.
>> 
>> Just wanting to convert the Subversion history as-is to git.
>> I studied the git-svn reference docs [2] plus the related chapter of
>> the ProGit book [3] and assume that I understood how git-svn works.
>> Still I'm not a git expert, just a sporadic user.
>> 
>> Somehow `git svn fetch` (2.29.2.windows.3) looses merge information
>> between vendor branch and trunk plus tags are referencing the
>> predecessors instead of the original ancestor.
>> Maybe there is a manual way to fix this for that small repository, but
>> it wouldn't be feasible for larger repositories, that's why I deceided
>> to write this bug report.
>> Is there anything I missed? (see my procedure below)
>> 
>> Fortunately I ran quite early into these issues and also with a very
>> small repository of just 11 commits, so I can provide a small
>> reproduction case (see below after the links).
>> Hoping you can enhance `git svn fetch`.
> 
> Tested further with re-created Subversion repositories, that either
> looked the same but made sure that svn:mergeinfo is present
> (Subversion >=1.5 via "cherry pick merge", no "2-URL merge"), or that
> has the vendor branch being copied from trunk (both attached).
> Only when the vendor branch was a copy from trunk, then svn-git got
> the merges correct. Otherwise - even with svn:mergeinfo - it does not
> get the merges.
> 
> Assumption:
> It seems that git svn handles trunk and branches in a special way, but
> Subversion actually does not have branches.
> In Subversion there are just directories and files, and a branch/tag
> is just a copy of another directory+revision and merges can happen
> between any directories independent if they have related ancestry or
> not.
> 
> Workaround:
> As git svn does not recognize all merges correctly (especially
> cross-branch copies) those lost links must be added manually.
> I wrote a small GNU awk script (attached) to determine all
> cross-branch copies from an `svnadmin dump`. This way the first
> revision when something got copied is known.
> Running git svn just to that revision, then fixing the parents and
> continuing with git svn up the next revision.
> This helps git svn to find the correct ancestors and correctly build
> the follow merges.
> The parents can be changed with `git replace -f --graft <commit>
> <existing correct parents> <additional correct parents>`.
> Additionally before continuing with git svn this `git replace` change
> can be made permanent with `git-filter-repo --force --replace-refs
> delete-no-add`.
> 
> 
>> Any help is appreciated, thanks in advance
>> Matthias Bücher

Found a nice tool called reposurgeon [4] that helps a lot to manage 
converting a repository from Subversion to git, even in a scriptable 
way.
The authors also helped out to determine that my repository has some 
awkward commits due to older Subversion versions.

[4] https://gitlab.com/esr/reposurgeon

>> [Links]
>> [1]
>> http://svnbook.red-bean.com/en/1.8/svn.advanced.vendorbr.html#svn.advanced.vendorbr.mirrored-sources
>> [2] https://git-scm.com/docs/git-svn
>> [3] 
>> https://git-scm.com/book/en/v2/Git-and-Other-Systems-Migrating-to-Git
>> 
>> 
>> [System Info]
>> git version:
>> git version 2.29.2.windows.3
>> cpu: x86_64
>> built from commit: d054eb1fc46ff23e7c95756a7c747e2f2864b478
>> sizeof-long: 4
>> sizeof-size_t: 8
>> shell-path: /bin/sh
>> uname: Windows 10.0 19042
>> compiler info: gnuc: 10.2
>> libc info: no libc information available
>> $SHELL (typically, interactive shell): C:\Program 
>> Files\Git\usr\bin\bash.exe
>> 
>> [Enabled Hooks]
>> none
>> 
>> 
>> [Commits in Subversion]
>> A Subversion repository dump is attached, plus a test where I
>> recreated the same history directly in a git repository without an
>> issue.
>> 
>> * trunk:  a------------d--e--h--i--j--k
>> *                     /     /
>> * vendor: a (empty)--b-----f
>> *                    ^     ^
>> * tags:              c     g
>> 
>> * Vendor releases: b, f
>> * Custom modifications: e, i, j, k
>> * Tags: really just used as tags, although Subversion internally they
>> are branches. Therefore wanting to create lightweight git tags,
>> although annotated git tags would be fine too.
>> 
>> 
>> [Expected Subversion to git repo conversion]
>> * trunk => branch "main"
>> * branches/* => branch "*"
>> * tags/* => tag "*"
>> * vendor/current => branch "vendor/current" (can be renamed later to
>> just "vendor")
>> * vendor/* => tag "vendor/*" (except for vendor/current)
>> 
>> Expected "tags":
>> vendor/5.4 = rev b (maybe c when annotated)
>> vendor/5.8 = rev f (maybe g when annotated)
>> 
>> 
>> [Wrong Results]
>> Merges from "vendor/current" branch to trunk get lost.
>> Tags are referencing the predecessors of the expected commit.
>> 
>> 
>> [Procedure]
>> ```
>> ### a) preparation
>> cd /d/Coding
>> #
>> cd dd-formmailer
>> svn log --xml --quiet | grep author | sort -u | perl -pe
>> 's/.*>(.*?)<.*/$1 = /' > authors-transform.txt
>> ## edit authors-transform.txt accordingly
>> 
>> ### b) git-svn adapted from ProGit book, but with "svn/" prefix
>> cd /d/Coding
>> git svn init --stdlayout --no-metadata --prefix="svn/" --
>> 'svn+ssh://svn@vcs/dd-formmailer' dd-formmailer-git
>> cd dd-formmailer-git
>> ## edit .git/config for additional vendor branches and tags
>> << __EOF
>> ...
>> [svn-remote "svn"]
>> 	...
>> 	fetch = trunk:refs/remotes/svn/trunk
>> #	branches = vendor/current:refs/remotes/svn/vendor/current ##
>> non-glob definition not working for branches
>> 	branches = vendor/{current}:refs/remotes/svn/vendor/*
>> 	branches = branches/*:refs/remotes/svn/*
>> 	tags = vendor/*:refs/remotes/svn/tags/vendor/*
>> 	tags = tags/*:refs/remotes/svn/tags/*
>> __EOF
>> ##
>> cat .git/config
>> git svn fetch --authors-file ../dd-formmailer/authors-transform.txt
>> #
>> git branch -vv --list ; git for-each-ref
>> gitk --all &
>> ```
>> 
>> [Log]
>> $ cat .git/config
>> [core]
>>         repositoryformatversion = 0
>>         filemode = false
>>         bare = false
>>         logallrefupdates = true
>>         symlinks = false
>>         ignorecase = true
>> [svn-remote "svn"]
>>         noMetadata = 1
>>         url = svn+ssh://svn@vcs/dd-formmailer
>>         fetch = trunk:refs/remotes/svn/trunk
>>         branches = vendor/{current}:refs/remotes/svn/vendor/*
>>         branches = branches/*:refs/remotes/svn/*
>>         tags = vendor/*:refs/remotes/svn/tags/vendor/*
>>         tags = tags/*:refs/remotes/svn/tags/*
>> 
>> $ git svn fetch --authors-file ../dd-formmailer/authors-transform.txt
>> r1 = 158d53044a5628897379403647a19ea13594b532 
>> (refs/remotes/svn/vendor/current)
>>         A       _svn__guideline.txt
>>         A       _svn_client_config.txt
>>         A       _svn_dir_ignore_list.txt
>> r1 = a795b654edbc296e6f38da398f032a4851fd0a9e (refs/remotes/svn/trunk)
>>         A       dd-formmailer.css
>>         A       dd-formmailer.php
>>         A       lang/BrazilianPortuguese.php
>>         A       lang/Catalan.php
>>         A       lang/Danish.php
>>         A       lang/Deutsch.php
>>         A       lang/Dutch.php
>>         A       lang/English.php
>>         A       lang/Finnish.php
>>         A       lang/French.php
>>         A       lang/Greek.php
>>         A       lang/Italian.php
>>         A       lang/NorwegianBokmaal.php
>>         A       lang/Polish.php
>>         A       lang/Portuguese.php
>>         A       lang/Romanian.php
>>         A       lang/Russian.php
>>         A       lang/Slovak.php
>>         A       lang/Slovene.php
>>         A       lang/Spanish.php
>>         A       lang/Swedish.php
>>         A       lang/Turkish.php
>>         A       recaptchalib.php
>> r2 = 8fd8668dbed2dde6b55306c71b3b629f5ed794ec 
>> (refs/remotes/svn/vendor/current)
>> Found possible branch point:
>> svn+ssh://svn@vcs/dd-formmailer/vendor/current =>
>> svn+ssh://svn@vcs/dd-formmailer/vendor/5.4, 1
>> Found branch parent: (refs/remotes/svn/tags/vendor/5.4)
>> 158d53044a5628897379403647a19ea13594b532
>> Following parent with do_switch
>>         A       dd-formmailer.css
>>         A       dd-formmailer.php
>>         A       lang/BrazilianPortuguese.php
>>         A       lang/Catalan.php
>>         A       lang/Danish.php
>>         A       lang/Deutsch.php
>>         A       lang/Dutch.php
>>         A       lang/English.php
>>         A       lang/Finnish.php
>>         A       lang/French.php
>>         A       lang/Greek.php
>>         A       lang/Italian.php
>>         A       lang/NorwegianBokmaal.php
>>         A       lang/Polish.php
>>         A       lang/Portuguese.php
>>         A       lang/Romanian.php
>>         A       lang/Russian.php
>>         A       lang/Slovak.php
>>         A       lang/Slovene.php
>>         A       lang/Spanish.php
>>         A       lang/Swedish.php
>>         A       lang/Turkish.php
>>         A       recaptchalib.php
>> Successfully followed parent
>> r3 = 7ab4f436cafc8af3ed2e727a6d8cbef1a8f8b39f 
>> (refs/remotes/svn/tags/vendor/5.4)
>>         A       dd-formmailer.css
>>         A       dd-formmailer.php
>>         A       lang/BrazilianPortuguese.php
>>         A       lang/Catalan.php
>>         A       lang/Danish.php
>>         A       lang/Deutsch.php
>>         A       lang/Dutch.php
>>         A       lang/English.php
>>         A       lang/Finnish.php
>>         A       lang/French.php
>>         A       lang/Greek.php
>>         A       lang/Italian.php
>>         A       lang/NorwegianBokmaal.php
>>         A       lang/Polish.php
>>         A       lang/Portuguese.php
>>         A       lang/Romanian.php
>>         A       lang/Russian.php
>>         A       lang/Slovak.php
>>         A       lang/Slovene.php
>>         A       lang/Spanish.php
>>         A       lang/Swedish.php
>>         A       lang/Turkish.php
>>         A       recaptchalib.php
>> r4 = 7ec3663fd8e7c9fcfeb2742968a948d6978776d4 (refs/remotes/svn/trunk)
>>         M       dd-formmailer.css
>>         M       dd-formmailer.php
>>         A       dd-verify.php
>> r5 = e65ba2bdcd12a1935c1a327507dad6b7117f452b (refs/remotes/svn/trunk)
>>         A       calendar.gif
>>         A       date_chooser.js
>>         M       dd-formmailer.css
>>         M       dd-formmailer.php
>>         A       lang/Belarussian.php
>>         A       lang/Czech.php
>>         A       lang/Estonian.php
>>         A       lang/Japanese.php
>>         A       lang/Vietnamese.php
>>         M       recaptchalib.php
>> r6 = 9f95df7ce49c5d1cb4715017d223a8bd1c8dcffc 
>> (refs/remotes/svn/vendor/current)
>> Found possible branch point:
>> svn+ssh://svn@vcs/dd-formmailer/vendor/current =>
>> svn+ssh://svn@vcs/dd-formmailer/vendor/5.8, 3
>> Found branch parent: (refs/remotes/svn/tags/vendor/5.8)
>> 8fd8668dbed2dde6b55306c71b3b629f5ed794ec
>> Following parent with do_switch
>>         A       calendar.gif
>>         A       date_chooser.js
>>         M       dd-formmailer.css
>>         M       dd-formmailer.php
>>         A       lang/Belarussian.php
>>         A       lang/Czech.php
>>         A       lang/Estonian.php
>>         A       lang/Japanese.php
>>         A       lang/Vietnamese.php
>>         M       recaptchalib.php
>> Successfully followed parent
>> r7 = cc00cb187386298cf974dda69f151d2ad4795917 
>> (refs/remotes/svn/tags/vendor/5.8)
>>         A       calendar.gif
>>         A       date_chooser.js
>>         M       dd-formmailer.css
>>         M       dd-formmailer.php
>>         M       dd-verify.php
>>         A       lang/Belarussian.php
>>         A       lang/Czech.php
>>         A       lang/Estonian.php
>>         A       lang/Japanese.php
>>         A       lang/Vietnamese.php
>>         M       recaptchalib.php
>> Checking svn:mergeinfo changes since r5: 1 sources, 1 changed
>> W: Cannot find common ancestor between
>> e65ba2bdcd12a1935c1a327507dad6b7117f452b and
>> 9f95df7ce49c5d1cb4715017d223a8bd1c8dcffc. Ignoring merge info.
>> r8 = 9a5cd8f55f377f469280171cd87219b8f528c693 (refs/remotes/svn/trunk)
>>         M       dd-formmailer.php
>> r9 = 8143782376d9fbc91a9181b367b72701205b017f (refs/remotes/svn/trunk)
>>         M       dd-formmailer.php
>> r10 = 6f563fc4c511ddcc53c2ffc5d26c1e116725bc6b 
>> (refs/remotes/svn/trunk)
>>         M       _svn_client_config.txt
>> r11 = e9130854178d2c2743a981f303cdd7f34e54b052 
>> (refs/remotes/svn/trunk)
>> svnserve: E210002: Network connection closed unexpectedly
>> Checked out HEAD:
>>   svn+ssh://svn@vcs/dd-formmailer/trunk r11
>> 
>> $ git branch -vv --list ; git for-each-ref
>> * main e913085 Updated client config for Windows Scripts
>> e9130854178d2c2743a981f303cdd7f34e54b052 commit refs/heads/main
>> 7ab4f436cafc8af3ed2e727a6d8cbef1a8f8b39f commit 
>> refs/remotes/svn/tags/vendor/5.4
>> cc00cb187386298cf974dda69f151d2ad4795917 commit 
>> refs/remotes/svn/tags/vendor/5.8
>> e9130854178d2c2743a981f303cdd7f34e54b052 commit refs/remotes/svn/trunk
>> 9f95df7ce49c5d1cb4715017d223a8bd1c8dcffc commit 
>> refs/remotes/svn/vendor/current
