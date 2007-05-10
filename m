From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] Move remote parsing into a library file out of builtin-push.
Date: Thu, 10 May 2007 00:07:18 -0700
Message-ID: <7vhcqlma1l.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0705092203130.18541@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu May 10 09:07:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hm2kI-0001KL-2S
	for gcvg-git@gmane.org; Thu, 10 May 2007 09:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbXEJHHU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 03:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755237AbXEJHHU
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 03:07:20 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:56706 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbXEJHHT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 03:07:19 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070510070719.FESO22040.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Thu, 10 May 2007 03:07:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xK7J1W00L1kojtg0000000; Thu, 10 May 2007 03:07:19 -0400
In-Reply-To: <Pine.LNX.4.64.0705092203130.18541@iabervon.org> (Daniel
	Barkalow's message of "Wed, 9 May 2007 22:04:19 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46832>

This seems to break t9400, with "fatal: bad repository 'gitcvs.git",
upon "git push".

: gitster t/db/remote; sh t9400-git-cvsserver-server.sh -i -v
* expecting success: cvs -Q co -d cvswork master &&
   test "$(echo $(grep -v ^D cvswork/CVS/Entries|cut -d/ -f2,3,5))" = "empty/1.1/"
cvs checkout: Updating cvswork
U cvswork/empty
*   ok 1: basic checkout

* expecting success: echo testfile1 >testfile1 &&
   git add testfile1 &&
   git commit -q -m "Add testfile1" &&
   git push gitcvs.git >/dev/null &&
   cd cvswork &&
   cvs -Q update &&
   test "$(echo $(grep testfile1 CVS/Entries|cut -d/ -f2,3,5))" = "testfile1/1.1/" &&
   diff -q testfile1 ../testfile1
fatal: bad repository 'gitcvs.git'
* FAIL 2: cvs update (create new file)
	echo testfile1 >testfile1 &&
	   git add testfile1 &&
	   git commit -q -m "Add testfile1" &&
	   git push gitcvs.git >/dev/null &&
	   cd cvswork &&
	   cvs -Q update &&
	   test "$(echo $(grep testfile1 CVS/Entries|cut -d/ -f2,3,5))" = "testfile1/1.1/" &&
	   diff -q testfile1 ../testfile1
: gitster t/db/remote; 
