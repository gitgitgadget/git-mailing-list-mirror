From: Eric Raymond <esr@thyrsus.com>
Subject: Re: Three issues from a Subversion-to-git migration
Date: Mon, 29 Mar 2010 05:10:56 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20100329091056.GC10538@thyrsus.com>
References: <20100326120906.F03BB20CD21@snark.thyrsus.com>
 <201003291100.13043.trast@student.ethz.ch>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Mar 29 11:11:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwAzw-00060G-2r
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 11:11:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754959Ab0C2JK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 05:10:58 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:42811
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397Ab0C2JK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 05:10:57 -0400
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id F1C70475FEF; Mon, 29 Mar 2010 05:10:56 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <201003291100.13043.trast@student.ethz.ch>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143450>

Thomas Rast <trast@student.ethz.ch>:
> Eric Raymond wrote:
> > 2. The git-svn migration logic does not handle unmodified SVN tag
> > trees well.
> 
> The problem here is that git-svn is designed to handle incremental
> updates, where it can't know whether some insane SVN user decides to
> modify the tag later on.

Yes.  Ideally, I suppose, git-svn (or whatever replaces it) would have
behavior something like this:

1. Turn unmodified tag directories into git tags
2. Turn odified tags into branches.
3. Recognize when a formerly unmodified tag has been modified, remove
   the git tag, and turn it into a branch.
 
> I've used the following hack to make real tags out of SVN "tags":
> 
> git for-each-ref --format="%(refname)" refs/remotes/tags/ |
> while read tag; do
>     GIT_COMMITTER_DATE="$(git log -1 --pretty=format:"%ad" "$tag")" \
>     GIT_COMMITTER_EMAIL="$(git log -1 --pretty=format:"%ce" "$tag")" \
>     GIT_COMMITTER_NAME="$(git log -1 --pretty=format:"%cn" "$tag")" \
>     git tag -m "$(git log -1 --pretty=format:"%s%n%b" "$tag")" \
>     "${tag#refs/remotes/tags/}" "$tag"
> done
> 
> Disclaimer: it worked last time I used it.  Haven't checked if it got
> dusty since.

Wow, that's ugly. But it does look like it ought to work.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
