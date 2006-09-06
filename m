From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH][RFC] Add git-archive-tree
Date: Wed, 06 Sep 2006 14:47:12 -0700
Message-ID: <7v4pvk7jmn.fsf@assigned-by-dhcp.cox.net>
References: <44F977C0.4060901@lsrfire.ath.cx>
	<7vwt8mx8lb.fsf@assigned-by-dhcp.cox.net>
	<44FF0DDE.7030700@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Franck Bui-Huu <vagabon.xyz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 06 23:47:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL5Ek-0004sq-5z
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 23:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWIFVrH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 17:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWIFVrH
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 17:47:07 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:50130 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932158AbWIFVrE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 17:47:04 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060906214704.DVTX18458.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 Sep 2006 17:47:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id K9n41V00M1kojtg0000000
	Wed, 06 Sep 2006 17:47:05 -0400
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <44FF0DDE.7030700@lsrfire.ath.cx> (Rene Scharfe's message of
	"Wed, 06 Sep 2006 20:05:18 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26564>

Rene Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> I then let the two chew away on the kernel repository.  And as
> kcachegrind impressively shows, all we do with our trees and objects is
> dwarfed by inflate().

The diff output codepath has a logic that says "if the blob we
are dealing with has the same object name as the corresponding
blob in the index, and if the index entry is clean (i.e. it is
known that the file sitting in the working tree matches the
blob), then do not inflate() but use data from that file
instead".  It was originally done that way because we used to
prepare temporary files out of blob and fed them to GNU diff,
but I think it is still kept that way.  I wonder if doing the
same may be cheaper for archivers.
