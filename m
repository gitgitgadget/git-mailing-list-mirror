From: Anton Gyllenberg <anton@iki.fi>
Subject: [PATCH] test case for regression caused by git-svn empty symlink fix
Date: Wed, 11 Feb 2009 00:38:45 +0200
Message-ID: <83dfc36c0902101438p7b7fbff8ja66b1fb021942cd8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 10 23:40:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX1H5-00060A-MT
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 23:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756005AbZBJWit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 17:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755674AbZBJWis
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 17:38:48 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:63164 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650AbZBJWir (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 17:38:47 -0500
Received: by nf-out-0910.google.com with SMTP id d21so20437nfb.21
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 14:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QzT7IwMljTgBlS1jDWodg7yCaf5Pid29vnRieyjTHnE=;
        b=ixJtLS7mhGisICm/veR4nXyKD2sEr9pFPIp4vl1FcAYQanV8KKl2jRMULhX2wQGPag
         SOpqoX1loixhJRagy0xWc2wm+mdidKzhXtTSKBp3L1CpQx3rJalDbDXkPXxvIuy/SGGy
         4o+czBMnGBlNuYi7N0AKro45LhlgwD7SoFfjU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        b=jdzzEvv7cxHuoP1U+d7RLgZYaZ9qVchrmBMbxhaFhZBDXd0Tuq/mN3KnwYTYU2Y2QP
         XXhFMPtXfNg5KX+Ko0sPVx7wwqE2DC0w90+giO977RkM19pNDNOfaEO+bHWYX2ocHmI6
         wIxScepLx0jsRcu7Ccvbs4vSCrxN67ciQp4WA=
Received: by 10.210.105.2 with SMTP id d2mr3462555ebc.155.1234305525833; Tue, 
	10 Feb 2009 14:38:45 -0800 (PST)
X-Google-Sender-Auth: 816b9b621c7a0f71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109327>

Commit dbc6c74d0858d77e61e092a48d467e725211f8e9 "git-svn: handle empty
files marked as symlinks in SVN" caused a regression in an unusual case
where a branch has been created in SVN, later deleted and then created
again from another branch point and the original branch point had empty
files not in the new branch. In some cases git svn fetch will then fail
while trying to fetch the empty file from the wrong SVN revision.

This adds a test case that reproduces the issue.

Signed-off-by: Anton Gyllenberg <anton@iki.fi>
---
 t/t9135-git-svn-moved-branch-empty-file.sh |   11 ++
 t/t9135/svn.dump                           |  192 ++++++++++++++++++++++++++++
 2 files changed, 203 insertions(+), 0 deletions(-)
 create mode 100755 t/t9135-git-svn-moved-branch-empty-file.sh
 create mode 100644 t/t9135/svn.dump

diff --git a/t/t9135-git-svn-moved-branch-empty-file.sh
b/t/t9135-git-svn-moved-branch-empty-file.sh
new file mode 100755
index 0000000..903575a
--- /dev/null
+++ b/t/t9135-git-svn-moved-branch-empty-file.sh
@@ -0,0 +1,11 @@
+#!/bin/sh
+
+test_description='test moved svn branch with missing empty files'
+
+. ./lib-git-svn.sh
+test_expect_success 'load svn dumpfile'  '
+	svnadmin load "$rawsvnrepo" < "${TEST_DIRECTORY}/t9135/svn.dump"
+	'
+
+test_expect_success 'clone using git svn' 'git svn clone -s "$svnrepo" x'
+test_done
diff --git a/t/t9135/svn.dump b/t/t9135/svn.dump
new file mode 100644
index 0000000..b51c0cc
--- /dev/null
+++ b/t/t9135/svn.dump
@@ -0,0 +1,192 @@
+SVN-fs-dump-format-version: 2
+
+UUID: 1f80e919-e9e3-4d80-a3ae-d9f21095e27b
+
+Revision-number: 0
+Prop-content-length: 56
+Content-length: 56
+
+K 8
+svn:date
+V 27
+2009-02-10T19:23:16.424027Z
+PROPS-END
+
+Revision-number: 1
+Prop-content-length: 123
+Content-length: 123
+
+K 7
+svn:log
+V 20
+init standard layout
+K 10
+svn:author
+V 8
+john.doe
+K 8
+svn:date
+V 27
+2009-02-10T19:23:17.195072Z
+PROPS-END
+
+Node-path: branches
+Node-kind: dir
+Node-action: add
+Prop-content-length: 10
+Content-length: 10
+
+PROPS-END
+
+
+Node-path: trunk
+Node-kind: dir
+Node-action: add
+Prop-content-length: 10
+Content-length: 10
+
+PROPS-END
+
+
+Revision-number: 2
+Prop-content-length: 121
+Content-length: 121
+
+K 7
+svn:log
+V 18
+branch-b off trunk
+K 10
+svn:author
+V 8
+john.doe
+K 8
+svn:date
+V 27
+2009-02-10T19:23:19.160095Z
+PROPS-END
+
+Node-path: branches/branch-b
+Node-kind: dir
+Node-action: add
+Node-copyfrom-rev: 1
+Node-copyfrom-path: trunk
+Prop-content-length: 34
+Content-length: 34
+
+K 13
+svn:mergeinfo
+V 0
+
+PROPS-END
+
+
+Revision-number: 3
+Prop-content-length: 120
+Content-length: 120
+
+K 7
+svn:log
+V 17
+add empty file b1
+K 10
+svn:author
+V 8
+john.doe
+K 8
+svn:date
+V 27
+2009-02-10T19:23:20.194568Z
+PROPS-END
+
+Node-path: branches/branch-b/b1
+Node-kind: file
+Node-action: add
+Prop-content-length: 10
+Text-content-length: 0
+Text-content-md5: d41d8cd98f00b204e9800998ecf8427e
+Content-length: 10
+
+PROPS-END
+
+
+Revision-number: 4
+Prop-content-length: 110
+Content-length: 110
+
+K 7
+svn:log
+V 8
+branch-c
+K 10
+svn:author
+V 8
+john.doe
+K 8
+svn:date
+V 27
+2009-02-10T19:23:21.169100Z
+PROPS-END
+
+Node-path: branches/branch-c
+Node-kind: dir
+Node-action: add
+Node-copyfrom-rev: 3
+Node-copyfrom-path: trunk
+
+
+Revision-number: 5
+Prop-content-length: 126
+Content-length: 126
+
+K 7
+svn:log
+V 23
+oops, wrong branchpoint
+K 10
+svn:author
+V 8
+john.doe
+K 8
+svn:date
+V 27
+2009-02-10T19:23:21.253557Z
+PROPS-END
+
+Node-path: branches/branch-c
+Node-action: delete
+
+
+Revision-number: 6
+Prop-content-length: 127
+Content-length: 127
+
+K 7
+svn:log
+V 24
+branch-c off of branch-b
+K 10
+svn:author
+V 8
+john.doe
+K 8
+svn:date
+V 27
+2009-02-10T19:23:21.314659Z
+PROPS-END
+
+Node-path: branches/branch-c
+Node-kind: dir
+Node-action: add
+Node-copyfrom-rev: 5
+Node-copyfrom-path: branches/branch-b
+Prop-content-length: 34
+Content-length: 34
+
+K 13
+svn:mergeinfo
+V 0
+
+PROPS-END
+
+
-- 
1.6.2.rc0
