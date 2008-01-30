From: "Ed S. Peschko" <esp5@pge.com>
Subject: Re: simple cvs-like git wrapper
Date: Wed, 30 Jan 2008 14:52:54 -0800
Message-ID: <20080130225254.GC9612@venus>
References: <20080129204048.GA9612@venus> <m3hcgw8dz7.fsf@localhost.localdomain> <20080130021050.GB9612@venus> <20080130040002.GM24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jan 30 23:53:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKLoO-0004bw-9G
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 23:53:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754523AbYA3WxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 17:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753544AbYA3WxL
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 17:53:11 -0500
Received: from mta06.pge.com ([131.90.0.76]:43464 "EHLO mta06.pge.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753474AbYA3WxK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 17:53:10 -0500
Received: from mta12.comp.pge.com (mta12.comp.pge.com [10.245.211.127])
	by mta06.pge.com (Switch-3.3.1/Switch-3.2.4) with ESMTP id m0UMqt9Z014609;
	Wed, 30 Jan 2008 14:52:55 -0800 (PST)
Received: from mdssdr01.utility.pge.com (mdssdr01.utility.pge.com [10.244.52.48])
	by mta12.comp.pge.com (Switch-3.3.1/Switch-3.3.0) with ESMTP id m0UMqsbZ029996;
	Wed, 30 Jan 2008 14:52:54 -0800 (PST)
Received: (from esp5@localhost)
	by mdssdr01.utility.pge.com (8.11.7p3+Sun/8.11.7) id m0UMqsP11834;
	Wed, 30 Jan 2008 14:52:54 -0800 (PST)
X-Authentication-Warning: mdssdr01.utility.pge.com: esp5 set sender to esp5@pge.com using -f
Content-Disposition: inline
In-Reply-To: <20080130040002.GM24004@spearce.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72076>

On Tue, Jan 29, 2008 at 11:00:02PM -0500, Shawn O. Pearce wrote:
> "Ed S. Peschko" <esp5@pge.com> wrote:
> > In our case, our code is tied to a database and a database instance. An
> > environment equals attachment to a given oracle SID. If someone is out of sync
> > with other people's changes, then that person's environment is wrong.
> 
> Surely not every single code change impacts the database schema
> and meaning of column values?  If that were truely the case then
> I'd say you have bigger issues to tackle.

well, no, but I'd say 80-90% of the changes we have are ones that we
want to instantly share with everybody. I was thinking that ones that
we didn't would be prefixed, as in:

	git-branch exp-<change_name>

and those would need to be renamed explicitly to become 'mainline'
branches before they were merged..

You've got some good points, and my original intent was to
answer them point-by-point, but suffice to say:

	1. I was hoping to make each branch correspond to a work request,
	   that would be tracked for SOX. We also need to track the changes
	   in mercury interactive, not git, so I've got some challenges
	   there in making a wrapper to handle this.


	2. A single, linear history on the remote end wouldn't be easy for
	   reporting purposes.

    3. A single linear history on the remote end wouldn't support 
	   the rare cases where I *do* want a single change.


I guess my scheme's workability depends on how effective git is at 
doing merges from branch to branch, and how good it is at fixing
conflicts in a way that is simple for the user. In CVS, I get: 

    >>>>>
    ...
    =====
    ...
    <<<<<


when a conflict occurs, and you need to resolve that conflict before
re-committing again. Does git do a similar thing?

Also, with git-ls-remote - is there a way to see more information 
about the remote branch rather than just its name, ie: can you say:

    git-ls-remote -l --heads origin

to get a list of changes in the order they were made? And is there a 
command that does what I want, ie:

	git pull origin --all 

Which pulls all branches from origin and merges them into the current
branch in an intelligent way, ie: by order in which the branches were 
committed, or even:

	git pull origin --re: '^(?!exp)'

which pulls in all branches matching a given regular expression (in this
case, not matching 'exp' at the beginning..

Ed
