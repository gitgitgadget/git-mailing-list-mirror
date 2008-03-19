From: Greg KH <greg@kroah.com>
Subject: Re: renaming a file into a directory causes a pull error on older
	repos
Date: Tue, 18 Mar 2008 18:51:56 -0700
Message-ID: <20080319015156.GA8874@kroah.com>
References: <20080316043138.GA7942@kroah.com> <7vlk4ganti.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 23:02:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc6MV-0002IT-9O
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 23:02:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757045AbYCSWBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 18:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761356AbYCSWBU
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 18:01:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:34480 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934343AbYCSWBR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 18:01:17 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174] helo=localhost)
	by pentafluge.infradead.org with esmtpsa (Exim 4.68 #1 (Red Hat Linux))
	id 1JbqiK-0006B2-Ah; Wed, 19 Mar 2008 05:19:49 +0000
Content-Disposition: inline
In-Reply-To: <7vlk4ganti.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77568>

On Mon, Mar 17, 2008 at 05:16:41PM -0700, Junio C Hamano wrote:
> Greg KH <greg@kroah.com> writes:
> 
> > The problem:
> >   If you turn a file in a repository into a directory, and place files
> >   in that dir and commit it, any other person who had that repo cloned
> >   somewhere else will get an error when they try to pull and update
> >   their version.
> >
> > The error for me is:
> > 	fatal: Entry 'stats/results-18-22.txt' would be overwritten by merge. Cannot merge.
> > 	Merge with strategy recursive failed.
> >
> > I had turned the file "stats" into a directory.
> 
> So...
> 
>  - originally "stats" was a file.

Yes.

>  - then one branch removes it and creates stats/results-18-22.txt file.

As well as many more files were aded to this directory.

>  - another branch keeps working elsewhere in the tree but has not touched
>    the "stats" file.

Correct, except the other branch did not add any new commits to the
repo.

> Now, the above error message complains about stats/results-18-22.txt being
> overwritten, so I presume that:
> 
>  - You have checked out the branch that has stats/results-18.22.txt;
> 
>  - You are merging the other branch that still had stats as a file into
>    that checked out branch with stats/results-18.22.txt file.
> 
> Are these presumptions correct?

Kind of, there are no "branches" in these repos, only the main one.

> Now, merge-recursive may be riddled with bugs in directory-file conflict
> detection area.  The way it detects conflicts is quite bogus --- it builds
> a list of files and directories in ancestor, our side and the other side,
> and anything that changes directoryness is marked as conflict, when the
> right thing to do is to complain only if the checking out of the result
> needs to have a file and a directory at the same place.
> 
> But I do not think the above error message is from merge-recursive proper.
> "Entry X would be overwritten by merge. Cannot merge." is an error message
> the 3-way read-tree (driven from merge-recursive) issues when you have
> local changes to file X that will go away as the result of the merge, to
> prevent us from losing your local changes to the file.  Didn't you have
> changes to that file when you did the merge?

I don't think I did.  I saved the repo on my disk at home, and when I
get access to it tomorrow, I'll verify this.

I've tried to create a simple script to duplicate this problem, and I
really can not do it at all, including trying to modify the file that
got clobered by the directory name.  Odd.  I need to look at that repo
and verify what I did to make sure it wasn't my fault here...

thanks for responding,

greg k-h
