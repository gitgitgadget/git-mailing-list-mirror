From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: fetch <repo> <branch>:<branch> fetches tags?
Date: Mon, 28 Jan 2008 21:09:55 -0600
Message-ID: <479E9903.9000706@nrlssc.navy.mil>
References: <479E9063.5000403@nrlssc.navy.mil> <alpine.LSU.1.00.0801290240240.23907@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 29 04:10:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJgrn-0005S2-JF
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 04:10:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbYA2DKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 22:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752255AbYA2DKA
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 22:10:00 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:33010 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682AbYA2DJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 22:09:59 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0T39tdZ018791;
	Mon, 28 Jan 2008 21:09:55 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 28 Jan 2008 21:09:55 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <alpine.LSU.1.00.0801290240240.23907@racer.site>
X-OriginalArrivalTime: 29 Jan 2008 03:09:55.0673 (UTC) FILETIME=[6C617490:01C86224]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15694001
X-TM-AS-Result: : Yes--19.944800-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1MDY1OC0xNTA2?=
	=?us-ascii?B?NTctNzAwMDc1LTEzOTAxMC03MDA3ODItNzAxNDU1LTcwMDYzMC03?=
	=?us-ascii?B?MDQ5MjctNzAxNDYxLTcwMzc4OC03MDQ0MjEtMTg4MDE5LTEyMTMz?=
	=?us-ascii?B?OC0xMjEzNjctNzA3NjU0LTcxMTk1My03MDY0NTQtNzAzNTI5LTcw?=
	=?us-ascii?B?MzE3OS03MDU0NTAtNzAzNDQwLTcwMzk2NS03MDE2NjktNzAxMjM2?=
	=?us-ascii?B?LTcwNDQyNS03MDIzNTgtNzAwMTYwLTEwNjU4MC03MDU1ODQtNzA0?=
	=?us-ascii?B?MjE5LTcwNTM4OC0xNDgwMzktMTQ4MDUxLTIwMDQy?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71933>

Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 28 Jan 2008, Brandon Casey wrote:
> 
>> Is this the intended behavior?
> 
> AFAICT yes.  Whenever you say "git fetch" without "--no-tags", it should 
> fetch those tags that reference objects that were fetched, and _only_ 
> those.

It doesn't always fetch tags only when "--no-tags" is missing. Sometimes
it refrains from fetching tags even when "--no-tags" is missing.

$ mkdir test1 && cd test1 && git init && echo : > file1 && git add file1 &&
  git commit -m 'Commit1' file1 && git tag -m 'CommitTag1' tag1 && cd .. &&
  mkdir test2 && cd test2 && git init && git fetch ../test1 master &&
  git branch master FETCH_HEAD && cd ../test1 && echo -n 'Test1: ' &&
  git tag -n -l && cd ../test2 && echo -n 'Test2: ' && git tag -n -l | grep '' || echo 'NO TAGS'

Initialized empty Git repository in .git/
Created initial commit 0f701fc: Commit1
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 file1
Initialized empty Git repository in .git/
warning: no common commits
remote: Counting objects: 3, done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
Test1: tag1            CommitTag1
Test2: NO TAGS


Notice the last two lines.


But, change that fetch to master:master and...

$ mkdir test1 && cd test1 && git init && echo : > file1 && git add file1 &&
  git commit -m 'Commit1' file1 && git tag -m 'CommitTag1' tag1 && cd .. &&
  mkdir test2 && cd test2 && git init && git fetch ../test1 master:master &&
  cd ../test1 && echo -n 'Test1: ' && git tag -n -l && cd ../test2 &&
  echo -n 'Test2: ' && git tag -n -l | grep '' || echo 'NO TAGS'

Initialized empty Git repository in .git/
Created initial commit d67022e: Commit1
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 file1
Initialized empty Git repository in .git/
warning: no common commits
remote: Counting objects: 3, done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
From ../test1
 * [new branch]      master     -> master
remote: Counting objects: 1, done.
remote: Total 1 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (1/1), done.
From ../test1
 * [new tag]         tag1       -> tag1
Test1: tag1            CommitTag1
Test2: tag1            CommitTag1


I only get the tags if I use the colon notation.

-brandon


> 
> Hth,
> Dscho
> 
> P.S.: What does the Navy do with git?

Manage software of course! What a silly question.

Kidding aside. I work with oceanographers.
