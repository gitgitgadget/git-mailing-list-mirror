From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH Cogito] Make cg more robust and user friendly
Date: Sun, 2 Oct 2005 12:13:06 +0200
Message-ID: <20051002101306.GB9219@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 02 12:13:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EM0qG-0004lq-6C
	for gcvg-git@gmane.org; Sun, 02 Oct 2005 12:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbVJBKNI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Oct 2005 06:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbVJBKNI
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Oct 2005 06:13:08 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:6113 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S1751057AbVJBKNH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Oct 2005 06:13:07 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 746956E1E07; Sun,  2 Oct 2005 12:13:03 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 2D8C86E18D9; Sun,  2 Oct 2005 12:13:03 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 9C7D560EF6; Sun,  2 Oct 2005 12:13:06 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9611>

Accept -h in addition to --help. Error out on unknown options. Convert to
be a real bash script and slightly simplify the control flow, so we can use
the 'type' builtin command for checking if the requested Cogito command
exists in the PATH.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---
commit 5e15803563ef00720541e89ae16a633ac8dfb7d7
tree 90374bdbc77b04bc5bfa4365e291e3603b0a7099
parent 20282cdd610ecef03c8c97853bc0749ef3ab32b3
author Jonas Fonseca <fonseca@diku.dk> Thu, 29 Sep 2005 15:12:02 +0200
committer Jonas Fonseca <fonseca@stud1-9.itu.dk> Thu, 29 Sep 2005 15:12:02 +0200

 cg |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/cg b/cg
--- a/cg
+++ b/cg
@@ -1,9 +1,16 @@
-#!/bin/sh
+#!/usr/bin/env bash
 
-[ x"$1" = "x" ] && exec cg-help
 cmd="$1"; shift
-( [ x"$cmd" = x"--help" ] ) && exec cg-help
-( [ x"$cmd" = x"--version" ] ) && exec cg-version
+case "$cmd" in
+-h|--help|"") cmd="help" ;;
+--version) cmd="version" ;;
+-*)
+	echo "cg: unknown option '$cmd' (try 'cg --help' or 'cg --version')" >&2
+	exit 1
+esac
 
 exe="cg-$cmd"
-exec $exe "$@"
+type -P "$exe" >/dev/null && exec "$exe" "$@"
+
+echo "cg: unknown command '$cmd' (try 'cg help')" >&2
+exit 1

-- 
Jonas Fonseca
