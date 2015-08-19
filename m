From: Anders Kaseorg <andersk@mit.edu>
Subject: [BUG/PATCH] t9350-fast-export: Add failing test for
 symlink-to-directory
Date: Wed, 19 Aug 2015 15:46:27 -0400 (EDT)
Message-ID: <alpine.DEB.2.10.1508191532330.31851@buzzword-bingo.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 19 21:51:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS9Of-0000A0-Nc
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 21:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751955AbbHSTvc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Aug 2015 15:51:32 -0400
Received: from dmz-mailsec-scanner-3.mit.edu ([18.9.25.14]:63209 "EHLO
	dmz-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751494AbbHSTvb convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 15:51:31 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Aug 2015 15:51:31 EDT
X-AuditID: 1209190e-f79c76d000002631-1c-55d4dd165310
Received: from mailhub-auth-2.mit.edu ( [18.7.62.36])
	(using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by dmz-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 97.2F.09777.61DD4D55; Wed, 19 Aug 2015 15:46:30 -0400 (EDT)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id t7JJkTxA031105;
	Wed, 19 Aug 2015 15:46:29 -0400
Received: from localhost (buzzword-bingo.mit.edu [18.9.64.24])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id t7JJkRwE001960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 19 Aug 2015 15:46:28 -0400
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixG6noit290qowf4NfBZdV7qZLBp6rzA7
	MHlcvKTs8XmTXABTFJdNSmpOZllqkb5dAlfGkS3LmQq28Fa0H/7H2sD4hquLkZNDQsBEYt7U
	j4wQtpjEhXvr2UBsIYHFTBJrz5t2MXIB2RsZJaa//cUG4exmkji3az8zSBWLgLbE/fa97CA2
	m4CaxIejX1lBbBEBUYkj8xeBTWIWEJfYtPwNE4gtLBAssWXJZDCbV8BDYvGHdjBbVEBX4tC/
	P2wQcUGJkzOfsED0qksc+HSREcIG2nWzjW0CI/8sJGWzkJTNQlK2gJF5FaNsSm6Vbm5iZk5x
	arJucXJiXl5qka6xXm5miV5qSukmRlAwckry7WD8elDpEKMAB6MSD++HHZdDhVgTy4orcw8x
	SnIwKYnypp29EirEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhPdWAlCONyWxsiq1KB8mJc3BoiTO
	u+kHX4iQQHpiSWp2ampBahFMVoaDQ0mC9+ltoEbBotT01Iq0zJwShDQTByfIcB6g4f9AaniL
	CxJzizPTIfKnGBWlxHlXgiQEQBIZpXlwvbBk8YpRHOgVYd6XIFU8wEQD1/0KaDAT0ODDEy6C
	DC5JREhJNTDaSyyIefd20i4DLX2DS11suQc+OD2u7zqbfuoi3+GgX4XVCfOc5sdVVRtYb/3F
	V8oZdOrS0XcHHj/9oc/UvD6qP+cGf7+Kxz575p6gF9O4hGffWmBZsf/bTQXf3uhz2m7BmW0n
	BHoZ2I8dn6k/Z7+JV9K0i/yrZ+7NPW2t412o7a/MqHb/SroSS3FGoqEWc1FxIgCj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276217>

git fast-export | git fast-import fails to preserve a commit that repla=
ces=20
a symlink with a directory.  Add a failing test case demonstrating this=
=20
bug.

The fast-export output for the commit in question looks like

  commit refs/heads/master
  mark :4
  author =E2=80=A6
  committer =E2=80=A6
  data 4
  two
  M 100644 :1 foo/world
  D foo

fast-import deletes the symlink foo and ignores foo/world.  Swapping th=
e M=20
line with the D line would give the correct result.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 t/t9350-fast-export.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 66c8b0a..5fb8a04 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -419,6 +419,30 @@ test_expect_success 'directory becomes symlink'   =
     '
 	(cd result && git show master:foo)
 '
=20
+test_expect_failure 'symlink becomes directory'        '
+	git init symlinktodir &&
+	git init symlinktodirresult &&
+	(
+		cd symlinktodir &&
+		mkdir bar &&
+		echo hello > bar/world &&
+		test_ln_s_add bar foo &&
+		git add foo bar/world &&
+		git commit -q -mone &&
+		git rm foo &&
+		mkdir foo &&
+		echo hello > foo/world &&
+		git add foo/world &&
+		git commit -q -mtwo
+	) &&
+	(
+		cd symlinktodir &&
+		git fast-export master -- foo |
+		(cd ../symlinktodirresult && git fast-import --quiet)
+	) &&
+	(cd symlinktodirresult && git show master:foo)
+'
+
 test_expect_success 'fast-export quotes pathnames' '
 	git init crazy-paths &&
 	(cd crazy-paths &&
--=20
2.5.0
