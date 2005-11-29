From: Chuck Lever <cel@netapp.com>
Subject: [PATCH 5/7] Add facility to print short list of patches around 'top'
Date: Tue, 29 Nov 2005 17:09:47 -0500
Message-ID: <20051129220947.9885.63635.stgit@dexter.citi.umich.edu>
References: <20051129220552.9885.41086.stgit@dexter.citi.umich.edu>
Reply-To: Chuck Lever <cel@citi.umich.edu>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 29 23:13:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhDfg-0006zv-TT
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 23:09:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbVK2WJt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 17:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbVK2WJs
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 17:09:48 -0500
Received: from citi.umich.edu ([141.211.133.111]:16206 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S932440AbVK2WJr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2005 17:09:47 -0500
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 9436F1BBD7;
	Tue, 29 Nov 2005 17:09:47 -0500 (EST)
To: catalin.marinas@gmail.com
In-Reply-To: <20051129220552.9885.41086.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12962>

When working in the middle of a very long series, I often find it useful
to have a list of the patches right around the current patch.  Add an
option to "stg series" called "--short" to provide this short list.

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 stgit/commands/series.py |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/stgit/commands/series.py b/stgit/commands/series.py
index a843307..ec1aaaf 100644
--- a/stgit/commands/series.py
+++ b/stgit/commands/series.py
@@ -39,6 +39,9 @@ options = [make_option('-b', '--branch',
            make_option('-e', '--empty',
                        help = 'check whether patches are empty '
                        '(much slower)',
+                       action = 'store_true'),
+           make_option('-s', '--short',
+                       help = 'list just the patches around the topmost patch',
                        action = 'store_true') ]
 
 
@@ -66,6 +69,13 @@ def func(parser, options, args):
 
     applied = crt_series.get_applied()
     unapplied = crt_series.get_unapplied()
+
+    if options.short:
+        if len(applied) > 5:
+            applied = applied[-6:]
+        if len(unapplied) > 5:
+            unapplied = unapplied[:5]
+
     patches = applied + unapplied
 
     max_len = 0
