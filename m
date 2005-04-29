From: David Greaves <david@dgreaves.com>
Subject: [PATCh] jit-trackdown
Date: Fri, 29 Apr 2005 17:03:04 +0100
Message-ID: <42725AB8.5090501@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 29 18:03:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRXwz-00078P-5c
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 18:02:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbVD2QHx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 12:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262806AbVD2QE2
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 12:04:28 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:37824 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262811AbVD2QDQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 12:03:16 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id F1B1CE6DA9; Fri, 29 Apr 2005 17:03:14 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 31685-17; Fri, 29 Apr 2005 17:03:14 +0100 (BST)
Received: from oak.dgreaves.com (unknown [217.135.197.185])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 58844E6DA8; Fri, 29 Apr 2005 17:03:14 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DRXxI-0002mo-E6; Fri, 29 Apr 2005 17:03:04 +0100
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Junio

Excellent tool :)
Should really be cg-trackdown

David


This patch allows the use of symbolic commits from Cogito's
.git/refs/heads and tags structure eg:
  jit-trackdown HEAD etc/db/schema.sql
or
  jit-trackdown v3.2 etc/db/schema.sql


Signed-off-by: David Greaves <david@dgreaves.com>
---


--- jit-trackdown.orig  2005-04-29 16:57:40.278707704 +0100
+++ jit-trackdown       2005-04-29 16:47:16.495483693 +0100
@@ -1,6 +1,8 @@
 #!/bin/sh

 # Usage: jit-trackdown <commit> paths...
+# <commit> can be the symbolic name HEAD
+# or a tag or head identifier.

 tmp=.jit-trackdown.$$
 hits=$tmp-hits
@@ -10,6 +12,14 @@
 tty -s || to_tty=:

 head="$1"
+if [ $head == "HEAD" ]; then
+  head=$(cat .git/HEAD)
+elif [ -f .git/refs/tags/$head ]; then
+  head=$(cat .git/refs/tags/$head)
+elif [ -f .git/refs/heads/$head ]; then
+  head=$(cat .git/refs/heads/$head)
+fi
+
 shift
 rev-list "$head" |
 while read commit

