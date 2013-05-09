From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] git-gui: allow "\ No newline at end of file" for linewise
 staging
Date: Thu, 9 May 2013 18:30:03 +0200
Message-ID: <20130509163002.GA3630@book-mint>
References: <CADEaiE-J4nEwyK4WSiH=zzaH6cb85mw15O3wxrWrTXJtZfJixQ@mail.gmail.com>
 <CADEaiE8GKfSQ5u+0bb8qtBe-3OTYJThGb-UFLU_pM-T9ZqvkiA@mail.gmail.com>
 <7vzk0qw8ts.fsf@alter.siamese.dyndns.org>
 <87vcb6bee5.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Tobias Preuss <tobias.preuss@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu May 09 18:30:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaTjb-0008Ur-Rc
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 18:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753023Ab3EIQaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 12:30:19 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.102]:60272 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318Ab3EIQaS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 12:30:18 -0400
Received: from [213.221.117.228] (helo=book-mint)
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UaTjP-0003Xs-Lz; Thu, 09 May 2013 18:30:12 +0200
Content-Disposition: inline
In-Reply-To: <87vcb6bee5.fsf@fox.patthoyts.tk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223746>

Counting of lines did not skip this line when generating the hunk
header.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
Here is an attempt at fixing the no newline issue. I would appreciate
another pair of eyes though.

 git-gui/lib/diff.tcl | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
index ec44055..30d9a79 100644
--- a/git-gui/lib/diff.tcl
+++ b/git-gui/lib/diff.tcl
@@ -764,8 +764,15 @@ proc apply_range_or_line {x y} {
 				# context line
 				set ln [$ui_diff get $i_l $next_l]
 				set patch "$patch$pre_context$ln"
-				set n [expr $n+1]
-				set m [expr $m+1]
+				# Skip the "\ No newline at end of
+				# file". Depending on the locale setting
+				# we don't know what this line looks
+				# like exactly. The only thing we do
+				# know is that it starts with "\ "
+				if {![string match {\\ *} $ln]} {
+					set n [expr $n+1]
+					set m [expr $m+1]
+				}
 				set pre_context {}
 			} elseif {$c1 eq $to_context} {
 				# turn change line into context line
-- 
1.8.3.rc1.40.gba374ae
