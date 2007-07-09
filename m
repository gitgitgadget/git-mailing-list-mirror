From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix "git log --parent -m" from emitting duplicated parent info
Date: Sun, 08 Jul 2007 18:28:08 -0700
Message-ID: <7vwsxaxt5j.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550707080737j56c161bdrf0c079b61877085b@mail.gmail.com>
	<7vd4z2za2g.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707090214280.4248@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 09 03:28:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7i36-0002ZB-4j
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 03:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757354AbXGIB2M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 21:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754830AbXGIB2L
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 21:28:11 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:54566 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756754AbXGIB2K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 21:28:10 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070709012810.QRM22777.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sun, 8 Jul 2007 21:28:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MDU81X00B1kojtg0000000; Sun, 08 Jul 2007 21:28:09 -0400
In-Reply-To: <Pine.LNX.4.64.0707090214280.4248@racer.site> (Johannes
	Schindelin's message of "Mon, 9 Jul 2007 02:15:11 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51941>

Sorry, not 88494239 but this one.

commit 884944239f2ab673cedfaa5e7999d31fd6a46331
Author: Junio C Hamano <junkio@cox.net>
Date:   Sun Jan 29 15:24:42 2006 -0800

    rev-list: omit duplicated parents.
    
    Showing the same parent more than once for a commit does not
    make much sense downstream, so stop it.
    
    This can happen with an incorrectly made merge commit that
    merges the same parent twice, but can happen in an otherwise
    sane development history while squishing the history by taking
    into account only commits that touch specified paths.
    
    For example,
    
    	$ git rev-list --max-count=1 --parents addafaf -- rev-list.c
    
    would have to show this commit ancestry graph:
    
                      .---o---.
                     /         \
                    .---*---o---.
                   /    93b74bc  \
       ---*---o---o-----o---o-----o addafaf
          d8f6b34  \             /
                    .---o---o---.
                     \         /
                      .---*---.
                          3815f42
    
    where 5 independent development tracks, only two of which have
    changes in the specified paths since they forked.  The last
    change for the other three development tracks was done by the
    same commit before they forked, and we were showing that three
    times.
    
    Signed-off-by: Junio C Hamano <junkio@cox.net>
