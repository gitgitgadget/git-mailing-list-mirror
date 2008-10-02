From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Add path_info tests to
	t/t9500-gitweb-standalone-no-errors.sh
Date: Thu, 02 Oct 2008 16:52:20 +0200
Message-ID: <20081002145010.19247.44420.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 02 16:55:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlPYe-000378-0E
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 16:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753782AbYJBOw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 10:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753688AbYJBOwZ
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 10:52:25 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:63674 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396AbYJBOwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 10:52:25 -0400
Received: by nf-out-0910.google.com with SMTP id d3so435010nfc.21
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 07:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=Eu7P45rnUAOu2bEhoxAc+6w6rFyovoX72XDXEFcZJmI=;
        b=J5/UZI2Zd4DRA1fJxhOLSwEgP9k6Il80wwkfp7KFMGj3enx171OY+cLsRBbpraNLOQ
         ee/+Y3ROBOrRie+WwjqrMRNC8192EfBszfdP3R/5Njy53W3xMwCNotAye+jNDmOvfr7V
         HRhhuSPSNR4aL9gVu+bh569jDUCr62JSNXftw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=sX40O+Hc18RQrQY+Gnil7ffkbscwbv99Sk6Pst91o+62kU4yp8AmeRHdutn+TviJup
         jUX4vXleLeHmgSdMW5HYX5dkc1eBUQP6vxtFxnsS0q6WWr9Ddz1EmwuCRE79WRsnKLH7
         IJObbQuJ0lPBqpbXtQuNvFgXExtBmDMPbLWU0=
Received: by 10.210.115.17 with SMTP id n17mr11539648ebc.62.1222959143113;
        Thu, 02 Oct 2008 07:52:23 -0700 (PDT)
Received: from localhost.localdomain (abvs210.neoplus.adsl.tpnet.pl [83.8.216.210])
        by mx.google.com with ESMTPS id z37sm1975861ikz.6.2008.10.02.07.52.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Oct 2008 07:52:21 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m92EqK1W019327;
	Thu, 2 Oct 2008 16:52:20 +0200
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97347>

Note that those tests only that there are no errors nor warnings
from Perl; they do not check for example if gitweb doesn't use
ARRAY(0x8e3cc20) instead of correct value in links, etc.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is the test thans to which I have dicovered errors in git_tree()
fixed in previous email. Nevertheless those two patches are unrelated,
so they are not numbered.

Those tests check _current_ situation, without $action, not
$hash_parent parameters possible in path_info.

 t/t9500-gitweb-standalone-no-errors.sh |   49 ++++++++++++++++++++++++++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 07117a8..64c4cce 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -503,6 +503,55 @@ test_expect_success \
 test_debug 'cat gitweb.log'
 
 # ----------------------------------------------------------------------
+# path_info links
+test_expect_success \
+	'path_info: project' \
+	'gitweb_run "" "/.git"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'path_info: project/branch' \
+	'gitweb_run "" "/.git/b"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'path_info: project/branch:file' \
+	'gitweb_run "" "/.git/master:file"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'path_info: project/branch:dir/' \
+	'gitweb_run "" "/.git/master:foo/"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'path_info: project/branch:file (non-existent)' \
+	'gitweb_run "" "/.git/master:non-existent"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'path_info: project/branch:dir/ (non-existent)' \
+	'gitweb_run "" "/.git/master:non-existent/"'
+test_debug 'cat gitweb.log'
+
+
+test_expect_success \
+	'path_info: project/branch:/file' \
+	'gitweb_run "" "/.git/master:/file"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'path_info: project/:/file (implicit HEAD)' \
+	'gitweb_run "" "/.git/:/file"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'path_info: project/:/ (implicit HEAD, top tree)' \
+	'gitweb_run "" "/.git/:/"'
+test_debug 'cat gitweb.log'
+
+
+# ----------------------------------------------------------------------
 # feed generation
 
 test_expect_success \
