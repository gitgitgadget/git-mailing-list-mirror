From: Junio C Hamano <junkio@cox.net>
Subject: Re: Add note about IANA confirmation
Date: Mon, 12 Sep 2005 14:41:14 -0700
Message-ID: <7vk6hm7ymd.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0509121057520.3242@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 12 23:43:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEw3H-0001II-Jm
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 23:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbVILVlR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 17:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbVILVlR
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 17:41:17 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:48867 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932273AbVILVlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2005 17:41:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050912214115.LAJW20473.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 12 Sep 2005 17:41:15 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509121057520.3242@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 12 Sep 2005 11:23:00 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8438>

Linus Torvalds <torvalds@osdl.org> writes:

> The git port (9418) is officially listed by IANA now.

Thanks.  Applied.

> Btw, another thing happened yesterday too: I'm now officially using a
> packed archive for my core kernel stuff. The format hasn't changed in
> I-don't-know-how-long, and I can't recall any pack-specific bug either
> (apart from the obvious lack of support by some of the client-side stuff).

You are brave ;-).  

Seriously, packed archive seems to be really stable.  I've been
on packed archive for git.git for quite some time now, and all
of my recent read-tree and merge experiments have been done on a
linux-2.6 repository that has several maintainer trees rolled
into a single big ball of wax, packed into one pack that weighs
about 76MB, with a few handred unpacked objects.

I noticed one thing that is a bit curious.  Packing the same set
of objects with --window=50 seems to give worse packing result
(space-wise) than with --window=10, which is the default if I
recall correctly.

: siamese; git-rev-list --objects v2.6.12 >++object-list-2.6.12
: siamese; git-pack-objects --window=50 --stdout \
  <./++object-list-2.6.12 >./++pack-w50.pack
Packing 31617 objects
: siamese; git-pack-objects --window=10 --stdout \
  <./++object-list-2.6.12 >./++pack-w10.pack
Packing 31617 objects
: siamese; ls -l ./++pack-w*.pack
-rw-rw-r--  1 junio src 57240724 Sep 12 14:39 ./++pack-w10.pack
-rw-rw-r--  1 junio src 57411879 Sep 12 14:37 ./++pack-w50.pack

BTW, I happen to know one pathological case where 'git repack'
would do a wrong thing and abort, but it is really of "doctor if
I do this it hurts -- do not do it then" kind, so it is not on
my priority list right now.
