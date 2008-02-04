From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] Add platform-independent .git "symlink"
Date: Mon, 04 Feb 2008 16:08:57 -0600
Message-ID: <47A78CF9.6040001@nrlssc.navy.mil>
References: <8c5c35580802020959v613b9e32v321e97f93f2af761@mail.gmail.com> <1201975757-13771-1-git-send-email-hjemli@gmail.com> <alpine.LSU.1.00.0802021815510.7372@racer.site> <alpine.LSU.1.00.0802021825220.7372@racer.site> <47A78104.9050909@nrlssc.navy.mil> <alpine.LSU.1.00.0802042128170.8543@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Lars Hjemli <hjemli@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 04 23:10:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM9W6-0007AN-IF
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 23:10:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753452AbYBDWJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 17:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752884AbYBDWJq
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 17:09:46 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:56043 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118AbYBDWJp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 17:09:45 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m14M8wWm013182;
	Mon, 4 Feb 2008 16:08:58 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 4 Feb 2008 16:08:58 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <alpine.LSU.1.00.0802042128170.8543@racer.site>
X-OriginalArrivalTime: 04 Feb 2008 22:08:58.0254 (UTC) FILETIME=[8A363AE0:01C8677A]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15706001
X-TM-AS-Result: : Yes--14.171900-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMDA3NS0xMzkw?=
	=?us-ascii?B?MTAtNzAxNDU1LTcwNDQyNS0xODgwMTktNzA1OTAxLTcwNzExOS03?=
	=?us-ascii?B?MTE5NTMtNzA0NzEyLTcwMjAyMC03MDgxNzktNzAxNzE5LTcwMjcy?=
	=?us-ascii?B?Ni03MDU1MDgtNzAwNzU5LTcwMjc2Mi03MDkzMjMtNzAwODQ5LTcw?=
	=?us-ascii?B?MTgzNy03MTA0NDItNzA1MTAyLTcwMDQ1NC03MDc2NjMtNzA0NjM2?=
	=?us-ascii?B?LTcwNDc5My03MDQ5ODAtNzA1MTY3LTcwMTIwMi03MDIwNDQtNzA5?=
	=?us-ascii?B?NTg0LTcwMTkxNC0xMjExMTYtNzA2NzE5LTcwNDc4Mi0xMzYwNzAt?=
	=?us-ascii?B?NzA5MDY1LTE0ODAzOS0xNDgwNTEtMjAwNDI=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72578>

Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 4 Feb 2008, Brandon Casey wrote:

> In my local version of git, you can say "git 
> branch --new-workdir=../bla new-branch [branch-point]".

Ah, I see, you are creating a new branch too.

>> Have you thought about using git-clone instead?
> 
> Briefly.  But this is not about cloning the repository.  It is about 
> having an additional working directory for the current repository.

I think that is true at the low level, but from a high level it feels
similar to me.

After your "git branch --new-workdir=..." you have something that acts
exactly like a full-fledged repository. It is very much dependent on
the original repo, similarly to how a --shared repo is, and it now
has new semantics in that operations within the new repo have an effect
in the original repo (and vice-versa). Making new repositories from
existing repositories is what git-clone does.

  git-branch: makes new branches, or generally handles modifying branches.
git-checkout: modifies the contents of the working directory.
   git-clone: makes new repositories from existing repositories.

Also, of the three, git-clone is the only one allowed to operate outside
of the repo. The other two are required to be called from within a repo
(or have GIT_DIR set), and currently only modify data within that repo.
So, allowing them to have an effect outside of the repo would extend
their current scope of operation.

>> It seems a good fit but would require a new option to specify a branch 
>> to checkout (which I believe is a requested feature for clone).
> 
> It is an often-requested feature for clone, but we have "clone -n" for 
> now, and nobody seemed to care deeply enough to actually do something 
> about it.

I'll probably do it if it is not beyond me.

> I _want_ the original 
> repository to know that there is another working directory.

Yes, your ideas are much better than simply adding the functionality of
the git-new-workdir script (which is what I was planning on doing btw :)

-brandon
