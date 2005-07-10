From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] Support for packs in HTTP
Date: Sun, 10 Jul 2005 16:10:17 -0700
Message-ID: <7vzmsus1eu.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.21.0507101539220.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 01:13:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Drkza-0000Pj-TS
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 01:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262203AbVGJXN3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 19:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbVGJXLP
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 19:11:15 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:40325 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S262207AbVGJXKu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2005 19:10:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050710231017.KFHW16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 10 Jul 2005 19:10:17 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0507101539220.30848-100000@iabervon.org> (Daniel Barkalow's message of "Sun, 10 Jul 2005 15:53:18 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Daniel Barkalow <barkalow@iabervon.org> writes:

> This series has one patch which is ready to go in and one that's not
> (although it's a reasonable phony for the current state of the git world).

I like the general direction in which this patch is leading us.

But before going further, I'd like to see a consensus on the
pack naming convention.  The "sha1 of packed object names" was
originally introduced to easily avoid the pack name collisions,
but not enforced, so a user could do the following and still
expect things to work:

    $ n=`git-pack-objects pk <list-of-objects`
    $ mv pk-$n.pack .git/objects/pack/pk.pack
    $ mv pk-$n.idx .git/objects/pack/pk.idx

The first part of this patch makes things stricter, and your
packfile under .git/objects/pack _must_ be named pack-X{40}.pack
(I am not saying this is a bad thing).  So I would suggest
either:

  - droping the packname parameter from git-pack-objects.  Make
    the packs always named pack-X{40}.pack (or just X{40}.pack);
    also have verify-pack to verify the name of the packfile,
    and make sure X{40} part of the name matches what it claims
    to contain;

  - or drop sha1_pack_name() and let the user name the pack any
    way he wants.

I am moderately in favor of the former.
