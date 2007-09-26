From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 5/5] rebase -i: avoid exporting GIT_AUTHOR_* variables
Date: Wed, 26 Sep 2007 11:51:53 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709261151300.28395@racer.site>
References: <Pine.LNX.4.64.0709251640360.28395@racer.site>
 <Pine.LNX.4.64.0709251643310.28395@racer.site> <46FA358E.40500@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Sep 26 12:53:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaUVt-0007ad-RH
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 12:53:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755101AbXIZKxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2007 06:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755081AbXIZKw7
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 06:52:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:44569 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751070AbXIZKw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 06:52:59 -0400
Received: (qmail invoked by alias); 26 Sep 2007 10:52:57 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp054) with SMTP; 26 Sep 2007 12:52:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/yZvwiPMzybqZ64c5OwV4Op3cwmKdANbVWMgHzJg
	njEtZaD5jdAbfW
X-X-Sender: gene099@racer.site
In-Reply-To: <46FA358E.40500@viscovery.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59223>

Hi,

On Wed, 26 Sep 2007, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> > index 445a299..e3e89dd 100755
> > --- a/git-rebase--interactive.sh
> > +++ b/git-rebase--interactive.sh
> > @@ -174,7 +174,11 @@ pick_one_preserving_merges () {
> >  			eval "$author_script"
> >  			msg="$(git cat-file commit $sha1 | sed -e '1,/^$/d')"
> >  			# NEEDSWORK: give rerere a chance
> > -			if ! output git merge $STRATEGY -m "$msg"
> > $new_parents
> > +			if ! GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME" \
> > +				GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" \
> > +				GIT_AUTHOR_DATE="$GIT_AUTHOR_DATE" \
> > +				output git merge $STRATEGY -m "$msg" \
> > +					$new_parents
> >  			then
> >  				printf "%s\n" "$msg" > "$GIT_DIR"/MERGE_MSG
> >  				die Error redoing merge $sha1
> > @@ -281,7 +285,9 @@ do_next () {
> >  		f)
> >  			# This is like --amend, but with a different message
> >  			eval "$author_script"
> > -			export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
> > GIT_AUTHOR_DATE
> > +			GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME" \
> > +			GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" \
> > +			GIT_AUTHOR_DATE="$GIT_AUTHOR_DATE" \
> >  			$USE_OUTPUT git commit -F "$MSG" $EDIT_COMMIT
> >  			;;
> >  		t)
> 
> According to Herbert Xu's recent post
> (http://article.gmane.org/gmane.comp.version-control.git/59219) this won't
> export the variables in all shells since 'output' is a shell function. :-(

Argh.

You know, I am _so_ close to just scrap it and rewrite it in C.

Ciao,
Dscho
