From: Ben Walton <bdwalton@gmail.com>
Subject: [PATCH 0/3] Fix a portability issue with git-cvsimport
Date: Sat,  9 Feb 2013 21:46:55 +0000
Message-ID: <1360446418-12280-1-git-send-email-bdwalton@gmail.com>
Cc: git@vger.kernel.org, Ben Walton <bdwalton@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 09 22:47:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4IGy-0000KT-7a
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 22:47:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932637Ab3BIVrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 16:47:12 -0500
Received: from jimi.chass.utoronto.ca ([128.100.160.32]:58076 "EHLO
	jimi.chass.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932617Ab3BIVrI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 16:47:08 -0500
Received: from hendrix.chass.utoronto.ca ([128.100.160.33]:52487 ident=93)
	  by jimi.chass.utoronto.ca with esmtp  (Exim 4.76)
	 (envelope-from <bwalton@benandwen.net>)
	 id 1U4IGI-0001MF-SN ; Sat, 09 Feb 2013 16:47:06 -0500
Received: from 86-42-148-161-dynamic.b-ras1.bbh.dublin.eircom.net ([86.42.148.161]:39733 helo=neilyoung)
	 (auth info: dovecot_plain:bwalton@chass.utoronto.ca) by hendrix.chass.utoronto.ca with esmtpsa (TLSv1:AES128-SHA:128)
	 (Exim 4.76)
	 (envelope-from <bwalton@benandwen.net>)
	 id 1U4IGF-0007jZ-Qx ; Sat, 09 Feb 2013 16:47:04 -0500
Received: from bwalton by neilyoung with local (Exim 4.80)
	(envelope-from <bwalton@benandwen.net>)
	id 1U4IGL-0003Cz-IQ; Sat, 09 Feb 2013 21:47:09 +0000
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215876>

This is my (long overdue) re-roll of the series that fixes a
portability issue with git-cvsimport's use of strftime.  It also fixes
a but in the original implementation of get_tz (now get_tz_offset).

I ended up taking taking only part of the implementation suggested by
Junio.

The only usage of get_tz_offset is by git-cvsimport and Git::SVN::Log
currently.  There are tests that validate it works currently so I
didn't add anything additional.  If the git-cvsimport tests are
removed, there are no tests remaining that exercise the code full as
the SVN tests use UTC times.

Ben Walton (3):
  Move Git::SVN::get_tz to Git::get_tz_offset
  Fix get_tz_offset to properly handle DST boundary cases
  Avoid non-portable strftime format specifiers in git-cvsimport

 git-cvsimport.perl  |    5 ++++-
 perl/Git.pm         |   23 +++++++++++++++++++++++
 perl/Git/SVN.pm     |   12 ++----------
 perl/Git/SVN/Log.pm |    8 ++++++--
 4 files changed, 35 insertions(+), 13 deletions(-)

-- 
1.7.10.4
