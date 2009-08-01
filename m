From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] revert: libify pick
Date: Sat, 1 Aug 2009 17:48:29 +0200
Message-ID: <200908011748.30032.chriscool@tuxfamily.org>
References: <20090731032548.4169.16389.chriscool@tuxfamily.org> <7v8wi52uig.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 01 17:48:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXGpL-0000FT-Bc
	for gcvg-git-2@gmane.org; Sat, 01 Aug 2009 17:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbZHAPry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2009 11:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751849AbZHAPrx
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 11:47:53 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:36394 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751712AbZHAPrx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2009 11:47:53 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id B6D688180B5;
	Sat,  1 Aug 2009 17:47:44 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 832A98180F9;
	Sat,  1 Aug 2009 17:47:41 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7v8wi52uig.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124628>

On Friday 31 July 2009, Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> >
> > 	This patch is part of trying to port git-rebase--interactive.sh
> > 	to C using code from the sequencer GSoC project. But maybe it can
> > 	be seen as a clean up too.
>
> Thanks.  Why doesn't this have Stephan's sign-off?

It has it in the v2 series I will post just after sending this email.

As usual feel free to squash all or some of the patches together if you 
prefer.

> The new "pick.c" file seems to be a nicer implementation of the main
> logic of builtin-revert.c and its primary niceness comes from the use of
> strbuf.
>
> A few minor points and comments.
>
>  * error() returns -1.
>
>         error("message");     =>        return error("message");
>         return -1;

This change is in patch 2.

>  * pick() might be a bit too short and abstract name for a generic
> library function.

I changed it to "pick_commit()" in patch 3.

>  * REVERSE is made to imply ADD_NOTE but the codepath that acts on
>    ADD_NOTE never seems to be reached if REVERSE is set.

I removed code that made REVERSE imply ADD_NOTE in patch 4

> The intent of pick() funtion looks like it starts from the current index
> (not HEAD), and allow the effect of one commit replayed (either forward
> or backward) to that state, leaving the result in the index.
>
> You do not have to start from a commit, so you can replay many commits to
> the index in sequence without commiting in between to squash multiple
> steps if you wanted to.  I think that makes sense as a nice general
> interface.
>
> The "if (no_commit)" codepath in the original code did things very
> differently from the usual "start from HEAD and replay the effect"
> codepath and it warranted the big "We do not intend to commit
> immediately" comment.  For pick() function, however, the "start from
> index" is the normal and only mode of operation.  Keeping the big comment
> is misleading.

I removed the misleading part and added some of your comments in patch 5.

> When it replays another commit on HEAD, the new code does not read "HEAD"
> by hand into head anymore, but it still has the check between the index
> and "HEAD" and refuses to run if the index is dirty, which means the tree
> you get from write_cache_as_tree() is guaranteed to be the same as
> "HEAD", so this conversion looks correct.

Thanks,
Christian.
