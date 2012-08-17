From: Daniel Milde <daniel@milde.cz>
Subject: Problems with new location of submodule's GIT_DIR
Date: Fri, 17 Aug 2012 17:28:19 +0200
Message-ID: <1345217299.7952.83.camel@athena.dnet>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-2"
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 17 17:33:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2OYX-00009i-OW
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 17:33:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180Ab2HQPdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 11:33:44 -0400
Received: from s1.milde.cz ([77.93.192.212]:50038 "EHLO s1.milde.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932110Ab2HQPdm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 11:33:42 -0400
X-Greylist: delayed 556 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Aug 2012 11:33:42 EDT
Received: from [10.0.0.121] (79-98-72-219.sys-data.com [79.98.72.219])
	by s1.milde.cz (Postfix) with ESMTPSA id 8D0739B159
	for <git@vger.kernel.org>; Fri, 17 Aug 2012 16:25:28 +0100 (BST)
X-Mailer: Evolution 3.4.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203617>

Hi all,
I have encountered some difficulties with the new location of the
metainformation directory (GIT_DIR) of submodules.

The change of location happened in 1.7.8:

 * When populating a new submodule directory with "git submodule init",
   the $GIT_DIR metainformation directory for submodules is created
inside
   $GIT_DIR/modules/<name>/ directory of the superproject and referenced
   via the gitfile mechanism. This is to make it possible to switch
   between commits in the superproject that has and does not have the
   submodule in the tree without re-cloning.

Which problems it causes:

1) You cannot move submodule easily (change the path to submodule). You
can either remove the submodule and then add it again to different path,
or move the submodule directory and then edit path in its .git, change
path in superproject's .git/modules dir and in .git/config. This is
quite difficult in comparisson with previous behaviour when you can just
move the submodule and then stash changes.

2) This change introduced many difficulties on Windows platform, because
there is limitation to path length and the way how paths are now
composed leads to strange errors when project with submodules is in
user's dir. 

3) Submodules became dependent on superproject. This is quite bad if you
are using submodules a lot (e.g. versioning the whole working space),
because you cannot move or copy them out of the superproject now.

I honestly don't know why this change was introduced because I have
never seen git removing any submodule while walking through the history.
I have seen only the message saying that directory is not empty and so
git will not remove it. Or is there another reason why this change was
added to git?

Thanks

Cheers
Daniel
