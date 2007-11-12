From: "Adam J. Richter" <adam@yggdrasil.com>
Subject: stgit 0.13 + git 1.5.3.5 bogus "empty patch" status, and other problems
Date: Sun, 11 Nov 2007 16:39:42 -0800
Message-ID: <200711120039.lAC0dgex015049@freya.yggdrasil.com>
Cc: <git@vger.kernel.org>
To: <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 01:50:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrNVO-0002rE-3B
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 01:50:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbXKLAuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 19:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbXKLAuG
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 19:50:06 -0500
Received: from c-76-21-122-104.hsd1.ca.comcast.net ([76.21.122.104]:46262 "EHLO
	freya.yggdrasil.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750766AbXKLAuE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 19:50:04 -0500
X-Greylist: delayed 620 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Nov 2007 19:50:04 EST
Received: from freya.yggdrasil.com (localhost.lan [127.0.0.1])
	by freya.yggdrasil.com (8.14.2/8.13.8) with ESMTP id lAC0dgQM015050;
	Sun, 11 Nov 2007 16:39:43 -0800
Received: (from adam@localhost)
	by freya.yggdrasil.com (8.14.2/8.13.8/Submit) id lAC0dgex015049;
	Sun, 11 Nov 2007 16:39:42 -0800
X-Mailer: mail (GNU Mailutils 1.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64543>

Hi Catalin,

	I want to report two problems, at least one of which may be
due to some other environmental change such as a git upgrade.

	The first bug is less perhaps serious, and perhaps not new,
but it's easier to describe this one first.

	I have a small stack of patches in stgit for a source tree.
One of these patches modified a yacc grammer "parser.y", which, in
turn, causes the yacc files y.tab.{c,h} to be rebuilt.  y.tab.{c,h}
are included in the source tree for build environments that lack yacc.
Sometimes my attempts to check out a new source tree and rebuild would
result in y.tab.{c,h} not being built, probably due to 1 second
timestamp granularity somewhere (the ext3 file system, make, git,
stgit, whatever), probably not stgit's fault.

	So, did repeated "stg pop" commands to get to the point where
the change to parser.y is applied, did an "stg new", deleted
y.tab.{c,h}, did "stg rm y.tab.{c,h}" and "stg refresh".  So far, so
good.  Then I tried to do an "stg push" to re-integrate the next
patch, and I got a complaint from stgit about some git object not
existing.  This patch did not touch y.tab.{c,h} or any files touched
by any of the other patches I had pushed on.  I don't know stgit well
enough to recover from the situation gracefully, so I just wiped the
stgit tree and tried to apply the patches again, which brings me to
bug #2.

	I made a new stgit tree of the program (bash), pulling from a
local git tree, and attempted to apply the first patch, with usuaul
"stg new...make changes...stg refresh".  Then stg refresh informed
printed this message ("invalid_multibyte_sequence" is the name of the
new patch):

Checking for changes in the working directory ... done
Refreshing patch "invalid_multibyte_sequence" ... done (empty patch)

	"stg diff" still shows the changes as if I had not done an
"stg refresh".  Obviously, stg commits have worked for me in the past.
I suspect that a recent upgrade of git or other system software
triggered the break.

	I'll try to pass along what I find if I start debugging this
problem, but I probably won't be able to get into that immediately, so
I am just passing this data along for now in the hopes that it may be
helpful for someone else.

Adam
