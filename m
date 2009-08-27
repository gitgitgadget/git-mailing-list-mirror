From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v5a 6/6] fast-import: test the new option command
Date: Thu, 27 Aug 2009 11:40:31 -0700
Message-ID: <1251398431-12461-7-git-send-email-srabbelier@gmail.com>
References: <1251398431-12461-1-git-send-email-srabbelier@gmail.com>
 <1251398431-12461-2-git-send-email-srabbelier@gmail.com>
 <1251398431-12461-3-git-send-email-srabbelier@gmail.com>
 <1251398431-12461-4-git-send-email-srabbelier@gmail.com>
 <1251398431-12461-5-git-send-email-srabbelier@gmail.com>
 <1251398431-12461-6-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Ian Clatworthy <ian.cla
X-From: git-owner@vger.kernel.org Thu Aug 27 20:41:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgjur-0007FJ-Gh
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 20:41:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbZH0Sl1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 14:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751710AbZH0Sl1
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 14:41:27 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:56292 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701AbZH0Sl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 14:41:26 -0400
Received: by mail-ew0-f206.google.com with SMTP id 2so1486483ewy.17
        for <git@vger.kernel.org>; Thu, 27 Aug 2009 11:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=eq9X6603zOYv3TybTON6SqtUbxY0iJd8MgMJFRBIXcg=;
        b=TodJXQH6u/7G6B96gjGXMm+Wvs6PYTw3teF4UuAE9q/ArP6cy+91w9CBjdWTlzdJ4S
         RB/6UiQQ83PmbbycAs00OjaMLRKoLK+4H7BuJgS8iqvGU+tOCrRFF7a3L40stcifK8kp
         Xxjk+y+3Tz8LEQQLfop1I+jHF35yMapIEvYxs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FrzQeTCkLUMLZeXyZ/Jt4nruCSu0mXzFS5w1u19GYzag17R9viwzczLGjeI8A9MWaH
         HpAAdJNAEDK1NsQuw3MGutqsZUJfF5vafRDfCoRq7Z8Lc2LjJiZnr/pi5YfVjiLBI8Go
         NZ5Iba7pxN20sZLgjGzhn5jO5WP0YgkTXd+YE=
Received: by 10.216.89.129 with SMTP id c1mr23690wef.35.1251398488064;
        Thu, 27 Aug 2009 11:41:28 -0700 (PDT)
Received: from localhost.localdomain (kaayla.mtv.corp.google.com [172.22.72.177])
        by mx.google.com with ESMTPS id i35sm1687558gve.26.2009.08.27.11.41.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 Aug 2009 11:41:27 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.122.g6ffd7
In-Reply-To: <1251398431-12461-6-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127195>

Test three options (quiet and import/export-marks) and verify that the
commandline options override these.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

	Only difference from v4 is that it is rebased and a new test to
	verify that 'feature git-options' is now accepted.

 t/t9300-fast-import.sh |   68 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 67 insertions(+), 1 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index a5b9b38..1fbfc5e 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1089,7 +1089,7 @@ test_expect_success 'P: fail on blob mark in gitlink' '
     test_must_fail git fast-import <input'
 
 ###
-### series Q (feature)
+### series Q (feature and option)
 ###
 
 cat >input <<EOF
@@ -1108,4 +1108,70 @@ test_expect_success 'Q: supported feature is accepted' '
 	git fast-import <input
 '
 
+cat >input << EOF
+feature git-options
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
+feature git-options
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
+feature git-options
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
+feature git-options
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
