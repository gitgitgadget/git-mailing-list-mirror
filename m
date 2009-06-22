From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/2] rebase -i: use some kind of config file to save author information
Date: Mon, 22 Jun 2009 06:50:27 +0200
Message-ID: <200906220650.27685.chriscool@tuxfamily.org>
References: <20090620023413.3995.3630.chriscool@tuxfamily.org> <alpine.DEB.1.00.0906212354030.26154@pacific.mpi-cbg.de> <7v1vpdqiv2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 06:50:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIbUA-0004zJ-Go
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 06:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbZFVEuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 00:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbZFVEuP
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 00:50:15 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:37828 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750774AbZFVEuO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 00:50:14 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 2D53B81802F;
	Mon, 22 Jun 2009 06:50:09 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 46C6F81804E;
	Mon, 22 Jun 2009 06:50:07 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7v1vpdqiv2.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122009>

On Monday 22 June 2009, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > On Sat, 20 Jun 2009, Christian Couder wrote:
> >> This is better than saving in a shell script, because it will make
> >> it much easier to port "rebase -i" to C. This also removes some sed
> >> regexps and some "eval"s.
> >
> > It will not make it easier to port "rebase -i" to C, as this is an
> > internal file.  The user is not supposed to touch it at all.  Only
> > "rebase -i".  So it would be very easy to just use a different on-disk
> > format when turning "rebase -i" into a builtin.

I'd rather port "rebase -i" to C step by step like I started 
porting "bisect". So changing the format to something easier to deal with 
in C makes it easier to port.

> "This is an internal file" is just a declaration you are making, and the
> file is observable by anybody after "rebase -i" relinquishes the control
> to let the user sort out the mess.  The users do not have any obligation
> to honor your declaration, and strictly speaking it is a regression to
> change the file format.
>
> For example, when I realize I misspelt somebody's name (perhaps the
> mailpath between the sender and me mishandled the encoding headers), I
> could edit .git/rebase-merge/author-script and say "git rebase
> --continue" to let auto-amend to kick in, which would use the fixed
> author name from the file.
>
> 	Side note.  The current "rebase --continue" behaviour is somewhat
> 	inconsistent; if "edit" does not do anything to the tree, nor the
> 	user runs "git commit --amend', the commit is untouched, but if
> 	the user updates the index and says --continue without amending,
> 	the authorship is not taken from the auto-amended commit but is
> 	taken from the author-script file.  Perhaps something along the
> 	line of untested patch attached at the end would remedy this a
> 	bit?

Interesting. I will try it.

> Having said that, if we were to change the way rebase-i leaves its state
> behind so that it can pick up from where it left off, I prefer
> Christian's later suggestion to leave the object name of the commit that
> is being rebased in the file.  Sure, it makes it harder to lie about the
> authorship, but my previous example was purely "I _could_ do this" and
> not "I rely on being able to do this".

I just sent a v3 where the commit sha1 is saved in the file, so you can 
choose between v2 and v3 what behavior you prefer.

> But I have this nagging feeling that we may be able to get rid of even
> the "current commit".

I will have a look at that.

Thanks,
Christian.
