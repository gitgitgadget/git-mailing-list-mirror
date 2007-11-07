From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH 2/9] gitk i18n implementation: Import msgcat for message string translation; load translation catalogs.
Date: Wed, 7 Nov 2007 18:40:59 +0100
Message-ID: <200711071840.59972.stimming@tuhh.de>
References: <200711071839.08570.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Nov 07 18:14:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpoU2-0002OJ-LL
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 18:14:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755085AbXKGRN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 12:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755032AbXKGRN4
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 12:13:56 -0500
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:41496 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754597AbXKGRNz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 12:13:55 -0500
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id lA7HCNGK017556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 7 Nov 2007 18:12:23 +0100
Received: from [192.168.2.102] (p549012B6.dip0.t-ipconnect.de [84.144.18.182])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id lA7HCMX4002115
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 Nov 2007 18:12:23 +0100
User-Agent: KMail/1.9.5
In-Reply-To: <200711071839.08570.stimming@tuhh.de>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63835>

By setting the environment variable GITK_MSGSDIR, one can manually
set the directory where the .msg files are located. This is quite handy 
during development with GITK_MSGSDIR=po.
---
 gitk |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index 1da0b0a..629acfb 100755
--- a/gitk
+++ b/gitk
@@ -8476,6 +8476,25 @@ set diffcolors {red "#00a000" blue}
 set diffcontext 3
 set selectbgcolor gray85
 
+## For msgcat loading, first locate the installation location.
+if { [info exists ::env(GITK_MSGSDIR)] } {
+    ## Msgsdir was manually set in the environment.
+    set gitk_msgsdir $::env(GITK_MSGSDIR)
+} else {
+    ## Let's guess the prefix from argv0.
+    set gitk_prefix [file dirname [file dirname [file normalize $argv0]]]
+    set gitk_libdir [file join $gitk_prefix share gitk lib]
+    set gitk_msgsdir [file join $gitk_libdir msgs]
+    unset gitk_prefix
+}
+
+## Internationalization (i18n) through msgcat and gettext. See
+## http://www.gnu.org/software/gettext/manual/html_node/Tcl.html
+package require msgcat
+namespace import ::msgcat::mc
+## And eventually load the actual message catalog
+::msgcat::mcload $gitk_msgsdir
+
 catch {source ~/.gitk}
 
 font create optionfont -family sans-serif -size -12
-- 
1.5.3.4.206.g58ba4
