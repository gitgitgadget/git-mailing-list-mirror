From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: RFC: grafts generalised
Date: Thu, 3 Jul 2008 09:30:41 +0200
Message-ID: <20080703073041.GA28566@cuci.nl>
References: <20080702143519.GA8391@cuci.nl> <37fcd2780807021019t76008bbfq265f8bf15f59c178@mail.gmail.com> <37fcd2780807021058r5ed820cfmdc98f98f36d5c8ae@mail.gmail.com> <20080702181021.GD16235@cuci.nl> <486C6B8E.5040202@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jul 03 10:27:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEK9v-0002yW-Ri
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 10:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756641AbYGCIVD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 04:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751997AbYGCITU
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 04:19:20 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:50414 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937010AbYGCHaq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 03:30:46 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 15BD35465; Thu,  3 Jul 2008 09:30:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <486C6B8E.5040202@viscovery.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87258>

Johannes Sixt wrote:
>Stephen R. van den Berg schrieb:
>> Dmitry Potapov wrote:
>>> On second thought, it may be not necessary. You can extract an old commit
>>> object, edit it, put it into Git with a new SHA1, and then use the graft file to
>>> replace all references from an old to a new one. And you will be able to see
>>> changes immediately in gitk.

>> Hmmmm, interesting thought.  That just might solve my problem.

>I don't think it would.

>You want to apply a patch through a part of the history. To do that, it is
>not sufficient to apply the patch to only one commit/tree and then fake
>parenthood of its child commits. You still need to apply the patch to all
>children.

I am aware of that.
There are actually two common cases:
- Historical changes which are confined and don't ripple through.  The
  above solution works just fine for that.
- Ripple-through changes.  They indeed need to be applied to every tree
  in the first-parent chain.  Even though this is going to take a
  considerable amount of time, there still are certain advantages to
  doing this using the method described above:
  + You can apply the patch to every commit/tree "interactively" if you want.
    (Yes, I know, git-sequencer supports this one as well, but not the
    next point).
  + You can view the change at any point in time (including in relation to the
    tree that follows it), right after making the amendments (without letting
    it ripple through to the end).
  + The ripple-through does not need to be performed in topological order,
    i.e. eventually you'll have to touch everything, but you can do it
    in the order you see fit (whatever is most efficient to work on).
  + If, at some point during the ripple-through process, you find out
    that you forgot some change(s), you can abort or restart the
    ripple-through without having spent all that time waiting for a
    full-ripple-through.

Actually, ripple-through changes are rare.  In the current project it
seems I need exactly one, but it's buried deep in the past (sadly).
The reason why I need it, is to make sure that git-bisect will work for
any revision in the past (i.e. the tree contained/contains some
too-clever-for-their-own-good $Revision$-expansion dependencies)
-- 
Sincerely,
           Stephen R. van den Berg.

This is a day for firm decisions!  Or is it?
