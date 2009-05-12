From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git default behavior seems odd from a Unix command line point
 of  view
Date: Tue, 12 May 2009 14:26:48 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0905121415000.2147@iabervon.org>
References: <4e963a650905120818m70b75892gb4e052187910b9a5@mail.gmail.com>  <7vd4ae8fls.fsf@alter.siamese.dyndns.org> <4e963a650905120924j52d38c0dg577d93e913013e38@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andrew Schein <andrew@andrewschein.com>
X-From: git-owner@vger.kernel.org Tue May 12 20:27:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3wh9-0001fh-RM
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 20:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbZELS0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 14:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbZELS0t
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 14:26:49 -0400
Received: from iabervon.org ([66.92.72.58]:53430 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751002AbZELS0s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 14:26:48 -0400
Received: (qmail 18202 invoked by uid 1000); 12 May 2009 18:26:48 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 May 2009 18:26:48 -0000
In-Reply-To: <4e963a650905120924j52d38c0dg577d93e913013e38@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118941>

On Tue, 12 May 2009, Andrew Schein wrote:

> Hi Junio -
> 
> Thanks for your reply giving historical context.  The command line
> examples I gave were intended to give examples of the output rather
> than my own usage pattern.
> 
> Here is my actual usage pattern... from a file called "sync.sh"
> (would love feedback on whether this is the gitly? way to solve my use
> case):

What *is* your use case? What you're doing seems nuts to me (like, you're 
going to send out files with this script that someone is in the middle of 
editting), but I don't know what you're trying to do.

> # environment set up occurs before loop, I pull before "pushing" in an
> attempt to prevent
> # conflicts from being left on the shared repository.
> for dir in ./* ; do
>     if [ ! -d $dir ]      ; then continue ; fi #not a directory
>     if [ ! -e $dir/.git ] ; then continue ; fi #not a git repo
>     dir=`basename $dir`
>     echo "syncing: $dir"
>     set +e # commit returns an error if there is nothing to commit.
>     (cd ./$dir ; git commit -a)
>     set -e
>     (cd ./$dir ; git pull $UP "$REPO/$dir" master)        #pull
>     ssh $HOST "mkdir -p $DEST_CACHE/$LOC/$dir"  # these three lines
> handle "push"
>     rsync -rl --delete ./$dir/.git -e ssh "$DEST:$DEST_CACHE/$LOC/$dir/.git"
>     ssh $DEST "(cd $LOC/$dir ; /tools/bin/git pull
> $DEST_CACHE/$LOC/$dir/.git master)"
> 
> done

What are you trying to avoid by not using "git push"? Why are you 
committing whatever changes happen to be in working directories? Are you 
intending to be able to handle non-trivial merges?

	-Daniel
*This .sig left intentionally blank*
