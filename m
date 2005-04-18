From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [RFC] General object parsing
Date: Sun, 17 Apr 2005 20:25:26 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504171958520.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 02:21:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNK1D-0000y0-1z
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 02:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVDRAZS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 20:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbVDRAZS
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 20:25:18 -0400
Received: from iabervon.org ([66.92.72.58]:18181 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261579AbVDRAZM (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 20:25:12 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNK4s-0000Jr-00; Sun, 17 Apr 2005 20:25:26 -0400
To: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

After the fiasco with confusing struct revision for a struct commit, I've
worked out something that makes more sense. I've actually ported
fsck-cache, rev-tree, and my merge-base to it, so it should at least be
comprehensive.

The design is as follows:

There is a struct object for each object in the database, although they
are only created on demand. It contains the type and sha1 of the
object, as well as a flag for whether the object contents have been read,
more flags for general use, a list of objects which it references, and a
flag for whether any objects reference it.

Each struct object is embedded in a type-specific struct, which contains
further information. For example, struct commit has the date, the parents,
and the tree.

Parsing objects is progressive; objects are created in an unread state
(with no disk access), and functions can be called to parse each object as
it is determined to be interesting. This should generally allow for only
the necessary portions of a large set of object references to be read.

Any comment on the design, or should I send my implementation?

	-Daniel
*This .sig left intentionally blank*

