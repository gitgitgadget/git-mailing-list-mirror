From: Jon Loeliger <jdl@jdl.com>
Subject: Dubious format-patch options
Date: Thu, 12 Jun 2008 20:14:17 -0500
Message-ID: <E1K6xrt-00033S-2J@jdl.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 03:15:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6xsq-0001Fu-2S
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 03:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758450AbYFMBOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 21:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758211AbYFMBOV
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 21:14:21 -0400
Received: from jdl.com ([208.123.74.7]:35859 "EHLO jdl.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757494AbYFMBOV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 21:14:21 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>)
	id 1K6xrt-00033S-2J
	for git@vger.kernel.org; Thu, 12 Jun 2008 20:14:20 -0500
X-Spam-Score: -2.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84821>

Git-ites,

Hmmm... There are a ton of dubious options being accepted
by the "git format-patch" command due to it being a skinny
front to "git log".  Like, the -S and pick-axe crew:

Yeah, this is context-less, but my point is that we get
totally different behavior from the -S"string" here:

    $ git log -SC alt~1..HEAD
    commit bca87c386c8868664e64d397108b8e6deda1e574
    Author: Jon Loeliger <jdl@jdl.com>
    Date:   Thu Jun 12 17:57:57 2008 -0500

	C
versus

    $ git format-patch -SC alt~1..HEAD
    0001-C.patch
    0002-D.patch
    0003-Z.patch
    0004-F.patch

Oh yeah.

And --color is a cool thing too.  I mean, I was pleasantly
pleased with:

    $ git format-patch -1 --stdout --color master

But I seriously doubt that we _really_ want to send a
patch that has the embedded escape sequences in it:

    From: Jon Loeliger <jdl@jdl.com>
    Date: Thu, 12 Jun 2008 18:13:10 -0500
    Subject: [PATCH] F

    ---
     fileESC[m |    1 ESC[32m+ESC[m
     1 files changed, 1 insertions(+), 0 deletions(-)ESC[m

    ESC[1mdiff --git a/file b/fileESC[m
    ESC[1mindex 6ac15b9..65f21da 100644ESC[m
    ESC[1m--- a/fileESC[m
    ESC[1m+++ b/fileESC[m
    ESC[36m@@ -5,3 +5,4 @@ D
    ESC[m X
    ESC[m Y
    ESC[m Z
    ESC[mESC[32m+ESC[mESC[32mFESC[m
    -- 
    1.5.6.rc0.46.gd2b3

Oh yeah.  Another Vodka Tonic please while git-send-email that...

jdl
