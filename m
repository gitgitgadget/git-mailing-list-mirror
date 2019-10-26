Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F9BC1F4C0
	for <e@80x24.org>; Sat, 26 Oct 2019 14:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfJZO7z (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Oct 2019 10:59:55 -0400
Received: from renault.us.lt ([79.98.26.146]:36234 "EHLO renault.us.lt"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbfJZO7z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Oct 2019 10:59:55 -0400
X-Greylist: delayed 1277 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Oct 2019 10:59:53 EDT
Received: from [127.0.0.1] (helo=renault.us.lt)
        by renault.us.lt with esmtpa (Exim 4.92.3)
        (envelope-from <dev@kipras.org>)
        id 1iOND8-00026w-Vn
        for git@vger.kernel.org; Sat, 26 Oct 2019 17:38:34 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 26 Oct 2019 17:38:34 +0300
From:   dev@kipras.org
To:     git@vger.kernel.org
Subject: [FR] Allow `git stash create` to include untracked changes
Message-ID: <d02ddc0db596771820b0cfdfae5b1504@kipras.org>
X-Sender: dev@kipras.org
User-Agent: Roundcube Webmail/1.3.10
X-Authenticated-Id: dev@kipras.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

TL;DR:
Would it be possible for `git stash create` to include untracked changes 
(probably the same way `git stash push --include-untracked` does)?

---

I'm having some trouble with `git stash create`.

Currently, in my script (https://github.com/sarpik/git-backup), I 
essentially want to create a stash from untracked changes, create a 
branch from the stash, push the branch to a remote repository & pop the 
stash back, while keeping the backup branch. A remote stash, if you may.

I'm able to do this with regular `git stash push --include-untracked` 
and `git stash pop` commands, but there're some issues I've encountered 
and I believe that this is not the optimal solution.
This could be solved with `git stash create`, but it's unable to (as far 
as I know) create the stash with untracked/all changes.

Once again:
Would it be possible for `git stash create` to include untracked changes 
(probably the same way `git stash push --include-untracked` does)?

---

The issues I've so far encountered were:

Say I'm in an untracked directory. If I run `git stash push 
--include-untracked` and stay in this untracked directory, which 
actually does not exist anymore, and then run `git stash pop`, I get 
fatal errors and I'm unable to do anything else:

fatal: Unable to read current working directory: No such file or 
directory

(please see https://github.com/sarpik/git-backup/issues/10 and 
specifically, 
https://github.com/sarpik/git-backup/issues/10#issuecomment-546599631)

This could probably be solved by `cd`ing up until I'm inside the same 
directory where `.git/` folder is placed and only then running `git 
stash push --include-untracked` and `git stash pop`.

Even then, this approach still kind of sucks, because you're still 
temporarily stashing user's changes. I'd like to avoid this and `git 
stash create` seems like the perfect solution, if only it could include 
untracked changes.

Thank you very much - please let me know if there's anything else I 
could help with.
