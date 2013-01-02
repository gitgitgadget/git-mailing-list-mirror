From: Dan McGee <dan@archlinux.org>
Subject: Test failures with python versions when building git 1.8.1
Date: Tue, 1 Jan 2013 22:12:17 -0600
Message-ID: <CAEik5nOqge8ix4WGf-h+0Dmz1CanH_XtQdB-CxvPsggSu1-LzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: GIT Mailing-list <git@vger.kernel.org>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	David Michael Barr <b@rr-dav.id.au>
X-From: git-owner@vger.kernel.org Wed Jan 02 05:12:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqFh1-0007Oc-6a
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 05:12:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540Ab3ABEMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 23:12:20 -0500
Received: from mail-vc0-f177.google.com ([209.85.220.177]:35551 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525Ab3ABEMS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 23:12:18 -0500
Received: by mail-vc0-f177.google.com with SMTP id m8so13752176vcd.22
        for <git@vger.kernel.org>; Tue, 01 Jan 2013 20:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=JyzqoYPAT1bXzeeAShq+tsu9oIBAi5NGZpM8NV3Wmq8=;
        b=BjbSLp0wRsgcg1tYkLVR+INmh+bXxoMf83aJa8nXnMWtPYn7Zq2RFo6Mhd9/xgDmH/
         IoahVsdVNDbJ2mJrljU3UPvTlA7QPu9ZMYRUE40sMY8KhngKqhxgyGwD5s3eq7EX/T/h
         ot47w6s/nFtvjUH6otWkgrMCOK4b5sdd0ONc3KHAoreT4vFzQ4ShYTudvcnJ9hbJ0gfN
         GJIysIOlr1/LlWSxtXmajT7/hAJ/8YvuUJbEne//ErGKdJs/EvTMSYmvIXc4fBaUCW+S
         yBn/6Cc/vFaRS8bYpCxnuKyYkAa4TobVw/zbK/NjpnCkBZ+BA9IVE++2vsSfRDqZZeVl
         iQUQ==
Received: by 10.59.6.39 with SMTP id cr7mr72354689ved.17.1357099937799; Tue,
 01 Jan 2013 20:12:17 -0800 (PST)
Received: by 10.58.34.11 with HTTP; Tue, 1 Jan 2013 20:12:17 -0800 (PST)
X-Google-Sender-Auth: ZyB-riWlf1-jElq7i0VTYJVulSM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212490>

A test case snuck in this release that assumes /usr/bin/python is
python2 and causes test failures. Unlike all other tests and code
depending on python, this one does not respect PYTHON_PATH, which we
explicitly set when building git on Arch Linux due to python2 vs
python3 differences.

-Dan

make[1]: Entering directory `/build/src/git-1.8.1/t'
rm -f -r test-results
*** prove ***

Test Summary Report
-------------------
t9020-remote-svn.sh                              (Wstat: 256 Tests: 6 Failed: 4)
  Failed tests:  1-2, 5-6
  Non-zero exit status: 1
Files=608, Tests=8772, 76 wallclock secs ( 4.07 usr  0.65 sys + 91.83
cusr 37.14 csys = 133.69 CPU)
Result: FAIL
make[1]: *** [prove] Error 1
make[1]: Leaving directory `/build/src/git-1.8.1/t'
make: *** [test] Error 2


$ contrib/svn-fe/svnrdump_sim.py
  File "contrib/svn-fe/svnrdump_sim.py", line 43
    print "usage: %s dump URL -rLOWER:UPPER"
                                           ^
SyntaxError: invalid syntax

diff --git a/contrib/svn-fe/svnrdump_sim.py b/contrib/svn-fe/svnrdump_sim.py
index 1cfac4a..7e6148d 100755
--- a/contrib/svn-fe/svnrdump_sim.py
+++ b/contrib/svn-fe/svnrdump_sim.py
@@ -40,7 +40,7 @@ def writedump(url, lower, upper):

 if __name__ == "__main__":
         if not (len(sys.argv) in (3, 4, 5)):
-                print "usage: %s dump URL -rLOWER:UPPER"
+                print("usage: %s dump URL -rLOWER:UPPER")
                 sys.exit(1)
         if not sys.argv[1] == 'dump': raise NotImplementedError('only
"dump" is suppported.')
         url = sys.argv[2]
