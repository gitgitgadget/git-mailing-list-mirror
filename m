Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCA3C432C0
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 00:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23DCF2071F
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 00:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXy4X5IK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfKWAfB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 19:35:01 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:39430 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfKWAfA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 19:35:00 -0500
Received: by mail-wm1-f54.google.com with SMTP id t26so9631157wmi.4
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 16:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A3gZ1dPLc44EXYE3r7Sq+w+7eb5BJqReelFohNNIQDU=;
        b=FXy4X5IKuMkvBeSO3Ga9+dXXkpHsGff2kOkzekAlyhXekyT187xiUb5kmAkEVwo5Xi
         0Fs5DmgGj+5QI5cG+j1Y3iRbNCRsaFo9mwg++cd1ZQXk+WsYMSlKokuOw11GIxtgmr9u
         h5lMpo4071Eyui29LrOY1TRC3VzsXt1sK5QJjz1rUY3eIi+X99aQF6LRZ0ZaEb9KzVse
         iusEZi01FxJTADRqiQSL8uTHvPDyAyS7mGEKRxuIPoBM6shtjsfGhCxry7MO6rUwEGAp
         5nWv+52tkbeII01smtAgwaBQfqgI31sPVSDdCWLfGDiTPzifjr63/Ozh0+nLGDlfgVU0
         Fj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A3gZ1dPLc44EXYE3r7Sq+w+7eb5BJqReelFohNNIQDU=;
        b=FdSQe5kbqBE6ozJnJfkMvV29dktZOY6T9kvdts6SjjsS1Mkn++sIIPLpOmPARep8xa
         O5HJF7bJUdealAZRStRfX2qE0C/2dtgLTsl50ad28j4qi8tEAAlMS9F/rg8eFeK6y+vV
         bfa8lSy5Z/yXR58pj/26pHACZ83/nRq4mnjdUCgsuC5eAY3mdpKepxJj8ipj7rKtcTRa
         9ILrhx62eBesSHeencnMR+805GzSx6xpCnk127zQtMFHSq/yw+D7h9msbj/Shzi5VyjR
         +bEu18mb/CgNmoBZFfxDO0Rh1qpOmxE1UEWybjDzciMq2ApVKyVC9tw7ESYTqrJU8Soa
         5iMQ==
X-Gm-Message-State: APjAAAVY5vQUnto8D9qa4IIFYsXB98Lv7fieMydMLIfg0rO4sx5pmJdh
        KJS3mHbIDA4p3e7b8CTFS44=
X-Google-Smtp-Source: APXvYqwtxflmP0cSQHqKwA9R6XsMStOZSNKzMBz1RVyzbmtjS8AAyMikwSM9ujzs4sYnkBNuahamcg==
X-Received: by 2002:a1c:7e0e:: with SMTP id z14mr19746310wmc.52.1574469297904;
        Fri, 22 Nov 2019 16:34:57 -0800 (PST)
Received: from szeder.dev (x4db9604a.dyn.telefonica.de. [77.185.96.74])
        by smtp.gmail.com with ESMTPSA id x7sm9689217wrq.41.2019.11.22.16.34.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 16:34:57 -0800 (PST)
Date:   Sat, 23 Nov 2019 01:34:54 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Brian Norris <briannorris@chromium.org>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: git 2.24: git revert <commit1> <commit2> requires extra
 '--continue'?
Message-ID: <20191123003454.GA23183@szeder.dev>
References: <CA+ASDXNQ+9i-6uCNDwN46cnHJeciiqQSX5Z6EaqB9pbseQhVFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+ASDXNQ+9i-6uCNDwN46cnHJeciiqQSX5Z6EaqB9pbseQhVFw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 22, 2019 at 03:10:20PM -0800, Brian Norris wrote:
> Hi! I'm using git 2.24 (or, a variant of that packaged my distro -- I
> can try to build my own if this is deemed not reproducible), and I
> feel like I've been seeing a regression here:
> 
> Previously, when reverting multiple commits (with the default --edit
> behavior), as soon as I'm done editing the first revert commit
> message, the second revert commit pops up an editor, and I'm on my
> way. Now, it seems to require an extra 'git revert --continue' prompt
> in between, yet it doesn't actually recommend that. This is highly
> confusing, and seemingly unnecessary.

Thanks for the report, this is indeed a regression in v2.24.0: it
bisects down to a47ba3c777 (rebase -i: check for updated todo after
squash and reword, 2019-08-19) [Cc'ing Phillip].  It's not specific to
'git revert', but with a slight variation affects 'git cherry-pick' as
well.

> An annotated transcript provided below.

I transcribed your transcript into tests that can be run in our test
framework and demonstrate this regression:

  --- >8 ---

#!/bin/sh

test_description='test'

. ./test-lib.sh

test_expect_success "Brian's revert regression" '
	test_create_repo revert &&
	(
		cd revert &&

		echo 1 >file &&
		git add file &&
		git commit -m first &&
		echo 2 >file &&
		git commit -am second &&
		echo 3 >file &&
		git commit -am third &&

		git checkout -b branch &&

		git revert --edit HEAD HEAD^ &&

		echo 1 >expect &&
		test_cmp expect file
	)
'

test_expect_success "a variant of Brian's regression for cherry-pick" '
	test_create_repo cherry-pick &&
	(
		cd cherry-pick &&

		echo 1 >file &&
		git add file &&
		git commit -m first &&
		echo 2 >file &&
		git commit -am second &&
		echo 3 >file &&
		git commit -am third &&

		git checkout -b branch HEAD^^ &&

		git cherry-pick --edit master^ master &&

		echo 3 >expect &&
		test_cmp expect file
	)
'

test_done

  ---  >8  ---

They both succeed on a47ba3c777's parent, but fail on a47ba3c777 when
the 'git revert' or 'git cherry-pick' commands return with exit code 1
after reverting/cherry-picking the first commit instead of processing
the second commit:

  + git revert --edit HEAD HEAD^
  [branch 88ea48c] Revert "third"
   Author: A U Thor <author@example.com>
   1 file changed, 1 insertion(+), 1 deletion(-)
  On branch branch
  Revert currently in progress.
  
  nothing to commit, working tree clean
  error: last command exited with $?=1
  not ok 1 - Brian's revert regression



  + git cherry-pick --edit master^ master
  [branch 2cb3f74] second
   Author: A U Thor <author@example.com>
   Date: Sat Nov 23 00:17:32 2019 +0000
   1 file changed, 1 insertion(+), 1 deletion(-)
  On branch branch
  Cherry-pick currently in progress.
  
  nothing to commit, working tree clean
  The previous cherry-pick is now empty, possibly due to conflict
  resolution.
  If you wish to commit it anyway, use:
  
      git commit --allow-empty
  
  If you wish to skip this commit, use:
  
      git reset
  
  Then "git cherry-pick --continue" will resume cherry-picking
  the remaining commits.
  error: last command exited with $?=1
  not ok 2 - a variant of Brian's regression for cherry-pick


These test should probably be squeezed into
't3508-cherry-pick-many-commits.sh', but Friday has just turned into
Saturday around here, so that's enough from me for now.


> Note that none of this happens with --no-edit; my reverts happen
> smoothly, with no extra need for --continue.
> 
> Regards,
> Brian
> 
> $ mkdir tmp
> $ cd tmp
> /tmp$ git init
> Initialized empty Git repository in [...]/tmp/.git/
> /tmp$ touch foo
> /tmp$ git add foo
> /tmp$ echo bar >> foo
> /tmp$ git commit -am baz
> [master (root-commit) a388f78d9013] baz
>  1 file changed, 1 insertion(+)
>  create mode 100644 foo
> /tmp$ echo pow >> foo
> /tmp$ git commit -am whizzbang
> [master 51753222dd9a] whizzbang
>  1 file changed, 1 insertion(+)
> /tmp$ echo pop >> foo
> /tmp$ git commit -am nothing
> [master 7153607b11e0] nothing
>  1 file changed, 1 insertion(+)
> /tmp$ git revert HEAD HEAD^
> ## EDITOR pops up, as expected
> [master 586469974ec2] Revert "nothing"
>  1 file changed, 1 deletion(-)
> On branch master
> Revert currently in progress.
> 
> nothing to commit, working tree clean
> ## Unexpected, confusing pause? No prompt to '--continue'
> /tmp$ git log --oneline
> 586469974ec2 (HEAD -> master) Revert "nothing"
> 7153607b11e0 nothing
> 51753222dd9a whizzbang
> a388f78d9013 baz
> /tmp$ git status
> On branch master
> Revert currently in progress.
>   (run "git revert --continue" to continue)
>   (use "git revert --skip" to skip this patch)
>   (use "git revert --abort" to cancel the revert operation)
> 
> nothing to commit, working tree clean
> /tmp$ git revert --continue
> ## EDITOR pops up, as expected
> [master b8dd23f61d07] Revert "whizzbang"
>  1 file changed, 1 deletion(-)
> On branch master
> Revert currently in progress.
> 
> nothing to commit, working tree clean
> ## Unexpected state; both reverts happened, but revert is still in progress?
> /tmp$ git log --oneline
> b8dd23f61d07 (HEAD -> master) Revert "whizzbang"
> 586469974ec2 Revert "nothing"
> 7153607b11e0 nothing
> 51753222dd9a whizzbang
> a388f78d9013 baz
> /tmp$ git status
> On branch master
> Revert currently in progress.
>   (run "git revert --continue" to continue)
>   (use "git revert --skip" to skip this patch)
>   (use "git revert --abort" to cancel the revert operation)
> 
> nothing to commit, working tree clean
> ## OK...I'll run it one more time.
> /tmp$ git revert --continue
> /tmp$ git status
> On branch master
> nothing to commit, working tree clean
> ## *Now* I'm done
> /tmp$ git log --oneline
> b8dd23f61d07 (HEAD -> master) Revert "whizzbang"
> 586469974ec2 Revert "nothing"
> 7153607b11e0 nothing
> 51753222dd9a whizzbang
> a388f78d9013 baz
