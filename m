From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Thu, 2 Mar 2006 16:49:26 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603021643560.22647@g5.osdl.org>
References: <20060302164405.GB7292@trixie.casa.cgf.cx> <20060302165510.GB18929@spearce.org>
 <20060302220930.GE6183@steel.home> <Pine.LNX.4.64.0603021521250.22647@g5.osdl.org>
 <7v1wxk5ptf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 03 01:49:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEyUH-0007YL-Cu
	for gcvg-git@gmane.org; Fri, 03 Mar 2006 01:49:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097AbWCCAti (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 19:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752098AbWCCAti
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 19:49:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57056 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752097AbWCCAti (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 19:49:38 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k230nYDZ013206
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 2 Mar 2006 16:49:35 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k230nQln017498;
	Thu, 2 Mar 2006 16:49:30 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1wxk5ptf.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17127>



On Thu, 2 Mar 2006, Junio C Hamano wrote:
> 
> And you had lt/rev-list branch first listed in FETCH_HEAD.  In
> this particular example, lt/rev-list has only 3 commits on top
> of common things, but if your max were 3 instead of 10, the
> first round would actually show the tip 3 without showing any
> common stuff, and then the next round to show fk/blame branch
> would show only the remaining two, without ever showing the
> common stuff, even though it _could_ say the latest of the
> common stuff.

Yes. I considered it briefly, and it's fixable, but to fix it you'd 
have to actualyl walk the parent list yourself, rather than letting 
get_revision do it all for you.

And what my simple thing shows isn't really technically "wrong", since it 
has shown that there are commits missing from the output with the "..."

The question is just whether shared commits should be "balanced out", or 
shown as part of the first branch that merged them. I chose the latter, 
because it's not only simple, it's unambiguous (any balancing algorithm 
will depend on some random heuristic or other, and on how many commits are 
shown.

> >  - the old one did some formatting of the branch message that I don't 
> >    follow because I'm not a perl user. The new one just takes the 
> >    explanatory message for the branch merging as-is.
> 
> FETCH_HEAD has explanatory message in more or less "canonical"
> form.  It has noise word "branch", and the current repository is
> typically " of .".

Yeah, I actually looked at a few examples, so I knew what it was basically 
trying to do, and then I ignored it as not interesting to the exercise, 
which was to abuse the new revision listing library in interesting ways by 
calling it multiple times.

		Linus
