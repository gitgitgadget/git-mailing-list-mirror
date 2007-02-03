From: linux@horizon.com
Subject: Re: Why is it bad to rewind a branch that has already been pushed out?
Date: 3 Feb 2007 03:42:47 -0500
Message-ID: <20070203084247.13894.qmail@science.horizon.com>
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sat Feb 03 09:43:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDGUG-0002t2-Jq
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 09:43:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946402AbXBCInF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 03:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946404AbXBCInF
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 03:43:05 -0500
Received: from science.horizon.com ([192.35.100.1]:18106 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1946402AbXBCInE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 03:43:04 -0500
Received: (qmail 13897 invoked by uid 1000); 3 Feb 2007 03:42:47 -0500
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38554>

You're quite right that git's basic history model won't get
confused, just the users might be.

The basic problem is that, if you rewind your series from j to j^,
and Alice has already fetched it, she'll get an error when she tries to
fetch it again and git notices that j -> h is not a fast-forward.

It's not the error per se that's the problem, but the potentially
confusing condition that git fetch justifiably refuses to let you
get into without explicit authorization.

Heck, it could be a security breach, which is the main reason that
it's an error and not a warning.

It won't confuse git, but might confuse Alice.

How about:

 Be careful with that last command: in addition to losing any changes
 in the working directory, it will also remove all later commits from
 this branch.  If this branch is the only branch containing those
-commits, they will be lost.  (Also, don't use "git reset" on a
-publicly-visible branch that other developers pull from, as git will
-be confused by history that disappears in this way.)
+commits, they will be lost.  Also, avoid using "git reset" on a
+publicly-visible branch that other developers have pulled from,
+because git (deliberately) has no way to "pull back" the commits
+they've already seen.  Git can cope with the resultant mess, but
+it can be confusing.
