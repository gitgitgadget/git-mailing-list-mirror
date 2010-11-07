From: Zenaan Harkness <zen@freedbms.net>
Subject: merge two local mirrors with detached heads and similar remotes
Date: Sun, 7 Nov 2010 13:40:23 +1100
Message-ID: <AANLkTinidbrJjmt5w=TyFGMyNpaGobE1iDBm3VAWmZvX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 07 03:45:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEvFy-0004OW-Cl
	for gcvg-git-2@lo.gmane.org; Sun, 07 Nov 2010 03:45:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752644Ab0KGCk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Nov 2010 22:40:56 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49817 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101Ab0KGCkz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Nov 2010 22:40:55 -0400
Received: by bwz11 with SMTP id 11so3822839bwz.19
        for <git@vger.kernel.org>; Sat, 06 Nov 2010 19:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received:from:date
         :x-google-sender-auth:message-id:subject:to:content-type;
        bh=IWm6hZFY/rJk1GFcosoUHP7sOxDuGyxE2MfgY2oLSNM=;
        b=sd4LQNzTVHLYrDCClT91odSnbAdv0W5BEWQiBVZd2uRUaAbVoMZqIA0A5vY4LiKpix
         VAIgGyEwZYa+gSmtG+K5EWcxvTDdmUvwGImvNFByKeiA0dPMtCSHg69OkCCPFDT5xsJI
         W1XXas3SjVLnlc/oF31PqeO1ox8m7bxVXGlag=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        b=iWXWzbFWzG0p+7IIM5PWzaA3mLRIuAWYhfOX9vBL/jOy1RCQAX145IyJsMYqxofGss
         cAXwA9a0L5VteJlPHRxWQWB5L/ydXS8n0K+SEflS8/H42v9j1Hr5pIxl+3XD5b/v+IpY
         2vqp21aKmmMdNBwF2uHvaZ1B6YllY3yvhtaq4=
Received: by 10.204.64.80 with SMTP id d16mr3467393bki.181.1289097653717; Sat,
 06 Nov 2010 19:40:53 -0700 (PDT)
Received: by 10.204.83.4 with HTTP; Sat, 6 Nov 2010 19:40:23 -0700 (PDT)
X-Google-Sender-Auth: iCsX5A5w0Dncx1rfWVFdw15KADQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160865>

I wish to merge two local mirrors, which each should share the same
object store, and I have been reading for many hours and so far failed
to achieve.

I did learn  git remote add, and applied my knowledge to another local
git clone/ mirror as can be seen here:
$ cd bananajour.git/
$ git remote -v
eadz    https://github.com/eadz/bananajour.git (fetch)
eadz    https://github.com/eadz/bananajour.git (push)
fresh   https://github.com/freshtonic/bananajour.git (fetch)
fresh   https://github.com/freshtonic/bananajour.git (push)
origin  https://github.com/toolmantim/bananajour.git (fetch)
origin  https://github.com/toolmantim/bananajour.git (push)
ts      https://github.com/tswicegood/bananajour.git (fetch)
ts      https://github.com/tswicegood/bananajour.git (push)
$ gb -a
* master
  remotes/eadz/master
  remotes/eadz/railscamp-hackfest
  remotes/fresh/bigbananajour
  remotes/fresh/master
  remotes/fresh/railscamp-hackfest
  remotes/origin/HEAD -> origin/master
  remotes/origin/macruby
  remotes/origin/master
  remotes/origin/railscamp-hackfest
  remotes/origin/v3
  remotes/ts/master
  remotes/ts/railscamp-hackfest


So I want to achieve the same thing (multiple remotes in one local
repo) for an earlier clone of two separate repos, which really ought
to be just one, as follows:

A)
$ cd gitjour.git/
$ cat .git/config
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[remote "origin"]
        fetch = +refs/heads/*:refs/remotes/origin/*
        url = https://github.com/chad/gitjour.git
[branch "master"]
        remote = origin
        merge = refs/heads/master
$ git branch -a
* master
  remotes/origin/HEAD -> origin/master
  remotes/origin/master

B)
$ cd gitjour-new.git/
$ cat .git/config
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[remote "origin"]
        fetch = +refs/heads/*:refs/remotes/origin/*
        url = https://github.com/lachlanhardy/gitjour.git
[branch "master"]
        remote = origin
        merge = refs/heads/master
$ git branch -a
* master
  remotes/origin/8.2.0
  remotes/origin/HEAD -> origin/master
  remotes/origin/lachlanhardy
  remotes/origin/master
  remotes/origin/v8.1.0


I tried, by copying each repo A) and B) into t/ and u/ respectively, then:
$ cd t
$ git remote add lach ../u
$ git fetch latch

but I only get three resulting branches, not the expected 6:
$ gb -a
* master
  remotes/lach/master
  remotes/origin/HEAD -> origin/master
  remotes/origin/master


I'm still learning my terminology sorry, but it seems that the origin
branches in u/ are detached heads or something. That's fine, I just
want them to appear in my t/ mirror.

I realise that I will need to update t/.git/config so that the "lach"
remote points to its canonical/ web URL, but _first_ I want to get all
the refs and objects from my local version, before hooking it up to
the web for future updates. I want to take advantage of the download
I've already done.

(Notwithstanding the fact that these repos are barely a few hundred
KiB, I also need to do this job because my 18-month old linux repos
are in a similar situation - I want to save my disk space by combining
my Ubuntu Hardy linux repo (with it's branches/ heads), and a couple
others, with my canonical Linus linux repo, into one. I did use the
--reference option back when I made these repos respectively, to share
and to minimize download as much as possible, but it seems that what I
really want is a properly shared (single) repo with multiple remotes,
so I don't have to think about what sequence of locals to download
etc.

In this vein, a chapter in the tutorial, perhaps near 'recommended
workflows', on Repository Mirroring Best Practices might be in order.

TIA
Zenaan
