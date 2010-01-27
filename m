From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv11 20/20] builtin-gc: Teach the new --notes option to
 garbage-collect notes
Date: Wed, 27 Jan 2010 13:02:17 +0100
Message-ID: <201001271302.17368.johan@herland.net>
References: <1263762277-31419-1-git-send-email-johan@herland.net>
 <780e0a6b1001211127u6304546ej4e5bffbceca12e0b@mail.gmail.com>
 <7vtyufp6r9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 13:04:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Na6bK-0004Ba-Gm
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 13:02:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754462Ab0A0MCV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 07:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751968Ab0A0MCU
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 07:02:20 -0500
Received: from smtp.getmail.no ([84.208.15.66]:57566 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751285Ab0A0MCU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2010 07:02:20 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWW00JUWMRV2M00@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Jan 2010 13:02:19 +0100 (MET)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWW00FQCMRTHL20@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Jan 2010 13:02:19 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.27.114527
User-Agent: KMail/1.12.4 (Linux/2.6.32-ARCH; KDE/4.3.4; x86_64; ; )
In-reply-to: <7vtyufp6r9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138156>

On Thursday 21 January 2010, Junio C Hamano wrote:
> Stephen Boyd <bebarino@gmail.com> writes:
> > On Sun, Jan 17, 2010 at 1:04 PM, Johan Herland wrote:
> >> The new --notes option triggers a call to gc_notes(), which removes
> >> note objects that reference non-existing objects.
> >
> > Shouldn't notes be unconditionally garbage collected? Or maybe there's
> > a reason why notes should be treated differently that isn't written
> > here.
> 
> A few thoughts, inspired by this patch, but on other things around
> "notes":
> 
>  - This is more about pruning notes regarding objects that are no longer
>    availabe from _the tip_ of the notes tree.  It doesn't run (and I am
>    not suggesting to make it it to run) filter-branch to eradicate all
>    such stale notes from the notes commit ancestry, so in that sense this
>    is not really a garbage collection.

I've removed this patch from the next iteration of the series...

>  - We would want to have "notes prune" subcommand that lets us do the
>    pruning without all the other "gc" operation.  "git gc" would of
>  course call the same underlying code "notes prune" would use if we want
>  to be able to trigger "notes prune" from it.

...and replaced it with "git notes prune".

>  - Because there is no public interface to list objects that are
>  annotated with the most recent notes tree, the only thing this pruning
>  affects is the look-up overhead of "log --show-notes".  As such, it
>  might be better to later add tree rebalancing in "notes prune" and at
>  that point, it will become even less about garbage collection and more
>  about performance ("notes optimize?").
> 
>  - Do we want to have a public interface to list objects that are
>    annotated with notes?  "git notes" probably deserves a bit more
>    subcommands other than "(edit|show)" to help users, e.g. "list" and
>    "remove".

Added in the next iteration of the series.

>  - If this were "notes optimize" (this is just me thinking aloud),
>  perhaps we would want to do this at some key places (e.g. when you
>    automatically rebalance the tree).

There is currently no explicit rebalancing of the tree. The only thing "git 
notes prune" does, is call remove_note() for all notes referencing 
unreachable objects. Instead the tree is always kept in "balance" by 
remove_note() calling note_tree_consolidate() for the part of the tree 
affected by the removed note.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
