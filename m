From: Darrin Thompson <darrint@progeny.com>
Subject: Re: git-ls-files -o no recurse?
Date: Sat, 07 Jan 2006 13:20:55 -0500
Message-ID: <1136658055.6141.1.camel@localhost.localdomain>
References: <1136400692.5919.11.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0601041330550.3668@g5.osdl.org>
	 <7vk6ddq8x2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Jan 07 19:23:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvIj7-0001oD-KC
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 19:23:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579AbWAGSXh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 13:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752582AbWAGSXh
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 13:23:37 -0500
Received: from zealot.progeny.com ([216.37.46.162]:21465 "EHLO
	morimoto.progeny.com") by vger.kernel.org with ESMTP
	id S1752579AbWAGSXf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2006 13:23:35 -0500
Received: from localhost.localdomain (morimoto.progeny.com [192.168.1.53])
	by morimoto.progeny.com (Postfix) with ESMTP
	id 2F080636A4; Sat,  7 Jan 2006 13:23:27 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6ddq8x2.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.2.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14265>

This adds a test a test for the --directory option to git-ls-files.

Is '--directory' really what we want?

 t/t3003-ls-files-others-directory.sh |   38
++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)
 create mode 100644 t/t3003-ls-files-others-directory.sh

applies-to: 5001806332081159b00c35291d6aea232ed7e909
d484a8477d430a5fb2cefd2cf7008a5973d1fea5
diff --git a/t/t3003-ls-files-others-directory.sh
b/t/t3003-ls-files-others-directory.sh
new file mode 100644
index 0000000..d1d3d86
--- /dev/null
+++ b/t/t3003-ls-files-others-directory.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Darrin Thompson
+# Based on an earlier test by Junio C Hamano
+#
+
+test_description='git-ls-files test (--others --directory)
+
+This test runs git-ls-files --others --directory with the following on
+the filesystem.
+
+    path0       - a file
+    path1	- a symlink
+    path2/file2 - a file in a directory
+
+The --directory option should cause path2 to be in the listing, but
+not path2/file2.
+'
+. ./test-lib.sh
+
+date >path0
+ln -s xyzzy path1
+mkdir path2
+date >path2/file2
+test_expect_success \
+    'git-ls-files --directory --others to show output.' \
+    'git-ls-files --directory --others >output'
+cat >expected <<EOF
+output
+path0
+path1
+path2
+EOF
+
+test_expect_success \
+    'git-ls-files --directory --others should not pick up dir
contents.' \
+    'diff output expected'
+test_done
---
0.99.9i
