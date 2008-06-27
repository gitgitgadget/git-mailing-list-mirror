From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: Determining if two commits are on a separate branch
Date: Fri, 27 Jun 2008 17:13:29 +0200
Message-ID: <g4302r$ms9$1@ger.gmane.org>
References: <308083c30806270755t4316be67u1f468b51bf475d28@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 27 17:14:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCFen-0006D6-8O
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 17:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151AbYF0PNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 11:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752000AbYF0PNl
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 11:13:41 -0400
Received: from main.gmane.org ([80.91.229.2]:34480 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751921AbYF0PNk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 11:13:40 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KCFdq-0002s1-3v
	for git@vger.kernel.org; Fri, 27 Jun 2008 15:13:38 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 15:13:38 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 15:13:38 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <308083c30806270755t4316be67u1f468b51bf475d28@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86571>

Adr3nal D0S venit, vidit, dixit 27.06.2008 16:55:
> We are making extensive use of submodules at work and we have created
> a number of extra scripts to simplify our usage.  For example, there
> is git-rstatus, which recursively reports status of all submodules.
> 
> I am working on another script to check whether or not a change to any
> submodules jump branches.  If we have commits like this:
> 
> A--B--C
>    \--D
> 
> I don't care if a submodule moves from A to C or B to C, but I do care
> if a commit of the super-project would cause a jump from D to C or
> revert from C to B, effectively dropping previously committed code on
> the floor.
> 
> So, is there a "correct" or "best" way to determine if one commit's
> SHA follows directly from another's SHA in the commit history?

"Directly" as in "is child of", or as in "connected by the DAG"?

"git rev-list C..B" lists all commits which are not in C but in B. If 
this list is empty then B is "contained" in C. This is how you can test 
for being connected by the DAG. For the graph above, all of the 
following refspecs would return an empty list, indicating connectedness:

C..B
C..A
B..A
D..B
D..A

Are those the "good ones" in your case? Then you know how to test for 
the bad guys ;)

Michael
