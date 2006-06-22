From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [GIT PATCH] USB patches for 2.6.17
Date: Thu, 22 Jun 2006 14:01:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606221354070.6483@g5.osdl.org>
References: <20060621220656.GA10652@kroah.com> <Pine.LNX.4.64.0606211519550.5498@g5.osdl.org>
 <20060621225134.GA13618@kroah.com> <Pine.LNX.4.64.0606211814200.5498@g5.osdl.org>
 <20060622181826.GB22867@kroah.com> <20060622183021.GA5857@kroah.com>
 <Pine.LNX.4.64.0606221239100.5498@g5.osdl.org> <20060622200147.GA10712@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 23:01:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtWIk-0001d1-DF
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 23:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbWFVVBS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 17:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751898AbWFVVBS
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 17:01:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28308 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751088AbWFVVBR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jun 2006 17:01:17 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5ML1AUT029267
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 22 Jun 2006 14:01:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5ML19bM015734;
	Thu, 22 Jun 2006 14:01:09 -0700
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20060622200147.GA10712@mars.ravnborg.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22371>



On Thu, 22 Jun 2006, Sam Ravnborg wrote:
> 
> Personally I'm still missing two things:
> 1) A command to let me see what this Linus guy have applied compared to
> my tree - without touching anything in my tree. bk changes -R

	git fetch linus
	git log ..linus

Yes, it will fetch the things into your database, unlike BK, but that's 
kind of the point. That's what makes branches so powerful (you can do a 
lot more than "bk changes -R").

> 2) A dry-run of a fetch+pull. I can do that if I really study the man
> pages I know. But "git pull --dry-run" would be more convinient.

Hmm? Again, do

	git fetch <thing-to-be-fetched>

into a local branch first. That gets it into your repo, so that you can do 
things.

After that, I'm not quite sure what you mean by "--dry-run". Do you mean 
to know about file-level conflicts? You do need to do the merge in order 
to know whether the conflicts can be resolved, but even without doing the 
merge you can look for _file_level_ conflicts by other means.

I don't think anybody has done it, but a script like

	OTHER="$1"
	BASE=$(git-merge-base HEAD $OTHER) || exit
	git-merge-tree $BASE HEAD $OTHER | grep -v '^0'

will show if there were file-level conflicts (in a pretty strange format, 
admittedly).

Of course, 99% of the time, a three-way merge will just handle those fine 
(the output from "git-merge-tree" is enough to know to do a three-way 
merge on temp-files, if you want to try that).

		Linus
