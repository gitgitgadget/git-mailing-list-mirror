From: Junio C Hamano <junkio@cox.net>
Subject: Re: Wine + GIT
Date: Thu, 08 Dec 2005 10:17:23 -0800
Message-ID: <7v4q5jjvws.fsf@assigned-by-dhcp.cox.net>
References: <20051208073000.7097.qmail@science.horizon.com>
	<20051208092945.GA4921@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux@horizon.com, git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Dec 08 19:21:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkQKk-00078w-2V
	for gcvg-git@gmane.org; Thu, 08 Dec 2005 19:17:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbVLHSR0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 13:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbVLHSR0
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 13:17:26 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:8892 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932224AbVLHSRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2005 13:17:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051208181638.DHEC6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 8 Dec 2005 13:16:38 -0500
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20051208092945.GA4921@c165.ib.student.liu.se> (Fredrik
	Kuivinen's message of "Thu, 8 Dec 2005 10:29:45 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13367>

Fredrik Kuivinen <freku045@student.liu.se> writes:

> However, in some other cases such as rename/rename, file/directory and
> add/add conflicts "a~A" and "a~B" will be created in the working
> directory. The recursive strategy will (or, is supposed to) tell you
> about such things, though.

I think one reason for this was because read-tree -m was the
only way to create higher stage entries in the index, and after
detecting renames, the recursive merge strategy did not have a
good way to insert these as different stages in the index.

I extended update-index --index-info a little bit to let people
insert higher stage entries in the index, so we could if we
wanted to.

Here are the differences I know about between resolve and
recursive other than ~A ~B:

 - in add/add case, merge-one-file tries to be cuter and leaves
   conflict-marked merge result.

 - content conflict in a renamed path gets its index entry
   collapsed, unlike other content conflicts.
