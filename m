From: Anders Kaseorg <andersk@MIT.EDU>
Subject: [PATCH] gitk: Take only numeric version components when computing
 $git_version
Date: Thu, 06 Jan 2011 17:42:33 -0700
Message-ID: <1294360953.21006.2.camel@fixed-disk>
References: <4D231646.5080005@debugon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mathias Lafeldt <misfire@debugon.org>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 01:42:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pb0Po-0005Mg-FB
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 01:42:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753506Ab1AGAmm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Jan 2011 19:42:42 -0500
Received: from DMZ-MAILSEC-SCANNER-4.MIT.EDU ([18.9.25.15]:57033 "EHLO
	dmz-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752137Ab1AGAml (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Jan 2011 19:42:41 -0500
X-AuditID: 1209190f-b7c1dae000000a2b-43-4d2661806ba3
Received: from mailhub-auth-3.mit.edu ( [18.9.21.43])
	by dmz-mailsec-scanner-4.mit.edu (Symantec Brightmail Gateway) with SMTP id 38.CB.02603.081662D4; Thu,  6 Jan 2011 19:42:40 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id p070gc3v016049;
	Thu, 6 Jan 2011 19:42:39 -0500
Received: from [192.168.1.108] (c-71-56-216-201.hsd1.co.comcast.net [71.56.216.201])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p070gYcY023600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 6 Jan 2011 19:42:36 -0500 (EST)
In-Reply-To: <4D231646.5080005@debugon.org>
X-Mailer: Evolution 2.32.1 
X-Brightmail-Tracker: AAAAARcU4pI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164689>

This fixes errors running with release candidate versions of Git:
  Error in startup script: expected version number but got "1.7.4-rc0"

Also, $git_version is no longer artificially limited to three
components.  That limitation was added by commit
194bbf6cc8c2f3c14a920c841841d66b7667a848 to deal with msysGit version
strings like =E2=80=9C1.6.4.msysgit.0=E2=80=9D, and we don=E2=80=99t ne=
ed it now.  Hence as
another side effect, this enables showing notes with git version
1.6.6.2 or 1.6.6.3, as originally intended by commit
7defefb134270b6e8ab3e422b343b41a4a383f5d.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 gitk-git/gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index e82c6bf..9cbc09d 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -11581,7 +11581,7 @@ if {![info exists have_ttk]} {
 set use_ttk [expr {$have_ttk && $want_ttk}]
 set NS [expr {$use_ttk ? "ttk" : ""}]
=20
-set git_version [join [lrange [split [lindex [exec git version] end] .=
] 0 2] .]
+regexp {^git version ([\d.]*\d)} [exec git version] _ git_version
=20
 set show_notes {}
 if {[package vcompare $git_version "1.6.6.2"] >=3D 0} {
--=20
1.7.4-rc0
