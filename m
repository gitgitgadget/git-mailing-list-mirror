From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: receive.denyCurrentBranch
Date: Sun, 8 Feb 2009 12:50:36 -0500
Message-ID: <76718490902080950r798ca02es4e560da35e499046@mail.gmail.com>
References: <20090208042910.19079.qmail@science.horizon.com>
	 <alpine.DEB.1.00.0902081128420.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: George Spelvin <linux@horizon.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 08 18:52:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWDp7-00041Q-Mn
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 18:52:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506AbZBHRui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 12:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752450AbZBHRui
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 12:50:38 -0500
Received: from rv-out-0506.google.com ([209.85.198.227]:7259 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202AbZBHRuh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 12:50:37 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1478654rvb.1
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 09:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rS7Sff2O2e51o2VY0B9I+HJP4soGOiVki0oMk4aafHo=;
        b=kSTcqgZ1EV7/2arjOujKMPPJFZ+x5+jgcojFyfJzYYMqIfx/GPWpn7AJgPAPirM1RF
         TdQbx/MUIDwIELEBA4b3pfyeMSck0fqNdoGOxJgxHI8MJH3KF5vrLqdqltURYuWB41Ua
         HSUiXsWhhsnP43056DTOMEoD2Ud2dRfCDf9eo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wKQz9TYqMi7XKNKHDEmwC+JucWgNe8ZE+vJxqKnzvo6gDTfZZoFA5rtUVc437UzYXC
         nbTqDvgFoNo8mJvXqGVWZYoEOFb9vUwXKKIJHDDrtHgAI0xoyzJvuxFGljknYZyiRzM2
         oHNhFi7eogLJI94cmQTkJyTN+E1KQ8gtPJDgY=
Received: by 10.140.144.1 with SMTP id r1mr2552865rvd.209.1234115436794; Sun, 
	08 Feb 2009 09:50:36 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902081128420.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108995>

On Sun, Feb 8, 2009 at 5:30 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> It's insane, that's what it is.
>
> You have _no_ business meddling with a remote working directory, _except_
> by logging into that machine and working on that working directory
> _directly_.
>
> If you do not agree, you have not thought about the implications, i.e.
> what problems you buy.

Just by way of providing an additional perspective, I thought I'd illustrate
how Mercurial handles this situation:

$ mkdir repoA
$ cd repoA
repoA$ hg init
repoA$ echo foo > foo
repoA$ hg add foo
repoA$ hg commit -m "added foo"
repoA$ cd ..
$ hg clone repoA repoB
updating working directory
1 files updated, 0 files merged, 0 files removed, 0 files unresolved
$ cd repoA
repoA$ cat >> .hg/hgrc <<EOF
> [paths]
> default = ../repoB
> EOF
repoA$ echo bar > bar
repoA$ hg add bar
repoA$ hg commit -m "added bar"
repoA$ hg push
pushing to /Users/jay/repoB
searching for changes
adding changesets
adding manifests
adding file changes
added 1 changesets with 1 changes to 1 files
repoA$ cd ../repoB
repoB$ hg parents
0   d32c3edefcba   2009-02-08 11:18 -0500   jaysoffian
  added foo

repoB$ hg glog
o  1[tip]   8e0a16e691f4   2009-02-08 11:19 -0500   jaysoffian
|    added bar
|
@  0   d32c3edefcba   2009-02-08 11:18 -0500   jaysoffian
     added foo

repoB$ echo baz > baz
repoB$ hg add baz
repoB$ hg commit -m "added baz"
created new head
repoB$ hg parents
2[tip]:0   8d7db8257fd0   2009-02-08 11:19 -0500   jaysoffian
  added baz

repoB$ hg glog
@  2[tip]:0   8d7db8257fd0   2009-02-08 11:19 -0500   jaysoffian
|    added baz
|
| o  1   8e0a16e691f4   2009-02-08 11:19 -0500   jaysoffian
|/     added bar
|
o  0   d32c3edefcba   2009-02-08 11:18 -0500   jaysoffian
     added foo

Now let's look at what happens if I pull from B, instead of pushing from A:

$ rm -rf repoA repoB
$ mkdir repoA
$ cd repoA
repoA$ hg init
repoA$ echo foo > foo
repoA$ hg add foo
repoA$ hg commit -m "added foo"
repoA$ cd ..
$ hg clone repoA repoB
updating working directory
1 files updated, 0 files merged, 0 files removed, 0 files unresolved
$ cd repoA
repoA$ echo bar > bar
repoA$ hg add bar
repoA$ hg commit -m "added bar"
repoA$ cd ../repoB
repoB$ hg pull
pulling from /Users/jay/repoA
searching for changes
adding changesets
adding manifests
adding file changes
added 1 changesets with 1 changes to 1 files
(run 'hg update' to get a working copy)
callisto:~/repoB$ hg parents
0   1adbe0643fb7   2009-02-08 11:22 -0500   jaysoffian
  added foo

repoB$ hg glog
o  1[tip]   66a5c6395cfc   2009-02-08 11:22 -0500   jaysoffian
|    added bar
|
@  0   1adbe0643fb7   2009-02-08 11:22 -0500   jaysoffian
     added foo

repoB$ echo baz > baz
repoB$ hg add baz
repoB$ hg commit -m "added baz"
created new head
repoB$ hg parents
2[tip]:0   cb8f0c639bd4   2009-02-08 11:23 -0500   jaysoffian
  added baz

repoB$ hg glog
@  2[tip]:0   cb8f0c639bd4   2009-02-08 11:23 -0500   jaysoffian
|    added baz
|
| o  1   66a5c6395cfc   2009-02-08 11:22 -0500   jaysoffian
|/     added bar
|
o  0   1adbe0643fb7   2009-02-08 11:22 -0500   jaysoffian
     added foo

What I especially like about Mercurial here is that pushing from A is
perfectly symetrical to pulling from B.

With git, cloning sets things up to fetch into a tracking branch, but then the
push is not symetric to the fetch. That makes sense if you're cloning from a
bare repo, but I think leads to confusion for new users when they clone a
non-bare repo they wish to later push into. I dunno, I guess we'll see if the
new message helps any.

j.
