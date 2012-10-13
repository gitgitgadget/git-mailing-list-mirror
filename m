From: "George Spelvin" <linux@horizon.com>
Subject: git reflog delete HEAD@{1} HEAD@{2} caught me by surprise...
Date: 13 Oct 2012 18:08:55 -0400
Message-ID: <20121013220855.24116.qmail@science.horizon.com>
Cc: linux@horizon.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 00:14:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TN9yS-0004ZD-My
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 00:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754188Ab2JMWI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2012 18:08:57 -0400
Received: from science.horizon.com ([71.41.210.146]:22670 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754166Ab2JMWI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2012 18:08:56 -0400
Received: (qmail 24117 invoked by uid 1000); 13 Oct 2012 18:08:55 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207581>

Try the following commands in an empty directory:
(I'm using the bash extention for {1..5}.)

git init
for i in {1..5}; do git commit -m "Commit $i" --allow-empty; done
git reflog
	bc93e06 HEAD@{0}: commit: Commit 5
	e14f92d HEAD@{1}: commit: Commit 4
	ac64d8e HEAD@{2}: commit: Commit 3
	287602b HEAD@{3}: commit: Commit 2
	183a378 HEAD@{4}: commit (initial): Commit 1
git reflog delete HEAD@{{1,2}}
git reflog
	bc93e06 HEAD@{0}: commit: Commit 5
	e14f92d HEAD@{1}: commit: Commit 3
	287602b HEAD@{2}: commit (initial): Commit 1

Er...I meant to delete Commit 3 from the reflog, not Commit 2.

In hindsight, it's obvious how this could happen, but it definitely
took me by surprise when I was trying to delete the reference to
a large and messy merge (that I didn't want and bloated my repository
size) from the reflog.

If this is, in fact, Working As Designed, could I request a paragraph
in the man page clarifying it?  something like:


To delete single entries from the reflog, use the subcommand "delete"
and specify the _exact_ entry (e.g. "`git reflog delete master@{2}`").

You may delete multiple reflog entries with one delete command,
_however_ they are processed one at a time, so earlier deletes will cause
renumbering that will affect later ones.  To delete reflog entries @{2}
and @{3}, the command would be either "`git reflog delete @{3} @{2}`",
or "`git reflog delete @{2} @{2}`".
