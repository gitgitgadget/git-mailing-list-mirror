From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] A new merge algorithm, take 3
Date: Thu, 08 Sep 2005 10:51:04 -0700
Message-ID: <7vy867v46v.fsf@assigned-by-dhcp.cox.net>
References: <20050907164734.GA20198@c165.ib.student.liu.se>
	<7v1x407min.fsf@assigned-by-dhcp.cox.net>
	<431F34FF.5050301@citi.umich.edu>
	<7vvf1cz64l.fsf@assigned-by-dhcp.cox.net>
	<4320536D.2010706@citi.umich.edu>
	<7v7jdrwlih.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509081012540.3208@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: cel@citi.umich.edu, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 08 19:52:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDQYI-0002uY-Qr
	for gcvg-git@gmane.org; Thu, 08 Sep 2005 19:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbVIHRvH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Sep 2005 13:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbVIHRvH
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Sep 2005 13:51:07 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:12507 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S964908AbVIHRvG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2005 13:51:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050908175105.MSLL3414.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 8 Sep 2005 13:51:05 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509081012540.3208@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 8 Sep 2005 10:19:57 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8205>

Linus Torvalds <torvalds@osdl.org> writes:

> So the data structure is optimized for a different case than reading in 
> trees. Big deal. That optimization is definitely worth it: it allows us to 
> do the read_cache() with the actual index entries being totally read-only 
> (a linked list would have to add a "next" pointer to the cache entries and 
> not allow the in-place thing that read_cache() does).

Yes, you are right.  What is being discussed is to help
read-tree.c while keeping that nice property.

I think Daniel's patch is going in the right direction.  It can
be told to populate the resulting cache from scratch by reading
the current cache and the trees being read, instead of inserting
and removing the current cache as it does right now.  Once that
is done, we would not have to do repeated memmove to insert and
delete an entry one at a time anymore.
