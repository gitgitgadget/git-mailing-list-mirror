From: Jeff King <peff@peff.net>
Subject: Re: v1.5.4 plans
Date: Tue, 11 Dec 2007 07:53:47 -0500
Message-ID: <20071211125347.GA18140@sigill.intra.peff.net>
References: <7vy7cwsi3p.fsf@gitster.siamese.dyndns.org> <7vk5o6jbq9.fsf@gitster.siamese.dyndns.org> <7v63zjgoel.fsf@gitster.siamese.dyndns.org> <7vsl2i6ea4.fsf@gitster.siamese.dyndns.org> <7vhcixtnm4.fsf@gitster.siamese.dyndns.org> <7vfxye4yv7.fsf@gitster.siamese.dyndns.org> <7vve78qhtf.fsf@gitster.siamese.dyndns.org> <7vmysijhwq.fsf_-_@gitster.siamese.dyndns.org> <20071210234941.GE22254@coredump.intra.peff.net> <7vtzmqhvgq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 13:54:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J24cm-0001ha-UL
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 13:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938AbXLKMxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 07:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752018AbXLKMxu
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 07:53:50 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4285 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751615AbXLKMxu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 07:53:50 -0500
Received: (qmail 13829 invoked by uid 111); 11 Dec 2007 12:53:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 11 Dec 2007 07:53:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Dec 2007 07:53:47 -0500
Content-Disposition: inline
In-Reply-To: <7vtzmqhvgq.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67847>

On Mon, Dec 10, 2007 at 05:27:17PM -0800, Junio C Hamano wrote:

> Thanks for a reminder.  Anything else?

This bugfix has been sitting in my repo for a few weeks.  When it last
appeared, you asked if the other code paths needed a similar fix, and I
verified that they did not, so I think it is complete as-is.

-- >8 --
git-clone: print an error message when trying to clone empty repo

Previously, cloning an empty repository looked like this:

$ (mkdir parent && cd parent && git --bare init)
$ git-clone parent child
Initialized empty Git repository in /home/peff/clone/child/.git/
$ cd child
-bash: cd: child: No such file or directory
$ echo 'wtf?' | mail git@vger.kernel.org

Now we at least report that the clone was not successful.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-clone.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index ecf9d89..96a356d 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -297,7 +297,8 @@ yes)
 				      find objects -type f -print | sed -e 1q)
 			# objects directory should not be empty because
 			# we are cloning!
-			test -f "$repo/$sample_file" || exit
+			test -f "$repo/$sample_file" ||
+				die "fatal: cannot clone empty repository"
 			if ln "$repo/$sample_file" "$GIT_DIR/objects/sample" 2>/dev/null
 			then
 				rm -f "$GIT_DIR/objects/sample"
-- 
1.5.3.7.2224.ge4a5
