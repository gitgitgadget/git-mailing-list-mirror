From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: git stash: add --index-only, or --keep-index should not stash
 index?
Date: Mon, 14 Mar 2011 17:21:54 -0500
Message-ID: <4D7E9502.4060502@gmail.com>
References: <4D7A6E37.8080104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 23:22:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzG9P-0008HU-7w
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 23:22:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253Ab1CNWWB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 18:22:01 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:37728 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932216Ab1CNWWA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 18:22:00 -0400
Received: by yia27 with SMTP id 27so2218787yia.19
        for <git@vger.kernel.org>; Mon, 14 Mar 2011 15:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version
         :newsgroups:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=skJRcFcqmj+ZdBxANSPbzeTF12mG0wUfNd0n9ixNYB8=;
        b=ATS9lk5nnILme4ixnsFRBIPNckDEHmGZ7oW8WktsiCUlf2v4Exig4QyCn/uw9cMCIC
         xPpso92AAHy+r9ao3j6aOXAN1N9y34tON3Msh5uxnjyELfaOt6Z7b4t1MSmpzV4PZ7e4
         yjUOf+bWNSFIORZF7wpCbspy/x7ZhS1n83EyU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=QUbj/CEIzpgmSHlfEk/9/9VMoGotl2nn/cm8CyPmfdl2sP182xJmF8AyifET/r9y4Y
         /7k6/HmgYVN59MOj4Lqf416QE13w3wlK4rP2aWXA20jEDD6ysqB//+BgEcnypxs4QzvF
         LWQ5xgiNlyLFF8y69jQFAdBtHvb0ruvc8GNwI=
Received: by 10.90.199.19 with SMTP id w19mr2814090agf.19.1300141319764;
        Mon, 14 Mar 2011 15:21:59 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id x31sm7125030ana.9.2011.03.14.15.21.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Mar 2011 15:21:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4D7A6E37.8080104@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169031>

On 3/11/2011 12:47 PM, Piotr Krukowiecki wrote:
> Hi,
>
> I wanted to do something like "Testing partial commits" described in
> git-stash documentation (see end of mail for reference). I think this
> is a common scenario: you start working on some feature, then discover
> a bug, start fixing it, but realize it needs more work. So now you have
> two features that needs more work (both are not ready for committing).
>
> The documentation says to use --keep-index in this case.
>
> The problem is that --keep-index leaves changes in index intact, but at
> the same time it saves them in stash. So if I edit those changes I'm likely
> to get conflicts when applying the stash.
>
> For example:
>
> $ git init&&  echo a>  a&&  git add .&&  git commit -m a
> $ echo x>  a&&  git add a&&  git stash save --keep-index
> $ echo y>  a&&  git add a&&  git commit -m y
> $ git stash pop
> Auto-merging a
> CONFLICT (content): Merge conflict in a
>
> Maybe --keep-index should not stash staged changes? This would fix this
> problem. And I can't  think of a situation when would want to stash changes
> and at the same time keep them.
>
> If --keep-index works correctly maybe a new option, for example --index-only
> (or --cached-only?) could be introduced?
>
>
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Testing partial commits::
>
> You can use `git stash save --keep-index` when you want to make two or
> more commits out of the changes in the work tree, and you want to test
> each change before committing:
> +
> ----------------------------------------------------------------
> # ... hack hack hack ...
> $ git add --patch foo            # add just first part to the index
> $ git stash save --keep-index    # save all other changes to the stash
> $ edit/build/test first part
> $ git commit -m 'First part'     # commit fully tested change
> $ git stash pop                  # prepare to work on all other changes
> # ... repeat above five steps until one commit remains ...
> $ edit/build/test remaining parts
> $ git commit foo -m 'Remaining parts'
> ----------------------------------------------------------------
>
>
behind-the-scenes, git stash saves your working tree as a commit and 
your index as another commit.  "git-stash apply" and "git-stash pop" 
only apply your stashed-index if you do "git-stash-apply --index".  The 
default is to only apply your stashed-work-tree.  You can create new 
branches from your stashes with "git-stash branch".  You may find that 
much better to deal with for managing your work.  Stashes aren't really 
intended to be the primary way to manage your work, but instead are a 
supplement.  Branches are a better main tool for managing work.  You can 
create a branch from your stash and when the branch is ready you can 
merge it into your other branch.

v/r,
neal
