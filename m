From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH jn/svn-fe] t9010 (svn-fe): Eliminate dependency on svn perl
 bindings
Date: Sat, 20 Nov 2010 16:31:28 -0600
Message-ID: <20101120223128.GA6584@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 20 23:34:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJw0M-00013x-JQ
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 23:33:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755146Ab0KTWbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Nov 2010 17:31:40 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38250 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755059Ab0KTWbj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Nov 2010 17:31:39 -0500
Received: by yxf34 with SMTP id 34so3412569yxf.19
        for <git@vger.kernel.org>; Sat, 20 Nov 2010 14:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=LnfK/8PKuZgH2nq99gdzLN4zDwVvTMBR2GEJG12ruw0=;
        b=FY3RDYfaVD1Sjr53kCM+mqwJRLnQxZzpTOprUlKjV7o17o53aEfaHsGN+gYezAGGPd
         PAW1d5Ak0TCIpNyz5RQyyaQb9x0KfFbgDNJvUawpCccy7C4mo68DGH6J3BYt8DRazmRC
         03FVHd8u8e8a8nukONC61U1POzFLD0o95m+ZM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=ZKBr2YIbb+hcsvd+YJ6oh0w8cDfcWueCiz+S4N/OgUwTq7mu+39wcyUpsNBbjkrGHT
         kPqoDN2ts/YMnB1e+2QtHcNNUhtis6eO2yS2IemUu8dEUDFN9pdIJjicGrgtC2SWGdlQ
         KYvR/Mu7mPY+6fOYxKr+YbU+TdMGOKnTWimco=
Received: by 10.150.92.19 with SMTP id p19mr1323778ybb.144.1290292298327;
        Sat, 20 Nov 2010 14:31:38 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id q18sm837062ybk.3.2010.11.20.14.31.36
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Nov 2010 14:31:37 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161844>

From: Ramkumar Ramachandra <artagnon@gmail.com>
Date: Sun Oct 10 22:00:40 2010 -0500

Running test t9010 without the SVN:: perl modules currently errors
out, for no good reason.  We can make these tests easier to read and
run by not using the perl libsvn bindings and instead duplicating only
the relevant code from lib-git-svn.sh.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
A patch from Ram from a while ago.  It's still a good idea; sorry
about the delay.

Patch is against the old svn-fe branch (cd9a7b57) but should apply
just as well to more recent versions.

 t/t9010-svn-fe.sh |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index a713dfc..fd851a4 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -2,9 +2,19 @@
 
 test_description='check svn dumpfile importer'
 
-. ./lib-git-svn.sh
+. ./test-lib.sh
 
-test_dump() {
+svnconf=$PWD/svnconf
+export svnconf
+
+svn_cmd () {
+	subcommand=$1 &&
+	shift &&
+	mkdir -p "$svnconf" &&
+	svn "$subcommand" --config-dir "$svnconf" "$@"
+}
+
+test_dump () {
 	label=$1
 	dump=$2
 	test_expect_success "$dump" '
-- 
1.7.2.3
