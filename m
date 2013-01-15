From: Ben Walton <bdwalton@gmail.com>
Subject: [PATCH 0/3] Fix a portability issue with git-cvsimport
Date: Tue, 15 Jan 2013 23:10:02 +0000
Message-ID: <1358291405-10173-1-git-send-email-bdwalton@gmail.com>
Cc: esr@thyrsus.com, git@vger.kernel.org,
	Ben Walton <bdwalton@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 16 00:11:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvFer-0000Dp-Kf
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 00:11:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934219Ab3AOXKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 18:10:45 -0500
Received: from jimi.chass.utoronto.ca ([128.100.160.32]:44873 "EHLO
	jimi.chass.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758685Ab3AOXKL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 18:10:11 -0500
Received: from hendrix.chass.utoronto.ca ([128.100.160.33]:57198 ident=93)
	  by jimi.chass.utoronto.ca with esmtp  (Exim 4.76)
	 (envelope-from <bwalton@benandwen.net>)
	 id 1TvFdx-0005dv-Qj ; Tue, 15 Jan 2013 18:10:09 -0500
Received: from 86-42-159-147-dynamic.b-ras1.bbh.dublin.eircom.net ([86.42.159.147]:55553 helo=neilyoung)
	 (auth info: dovecot_plain:bwalton@chass.utoronto.ca) by hendrix.chass.utoronto.ca with esmtpsa (TLSv1:AES128-SHA:128)
	 (Exim 4.76)
	 (envelope-from <bwalton@benandwen.net>)
	 id 1TvFdu-0005Ct-Va ; Tue, 15 Jan 2013 18:10:07 -0500
Received: from bwalton by neilyoung with local (Exim 4.80)
	(envelope-from <bwalton@benandwen.net>)
	id 1TvFe3-0002hA-Uf; Tue, 15 Jan 2013 23:10:16 +0000
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213686>

This patch series started as a quick fix for the use of %s and %z in
git-cvsimport but grew slightly when I realized that the get_tz
(get_tz_offset after this series) function used by Git::SVN didn't
properly handle DST boundary conditions.

I realize that Eric Raymond is working to deprecate the current
iteration of git-cvsimport so this series may be only partially
worthwhile.  (If the cvsps 2 vs 3 issue does require a fallback
git-cvsimport script then maybe the whole series is still valid?)  I'm
not attached to the current git-cvsimport so if the third patch isn't
useful then maybe the only the second patch is worthwhile (modified to
correct the function in its current location).

Currently, the DST boundary functionality is exercised by the
git-cvsimport tests.  If those go away as part of Eric's work then
another test that monitors this condition should be added.  I can do
that as part of this series if it seems the right way to go.

Ben Walton (3):
  Move Git::SVN::get_tz to Git::get_tz_offset
  Allow Git::get_tz_offset to properly handle DST boundary times
  Avoid non-portable strftime format specifiers in git-cvsimport

 git-cvsimport.perl  |    5 ++++-
 perl/Git.pm         |   43 +++++++++++++++++++++++++++++++++++++++++++
 perl/Git/SVN.pm     |   12 ++----------
 perl/Git/SVN/Log.pm |    8 ++++++--
 4 files changed, 55 insertions(+), 13 deletions(-)

-- 
1.7.10.4
