From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: How to reorder all commits include the initial commit
Date: Sun, 18 Mar 2012 10:58:05 +0800
Message-ID: <CANYiYbGbJxZPOAN9twBPZoD318eA_CLcsVzcFuoHrc32+e96FQ@mail.gmail.com>
References: <CAFT+Tg_DmqxiK1qw1YvNZtY07ZaZ89+JWohdWw2fm8f=6hAwiQ@mail.gmail.com>
	<m3k42jl2wn.fsf@localhost.localdomain>
	<CAFT+Tg9UGdBxj5-DTpxDJRVgvBCnmkmgm6nzVek0KeELgsNneQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: semtlenori@gmail.com
X-From: git-owner@vger.kernel.org Sun Mar 18 03:58:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S96KF-0000RO-QR
	for gcvg-git-2@plane.gmane.org; Sun, 18 Mar 2012 03:58:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752465Ab2CRC6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Mar 2012 22:58:08 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:60338 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062Ab2CRC6G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2012 22:58:06 -0400
Received: by vcqp1 with SMTP id p1so5405304vcq.19
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 19:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=QdMlhzdTxOl3W7GBujvQkP7LW7yb/l8WdG8pgpZ5Iss=;
        b=uSzYuSKcq5k9WXHWpSw0c/pvhlpQa0SdY6gTBFD65fczBWrtWM2p4eok2Em3DYQH5b
         xZp9oN00RXcruIk2pAX9SeBPE6GH1o8UT4qQoDQ3PbsHP9JiZLvxUD4x/g3m6GzuKtt8
         yIwYZLCfrO+WOx37WYYxNvixFUzME3W+8RNVFqitoJ1XL1xrhD78dgfiHED0n//ireJL
         ZKauH5NpHP6WfXXv7CECj43k3jtLEK4PbT/k+JbeDqLjWq2/aj/1BzL4DpQ4SnM4einm
         4kuVYAGO3EYxa5IsdqeqrZX0vdVwe3WDo1YMXAB3bzaRBIDquWGQiAvrK6a/85Uj8T1m
         igeA==
Received: by 10.52.64.234 with SMTP id r10mr3582207vds.39.1332039485344; Sat,
 17 Mar 2012 19:58:05 -0700 (PDT)
Received: by 10.52.26.37 with HTTP; Sat, 17 Mar 2012 19:58:05 -0700 (PDT)
In-Reply-To: <CAFT+Tg9UGdBxj5-DTpxDJRVgvBCnmkmgm6nzVek0KeELgsNneQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193366>

2012/3/18 Yi, EungJun <semtlenori@gmail.com>:
> Thanks to David Barr and Jakub Narebski.
> Finally I found the way based on your hints to solve my problem.
>
> $ git checkout -b test --orphan

option -b and --orphan can not be used together.

> $ git format-patch <newroot>^..<newroot> | git am

can not apply patch when there is no root commit

My test for your case:

log of master branch before rebase:

    $ git log --oneline
    1a91ece commit 3
    d7c6dec commit 2
    e32542d commit 1

rebase:

    $ git checkout --orphan new-master
    $ rm .git/index
    $ git commit --allow-empty -m initial
    $ git clean -fd
    $ git cherry-pick -n master^
    $ git commit --amend -C master^
    $ git rebase --root --onto new-master master
    $ git branch -d new-master

master after rebase:

    $ git log --oneline
    fbb9fb6 commit 3
    56afd5c commit 1
    894c42a commit 2

--
Jiang Xin
