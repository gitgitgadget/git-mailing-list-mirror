From: David Lang <david.lang@digitalinsight.com>
Subject: Re: [RFC] Support projects including other projects
Date: Thu, 12 May 2005 10:24:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0505121006150.25177@qynat.qvtvafvgr.pbz>
References: <Pine.LNX.4.21.0505121218280.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Petr Baudis <pasky@ucw.cz>, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu May 12 19:19:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWHK6-0008P1-33
	for gcvg-git@gmane.org; Thu, 12 May 2005 19:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbVELRZs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 13:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbVELRZs
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 13:25:48 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:6831 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S262084AbVELRZi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 13:25:38 -0400
Received: from atlims01.diginsite.com by warden2.diginsite.com
          via smtpd (for vger.kernel.org [12.107.209.244]) with SMTP; Thu, 12 May 2005 10:20:30 -0700
Received: by ATHEXC01 with Internet Mail Service (5.5.2657.72)
	id <KQJLG8CM>; Thu, 12 May 2005 13:24:46 -0400
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvexc00.digitalinsight.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id KQRNCZFH; Thu, 12 May 2005 10:24:42 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <Pine.LNX.4.21.0505121218280.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I was thinking about this recently while reading an article on bittorrent 
and how it works and it occured to me that perhapse the network access 
model of git should be reexamined.

git produces a large pool of objects, there are two ways that people want 
to access these objects.

1. pull the current version of a project (either a straight 'ckeckout' 
type pull or a 'merge' to a local project)

2. pull the objects nessasary for past versions of a project (either all 
the way back to the beginning of time or back to some point, that point 
being a number of possibilities (date, version, things you don't have, 
etc)

in either case the important thing that's key are the indexes related to a 
particular project, the objects themselves could all be in one huge pool 
for all projects that ever existed (this doesn't make sense if you use 
rsync to copy repositories as Linux origionally did, but if you have a 
more git-aware transport it can make sense)

I believe that there are going to be quite a number of cases where the 
same object is used for multiple projects (either becouse the project is a 
fork of another project or becouse some functions (or include files) are 
so trivial that they are basicly boilerplate and get reused or recreated) 
if you think about a major mirror server distributing a dozen linux 
distros via git you will realize that in many cases the source files, 
scripts, and (in many cases) even the binaries are really going to be 
identical objects for all the distros so a ftp/http server that used a git 
filesystem could result in a pretty significant saveings in disk space.

In addition, when you are doing a pull you can accept data from 
non-authoritative sources since each object (and it's index info) includes 
enough info to validate the object hasn't been tampered with (at least 
until such time as the hashes are sufficiantly broken, but that's another 
debate, and we had that one :-). so a bittorrent-like peer sharing system 
to fetch objects identified by the index files would open the potential 
for saving significant bandwith on the master servers while not 
comprimising the trees at all.

Going back (somewhat) to the subject at hand, with something like this you 
should be able to combine as many projects as you want in one repository, 
and the only issue would be the work nessasary to go through that 
repository and all the index files that point at it when you want to prune 
old data out of the object pool to save disk space.

thoughts? unfortunnatly I don't have the time to even consider codeing 
something like this up, but hopefully it will spark interest for someone 
who does.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
