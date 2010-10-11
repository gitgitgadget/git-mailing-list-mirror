From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 15/16] t9010 (svn-fe): Eliminate dependency on svn perl
 bindings
Date: Sun, 10 Oct 2010 22:00:40 -0500
Message-ID: <20101011030040.GO1553@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <20100716101352.GA14374@burratino>
 <20100809215719.GA4203@burratino>
 <20100810125317.GB3921@kytes>
 <20101011023435.GA706@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 11 05:04:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P58gC-0000ab-Vl
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 05:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059Ab0JKDD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 23:03:56 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37668 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753050Ab0JKDDz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 23:03:55 -0400
Received: by ywi6 with SMTP id 6so476869ywi.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 20:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6pmGu7xKqZ/qzOuP+eIjA7P2Dwcrnce97gUm4aWN248=;
        b=s38Z6bPNcEKfUiMihyRqDcvTdXOfzS41SQRZvjVM9Fjy5PSE5HlO0HxlupQquEOB5s
         CyWwGW8jzOMWE21AE0poDkx0DiEm/iHBe5kI5VpaocKBXt6uV5nEFLpXQ4xYLhMMEBt3
         h2C1s9liPTxghfqUQDB/gwsddOD7dflwb8JSc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=sDrxHuekDkBQsGecnB0get6A2ZyKR4ij4B8ZVk7A92FKIQQUna+fLedL9SMQN2pi8g
         wOHQ5uSug+OSFHRTWUU92YmB83o37bHNtzAxoylpd7OSS9pBfLg0vcRBOcvz1HxANIfg
         qgmOqssuv7ExKyaJWPvpT8c5PSlVMWDIV5QYk=
Received: by 10.101.126.19 with SMTP id d19mr2311505ann.249.1286766234782;
        Sun, 10 Oct 2010 20:03:54 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id g18sm7864900anh.38.2010.10.10.20.03.53
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 20:03:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101011023435.GA706@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158745>

From: Ramkumar Ramachandra <artagnon@gmail.com>

The svn-fe test script only requires git and the svn command-line
tools.  Make these tests easier to read and run by not using the perl
libsvn bindings and instead duplicating only the relevant code from
lib-git-svn.sh.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
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
