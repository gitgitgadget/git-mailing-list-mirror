From: Deskin Miller <deskinm@umich.edu>
Subject: [PATCH] Fix testcase failure when extended attributes are in use
Date: Sat, 11 Oct 2008 11:41:07 -0400
Message-ID: <20081011154107.GA14994@riemann.deskinm.fdns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, heikki.orsila@iki.fi
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Oct 11 17:45:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KogeS-00030D-1L
	for gcvg-git-2@gmane.org; Sat, 11 Oct 2008 17:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754531AbYJKPny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2008 11:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754225AbYJKPny
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Oct 2008 11:43:54 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:11966 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752808AbYJKPnx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2008 11:43:53 -0400
Received: by wr-out-0506.google.com with SMTP id 69so622922wri.5
        for <git@vger.kernel.org>; Sat, 11 Oct 2008 08:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent
         :sender;
        bh=GcaNtianLmeY6xFoPAAUFyB+RwgtPBmnGCBFocLs694=;
        b=l5P76j/O/oeHRq0PsA3p/UY6p/0xDG1mx/UPSzpOvb/pzb74+BdR1sMwyhD439z9oY
         1fi5iTRZIqbkBH+l8au5caP0PJsyZDf6qxKgQfz3ayi1ZbcijJlmm2ianWyYTFYdNy3m
         zlYg+fyb97mDxUWl7G2ft2QXmD56mLS7+G9T0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent:sender;
        b=RrNA1Ul4M0KnIasn5mqDZaYvsM9NTxrLrIIQ+6ETnH0989qUoKZVhytRxxSil3UeEJ
         76cGTCnd/b+XF6wB9KEUdT1xF9fHcnNmo5jTQ7hDBh52T09YC2lCXeieTvMIp0RTi11n
         M4DJK192FxokKO2PDlTGBvR5z/S1x9xxxVgJQ=
Received: by 10.65.97.18 with SMTP id z18mr3841146qbl.96.1223739831653;
        Sat, 11 Oct 2008 08:43:51 -0700 (PDT)
Received: from riemann.deskinm.fdns.net ([68.40.49.130])
        by mx.google.com with ESMTPS id k8sm5454823qba.5.2008.10.11.08.43.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 11 Oct 2008 08:43:50 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97980>

06cbe855 (Make core.sharedRepository more generic, 2008-04-16) made
several testcases in t1301-shared-repo.sh which fail if on a system
which creates files with extended attributes (e.g. SELinux), since ls
appends a '+' sign to the permission set in such cases.  This fixes the
testcase to strip any such sign prior to verifying the permission set.

Signed-off-by: Deskin Miller <deskinm@umich.edu>
---
Shawn, I read an email that said you'd maintain until Sunday the 12th, so I'm
sending this to you; if you want to punt to Junio, feel free.

Deskin Miller

 t/t1301-shared-repo.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index dc85e8b..b244f3e 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -83,7 +83,7 @@ do
 		rm -f .git/info/refs &&
 		git update-server-info &&
 		actual="$(ls -l .git/info/refs)" &&
-		actual=${actual%% *} &&
+		actual=$(echo "$actual" | sed -e "s/[+]\? .*$//") &&
 		test "x$actual" = "x-$y" || {
 			ls -lt .git/info
 			false
@@ -96,7 +96,7 @@ do
 		rm -f .git/info/refs &&
 		git update-server-info &&
 		actual="$(ls -l .git/info/refs)" &&
-		actual=${actual%% *} &&
+		actual=$(echo "$actual" | sed -e "s/[+]\? .*$//") &&
 		test "x$actual" = "x-$x" || {
 			ls -lt .git/info
 			false
-- 
1.6.0.2.307.gc427
