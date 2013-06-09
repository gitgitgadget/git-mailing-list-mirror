From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH gitk 0/4] gitk support for git log -L
Date: Sun, 9 Jun 2013 21:44:11 +0200
Message-ID: <cover.1370806329.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Mackerras <paulus@samba.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 09 21:44:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllXM-0003Rs-9f
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:44:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203Ab3FIToT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:44:19 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:11316 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751843Ab3FIToT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:44:19 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 9 Jun
 2013 21:44:09 +0200
Received: from hexa.v.cablecom.net (46.126.8.85) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 9 Jun
 2013 21:44:15 +0200
X-Mailer: git-send-email 1.8.3.496.g0d0267b
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227151>

Now that git log -L has hit master, I figure it's time to discuss the
corresponding change to gitk.

The hard part is that AFAICS this is the first history display
accessible through gitk that can only be computed in one go.  The
existing displays all work by having git-log perform a preliminary
search for the involved commits (or in some cases, only part of the
range while we fetch more).  log -L has to compute all the diffs
anyway, so nothing can be saved by attempting this; it is better to
load everything in bulk from a single git-log invocation.

Thus, patches 1--3 implement the infrastructure required to be able to
work from a single git-log command.

I would have loved to instead make a feature that also generalizes to

  git log --parents <whatever> | gitk --read-stdin

(or some other similar option).  This would make for much easier
testing of new git-log options.  Unfortunately this seems much harder
to achieve in the current structure of gitk.

Note: all my Tk-ing is computationally indistinguishable from cargo
culting.  Please review with a grain of salt.


Thomas Rast (4):
  gitk: refactor per-line part of getblobdiffline and its support
  gitk: split out diff part in $commitinfo
  gitk: support showing the gathered inline diffs
  gitk: recognize -L option

 gitk | 462 ++++++++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 266 insertions(+), 196 deletions(-)

-- 
1.8.3.496.g0d0267b
