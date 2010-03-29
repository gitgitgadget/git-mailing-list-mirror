From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Three issues from a Subversion-to-git migration
Date: Mon, 29 Mar 2010 11:32:53 +0200
Message-ID: <201003291132.53415.trast@student.ethz.ch>
References: <20100326120906.F03BB20CD21@snark.thyrsus.com> <201003291100.13043.trast@student.ethz.ch> <20100329091056.GC10538@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Mon Mar 29 11:33:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwBLP-0002AK-P9
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 11:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752397Ab0C2Jc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 05:32:57 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:25870 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751658Ab0C2Jc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 05:32:57 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 29 Mar
 2010 11:32:55 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 29 Mar
 2010 11:32:53 +0200
User-Agent: KMail/1.13.1 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.1; x86_64; ; )
In-Reply-To: <20100329091056.GC10538@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143451>

Eric Raymond wrote:
> > I've used the following hack to make real tags out of SVN "tags":
> > 
> > git for-each-ref --format="%(refname)" refs/remotes/tags/ |
> > while read tag; do
> >     GIT_COMMITTER_DATE="$(git log -1 --pretty=format:"%ad" "$tag")" \
> >     GIT_COMMITTER_EMAIL="$(git log -1 --pretty=format:"%ce" "$tag")" \
> >     GIT_COMMITTER_NAME="$(git log -1 --pretty=format:"%cn" "$tag")" \
> >     git tag -m "$(git log -1 --pretty=format:"%s%n%b" "$tag")" \
> >     "${tag#refs/remotes/tags/}" "$tag"
> > done
> > 
> > Disclaimer: it worked last time I used it.  Haven't checked if it got
> > dusty since.
> 
> Wow, that's ugly. But it does look like it ought to work.

BTW, you'll also want to use some treatment that removes the empty
commit that is generated from the 'svn copy' SVN commit for tagging.
One option is to use 'git filter-branch --prune-empty ...', which will
also drop other no-op commits.  If you want to remove only the ones
that come from tagging, creative use of git-diff-tree in the above
loop will work.

I suppose I was never bothered by the lack of automatic tagging
because I rarely found a git-svn import to be immediately fit for
publishing.  Usually it took some grafting and other filtering to
bring the history into shape anyway.  Maybe now that the svn:mergeinfo
support obviates the need for grafting, it's worth thinking about the
rest.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
