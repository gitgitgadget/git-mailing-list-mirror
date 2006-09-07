From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix memory leak in "connect.c".
Date: Wed, 06 Sep 2006 21:09:58 -0700
Message-ID: <7vwt8g48rt.fsf@assigned-by-dhcp.cox.net>
References: <20060907055952.dafffe2b.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 06:10:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLBDF-00024p-Gh
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 06:10:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWIGEJu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 00:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965290AbWIGEJu
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 00:09:50 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:21918 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S964786AbWIGEJt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 00:09:49 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060907040948.YNAS21457.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Thu, 7 Sep 2006 00:09:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KG9g1V00M1kojtg0000000
	Thu, 07 Sep 2006 00:09:41 -0400
To: Christian Couder <chriscool@tuxfamily.org>
In-Reply-To: <20060907055952.dafffe2b.chriscool@tuxfamily.org> (Christian
	Couder's message of "Thu, 7 Sep 2006 05:59:52 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26590>

Christian Couder <chriscool@tuxfamily.org> writes:

> sq_quote allocates some memory that should be freed.

That's technically correct, but the code you are touching is
immediately before exec() or die() so I chose to be sloppy and
short ;-).

With sq_quote_buf() (which was introduced with 77d604 Oct 10
2005), you should be able to directly write into the command[]
buffer, I think.  The code you touched predates that function
(b10d0e July 8 2005).
