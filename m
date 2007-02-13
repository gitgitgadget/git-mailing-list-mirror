From: Pavel Roskin <proski@gnu.org>
Subject: When to run git-update-server-info
Date: Mon, 12 Feb 2007 23:49:49 -0500
Message-ID: <1171342189.2326.68.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 13 05:49:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGpc3-0001Lc-Ef
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 05:49:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161017AbXBMEtw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 23:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161018AbXBMEtv
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 23:49:51 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:34915 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161017AbXBMEtv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 23:49:51 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HGpai-0006Gv-GZ
	for git@vger.kernel.org; Mon, 12 Feb 2007 23:48:32 -0500
Received: from proski by gnu.org with local (Exim 4.66)
	(envelope-from <proski@gnu.org>)
	id 1HGpbx-0000IQ-L8
	for git@vger.kernel.org; Mon, 12 Feb 2007 23:49:49 -0500
X-Mailer: Evolution 2.9.5 (2.9.5-4.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39489>

Hello!

It looks like that either the documentation is misleading or git is not
working as promised.

Documentation/repository-layout.txt says:

info/refs::
        This file is to help dumb transports to discover what
        refs are available in this repository.  Whenever you
        create/delete a new branch or a new tag, `git
        update-server-info` should be run to keep this file
        up-to-date if the repository is published for dumb
        transports.  The `git-receive-pack` command, which is
        run on a remote repository when you `git push` into it,
        runs `hooks/update` hook to help you achieve this.

My understanding of the above text is that git-update-server-info only
needs to be run if a new branch or tag is created, not on every
git-push.  Just because hooks/update is run on every push, it doesn't
mean that it needs to be done every time.

What happens in reality is that git-pull refuses to pull new revisions
from the repository if git-update-server-info is not run after a simple
git-push (from another repository, of course) that didn't create any
branch or tag.  However, git-clone would load all revisions.  I'm
accessing the repository over http.

The problem it, there is more than one way to get the branch revisions,
one is from info/refs and the other is from individual files under
refs/heads and refs/tags.  Using database terms, the git repository in
not normalized, so we get an update anomaly.

I understand that accessing one file could be faster over http, so I
tend to think that it's the documentation needs to be fixed.  If that's
the case, maybe hooks/update should be created executable by default?

Alternatively, git-update-server-info functionality could be embedded
into git-receive-pack to simplify server setup.

-- 
Regards,
Pavel Roskin
