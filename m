From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 6/7] t1303 (config): style tweaks
Date: Mon, 6 Sep 2010 20:53:18 -0500
Message-ID: <20100907015317.GG1182@burratino>
References: <4C85357A.8090000@web.de>
 <20100906190655.GG25426@burratino>
 <4C854B36.6010606@web.de>
 <20100907014135.GA1182@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 07 03:55:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsnPD-0000aR-0D
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 03:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755690Ab0IGBzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 21:55:22 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46589 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754165Ab0IGBzV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 21:55:21 -0400
Received: by ywh1 with SMTP id 1so1776997ywh.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 18:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ikOaiWQbA9ORAkOPxKmrDGtIQchXno1guBG9mOWQzqU=;
        b=XY9DExuf3eF38LeJItsxCl3EZdWG/aHyKbaN/gXEZaBKfr68osXJCC0Z7dE0VW2dlW
         T0dG91TjMQZj4aePiZ6qWxh6umrCQx/hv3Cp5yCiAl5QBSR4HWf/b7Y2/otDgxdyVurb
         kYGLY85biCF9T+s/WvzPZHRDJT2vHKLvNMRyE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FQAJudvLuxjClRlbFEWhtLcXoceIBZejx2FswyMbqFABvUPSQt+V95iSCzWEc2NEuC
         aMVMAne/waVFZIQbloc4LnzswDgG2/P9OnnG9bVgmKDGclqBp3xicHpWjJiDJkvdyfuu
         ew5XSGps604UJd5HCyjSvGCStgwczDxVNkUyw=
Received: by 10.150.54.21 with SMTP id c21mr530184yba.430.1283824520708;
        Mon, 06 Sep 2010 18:55:20 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id q21sm6748449ybk.11.2010.09.06.18.55.19
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 18:55:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100907014135.GA1182@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155664>

This test already has impeccable style, with one exception: there
is an unnecessary use of a subshell.  Use a {} block instead.
While at it:

 - guard setup commands with test_expect_success, so the commands
   are printed when the test is run with "-v" and errors in setup
   can be caught;
 - use echo instead of printf to print simple text ending with a
   newline, so the later use of printf stands out more;
 - put a single space before () in function definitions, for
   consistency with other shell scripts in git;
 - reorder arguments to test_cmp as "test_cmp expected actual".

Cc: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t1303-wacky-config.sh |   28 ++++++++++++++++------------
 1 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/t/t1303-wacky-config.sh b/t/t1303-wacky-config.sh
index 080117c..ce7ce1c 100755
--- a/t/t1303-wacky-config.sh
+++ b/t/t1303-wacky-config.sh
@@ -3,16 +3,20 @@
 test_description='Test wacky input to git config'
 . ./test-lib.sh
 
-setup() {
-	(printf "[section]\n" &&
-	printf "  key = foo") >.git/config
-}
-
-check() {
-	echo "$2" >expected
-	git config --get "$1" >actual 2>&1
-	test_cmp actual expected
-}
+test_expect_success 'setup: helper functions' '
+	setup () {
+		{
+			echo "[section]" &&
+			printf "  key = foo"
+		} >.git/config
+	} &&
+
+	check () {
+		echo "$2" >expected
+		git config --get "$1" >actual 2>&1
+		test_cmp expected actual
+	}
+'
 
 test_expect_success 'modify same key' '
 	setup &&
@@ -34,14 +38,14 @@ test_expect_success 'add key in different section' '
 	check section2.key bar
 '
 
-SECTION="test.q\"s\\sq'sp e.key"
 test_expect_success 'make sure git config escapes section names properly' '
+	SECTION="test.q\"s\\sq'\''sp e.key" &&
 	git config "$SECTION" bar &&
 	check "$SECTION" bar
 '
 
-LONG_VALUE=$(printf "x%01021dx a" 7)
 test_expect_success 'do not crash on special long config line' '
+	LONG_VALUE=$(printf "x%01021dx a" 7) &&
 	setup &&
 	git config section.key "$LONG_VALUE" &&
 	check section.key "fatal: bad config file line 2 in .git/config"
-- 
1.7.2.3
