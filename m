From: Jan Hudec <bulb@ucw.cz>
Subject: [PATCH] Improve description of git-branch -d and -D in man page.
Date: Sat, 17 Nov 2007 20:51:44 +0100
Message-ID: <20071117195144.GF5198@efreet.light.src>
References: <874pfq9q8s.fsf@osv.gnss.ru> <200711131703.16357.jnareb@gmail.com> <A919E788-C5D0-4404-95D4-869BAFE868AC@zib.de> <200711131842.03622.jnareb@gmail.com> <87d4ue81tv.fsf@osv.gnss.ru> <20071117191256.GD5198@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: osv@javad.com
X-From: git-owner@vger.kernel.org Sat Nov 17 20:52:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItTi4-0001Ne-OV
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 20:52:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759343AbXKQTvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 14:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758879AbXKQTvw
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 14:51:52 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:51962 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758660AbXKQTvv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 14:51:51 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 411525736C;
	Sat, 17 Nov 2007 20:51:50 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id 2Uc609rL1Qyk; Sat, 17 Nov 2007 20:51:46 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 8002D572BE;
	Sat, 17 Nov 2007 20:51:45 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1ItThg-0000pq-AM; Sat, 17 Nov 2007 20:51:44 +0100
Content-Disposition: inline
In-Reply-To: <20071117191256.GD5198@efreet.light.src>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65298>

Some users expect that deleting a remote-tracking branch would prevent
fetch from creating it again, so be explcit about that it's not the case.
Also be a little more explicit about what fully merged means.

Signed-off-by: Jan Hudec <bulb@ucw.cz>
---

On Sat, Nov 17, 2007 at 20:12:56 +0100, Jan Hudec wrote:
> On Tue, Nov 13, 2007 at 20:58:20 +0300, osv@javad.com wrote:
> > <quote Documentation/git-branch.txt>
> > Delete unneeded branch::
> > +
> > ------------
> > $ git clone git://git.kernel.org/.../git.git my.git
> > $ cd my.git
> > $ git branch -d -r origin/todo origin/html origin/man   <1>
> > $ git branch -D test                                    <2>
> > ------------
> > +
> > <1> Delete remote-tracking branches "todo", "html", "man"
> > </quote>
> > 
> > That's *exactly* what I did! And it *doesn't work*! Well, it does delete
> > the branches, but they are automagically re-created on the next fetch,
> > so "deleting" them this way is useless.
> 
> Of course it *does* work. It *deletes* the branches. There is not a single
> word about stopping fetch getting them!
> 
> Obviously given that the example is slightly contrived, it should really
> be mentioned that it does not affect fetch at all.

Would this make the description obvious enough?

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

 Documentation/git-branch.txt |   21 ++++++++++++++-------
 1 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 5ce905d..f87b696 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -45,17 +45,22 @@ to happen.
 
 With a `-d` or `-D` option, `<branchname>` will be deleted.  You may
 specify more than one branch for deletion.  If the branch currently
-has a reflog then the reflog will also be deleted. Use -r together with -d
-to delete remote-tracking branches.
+has a reflog then the reflog will also be deleted.
+
+Use -r together with -d to delete remote-tracking branches. Note, that it
+only makes sense to delete remote-tracking branches if they no longer exist
+in remote repository or if gitlink:git-fetch[1] was configured not to fetch
+them again. See also 'prune' subcommand of gitlink:git-remote[1] for way to
+clean up all obsolete remote-tracking branches.
 
 
 OPTIONS
 -------
 -d::
-	Delete a branch. The branch must be fully merged.
+	Delete a branch. The branch must be fully merged in HEAD.
 
 -D::
-	Delete a branch irrespective of its index status.
+	Delete a branch irrespective of its merged status.
 
 -l::
 	Create the branch's reflog.  This activates recording of
@@ -153,9 +158,11 @@ $ git branch -d -r origin/todo origin/html origin/man   <1>
 $ git branch -D test                                    <2>
 ------------
 +
-<1> Delete remote-tracking branches "todo", "html", "man"
-<2> Delete "test" branch even if the "master" branch does not have all
-commits from test branch.
+<1> Delete remote-tracking branches "todo", "html", "man". Next 'fetch' or
+'pull' will create them again unless you configure them not to. See
+gitlink:git-fetch[1].
+<2> Delete "test" branch even if the "master" branch (or whichever branch is
+currently checked out) does not have all commits from test branch.
 
 
 Notes
-- 
1.5.3.5
