From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: complex cvs import
Date: Fri, 22 Aug 2008 17:14:35 +0200
Message-ID: <g8ml4s$2cd$1@ger.gmane.org>
References: <48AEBB72.6060209@xmos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 17:15:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWYMk-0003Iz-UZ
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 17:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbYHVPOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 11:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbYHVPOv
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 11:14:51 -0400
Received: from main.gmane.org ([80.91.229.2]:60102 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101AbYHVPOu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 11:14:50 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KWYLd-0001wj-3X
	for git@vger.kernel.org; Fri, 22 Aug 2008 15:14:45 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 15:14:45 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 15:14:45 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <48AEBB72.6060209@xmos.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93310>

Luis Gutierrez venit, vidit, dixit 22.08.2008 15:13:
> Hi All,
> 
> During the past year or so we have been using a bastardized version of 
> CVS in which branches were not 'true' cvs branches, but just a copy of 
> the original data in a different folder. For instance, we would have 
> something like this:
> 
> ProjectX
>    \---- dev01
>    |       \... normal cvs data
>    \---- dev02
>    |       \... normal cvs data
>    \---- release01
>    |       \... normal cvs data
>    \---- release02
>            \... normal cvs data
> 
> While a timeline of the branches looks like this:
> 
>                 /---release01
> ----dev01------+                /---release02
>                 \---dev02------+--
> 
> Now that we are trying to move to git, and I'm having problems importing 
> the projects with their full history.
> 
> What I have done is use git-cvsimport on each of those branches to 
> create separate git repositories: dev01, dev02, release01, and release02.
> 
> What I was planing on doing next was:
> (all from the dev01 branch)
> 1) git branch dev01
> 2) git checkout -b release01
> 3) git pull ssh:/..../release01
> 4) git checkout -b dev02
> 5) git pull ssh:/..../dev02
> 6) git checkout -b release02
> 7) git pull ssh:/..../release02
> 
> Now, the problem I'm seeing is that I get hundreds of conflicts when 
> pulling.
> 
> Short from doing a git-mergetool 100's of times, is there a better way 
> of doing this? One that guarantees I keep the latests version (ie, the 
> one I'm pulling from).
> Put in another way, is there a way to let git know that it will not 
> merge the last version of the files, just the history?
> 
> Cheers.
> 
> Luis Gutierrez

How about:

- fetch instead of pull
- After each fetch, put the fetched thing in a local branch:
git checkout -b release01 FETCH_HEAD

Now you've got local "branches" without a common root.

Finally, stitch it together using grafts and filter-branch.

Michael
