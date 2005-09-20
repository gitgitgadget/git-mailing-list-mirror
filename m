From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: GIT - breaking backward compatibility
Date: Tue, 20 Sep 2005 09:11:16 +0200
Message-ID: <20050920071116.GJ15165MdfPADPa@greensroom.kotnet.org>
References: <7vpsr4cx0f.fsf@assigned-by-dhcp.cox.net>
 <20050920062549.GI15165MdfPADPa@greensroom.kotnet.org>
 <7v3bo06xv4.fsf@assigned-by-dhcp.cox.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 20 09:12:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHcHj-0006vt-PZ
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 09:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932749AbVITHLV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 03:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932751AbVITHLV
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 03:11:21 -0400
Received: from smtp15.wxs.nl ([195.121.6.54]:53131 "EHLO smtp15.wxs.nl")
	by vger.kernel.org with ESMTP id S932749AbVITHLU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2005 03:11:20 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp15.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with SMTP id <0IN300GUJTAS50@smtp15.wxs.nl> for git@vger.kernel.org; Tue,
 20 Sep 2005 09:11:17 +0200 (CEST)
Received: (qmail 24997 invoked by uid 500); Tue, 20 Sep 2005 07:11:16 +0000
In-reply-to: <7v3bo06xv4.fsf@assigned-by-dhcp.cox.net>
To: Junio C Hamano <junkio@cox.net>
Mail-followup-to: Junio C Hamano <junkio@cox.net>,
 Git Mailing List <git@vger.kernel.org>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8985>

On Mon, Sep 19, 2005 at 11:45:35PM -0700, Junio C Hamano wrote:
> Sven Verdoolaege <skimo@kotnet.org> writes:
> 
> > What tool can be used as a replacement for git-diff-stages ?
> 
> If we removed it, you would probably end up scripting it by
> using output from git-ls-files --stage (or --unmerged), and
> comparing the mode and SHA1 for the stages, and if you want -p
> output then git-unpack-file and diff too.

OK, that was basically what I had planed to do, until I noticed
in your mail that there was a tool called git-diff-stages.
I just thought your removing it meant that it had become
a special case of some other tool.

> But the real question was how useful what git-diff-stages does
> is.  Comparing stage3 (or stage1) and working tree might be
> suseful, but comparing stage<n> and stage<m> is what the command
> is about.  Since those stages are present after/during an
> incomplete merge, probably the user or script is trying to
> figure out what happened by inspecting the trees being merged --
> if that is the case, instead of inspecting what the merge
> algorithm which did not complete used to apply its heuristics
> (which is essentially what is left in those stages), you or your
> script can run 'git-diff-tree' across trees involved in the
> merge directly.

But the merge heuristics usually do a pretty good job
so the user would have to perform fewer manual merge operations
if she starts off from the result of the failed merge.
(And if it turns out that the merge heuristics really didn't
work, she can still throw the results away.)

The reason I'm asking is that I used dirdiff to do a "difficult"
merge which required some manual intervention.
The way I used it now, was to load the merge base, the two
heads and the working directory (containing the result of the
failed merge) in dirdiff and then to merge the final
result into the working directory.

I still need to look at the merging stuff in more detail,
but I figured that it would actually be more interesting
if dirdiff could perform the merge on the index rather than
the working directory.
What do you think ?

skimo
