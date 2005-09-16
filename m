From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Subject: [patch 08/11] Fix "stg clean" when stack is empty
Date: Fri, 16 Sep 2005 21:35:21 +0200
Message-ID: <20050916193521.18681.32747.stgit@zion.home.lan>
References: <20050916193511.18681.24189.stgit@zion.home.lan>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 21:40:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGM2V-0005pe-9n
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 21:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965300AbVIPTiS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 15:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965305AbVIPTiR
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 15:38:17 -0400
Received: from ppp-62-11-79-165.dialup.tiscali.it ([62.11.79.165]:26251 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965300AbVIPTiR
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 15:38:17 -0400
Received: from zion.home.lan (localhost [127.0.0.1])
	by zion.home.lan (Postfix) with ESMTP id 7B2D828613;
	Fri, 16 Sep 2005 21:35:21 +0200 (CEST)
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20050916193511.18681.24189.stgit@zion.home.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8718>

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

It crashes on accessing 1st element of an empty array.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 stgit/commands/clean.py |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/stgit/commands/clean.py b/stgit/commands/clean.py
--- a/stgit/commands/clean.py
+++ b/stgit/commands/clean.py
@@ -65,7 +65,8 @@ def func(parser, options, args):
 
     if options.applied:
         applied = crt_series.get_applied()
-        crt_series.pop_patch(applied[0])
+        if applied != []:
+            crt_series.pop_patch(applied[0])
         __delete_empty(applied, True)
 
     if options.unapplied:
