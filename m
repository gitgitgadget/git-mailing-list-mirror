From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v5 6/6] fast-import: test the new option command
Date: Thu, 27 Aug 2009 11:12:16 -0700
Message-ID: <1251396736-928-6-git-send-email-srabbelier@gmail.com>
References: <1251396736-928-1-git-send-email-srabbelier@gmail.com>
 <1251396736-928-2-git-send-email-srabbelier@gmail.com>
 <1251396736-928-3-git-send-email-srabbelier@gmail.com>
 <1251396736-928-4-git-send-email-srabbelier@gmail.com>
 <1251396736-928-5-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Ian Clatworthy <ian.cla
X-From: git-owner@vger.kernel.org Thu Aug 27 20:13:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgjTJ-0007KF-JH
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 20:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447AbZH0SMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 14:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752421AbZH0SMp
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 14:12:45 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:64890 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378AbZH0SMn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 14:12:43 -0400
Received: by ey-out-2122.google.com with SMTP id 25so299070eya.19
        for <git@vger.kernel.org>; Thu, 27 Aug 2009 11:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=SyOx7OT2fgLc+FTcWCIFwUEIfbzCHWDUobSFfIDJPT0=;
        b=s2FI4a4RNMQkycv+Pqu4v0B2dca8QeKGGiRQnSlc43D4Razv9zpxeFrUgNj4LuvRjg
         FIdM3u5il3+OFh/COUQ2kUfG3FaoQu0Pp5ZYRq+Ru39dxZObJ4hcL2cQyemmudfvqTCy
         cwk03MBgMiJnwCNndnX3vpnXdX+tn4Z3dEZaE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nUO8ia5tmQ1APFwOHLiaETg7P2oSo+ItwkJfnpwiY55pwf99MJRJVL3iVRENNfP+rx
         juwfWxSCt2E+p1c1tt7SmbK4xh8xlH98ZOvIBEza1rf2nMfRvsyUczaoQFNyiwyLw5hc
         v+tWoqMgRKRzi/lykoYb50UnQ0dCKVKRumfs0=
Received: by 10.211.143.20 with SMTP id v20mr601019ebn.76.1251396765835;
        Thu, 27 Aug 2009 11:12:45 -0700 (PDT)
Received: from localhost.localdomain (kaayla.mtv.corp.google.com [172.22.72.177])
        by mx.google.com with ESMTPS id 10sm62710eyz.25.2009.08.27.11.12.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 Aug 2009 11:12:45 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.122.g6ffd7
In-Reply-To: <1251396736-928-5-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127188>

Test three options (quiet and import/export-marks) and verify that the
commandline options override these.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

	Only difference from v4 is that it is rebased and a new test to
	verify that 'feature git-options' is now accepted.

 t/t9300-fast-import.sh |   64 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 63 insertions(+), 1 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index a5b9b38..08469a2 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1089,7 +1089,7 @@ test_expect_success 'P: fail on blob mark in gitlink' '
     test_must_fail git fast-import <input'
 
 ###
-### series Q (feature)
+### series Q (feature and option)
 ###
 
 cat >input <<EOF
@@ -1108,4 +1108,66 @@ test_expect_success 'Q: supported feature is accepted' '
 	git fast-import <input
 '
 
+cat >input << EOF
+option quiet
+blob
+data 3
+hi
+
+EOF
+
+touch empty
+
+test_expect_success 'Q: quiet option results in no stats being output' '
+    cat input | git fast-import 2> output &&
+    test_cmp empty output
+'
+
+cat >input << EOF
+option export-marks=git.marks
+blob
+mark :1
+data 3
+hi
+
+EOF
+
+test_expect_success \
+    'Q: export-marks option results in a marks file being created' \
+    'cat input | git fast-import &&
+    grep :1 git.marks'
+
+test_expect_success \
+    'Q: export-marks options can be overriden by commandline options' \
+    'cat input | git fast-import --export-marks=other.marks &&
+    grep :1 other.marks'
+
+cat >input << EOF
+option import-marks=marks.out
+option export-marks=marks.new
+EOF
+
+test_expect_success \
+    'Q: import to output marks works without any content' \
+    'cat input | git fast-import &&
+    test_cmp marks.out marks.new'
+
+cat >input <<EOF
+option import-marks=nonexistant.marks
+option export-marks=marks.new
+EOF
+
+test_expect_success \
+    'Q: import marks uses the commandline marks file when the stream specifies one' \
+    'cat input | git fast-import --import-marks=marks.out &&
+    test_cmp marks.out marks.new'
+
+cat >input <<EOF
+feature git-options
+EOF
+
+test_expect_success 'Q: feature option is accepted' '
+	git fast-import <input
+'
+
 test_done
-- 
1.6.4.122.g6ffd7
