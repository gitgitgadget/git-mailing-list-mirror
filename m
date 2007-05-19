From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 0/2] Avoid spending cycles to deltify binary guck
Date: Sat, 19 May 2007 00:47:59 -0700
Message-ID: <117956087914-git-send-email-junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 19 09:48:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpJfk-0006Ul-7f
	for gcvg-git@gmane.org; Sat, 19 May 2007 09:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754078AbXESHsA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 03:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754437AbXESHsA
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 03:48:00 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:43698 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754078AbXESHsA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 03:48:00 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070519074800.GXHX12190.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>
          for <git@vger.kernel.org>; Sat, 19 May 2007 03:48:00 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 0vnz1X0031kojtg0000000; Sat, 19 May 2007 03:47:59 -0400
X-Mailer: git-send-email 1.5.2.rc3.87.g404f
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47728>

Somebody wondered on #git if there is a way to avoid spending
cycles and memory on certain objects in a repository, most
notably huge image files (or it might have been porn video
collection, but I do not recall the details).

Here is a quick-and-clean patch series to help such a repository.

 [PATCH 1/2] pack-objects: pass fullname down to add_object_entry()
 [PATCH 2/2] Teach "delta" attribute to pack-objects.

Although we give pack-objects the pathname for each blob, we
used to hash it down before registering the object to
object_entry array.  The first one moves the call site to the
hash function a bit, to give add_object_entry() to inspect the
pathname.

The second patch teaches add_object_entry() to record if an
entry should be exempt from the deltification process, and use
the .gitattributes mechanism to tell which objects should be
marked as such.

The patches are based on np/pack series, and should apply
cleanly to 'next'.
