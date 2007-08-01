From: David Kastrup <dak@gnu.org>
Subject: Re: git-commit --amend -m "..." complains?!?
Date: Wed, 01 Aug 2007 21:23:18 +0200
Message-ID: <85myxbrrdl.fsf@lola.goethe.zz>
References: <86643znxgz.fsf@lola.quinscape.zz>
	<7v8x8v5g2z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 21:24:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGJo2-0006nV-MQ
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 21:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756782AbXHATYL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 15:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757285AbXHATYL
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 15:24:11 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:40940 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756328AbXHATYJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Aug 2007 15:24:09 -0400
Received: from mail-in-07-z2.arcor-online.net (mail-in-07-z2.arcor-online.net [151.189.8.19])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 9174E15C076;
	Wed,  1 Aug 2007 21:24:05 +0200 (CEST)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-07-z2.arcor-online.net (Postfix) with ESMTP id 7A24D2C6A01;
	Wed,  1 Aug 2007 21:24:05 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-017-017.pools.arcor-ip.net [84.61.17.17])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 2E35A3425F4;
	Wed,  1 Aug 2007 21:24:05 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 1837A1C3E076; Wed,  1 Aug 2007 21:23:18 +0200 (CEST)
In-Reply-To: <7v8x8v5g2z.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Wed\, 01 Aug 2007 10\:18\:12 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV version 0.91.1, clamav-milter version 0.91.1 on mail-in-09.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54469>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> I get
>>
>> Option -m cannot be combined with -c/-C/-F/--amend.
>>
>> but that makes no sense: of course there is ample reason for providing
>> an amended commit message on the command line.  -c, -C and -F indeed
>> all provide an alternative commit message, but --amend doesn't.
>
> The option --amend is about "reusing the original commit message
> and make amending edit on top".

Uh no.  From the man page:

	--amend
	   Used to amend the tip of the current branch. Prepare the
	   tree object you would want to replace the latest commit
	   as usual (this includes the usual -i/-o and explicit
	   paths), and the commit log editor is seeded with the
	   commit message from the tip of the current branch. The
	   commit you create replaces the current tip -- if it was a
	   merge, it will have the parents of the current tip as
	   parents -- so the current top commit is discarded.

	   It is a rough equivalent for:

			    $ git reset --soft HEAD^
			    $ ... do something else to come up with the right tree ...
			    $ git commit -c ORIG_HEAD

	   but can be used to amend a merge commit.


The --amend is not, according to the manual page, there to amend the
commit message, but primarily to amend the commit.

If one does not want to amend the message, this is easily done with -C
HEAD.  If one wants to amend the message but not by editing, one is
plain out of luck.

-C, -F and -m are all logically exclusive (and -C -e is the same as
-c).  But --amend seems completely orthogonal to me with regard to the
commit message: it just has a different seed from the normal commit
message edit.  You can override the seed with a normal commit using -c
-C -F and -m.  Why not with --amend?

> If you are restarting the message from scratch, --amend does not
> make much sense.

It amends the _commit_.  You can edit files, add them, and commit
additional changes.  If you are using a dumb terminal (or a system
with nonworking VISUAL over the link in question), you don't _want_ an
editor called up.

> You can do:
>
> 	$ git reset HEAD^
>         $ git commit -m "blah"
>
> if you do not want to reuse the commit message.

You can pretty much _always_ avoid --amend in a similar manner, but
why would you?  It is convenient.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
