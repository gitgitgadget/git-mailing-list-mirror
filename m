From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [PATCHv2] git-web--browse: Add support for google chrome
Date: Wed, 19 May 2010 15:21:32 +0530
Message-ID: <1274262692-3783-2-git-send-email-pavan.sss1991@gmail.com>
References: <1274262692-3783-1-git-send-email-pavan.sss1991@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: git@vger.kernel.org, jnareb@gmail.com, chriscool@tuxfamily.org,
	pasky@ucw.cz
X-From: git-owner@vger.kernel.org Wed May 19 11:52:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEfwk-00011W-Iy
	for gcvg-git-2@lo.gmane.org; Wed, 19 May 2010 11:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756096Ab0ESJwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 May 2010 05:52:09 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:64484 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755781Ab0ESJwI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 May 2010 05:52:08 -0400
Received: by mail-px0-f174.google.com with SMTP id 18so694313pxi.19
        for <git@vger.kernel.org>; Wed, 19 May 2010 02:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=QkLTwlAcvMPWGGQBfQKpMb9nSjPu8aRAB5cFpGpWJqk=;
        b=or0GZ4U+vA5i5sUQo8D25A9sidZwfIymNcaQQpsyGvdHxKKj7ALVyp4ffygCpoQjGM
         ncz84m3D6t0x6UwxQV5pWw1tSCdaFa1ePHjao7QrYZi9x8MV0gqqgotH6dNjROpPA3ld
         XVMT/6CMhNX2q87ZI5uDODJUcx9JF8kzPQj7s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WiNOYFkMjgA/IyBmzugKLvMcR4c/jZFLchvWvGNxMf1taAfMqaAwuEOqxnvhEhINTn
         XzKp/xTn5hd35BTcrHazCrzTXRmwi21UalE61TvuezhLrq1OgB+SGVoPeAcviPgSaZnh
         9I9GdtU8poQ/rIEqZx2hb3OFwAty/QNjg8o8s=
Received: by 10.115.113.6 with SMTP id q6mr7232213wam.165.1274262727772;
        Wed, 19 May 2010 02:52:07 -0700 (PDT)
Received: from localhost.localdomain ([202.63.112.23])
        by mx.google.com with ESMTPS id d16sm3965807wam.12.2010.05.19.02.52.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 May 2010 02:52:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.16.g5d405c.dirty
In-Reply-To: <1274262692-3783-1-git-send-email-pavan.sss1991@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147322>

Add support for another web browser called chrome. To
select it, the value of the browser is 'chromium'.

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
---
 git-web--browse.sh |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/git-web--browse.sh b/git-web--browse.sh
index a578c3a..6df5ee8 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -31,7 +31,7 @@ valid_custom_tool()
 
 valid_tool() {
 	case "$1" in
-		firefox | iceweasel | konqueror | w3m | links | lynx | dillo | open | start)
+		firefox | iceweasel | chrome | chromium | konqueror | w3m | links | lynx | dillo | open | start)
 			;; # happy
 		*)
 			valid_custom_tool "$1" || return 1
@@ -103,7 +103,7 @@ fi
 
 if test -z "$browser" ; then
     if test -n "$DISPLAY"; then
-	browser_candidates="firefox iceweasel konqueror w3m links lynx dillo"
+	browser_candidates="firefox iceweasel chrome chromium konqueror w3m links lynx dillo"
 	if test "$KDE_FULL_SESSION" = "true"; then
 	    browser_candidates="konqueror $browser_candidates"
 	fi
@@ -146,6 +146,11 @@ case "$browser" in
 	test "$vers" -lt 2 && NEWTAB=''
 	"$browser_path" $NEWTAB "$@" &
 	;;
+    chrome|chromium)
+	# Actual command for chromium is chromium-browser.
+	# No need to specify newTab. It's default in chromium
+	eval "$browser_path-browser" "$@" &
+	;;
     konqueror)
 	case "$(basename "$browser_path")" in
 	    konqueror)
-- 
1.7.1.16.g5d405c.dirty
