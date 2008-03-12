From: kenneth johansson <ken@kenjo.org>
Subject: speed of fetch for stable linux tree
Date: Wed, 12 Mar 2008 03:03:57 +0000 (UTC)
Message-ID: <fr7h6t$rji$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 04:05:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZHHU-0004AC-S2
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 04:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbYCLDET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 23:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751587AbYCLDET
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 23:04:19 -0400
Received: from main.gmane.org ([80.91.229.2]:46900 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751086AbYCLDER (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 23:04:17 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JZHGD-0005qT-6d
	for git@vger.kernel.org; Wed, 12 Mar 2008 03:04:09 +0000
Received: from 1-1-4-20a.ras.sth.bostream.se ([82.182.72.90])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Mar 2008 03:04:09 +0000
Received: from ken by 1-1-4-20a.ras.sth.bostream.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Mar 2008 03:04:09 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 1-1-4-20a.ras.sth.bostream.se
User-Agent: Pan/0.132 (Waxed in Black)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76917>

I made a small script to clone linus tree and then add remotes for the 
stable trees. What was a bit surprising was the amount of time it took git 
to figure out what object to fetch for the remotes. There is not that many
uniq object in the stable branches.

I tried to run it several times just to eliminate some network problem but 
got more or less the same overall behavior. 

-----
#! /bin/bash

FIRST_STABLE=12
LAST_STABLE=24

time git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
cd linux-2.6

for sublevel in `seq ${FIRST_STABLE} ${LAST_STABLE}` ;do
    echo "Creating remote tracking for 2.6.$sublevel"
    time git remote add -f stable_2.6.${sublevel} git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.${sublevel}.y.git
done

time git remote add -f kgdb_light git://git.kernel.org/pub/scm/linux/kernel/git/mingo/linux-2.6-kgdb.git

-----
log 
-----
Initialized empty Git repository in /local/tmp/linux-2.6/.git/

real	3m19.345s
user	0m46.123s
sys	0m5.980s
Creating remote tracking for 2.6.12
remote: Counting objects: 400, done.
remote: Compressing objects: 100% (168/168), done.
remote: Total 289 (delta 186), reused 223 (delta 121)
Receiving objects: 100% (289/289), 403.12 KiB | 199 KiB/s, done.
Resolving deltas: 100% (186/186), completed with 66 local objects.
From git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.12.y
 * [new branch]      chris      -> stable_2.6.12/chris
 * [new branch]      master     -> stable_2.6.12/master
 * [new branch]      origin     -> stable_2.6.12/origin
remote: Counting objects: 6, done.
remote: Compressing objects: 100% (6/6), done.
remote: Total 6 (delta 0), reused 3 (delta 0)
Unpacking objects: 100% (6/6), done.
From git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.12.y
 * [new tag]         v2.6.12.1  -> v2.6.12.1
 * [new tag]         v2.6.12.2  -> v2.6.12.2
 * [new tag]         v2.6.12.3  -> v2.6.12.3
 * [new tag]         v2.6.12.4  -> v2.6.12.4
 * [new tag]         v2.6.12.5  -> v2.6.12.5
 * [new tag]         v2.6.12.6  -> v2.6.12.6

real	9m15.418s
user	0m1.484s
sys	0m0.316s
Creating remote tracking for 2.6.13
remote: Counting objects: 357, done.
remote: Compressing objects: 100% (130/130), done.
remote: Total 251 (delta 176), reused 196 (delta 121)
Receiving objects: 100% (251/251), 192.86 KiB, done.
Resolving deltas: 100% (176/176), completed with 77 local objects.
From git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.13.y
 * [new branch]      master     -> stable_2.6.13/master
remote: Counting objects: 4, done.
remote: Compressing objects: 100% (4/4), done.
remote: Total 4 (delta 0), reused 2 (delta 0)
Unpacking objects: 100% (4/4), done.
From git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.13.y
 * [new tag]         v2.6.13.1  -> v2.6.13.1
 * [new tag]         v2.6.13.2  -> v2.6.13.2
 * [new tag]         v2.6.13.3  -> v2.6.13.3
 * [new tag]         v2.6.13.4  -> v2.6.13.4
 * [new tag]         v2.6.13.5  -> v2.6.13.5

real	2m4.492s
user	0m1.524s
sys	0m0.236s
Creating remote tracking for 2.6.14
remote: Counting objects: 716, done.
remote: Compressing objects: 100% (235/235), done.
remote: Total 537 (delta 372), reused 467 (delta 302)
Receiving objects: 100% (537/537), 435.85 KiB, done.
Resolving deltas: 100% (372/372), completed with 122 local objects.
From git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.14.y
 * [new branch]      master     -> stable_2.6.14/master
remote: Counting objects: 7, done.
remote: Compressing objects: 100% (7/7), done.
remote: Total 7 (delta 0), reused 7 (delta 0)
Unpacking objects: 100% (7/7), done.
From git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.14.y
 * [new tag]         v2.6.14.1  -> v2.6.14.1
 * [new tag]         v2.6.14.2  -> v2.6.14.2
 * [new tag]         v2.6.14.3  -> v2.6.14.3
 * [new tag]         v2.6.14.4  -> v2.6.14.4
 * [new tag]         v2.6.14.5  -> v2.6.14.5
 * [new tag]         v2.6.14.6  -> v2.6.14.6
 * [new tag]         v2.6.14.7  -> v2.6.14.7

real	1m27.177s
user	0m1.500s
sys	0m0.248s
Creating remote tracking for 2.6.15
remote: Counting objects: 790, done.
remote: Compressing objects: 100% (293/293), done.
remote: Total 600 (delta 422), reused 484 (delta 306)
Receiving objects: 100% (600/600), 486.39 KiB, done.
Resolving deltas: 100% (422/422), completed with 133 local objects.
From git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.15.y
 * [new branch]      master     -> stable_2.6.15/master
 * [new branch]      origin     -> stable_2.6.15/origin
remote: Counting objects: 7, done.
remote: Compressing objects: 100% (7/7), done.
remote: Total 7 (delta 0), reused 7 (delta 0)
Unpacking objects: 100% (7/7), done.
From git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.15.y
 * [new tag]         v2.6.15.1  -> v2.6.15.1
 * [new tag]         v2.6.15.2  -> v2.6.15.2
 * [new tag]         v2.6.15.3  -> v2.6.15.3
 * [new tag]         v2.6.15.4  -> v2.6.15.4
 * [new tag]         v2.6.15.5  -> v2.6.15.5
 * [new tag]         v2.6.15.6  -> v2.6.15.6
 * [new tag]         v2.6.15.7  -> v2.6.15.7

real	1m21.806s
user	0m1.528s
sys	0m0.280s
Creating remote tracking for 2.6.16
remote: Counting objects: 6946, done.
remote: Compressing objects: 100% (2277/2277), done.
remote: Total 5896 (delta 4744), reused 4709 (delta 3616)
Receiving objects: 100% (5896/5896), 1.03 MiB | 344 KiB/s, done.
Resolving deltas: 100% (4744/4744), completed with 989 local objects.
From git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y
 * [new branch]      master     -> stable_2.6.16/master
remote: Counting objects: 99, done.
remote: Compressing objects: 100% (99/99), done.
remote: Total 99 (delta 0), reused 94 (delta 0)
Unpacking objects: 100% (99/99), done.
From git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y
 * [new tag]         v2.6.16.1  -> v2.6.16.1
 * [new tag]         v2.6.16.10 -> v2.6.16.10
 * [new tag]         v2.6.16.11 -> v2.6.16.11
 * [new tag]         v2.6.16.12 -> v2.6.16.12
 * [new tag]         v2.6.16.13 -> v2.6.16.13
 * [new tag]         v2.6.16.14 -> v2.6.16.14
 * [new tag]         v2.6.16.15 -> v2.6.16.15
 * [new tag]         v2.6.16.16 -> v2.6.16.16
 * [new tag]         v2.6.16.17 -> v2.6.16.17
 * [new tag]         v2.6.16.18 -> v2.6.16.18
 * [new tag]         v2.6.16.19 -> v2.6.16.19
 * [new tag]         v2.6.16.2  -> v2.6.16.2
 * [new tag]         v2.6.16.20 -> v2.6.16.20
 * [new tag]         v2.6.16.21 -> v2.6.16.21
 * [new tag]         v2.6.16.22 -> v2.6.16.22
 * [new tag]         v2.6.16.23 -> v2.6.16.23
 * [new tag]         v2.6.16.24 -> v2.6.16.24
 * [new tag]         v2.6.16.25 -> v2.6.16.25
 * [new tag]         v2.6.16.26 -> v2.6.16.26
 * [new tag]         v2.6.16.27 -> v2.6.16.27
 * [new tag]         v2.6.16.28 -> v2.6.16.28
 * [new tag]         v2.6.16.28-rc1 -> v2.6.16.28-rc1
 * [new tag]         v2.6.16.28-rc2 -> v2.6.16.28-rc2
 * [new tag]         v2.6.16.28-rc3 -> v2.6.16.28-rc3
 * [new tag]         v2.6.16.29 -> v2.6.16.29
 * [new tag]         v2.6.16.29-rc1 -> v2.6.16.29-rc1
 * [new tag]         v2.6.16.29-rc2 -> v2.6.16.29-rc2
 * [new tag]         v2.6.16.3  -> v2.6.16.3
 * [new tag]         v2.6.16.30 -> v2.6.16.30
 * [new tag]         v2.6.16.30-pre1 -> v2.6.16.30-pre1
 * [new tag]         v2.6.16.30-rc1 -> v2.6.16.30-rc1
 * [new tag]         v2.6.16.31 -> v2.6.16.31
 * [new tag]         v2.6.16.31-rc1 -> v2.6.16.31-rc1
 * [new tag]         v2.6.16.32 -> v2.6.16.32
 * [new tag]         v2.6.16.32-rc1 -> v2.6.16.32-rc1
 * [new tag]         v2.6.16.33 -> v2.6.16.33
 * [new tag]         v2.6.16.33-rc1 -> v2.6.16.33-rc1
 * [new tag]         v2.6.16.34 -> v2.6.16.34
 * [new tag]         v2.6.16.34-rc1 -> v2.6.16.34-rc1
 * [new tag]         v2.6.16.35 -> v2.6.16.35
 * [new tag]         v2.6.16.35-rc1 -> v2.6.16.35-rc1
 * [new tag]         v2.6.16.36 -> v2.6.16.36
 * [new tag]         v2.6.16.36-rc1 -> v2.6.16.36-rc1
 * [new tag]         v2.6.16.37 -> v2.6.16.37
 * [new tag]         v2.6.16.37-rc1 -> v2.6.16.37-rc1
 * [new tag]         v2.6.16.38 -> v2.6.16.38
 * [new tag]         v2.6.16.38-rc1 -> v2.6.16.38-rc1
 * [new tag]         v2.6.16.38-rc2 -> v2.6.16.38-rc2
 * [new tag]         v2.6.16.39 -> v2.6.16.39
 * [new tag]         v2.6.16.39-rc1 -> v2.6.16.39-rc1
 * [new tag]         v2.6.16.4  -> v2.6.16.4
 * [new tag]         v2.6.16.40 -> v2.6.16.40
 * [new tag]         v2.6.16.40-rc1 -> v2.6.16.40-rc1
 * [new tag]         v2.6.16.41 -> v2.6.16.41
 * [new tag]         v2.6.16.41-rc1 -> v2.6.16.41-rc1
 * [new tag]         v2.6.16.42 -> v2.6.16.42
 * [new tag]         v2.6.16.42-rc1 -> v2.6.16.42-rc1
 * [new tag]         v2.6.16.43 -> v2.6.16.43
 * [new tag]         v2.6.16.43-rc1 -> v2.6.16.43-rc1
 * [new tag]         v2.6.16.44 -> v2.6.16.44
 * [new tag]         v2.6.16.44-rc1 -> v2.6.16.44-rc1
 * [new tag]         v2.6.16.44-rc2 -> v2.6.16.44-rc2
 * [new tag]         v2.6.16.45 -> v2.6.16.45
 * [new tag]         v2.6.16.45-rc1 -> v2.6.16.45-rc1
 * [new tag]         v2.6.16.46 -> v2.6.16.46
 * [new tag]         v2.6.16.46-rc1 -> v2.6.16.46-rc1
 * [new tag]         v2.6.16.47 -> v2.6.16.47
 * [new tag]         v2.6.16.47-rc1 -> v2.6.16.47-rc1
 * [new tag]         v2.6.16.48 -> v2.6.16.48
 * [new tag]         v2.6.16.49 -> v2.6.16.49
 * [new tag]         v2.6.16.49-rc1 -> v2.6.16.49-rc1
 * [new tag]         v2.6.16.5  -> v2.6.16.5
 * [new tag]         v2.6.16.50 -> v2.6.16.50
 * [new tag]         v2.6.16.50-rc1 -> v2.6.16.50-rc1
 * [new tag]         v2.6.16.51 -> v2.6.16.51
 * [new tag]         v2.6.16.51-rc1 -> v2.6.16.51-rc1
 * [new tag]         v2.6.16.52 -> v2.6.16.52
 * [new tag]         v2.6.16.52-rc1 -> v2.6.16.52-rc1
 * [new tag]         v2.6.16.53 -> v2.6.16.53
 * [new tag]         v2.6.16.53-rc1 -> v2.6.16.53-rc1
 * [new tag]         v2.6.16.54 -> v2.6.16.54
 * [new tag]         v2.6.16.54-rc1 -> v2.6.16.54-rc1
 * [new tag]         v2.6.16.55 -> v2.6.16.55
 * [new tag]         v2.6.16.55-rc1 -> v2.6.16.55-rc1
 * [new tag]         v2.6.16.56 -> v2.6.16.56
 * [new tag]         v2.6.16.56-rc1 -> v2.6.16.56-rc1
 * [new tag]         v2.6.16.56-rc2 -> v2.6.16.56-rc2
 * [new tag]         v2.6.16.57 -> v2.6.16.57
 * [new tag]         v2.6.16.57-rc1 -> v2.6.16.57-rc1
 * [new tag]         v2.6.16.58 -> v2.6.16.58
 * [new tag]         v2.6.16.58-rc1 -> v2.6.16.58-rc1
 * [new tag]         v2.6.16.59 -> v2.6.16.59
 * [new tag]         v2.6.16.59-rc1 -> v2.6.16.59-rc1
 * [new tag]         v2.6.16.6  -> v2.6.16.6
 * [new tag]         v2.6.16.60 -> v2.6.16.60
 * [new tag]         v2.6.16.60-rc1 -> v2.6.16.60-rc1
 * [new tag]         v2.6.16.7  -> v2.6.16.7
 * [new tag]         v2.6.16.8  -> v2.6.16.8
 * [new tag]         v2.6.16.9  -> v2.6.16.9

real	0m14.151s
user	0m2.728s
sys	0m0.308s
Creating remote tracking for 2.6.17
remote: Counting objects: 1371, done.
remote: Compressing objects: 100% (493/493), done.
remote: Total 1071 (delta 872), reused 777 (delta 578)
Receiving objects: 100% (1071/1071), 200.11 KiB | 94 KiB/s, done.
Resolving deltas: 100% (872/872), completed with 285 local objects.
From git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.17.y
 * [new branch]      master     -> stable_2.6.17/master
remote: Counting objects: 14, done.
remote: Compressing objects: 100% (14/14), done.
remote: Total 14 (delta 0), reused 14 (delta 0)
Unpacking objects: 100% (14/14), done.
From git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.17.y
 * [new tag]         v2.6.17.1  -> v2.6.17.1
 * [new tag]         v2.6.17.10 -> v2.6.17.10
 * [new tag]         v2.6.17.11 -> v2.6.17.11
 * [new tag]         v2.6.17.12 -> v2.6.17.12
 * [new tag]         v2.6.17.13 -> v2.6.17.13
 * [new tag]         v2.6.17.14 -> v2.6.17.14
 * [new tag]         v2.6.17.2  -> v2.6.17.2
 * [new tag]         v2.6.17.3  -> v2.6.17.3
 * [new tag]         v2.6.17.4  -> v2.6.17.4
 * [new tag]         v2.6.17.5  -> v2.6.17.5
 * [new tag]         v2.6.17.6  -> v2.6.17.6
 * [new tag]         v2.6.17.7  -> v2.6.17.7
 * [new tag]         v2.6.17.8  -> v2.6.17.8
 * [new tag]         v2.6.17.9  -> v2.6.17.9

real	0m18.256s
user	0m1.764s
sys	0m0.164s
Creating remote tracking for 2.6.18
remote: Counting objects: 2026, done.
remote: Compressing objects: 100% (748/748), done.
remote: Total 1514 (delta 1208), reused 1049 (delta 761)
Receiving objects: 100% (1514/1514), 335.89 KiB | 141 KiB/s, done.
Resolving deltas: 100% (1208/1208), completed with 449 local objects.
From git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.18.y
 * [new branch]      master     -> stable_2.6.18/master
remote: Counting objects: 8, done.
remote: Compressing objects: 100% (8/8), done.
remote: Total 8 (delta 0), reused 6 (delta 0)
Unpacking objects: 100% (8/8), done.
From git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.18.y
 * [new tag]         v2.6.18.1  -> v2.6.18.1
 * [new tag]         v2.6.18.2  -> v2.6.18.2
 * [new tag]         v2.6.18.3  -> v2.6.18.3
 * [new tag]         v2.6.18.4  -> v2.6.18.4
 * [new tag]         v2.6.18.5  -> v2.6.18.5
 * [new tag]         v2.6.18.6  -> v2.6.18.6
 * [new tag]         v2.6.18.7  -> v2.6.18.7
 * [new tag]         v2.6.18.8  -> v2.6.18.8

real	0m7.045s
user	0m1.836s
sys	0m0.212s
Creating remote tracking for 2.6.19
remote: Counting objects: 1439, done.
remote: Compressing objects: 100% (446/446), done.
remote: Total 1104 (delta 801), reused 937 (delta 658)
Receiving objects: 100% (1104/1104), 1.04 MiB | 384 KiB/s, done.
Resolving deltas: 100% (801/801), completed with 232 local objects.
From git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.19.y
 * [new branch]      master     -> stable_2.6.19/master
remote: Counting objects: 7, done.
remote: Compressing objects: 100% (7/7), done.
remote: Total 7 (delta 0), reused 4 (delta 0)
Unpacking objects: 100% (7/7), done.
From git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.19.y
 * [new tag]         v2.6.19.1  -> v2.6.19.1
 * [new tag]         v2.6.19.2  -> v2.6.19.2
 * [new tag]         v2.6.19.3  -> v2.6.19.3
 * [new tag]         v2.6.19.4  -> v2.6.19.4
 * [new tag]         v2.6.19.5  -> v2.6.19.5
 * [new tag]         v2.6.19.6  -> v2.6.19.6
 * [new tag]         v2.6.19.7  -> v2.6.19.7

real	0m16.525s
user	0m1.660s
sys	0m0.172s
Creating remote tracking for 2.6.20
remote: Counting objects: 3217, done.
remote: Compressing objects: 100% (1085/1085), done.
remote: Total 2569 (delta 2100), reused 1951 (delta 1484)
Receiving objects: 100% (2569/2569), 513.33 KiB | 138 KiB/s, done.
Resolving deltas: 100% (2100/2100), completed with 616 local objects.
From git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.20.y
 * [new branch]      master     -> stable_2.6.20/master
 * [new branch]      origin     -> stable_2.6.20/origin
remote: Counting objects: 20, done.
remote: Compressing objects: 100% (20/20), done.
remote: Total 20 (delta 0), reused 20 (delta 0)
Unpacking objects: 100% (20/20), done.
From git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.20.y
 * [new tag]         v2.6.20.1  -> v2.6.20.1
 * [new tag]         v2.6.20.10 -> v2.6.20.10
 * [new tag]         v2.6.20.11 -> v2.6.20.11
 * [new tag]         v2.6.20.12 -> v2.6.20.12
 * [new tag]         v2.6.20.13 -> v2.6.20.13
 * [new tag]         v2.6.20.14 -> v2.6.20.14
 * [new tag]         v2.6.20.15 -> v2.6.20.15
 * [new tag]         v2.6.20.16 -> v2.6.20.16
 * [new tag]         v2.6.20.17 -> v2.6.20.17
 * [new tag]         v2.6.20.18 -> v2.6.20.18
 * [new tag]         v2.6.20.19 -> v2.6.20.19
 * [new tag]         v2.6.20.2  -> v2.6.20.2
 * [new tag]         v2.6.20.20 -> v2.6.20.20
 * [new tag]         v2.6.20.21 -> v2.6.20.21
 * [new tag]         v2.6.20.3  -> v2.6.20.3
 * [new tag]         v2.6.20.4  -> v2.6.20.4
 * [new tag]         v2.6.20.5  -> v2.6.20.5
 * [new tag]         v2.6.20.6  -> v2.6.20.6
 * [new tag]         v2.6.20.7  -> v2.6.20.7
 * [new tag]         v2.6.20.8  -> v2.6.20.8
 * [new tag]         v2.6.20.9  -> v2.6.20.9

real	0m15.644s
user	0m2.120s
sys	0m0.228s
Creating remote tracking for 2.6.21
remote: Counting objects: 1165, done.
remote: Compressing objects: 100% (404/404), done.
remote: Total 906 (delta 744), reused 663 (delta 501)
Receiving objects: 100% (906/906), 170.48 KiB | 81 KiB/s, done.
Resolving deltas: 100% (744/744), completed with 251 local objects.
From git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.21.y
 * [new branch]      master     -> stable_2.6.21/master
remote: Counting objects: 7, done.
remote: Compressing objects: 100% (7/7), done.
remote: Total 7 (delta 0), reused 7 (delta 0)
Unpacking objects: 100% (7/7), done.
From git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.21.y
 * [new tag]         v2.6.21.1  -> v2.6.21.1
 * [new tag]         v2.6.21.2  -> v2.6.21.2
 * [new tag]         v2.6.21.3  -> v2.6.21.3
 * [new tag]         v2.6.21.4  -> v2.6.21.4
 * [new tag]         v2.6.21.5  -> v2.6.21.5
 * [new tag]         v2.6.21.6  -> v2.6.21.6
 * [new tag]         v2.6.21.7  -> v2.6.21.7

real	0m6.841s
user	0m1.824s
sys	0m0.120s
Creating remote tracking for 2.6.22
remote: Counting objects: 2678, done.
remote: Compressing objects: 100% (949/949), done.
remote: Total 2133 (delta 1720), reused 1587 (delta 1184)
Receiving objects: 100% (2133/2133), 461.92 KiB | 142 KiB/s, done.
Resolving deltas: 100% (1720/1720), completed with 510 local objects.
From git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.22.y
 * [new branch]      master     -> stable_2.6.22/master
remote: Counting objects: 19, done.
remote: Compressing objects: 100% (19/19), done.
remote: Total 19 (delta 0), reused 12 (delta 0)
Unpacking objects: 100% (19/19), done.
From git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.22.y
 * [new tag]         v2.6.22.1  -> v2.6.22.1
 * [new tag]         v2.6.22.10 -> v2.6.22.10
 * [new tag]         v2.6.22.11 -> v2.6.22.11
 * [new tag]         v2.6.22.12 -> v2.6.22.12
 * [new tag]         v2.6.22.13 -> v2.6.22.13
 * [new tag]         v2.6.22.14 -> v2.6.22.14
 * [new tag]         v2.6.22.15 -> v2.6.22.15
 * [new tag]         v2.6.22.16 -> v2.6.22.16
 * [new tag]         v2.6.22.17 -> v2.6.22.17
 * [new tag]         v2.6.22.18 -> v2.6.22.18
 * [new tag]         v2.6.22.19 -> v2.6.22.19
 * [new tag]         v2.6.22.2  -> v2.6.22.2
 * [new tag]         v2.6.22.3  -> v2.6.22.3
 * [new tag]         v2.6.22.4  -> v2.6.22.4
 * [new tag]         v2.6.22.5  -> v2.6.22.5
 * [new tag]         v2.6.22.6  -> v2.6.22.6
 * [new tag]         v2.6.22.7  -> v2.6.22.7
 * [new tag]         v2.6.22.8  -> v2.6.22.8
 * [new tag]         v2.6.22.9  -> v2.6.22.9

real	0m14.212s
user	0m2.076s
sys	0m0.188s
Creating remote tracking for 2.6.23
remote: Counting objects: 2229, done.
remote: Compressing objects: 100% (912/912), done.
remote: Total 1756 (delta 1433), reused 1105 (delta 844)
Receiving objects: 100% (1756/1756), 321.40 KiB | 149 KiB/s, done.
Resolving deltas: 100% (1433/1433), completed with 456 local objects.
From git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.23.y
 * [new branch]      master     -> stable_2.6.23/master
remote: Counting objects: 17, done.
remote: Compressing objects: 100% (17/17), done.
remote: Total 17 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (17/17), done.
From git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.23.y
 * [new tag]         v2.6.23.1  -> v2.6.23.1
 * [new tag]         v2.6.23.10 -> v2.6.23.10
 * [new tag]         v2.6.23.11 -> v2.6.23.11
 * [new tag]         v2.6.23.12 -> v2.6.23.12
 * [new tag]         v2.6.23.13 -> v2.6.23.13
 * [new tag]         v2.6.23.14 -> v2.6.23.14
 * [new tag]         v2.6.23.15 -> v2.6.23.15
 * [new tag]         v2.6.23.16 -> v2.6.23.16
 * [new tag]         v2.6.23.17 -> v2.6.23.17
 * [new tag]         v2.6.23.2  -> v2.6.23.2
 * [new tag]         v2.6.23.3  -> v2.6.23.3
 * [new tag]         v2.6.23.4  -> v2.6.23.4
 * [new tag]         v2.6.23.5  -> v2.6.23.5
 * [new tag]         v2.6.23.6  -> v2.6.23.6
 * [new tag]         v2.6.23.7  -> v2.6.23.7
 * [new tag]         v2.6.23.8  -> v2.6.23.8
 * [new tag]         v2.6.23.9  -> v2.6.23.9

real	0m15.822s
user	0m1.972s
sys	0m0.196s
Creating remote tracking for 2.6.24
remote: Counting objects: 693, done.
remote: Compressing objects: 100% (101/101), done.
remote: Total 526 (delta 444), reused 505 (delta 425)
Receiving objects: 100% (526/526), 78.25 KiB, done.
Resolving deltas: 100% (444/444), completed with 167 local objects.
From git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.24.y
 * [new branch]      master     -> stable_2.6.24/master
remote: Counting objects: 3, done.
remote: Compressing objects: 100% (3/3), done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
From git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.24.y
 * [new tag]         v2.6.24.1  -> v2.6.24.1
 * [new tag]         v2.6.24.2  -> v2.6.24.2
 * [new tag]         v2.6.24.3  -> v2.6.24.3

real	0m10.712s
user	0m1.636s
sys	0m0.112s
remote: Counting objects: 180, done.
remote: Compressing objects: 100% (24/24), done.
remote: Total 134 (delta 110), reused 134 (delta 110)
Receiving objects: 100% (134/134), 55.55 KiB, done.
Resolving deltas: 100% (110/110), completed with 45 local objects.
From git://git.kernel.org/pub/scm/linux/kernel/git/mingo/linux-2.6-kgdb
 * [new branch]      master     -> kgdb_light/master

real	0m9.004s
user	0m1.532s
sys	0m0.080s

-----
