From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/8 v1] gitweb: Make running t9501 test with '--debug' reliable and usable
Date: Sat, 30 Jan 2010 23:30:38 +0100
Message-ID: <1264890645-28310-2-git-send-email-jnareb@gmail.com>
References: <1264890645-28310-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 30 23:31:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbLql-0008Ua-KS
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 23:31:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754152Ab0A3WbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 17:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754129Ab0A3WbF
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 17:31:05 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:37315 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753829Ab0A3WbD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 17:31:03 -0500
Received: by fxm20 with SMTP id 20so3058001fxm.21
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 14:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=AZITGVAIDS6lXGUyldLi2yTw4AKvTJtk+P8BK43NODo=;
        b=EIBxKpAuCtd8ERkho58+s3Nwoa7dOpPHlhE5z/LeEtRdid9B/8SqqB+LmmDUv+dTRf
         hCMFk4VGOe1RHeC9KRR7ydmlGWAQmeCX6PPKWfJyjWynakVYcdTv1u79otDW0kq4aoSm
         WTZxP3nknpApFfVNFZVNtZ7U7kmuaIJQECDX4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=u1KWpeD7UljxjmdmvPH+bwAde07BNhDAI4qjfSDvGO7mvUyrRmTzJvaEm1vCwQ9YnY
         4pA/1AD4EnNPyHOtMzVftwqZCjEwbikEzGwjbg8mOOFqzv+gks8ZNCXObp+F6PglHivC
         Ce2lWGSdhHICgBvuQ2ZyINsNhdpc0DuJE6E3Q=
Received: by 10.223.15.148 with SMTP id k20mr397263faa.67.1264890658776;
        Sat, 30 Jan 2010 14:30:58 -0800 (PST)
Received: from localhost.localdomain (abwu191.neoplus.adsl.tpnet.pl [83.8.244.191])
        by mx.google.com with ESMTPS id 15sm1157284fxm.6.2010.01.30.14.30.57
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 30 Jan 2010 14:30:58 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1264890645-28310-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138507>

Remove test_debug lines after 'snapshots: tgz only default format
enabled' and 'snapshots: all enabled in default, use default disabled
value' tests.  Those tests constitute of multiple gitweb_run
invocation, therefore outputting gitweb.output for the last gitweb_run
wouldn't help much in debugging test failure, and can only confuse.

For snapshot tests which check for "200 OK" status, change
  test_debug 'cat gitweb.output'
to
  test_debug 'cat gitweb.headers'
Otherwise when running this test with '--debug' option,
t/t9501-gitweb-standalone-http-status.sh would dump *binary data* (the
snapshot itself) to standard output, which can mess up state of terminal
due to term control characters which can be embedded in output.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch appears in this series for the first time.

I have decided against cleaning up t/t9501-gitweb-standalone-http-status.sh
by conforming to single style of quoting and whitespaces, and by putting 
initial test_commit inside test_expect_success setup.  This is the minimal
change.

 t/t9501-gitweb-standalone-http-status.sh |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
index 0688a57..9e8bc01 100755
--- a/t/t9501-gitweb-standalone-http-status.sh
+++ b/t/t9501-gitweb-standalone-http-status.sh
@@ -33,7 +33,6 @@ test_expect_success \
     grep "403 - Snapshot format not allowed" gitweb.output &&
     gitweb_run "p=.git;a=snapshot;h=HEAD;sf=zip" &&
     grep "403 - Unsupported snapshot format" gitweb.output'
-test_debug 'cat gitweb.output'
 
 
 cat >>gitweb_config.perl <<\EOF
@@ -50,7 +49,6 @@ test_expect_success \
     grep "403 - Snapshot format not allowed" gitweb.output &&
     gitweb_run "p=.git;a=snapshot;h=HEAD;sf=zip" &&
     grep "Status: 200 OK" gitweb.output'
-test_debug 'cat gitweb.output'
 
 
 cat >>gitweb_config.perl <<\EOF
@@ -72,7 +70,7 @@ test_expect_success \
     'snapshots: tgz explicitly enabled' \
     'gitweb_run "p=.git;a=snapshot;h=HEAD;sf=tgz" &&
     grep "Status: 200 OK" gitweb.output'
-test_debug 'cat gitweb.output'
+test_debug 'cat gitweb.headers'
 
 
 # ----------------------------------------------------------------------
@@ -82,7 +80,7 @@ test_expect_success 'snapshots: good tree-ish id' '
 	gitweb_run "p=.git;a=snapshot;h=master;sf=tgz" &&
 	grep "Status: 200 OK" gitweb.output
 '
-test_debug 'cat gitweb.output'
+test_debug 'cat gitweb.headers'
 
 test_expect_success 'snapshots: bad tree-ish id' '
 	gitweb_run "p=.git;a=snapshot;h=frizzumFrazzum;sf=tgz" &&
@@ -105,7 +103,7 @@ test_expect_success 'snapshots: good object id' '
 	gitweb_run "p=.git;a=snapshot;h=$ID;sf=tgz" &&
 	grep "Status: 200 OK" gitweb.output
 '
-test_debug 'cat gitweb.output'
+test_debug 'cat gitweb.headers'
 
 test_expect_success 'snapshots: bad object id' '
 	gitweb_run "p=.git;a=snapshot;h=abcdef01234;sf=tgz" &&
-- 
1.6.6.1
