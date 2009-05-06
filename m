From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: [PATCH] git-remote: make remote name optional for prune
	operation
Date: Wed, 6 May 2009 19:55:00 +0200
Message-ID: <20090506175500.GA19976@pvv.org>
References: <1241620621-12188-1-git-send-email-julien@danjou.info> <7vab5qw3nr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julien Danjou <julien@danjou.info>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 06 19:55:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1lKt-0003qi-M1
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 19:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755420AbZEFRzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 13:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754666AbZEFRzG
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 13:55:06 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:45850 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628AbZEFRzF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 13:55:05 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1M1lKe-0003wE-3D; Wed, 06 May 2009 19:55:00 +0200
Content-Disposition: inline
In-Reply-To: <7vab5qw3nr.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118360>

On Wed, May 06, 2009 at 10:18:48AM -0700, Junio C Hamano wrote:
> Julien Danjou <julien@danjou.info> writes:
> 
> > We consider that if `git remote prune` is called without a name, we
> > actually want to prune all remotes.
> 
> I think we try to make an opearation that discards information from many
> things at once by mistake, and it feels that this patch goes against it.
> 
> In what situation does this new short-cut make things convenient, and how
> often does such a situation come up?  The only one I can think of is when
> you are interacting with many volatile remotes that create and delete
> branches all the time, and when you are trying to repack/pack-ref your
> local repository with as much cruft removed, but in such a set-up, next
> time you interact with your remotes, you will get their "branch of the
> day" in your remote tracking namespace that will disappear shortly, and it
> does not sound like it is such a big deal if you did not run "remote
> prune" to all of them at once anyway.
> 
> Having said all that...
> 
> > diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
> > index 9e2b4ea..c566061 100644
> > --- a/Documentation/git-remote.txt
> > +++ b/Documentation/git-remote.txt
> > @@ -15,7 +15,7 @@ SYNOPSIS
> >  'git remote rm' <name>
> >  'git remote set-head' <name> [-a | -d | <branch>]
> >  'git remote show' [-n] <name>
> > -'git remote prune' [-n | --dry-run] <name>
> > +'git remote prune' [-n | --dry-run] [name]
> >  'git remote update' [-p | --prune] [group | remote]...
> 
> I think you would want to say [<name>] here, but looking at this list, I
> wonder if it would be more appropriate to allow "remote group" to be given
> to "prune" (and perhaps "show").

I also think that if we want to change prune, we should change it to
interpret its parameters identically to update. This means that no
argument will not expand to "all remotes", but rather to the possibly
configured "default" group.

In other words: I think "git remote update -p" and "git remote prune"
should prune the same remotes (both with and without additional arguments).

- Finn Arne
