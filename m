X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 1/3] Document some current bugs and add to the TODO list.
Date: Thu, 30 Nov 2006 01:27:17 +0100
Message-ID: <20061130002717.21981.38049.stgit@gandelf.nowhere.earth>
References: <20061130002304.21981.67797.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
NNTP-Posting-Date: Thu, 30 Nov 2006 00:29:01 +0000 (UTC)
Cc: GIT list <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061130002304.21981.67797.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32685>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpZmT-0002Pj-FS for gcvg-git@gmane.org; Thu, 30 Nov
 2006 01:28:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967723AbWK3A1u (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 19:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967727AbWK3A1u
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 19:27:50 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:52134 "EHLO
 smtp3-g19.free.fr") by vger.kernel.org with ESMTP id S967723AbWK3A1t (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 19:27:49 -0500
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net
 [81.57.214.146]) by smtp3-g19.free.fr (Postfix) with ESMTP id 23C0549E62;
 Thu, 30 Nov 2006 01:27:48 +0100 (CET)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch) by
 bylbo.nowhere.earth with esmtp (Exim 4.62) (envelope-from
 <ydirson@altern.org>) id 1GpZmx-0006Ax-Qk; Thu, 30 Nov 2006 01:28:31 +0100
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 TODO |   51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index 6f7a132..ad02a0e 100644
--- a/TODO
+++ b/TODO
@@ -26,3 +26,54 @@ The future, when time allows or if someone else does them:
 - patch synchronisation between between branches (as some people,
   including me have the same patches based on different branches and
   they have scripts for moving the changes in one to the others)
+- numeric shortcuts for naming patches near top (eg. +1, -2)
+- (config?) parameter for number of patches included by "series -s"
+- refuse to "stg init" a branch known as remote (through .git/remotes/,
+  .git/branches/ or any other info)
+
+Bugs:
+
+- cannot use "stg refresh file" after "cg-rm file"
+- patch names with spaces are accepted by "stg new" but break "stg series -d"
+- "stg goto $(stg top)" fails with unhandled exception
+- at least "commit is not robust wrt out-of-diskspace condition:
+|deps$ stg commit
+|error: git-checkout-index: unable to write file MANIFEST
+|error: git-checkout-index: unable to write file META.yml
+|error: git-checkout-index: unable to write file Makefile.PL
+|error: git-checkout-index: unable to write file doc/README.dbk.xml
+|error: git-checkout-index: unable to write file graph-includes
+|error: git-checkout-index: unable to write file lib/graphincludes/params.pm
+|fatal: unable to write new index file
+|stg commit: git-read-tree failed (local changes maybe?)
+|Committing 4 patches...
+(luckily nothing was really committed)
+
+- cannot branch off arbitrary branch when current branch not under
+stgit control:
+|$ stg branch 
+|bar
+|$ stg branch -c foo2 foo
+|stg branch: Branch "bar" not initialised
+
+- patch created with empty description ("stg new" and quit editor
+without saving) confuse "series -d":
+|$ stg series -ds
+|+ p5  | p5
+|Traceback (most recent call last):
+|  File "/usr/bin/stg", line 43, in ?
+|    main()
+|  File "/var/lib/python-support/python2.4/stgit/main.py", line 261, in main
+|    command.func(parser, options, args)
+|  File "/var/lib/python-support/python2.4/stgit/commands/series.py", line 107, in func
+|    __print_patch(applied[-1], '> ', '0>', max_len, options)
+|  File "/var/lib/python-support/python2.4/stgit/commands/series.py", line 63, in __print_patch
+|    print prefix + patch.ljust(length) + '  | ' + __get_description(patch)
+|  File "/var/lib/python-support/python2.4/stgit/commands/series.py", line 55, in __get_description
+|    descr = p.get_description().strip()
+|AttributeError: 'NoneType' object has no attribute 'strip'
+|dwitch@gandelf:/export/work/yann/git/foo/a$ stg series
+|+ p5
+|> y
+|$ cat .git/patches/master/patches/y/description
