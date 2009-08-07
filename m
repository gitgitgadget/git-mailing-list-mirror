From: Hannes Eder <heder@google.com>
Subject: [PATCH] Add 'stg prev' and 'stg next'
Date: Fri, 07 Aug 2009 12:45:09 +0200
Message-ID: <20090807104503.15805.95504.stgit@jazzy.zrh.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 12:46:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZMyE-0008AG-EJ
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 12:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755917AbZHGKqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 06:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755830AbZHGKqg
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 06:46:36 -0400
Received: from smtp-out.google.com ([216.239.45.13]:62302 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755812AbZHGKqf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 06:46:35 -0400
Received: from wpaz21.hot.corp.google.com (wpaz21.hot.corp.google.com [172.24.198.85])
	by smtp-out.google.com with ESMTP id n77AkX0B014342;
	Fri, 7 Aug 2009 03:46:33 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1249641993; bh=yYVt6cH/r4hkIzR26ekmbuQdhBo=;
	h=DomainKey-Signature:Subject:From:Date:Message-ID:User-Agent:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:To:Cc:
	 X-System-Of-Record; b=xASr+uBNAEP33FbKF4+ikJqk+HvR1UMeZrWkPfWAYOSw
	wOv/xVJoZGa0nvaZ9RcpPCvbT3EfZvfz6NGiE/xo0w==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=subject:from:date:message-id:user-agent:mime-version:
	content-type:content-transfer-encoding:to:cc:x-system-of-record;
	b=LrgJym0bdBqyN0WsRrvpdwwaW2OZWkQYTYKZW5mH5T6D8r+4hx7ZcqwMCvZl7hSjM
	9k3sQdMh5A+LK5zPjqfXA==
Received: from localhost (jazzy.zrh.corp.google.com [172.16.74.150])
	by wpaz21.hot.corp.google.com with ESMTP id n77AkUV4027729;
	Fri, 7 Aug 2009 03:46:30 -0700
Received: by localhost (Postfix, from userid 95149)
	id 08DA4EA4E4; Fri,  7 Aug 2009 12:46:29 +0200 (CEST)
User-Agent: StGit/0.15-rc1-9-gd8846-dirty
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125191>

These commands are related to 'stg top'.  They print the patch below
resp. above the topmost patch, given that they exist.

Signed-off-by: Hannes Eder <heder@google.com>
---
Ok, I confess it's not kill feature, but Mercurial has these commands
and I use them from time to time.  Maybe somebody else finds it useful
as well, so I decided to share it. ;)

Cheers,
Hannes

 stgit/commands/next.py |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 stgit/commands/prev.py |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+), 0 deletions(-)
 create mode 100644 stgit/commands/next.py
 create mode 100644 stgit/commands/prev.py

diff --git a/stgit/commands/next.py b/stgit/commands/next.py
new file mode 100644
index 0000000..c8e2599
--- /dev/null
+++ b/stgit/commands/next.py
@@ -0,0 +1,48 @@
+__copyright__ = """
+Copyright (C) 2005, Catalin Marinas <catalin.marinas@gmail.com>
+
+This program is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License version 2 as
+published by the Free Software Foundation.
+
+This program is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with this program; if not, write to the Free Software
+Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+"""
+
+from stgit.argparse import opt
+from stgit.commands import common
+from stgit.out import out
+from stgit import argparse
+
+help = 'Print the name of the next patch'
+kind = 'stack'
+usage = ['']
+description = """
+Print the name of the next patch."""
+
+args = []
+options = [
+    opt('-b', '--branch', args = [argparse.stg_branches],
+        short = 'Use BRANCH instead of the default branch')]
+
+directory = common.DirectoryHasRepositoryLib()
+
+def func(parser, options, args):
+    """Show the name of the next patch
+    """
+    if len(args) != 0:
+        parser.error('incorrect number of arguments')
+
+    stack = directory.repository.get_stack(options.branch)
+    unapplied = stack.patchorder.unapplied
+
+    if unapplied:
+        out.stdout(unapplied[0])
+    else:
+        raise common.CmdException, 'No unapplied patches'
diff --git a/stgit/commands/prev.py b/stgit/commands/prev.py
new file mode 100644
index 0000000..79f97a8
--- /dev/null
+++ b/stgit/commands/prev.py
@@ -0,0 +1,48 @@
+__copyright__ = """
+Copyright (C) 2005, Catalin Marinas <catalin.marinas@gmail.com>
+
+This program is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License version 2 as
+published by the Free Software Foundation.
+
+This program is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with this program; if not, write to the Free Software
+Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+"""
+
+from stgit.argparse import opt
+from stgit.commands import common
+from stgit.out import out
+from stgit import argparse
+
+help = 'Print the name of the previous patch'
+kind = 'stack'
+usage = ['']
+description = """
+Print the name of the previous patch."""
+
+args = []
+options = [
+    opt('-b', '--branch', args = [argparse.stg_branches],
+        short = 'Use BRANCH instead of the default branch')]
+
+directory = common.DirectoryHasRepositoryLib()
+
+def func(parser, options, args):
+    """Show the name of the previous patch
+    """
+    if len(args) != 0:
+        parser.error('incorrect number of arguments')
+
+    stack = directory.repository.get_stack(options.branch)
+    applied = stack.patchorder.applied
+
+    if applied and len(applied) >= 2:
+        out.stdout(applied[-2])
+    else:
+        raise common.CmdException, 'Not enough applied patches'
