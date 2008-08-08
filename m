From: Jan Wielemaker <J.Wielemaker@uva.nl>
Subject: Re: git filter-branch --subdirectory-filter, still a mistery
Date: Fri, 8 Aug 2008 13:25:29 +0200
Message-ID: <200808081325.29241.J.Wielemaker@uva.nl>
References: <200808061539.50268.J.Wielemaker@uva.nl> <200808071214.25399.J.Wielemaker@uva.nl> <200808080148.27384.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Aug 08 13:27:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRQ7A-0006GU-Lk
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 13:26:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbYHHLZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 07:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754282AbYHHLZe
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 07:25:34 -0400
Received: from smtp-vbr5.xs4all.nl ([194.109.24.25]:3411 "EHLO
	smtp-vbr5.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753294AbYHHLZe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 07:25:34 -0400
Received: from ct.xs4all.nl (ct.xs4all.nl [82.92.39.12])
	by smtp-vbr5.xs4all.nl (8.13.8/8.13.8) with ESMTP id m78BPT9c061518;
	Fri, 8 Aug 2008 13:25:30 +0200 (CEST)
	(envelope-from J.Wielemaker@uva.nl)
User-Agent: KMail/1.9.6 (enterprise 20070904.708012)
In-Reply-To: <200808080148.27384.trast@student.ethz.ch>
Content-Disposition: inline
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91657>

Hi Thomas,

On Friday 08 August 2008 01:48:05 Thomas Rast wrote:
> This appears to be a bug.  I've whipped up a patch that will follow
> and should fix the bug.  It has nothing to do with packed-refs; the
> current filter-branch chokes on annotated tags during
> --subdirectory-filter, even though there is support for tag rewriting.
>
> However, to enable tag rewriting, you need to say --tag-name-filter
> cat.

That works!

> > Now it runs to the end.  Unfortunagtely the history is completely
> > screwed up :-(:
> >
> > 	* There are a lot of commits that are not related to the dir
> > 	* Commits start long before the directory came into existence,
> > 	Looks like it just shows the whole project at this place.
>
> For some reason the ancestor detection does not work right.  I'm also
> following up with an RFH patch that significantly improves the success
> rate (in terms of branches and tags successfully mapped to a rewritten
> commit) in the case of your repository.  I doubt more staring at the
> code would yield any more ideas at this hour, so ideas would be
> appreciated.
>
> The rest is just the other commits/tags showing a lot of the history.
> I don't know of any built-in way to prune the branches and tags that
> aren't part of the new master, but
>
>   git branch -a --no-merged master
>
> can tell you which branches aren't ancestors of master.

I retried with your two patches. That looks a *lot* better. After using
the above and deleting the reported branches there are still some
branches left, but at least switching to them doesn't bring the complete
project back.

Now there are a few weird tags left, some of these may well be the
result of weird things in the repository. The repository was on CVS
until about a year ago and was converted (using SVN as intermediate).

The big problem is anything that relates to the days before the filtered
directory was part of the project. There are lots of tags there and
switching to them brings back the old project. I'd guess the correct
behaviour is that either all these tags refer to an empty tree or (which
I would prefer) all such tags are deleted.

Is this a bug?  Is there a trick here?  git clone --depth doesn't
seem appropriate.

	Cheers --- Jan
