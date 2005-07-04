From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 0/2] Support for transferring pack files in git-ssh-*
Date: Mon, 4 Jul 2005 14:48:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0507041416240.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 04 20:50:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpW1f-0006iX-8U
	for gcvg-git@gmane.org; Mon, 04 Jul 2005 20:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbVGDSu3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jul 2005 14:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbVGDSu3
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jul 2005 14:50:29 -0400
Received: from iabervon.org ([66.92.72.58]:43780 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261534AbVGDSuY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jul 2005 14:50:24 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DpVzd-000881-00; Mon, 4 Jul 2005 14:48:33 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This series allows git-ssh-* to transfer objects packed into pack files in
the case of updating a ref file. It is a proof-of-concept for transferring
pack files in any situation where it's useful.

The general method is that the fetch() method has the option of
additionally getting other objects in addition to the one
specified; objects which aren't needed are specified with
dont_fetch() (when it makes sense to exclude them). In this version, it
only excludes an object when it is the current value of a ref file that is
being updated, but further exclusions are clearly possible.

In the case of git-ssh-*, the target specifies objects to exclude, and the
source responds (asynchronously) with whether or not it knows how to
exclude them (i.e., whether or not it has them). If the target has gotten
an object excluded, it requests a pack file instead of a single object,
and the source provides all objects referenced from the given hash,
excluding those specified for exclusion.

	-Daniel
*This .sig left intentionally blank*
