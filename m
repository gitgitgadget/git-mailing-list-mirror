From: Maaartin <grajcar1@seznam.cz>
Subject: Re: [PROPOSAL] .gitignore syntax modification
Date: Fri, 8 Oct 2010 21:58:59 +0000 (UTC)
Message-ID: <loom.20101008T234354-493@post.gmane.org>
References: <113B4C41-ECDA-479D-A281-DF6ACDFE8FBB@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 08 23:59:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4KyF-0003gZ-RK
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 23:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759678Ab0JHV7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 17:59:14 -0400
Received: from lo.gmane.org ([80.91.229.12]:44922 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752277Ab0JHV7N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 17:59:13 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1P4Ky5-0003c9-0h
	for git@vger.kernel.org; Fri, 08 Oct 2010 23:59:09 +0200
Received: from 188-120-198-113.luckynet.cz ([188-120-198-113.luckynet.cz])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 23:59:09 +0200
Received: from grajcar1 by 188-120-198-113.luckynet.cz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 23:59:09 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.120.198.113 (Opera/9.80 (Windows NT 5.2; U; en) Presto/2.6.30 Version/10.62)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158545>

Kevin Ballard <kevin <at> sb.org> writes:

> ... Similarly, for foo.xcodeproj packages I
> like to ignore all contained files except project.pbxproj. 
Unfortunately, .gitignore has no good way of
> matching this sort of thing at anything other than the root level. Here's an 
example of my global
> ~/.gitignore file:
> 
> *.xcodeproj/*
> !*.xcodeproj/*.pbxproj
> 
> ... On any repository where this isn't the case, I have to duplicate this 
pattern into
> a .gitignore file at the right level.

You don't. You can do something like

*.xcodeproj/*
!.xcodeproj/subdir_with_project
.xcodeproj/subdir_with_project/*
!.xcodeproj/subdir_with_project/*.pbxproj

I'm a beginner but I just stumbled upon this very problem five minutes ago.

The reason for git ignoring everything in the directory without ever looking 
there is efficiency. Maybe we would need something like "weak ignore" meaning 
ignore all matching files but traverse the directories. I'd propose the syntax

?*.xcodeproj
!*.pbxproj

for this. The pattern after the question would exclude all files below 
*.xcodeproj but still traverse the directories there. The second pattern would 
re-include the *.pbxproj files.

The lower efficiency would be no problem, since this was user's choice not to 
use the standard pattern. You could still prevent digging too deep by using 
additionally something like

*.xcodeproj/*/*
