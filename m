From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT] [PATCH] Fix fatal "guilt graph" error in sha1sum invocation.
Date: Wed, 14 Mar 2012 14:34:38 +0100
Message-ID: <87399bpaq9.fsf@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Wed Mar 14 14:34:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7oLs-00028x-JZ
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 14:34:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030507Ab2CNNer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 09:34:47 -0400
Received: from smtp.opera.com ([213.236.208.81]:48742 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932278Ab2CNNeq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 09:34:46 -0400
Received: from centurion.linkoping.osa (oslo.jvpn.opera.com [213.236.208.46])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id q2EDYdx8008252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 14 Mar 2012 13:34:40 GMT
Received: by centurion.linkoping.osa (Postfix, from userid 1000)
	id B884FB9A0EC; Wed, 14 Mar 2012 14:34:38 +0100 (CET)
CC: ceder@lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193105>

Fix the compatibility function sha1 so that it reads from
stdin (and not a file with a zero-length file name) when
no argument is supplied.

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 os.Darwin |    7 ++++++-
 os.Linux  |    7 ++++++-
 os.SunOS  |    7 ++++++-
 3 files changed, 18 insertions(+), 3 deletions(-)

Note: I have tested both versions of the sha1 function, but only on
Linux as I don't have access to a Mac.

    /ceder

diff --git a/os.Darwin b/os.Darwin
index 470f5fb..acf6b68 100644
--- a/os.Darwin
+++ b/os.Darwin
@@ -27,7 +27,12 @@ head_n()
 # usage: sha1 [file]
 sha1()
 {
-	openssl dgst -sha1 "$1" | sed "s,SHA1.\(.*\).= \(.*\),\2  \1,"
+	if [ $# = 1 ]
+	then
+		openssl dgst -sha1 "$1" | sed "s,SHA1.\(.*\).= \(.*\),\2  \1,"
+	else
+		openssl dgst -sha1 | sed 's,$,  -,'
+	fi
 }
 
 # usage: cp_a <src> <dst>
diff --git a/os.Linux b/os.Linux
index 30b9cb0..aaebf88 100644
--- a/os.Linux
+++ b/os.Linux
@@ -30,7 +30,12 @@ head_n()
 # usage: sha1 [file]
 sha1()
 {
-	sha1sum "$1"
+	if [ $# = 1 ]
+	then
+		sha1sum "$1"
+	else
+		sha1sum
+	fi
 }
 
 # usage: cp_a <src> <dst>
diff --git a/os.SunOS b/os.SunOS
index 30b9cb0..aaebf88 100644
--- a/os.SunOS
+++ b/os.SunOS
@@ -30,7 +30,12 @@ head_n()
 # usage: sha1 [file]
 sha1()
 {
-	sha1sum "$1"
+	if [ $# = 1 ]
+	then
+		sha1sum "$1"
+	else
+		sha1sum
+	fi
 }
 
 # usage: cp_a <src> <dst>
-- 
1.7.9
