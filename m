From: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
Subject: Test t9500 fails if Time::HiRes is missing
Date: Mon, 23 Jan 2012 05:50:23 +0100 (CET)
Message-ID: <hbf.20120123rqzg@bombur.uio.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 23 05:50:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpBrm-0001jW-Ct
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 05:50:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752774Ab2AWEu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jan 2012 23:50:26 -0500
Received: from mail-out1.uio.no ([129.240.10.57]:58886 "EHLO mail-out1.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752731Ab2AWEu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jan 2012 23:50:26 -0500
Received: from mail-mx4.uio.no ([129.240.10.45])
	by mail-out1.uio.no with esmtp (Exim 4.75)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1RpBrM-0004TC-Rb
	for git@vger.kernel.org; Mon, 23 Jan 2012 05:50:24 +0100
Received: from bombur.uio.no ([129.240.6.233])
	by mail-mx4.uio.no with esmtp  (Exim 4.76)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1RpBrM-0002Yq-Gs; Mon, 23 Jan 2012 05:50:24 +0100
Received: by bombur.uio.no (Postfix, from userid 2112)
	id 340E2126B; Mon, 23 Jan 2012 05:50:23 +0100 (CET)
X-UiO-Ratelimit-Test: rcpts/h 2 msgs/h 1 sum rcpts/h 2 sum msgs/h 1 total rcpts 2095 max rcpts/h 17 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=5.0, autolearn=disabled, T_RP_MATCHES_RCVD=-0.01,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: 8AE0C8B4A7895682AD01B72A935E33443578FE9E
X-UiO-SPAM-Test: remote_host: 129.240.6.233 spam_score: -49 maxlevel 80 minaction 1 bait 0 mail/h: 1 total 921 max/h 5 blacklist 0 greylist 1 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188977>

t9500-gitweb-standalone-no-errors fails: Git 1.7.9.rc2/1.7.8.4, RHEL
6.2, Perl 5.10.1.  Reverting 3962f1d756ab41c1d180e35483d1c8dffe51e0d1
fixes it.  The commit expects Time::HiRes to be present, but RedHat
has split it out to a separate RPM perl-Time-HiRes.  Better add a
comment about that, so it doesn't get re-reverted.

Or pacify the test and expect gitweb@RHEL-users to install the RPM:

--- git-1.7.9.rc2/t/gitweb-lib.sh~
+++ git-1.7.9.rc2/t/gitweb-lib.sh
@@ -113,4 +113,9 @@
 	test_done
 }
 
+perl -MTime::HiRes -e 0 >/dev/null 2>&1 || {
+	skip_all='skipping gitweb tests, Time::HiRes module not available'
+	test_done
+}
+
 gitweb_init

-- 
Hallvard
