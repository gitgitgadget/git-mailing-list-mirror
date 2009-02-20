From: Dan Fabulich <dan@fabulich.com>
Subject: git-svn and branches with spaces
Date: Fri, 20 Feb 2009 15:26:04 -0800 (PST)
Message-ID: <alpine.OSX.1.10.0902201515470.1576@sfimac.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 21 00:27:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaemP-0008Dl-Hl
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 00:27:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754289AbZBTX0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 18:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754090AbZBTX0I
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 18:26:08 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60749 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754071AbZBTX0H (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Feb 2009 18:26:07 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 5036A252CBC
	for <git@vger.kernel.org>; Fri, 20 Feb 2009 18:26:06 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 20 Feb 2009 18:26:06 -0500
X-Sasl-enc: h8BFIDIxXjuAlU+0cDQ0kZ0EF5UQJl9K3dZUymRhF3d7 1235172365
Received: from [10.5.5.148] (206-15-64-254.static.twtelecom.net [206.15.64.254])
	by mail.messagingengine.com (Postfix) with ESMTPSA id CDBE73A9B0
	for <git@vger.kernel.org>; Fri, 20 Feb 2009 18:26:05 -0500 (EST)
X-X-Sender: danfabulich@sfimac.local
User-Agent: Alpine 1.10 (OSX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110904>


As others have noticed, git-svn can't handle branches with spaces.

http://markmail.org/message/r56iyw3vubwbycgt

Turns out that there is a possible workaround: thiago's 
svn-all-fast-export tool is super super configurable, allowing you to work 
around evil branch names by modifying your matching rules.

http://repo.or.cz/w/svn-all-fast-export.git

I made rules like this:

match /branches/crazy branch with spaces/
   repository myproject
   branch crazy_branch_with_spaces
end match

match /branches/([^/]+)/
   repository myproject
   branch \1
end match

Since the rules apply in order, the evil branch name matched before the 
catch-all matcher, fixing my problem.

And it doesn't hurt that svn-all-fast-export is at least an order of 
magnitude faster than git-svn clone...  If you find that git-svn is too 
slow, I strongly recommend svn-all-fast-export.git for performance alone!

-Dan
