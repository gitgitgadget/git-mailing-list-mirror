From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Bisect: implement "bisect dunno" to mark untestable
 revisions.
Date: Mon, 8 Oct 2007 06:36:52 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710080632510.4174@racer.site>
References: <20071008053450.a52d7c5e.chriscool@tuxfamily.org>
 <Pine.LNX.4.64.0710080444290.4174@racer.site> <200710080734.23878.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio Hamano <junkio@cox.net>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Oct 08 07:37:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IelIv-0007JJ-VI
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 07:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbXJHFhK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 01:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbXJHFhK
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 01:37:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:57981 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751210AbXJHFhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 01:37:09 -0400
Received: (qmail invoked by alias); 08 Oct 2007 05:37:07 -0000
Received: from unknown (EHLO [172.17.38.182]) [38.99.84.33]
  by mail.gmx.net (mp019) with SMTP; 08 Oct 2007 07:37:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/b4mUZ/ofbRr+CtfJK9riueMsOZVe7eMJ10hunfG
	gi1psSGmDQRmZd
X-X-Sender: gene099@racer.site
In-Reply-To: <200710080734.23878.chriscool@tuxfamily.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60292>

Hi,

On Mon, 8 Oct 2007, Christian Couder wrote:

> Le lundi 8 octobre 2007, Johannes Schindelin a ?crit :
>
> > On Mon, 8 Oct 2007, Christian Couder wrote:
> > > diff --git a/git-bisect.sh b/git-bisect.sh
> > > index 388887a..c556318 100755
> > > --- a/git-bisect.sh
> > > +++ b/git-bisect.sh
> > > @@ -143,7 +145,7 @@ bisect_write_bad() {
> > >
> > >  bisect_good() {
> > >  	bisect_autostart
> > > -        case "$#" in
> > > +	case "$#" in
> >
> > White space breakage.
> 
> The patch tries to fix some white space breakages.
> 
> > > @@ -153,7 +155,6 @@ bisect_good() {
> > >  		rev=$(git rev-parse --verify "$rev^{commit}") || exit
> > >  		bisect_write_good "$rev"
> > >  		echo "git-bisect good $rev" >>"$GIT_DIR/BISECT_LOG"
> > > -
> >
> > ?
> 
> It also removes this unneeded blank line.

Both laudable changes; alas, they distracted me.

> > > @@ -164,6 +165,28 @@ bisect_write_good() {
> > >  	echo "# good: "$(git show-branch $rev) >>"$GIT_DIR/BISECT_LOG"
> > >  }
> > >
> > > +bisect_dunno() {
> > > +	bisect_autostart
> > > +	case "$#" in
> > > +	0)    revs=$(git rev-parse --verify HEAD) || exit ;;
> > > +	*)    revs=$(git rev-parse --revs-only --no-flags "$@") &&
> > > +		test '' != "$revs" || die "Bad rev input: $@" ;;
> > > +	esac
> > > +	for rev in $revs
> > > +	do
> > > +		rev=$(git rev-parse --verify "$rev^{commit}") || exit
> > > +		bisect_write_dunno "$rev"
> > > +		echo "git-bisect dunno $rev" >>"$GIT_DIR/BISECT_LOG"
> >
> > Should the last line not be put into bisect_write_dunno?  OTOH this is
> > the only call site of that function, so I strongly doubt that the
> > function (consisting of 3 lines, where the first is 'rev="$1"') is
> > necessary at all.
> 
> Well, there are "bisect_write_bad" and "bisect_write_good" that already 
> do the same thing as "bisect_write_dunno". In fact I thought that it was 
> better to just copy "bisect_dunno" from "bisect_good" and 
> "bisect_write_dunno" from "bisect_write_good".

If they also are called by just one site, and also do not do the complete 
printing to the log in the function (but also in the caller), I think they 
are not really worth it, either.

> If needed I can send another patch to factorise these functions.

That's not up to me to decide.  I'm just saying what I dislike.

Please do not take my criticism as a sign of a personal attack; if I did 
not find your patch worthwhile, I would not bother to respond.  So in a 
way, it is my way to show my appreciation for your work that I review and 
criticize it; for efficiency, I do not mention what I like ;-)

Ciao,
Dscho
