From: "Jan Hudec" <bulb@ucw.cz>
Subject: [BUG?] push to mirrior interferes with parallel operations
Date: Thu, 18 Nov 2010 08:39:17 +0100 (CET)
Message-ID: <e355bb33c6192a6a29de56c7be93278e.squirrel@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 18 08:39:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIz5h-0004rN-49
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 08:39:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755330Ab0KRHjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 02:39:19 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.26.195]:41438 "EHLO
	artax.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755319Ab0KRHjS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 02:39:18 -0500
X-Greylist: delayed 1433 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Nov 2010 02:39:18 EST
Received: from artax.karlin.mff.cuni.cz (localhost [127.0.0.1])
	by artax.karlin.mff.cuni.cz (Postfix) with ESMTP id 59F6C12801D
	for <git@vger.kernel.org>; Thu, 18 Nov 2010 08:39:17 +0100 (CET)
Received: from 62.24.65.159
        (SquirrelMail authenticated user jhud7196)
        by artax.karlin.mff.cuni.cz with HTTP;
        Thu, 18 Nov 2010 08:39:17 +0100 (CET)
User-Agent: SquirrelMail/1.4.15
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161653>

Hello all,

I have a repository populated with git-svn. For backup I have
a mirror remote set up. Today I ran 'git push backup' on one
terminal and before it finished (it's just on a network
filesystem, so it's kind of slow), I ran 'git svn fetch' on
another. And than I didn't see any results of that fetch.

What happened is that the push took the values of all the
refs -- including those in refs/remotes/svn as it's a mirror
for pushing them to the backup. Meanwhile the fetch udpated
them. But when the push finished with the remote repo, it
updated the local refs back to the values it pushed, undoing
the effects of that fetch.

The repository was created with simple:

    git remote add --mirror backup /mnt/server/path/to/repo.git

which created configuration:

    [remote "backup"]
	url = /mnt/server/path/to/repo.git
	fetch = +refs/*:refs/*
	mirror = true

So, should the push be more careful when updating the refs,
not simulate the pull back when doing a --mirror, or the
git remote add not add the 'fetch = +refs/*:refs/*' line?

Thanks,
Jan

-- 
                                        - Jan Hudec <bulb@ucw.cz>
