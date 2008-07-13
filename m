From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] bash completion: Fix the . -> .. revision range
	completion
Date: Mon, 14 Jul 2008 01:07:24 +0200
Message-ID: <20080713230724.GJ10151@machine.or.cz>
References: <20080713111847.29801.8969.stgit@localhost> <7vskudpiqq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 01:08:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIAg6-0001Ap-3u
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 01:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282AbYGMXH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 19:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754245AbYGMXH1
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 19:07:27 -0400
Received: from w241.dkm.cz ([62.24.88.241]:41069 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753495AbYGMXH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 19:07:27 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id DD298393B322; Mon, 14 Jul 2008 01:07:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vskudpiqq.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88355>

On Sun, Jul 13, 2008 at 02:38:37PM -0700, Junio C Hamano wrote:
> By the way, the above command line is another "dot" related frustration I
> always have.  If you try:
> 
> 	git log v1.5.6.<TAB>
> 
> the completion code adds a dot unconditionally when I want to choose from
> the list of v1.5.6.X tags.  Of course, I can work this around by dropping
> the last dot before asking for completion, so it is not really a very big
> deal, but I mention it here because this annoyance is exactly in the same
> league as your "git-submodule.<TAB>" example.

Actually, my original solution to this problem was simply to remove the
. -> .. completion altogether. Maybe this would still be the best course
of action? I don't think the . -> .. is actually very useful for anyone,
since you might as well just hit the dot another time instead of a tab.

> >  contrib/completion/git-completion.bash |    7 ++++++-
> >  1 files changed, 6 insertions(+), 1 deletions(-)
> >
> > diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> > index 61581fe..fe24b8c 100755
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -325,7 +325,12 @@ __git_complete_revlist ()
> >  		__gitcomp "$(__git_refs)" "$pfx" "$cur"
> >  		;;
> >  	*.)
> > -		__gitcomp "$cur."
> > +		if ls "$cur"* >/dev/null 2>&1; then
> 
> There is a slight Yuck factor for using "ls" here but I do not think of a
> better alternative offhand.

I have thought about this hard for some time, but couldn't come up with
anything better than this or

	(shopt -s nullglob; completion=("$cur"*); [ -n "$completion" ])

which looks quite awful (and can waste a lot of memory in case of some
really insane completion).

-- 
				Petr "Pasky" Baudis
GNU, n. An animal of South Africa, which in its domesticated state
resembles a horse, a buffalo and a stag. In its wild condition it is
something like a thunderbolt, an earthquake and a cyclone. -- A. Pierce
