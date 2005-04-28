From: Philip Pokorny <ppokorny@mindspring.com>
Subject: Re: PATCH[4/4]: Allow tree-id to return the ID of a tree object
Date: Thu, 28 Apr 2005 00:17:58 -0700
Message-ID: <42708E26.2090803@mindspring.com>
References: <426FBBE7.1090806@mindspring.com> <20050427232223.GM22956@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050205020104030408050005"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 09:13:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR3Cw-0001Dl-24
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 09:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbVD1HS0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 03:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVD1HS0
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 03:18:26 -0400
Received: from smtpauth04.mail.atl.earthlink.net ([209.86.89.64]:22423 "EHLO
	smtpauth04.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S261893AbVD1HR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 03:17:59 -0400
Received: from [68.164.169.208] (helo=[172.16.1.11])
	by smtpauth04.mail.atl.earthlink.net with asmtp (TLSv1:RC4-MD5:128)
	(Exim 4.34)
	id 1DR3Hb-0006WC-9z; Thu, 28 Apr 2005 03:17:59 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050427232223.GM22956@pasky.ji.cz>
X-ELNK-Trace: 662518af21fc89ef9c7f779228e2f6aeda0071232e20db4d3ec3c4685aed2185b5d129ed338e7ffd350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 68.164.169.208
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------050205020104030408050005
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Convert parent-id to similar style and function as the new commit-id and 
tree-id.

NOTE: parent-id uses commit-id rather than cg-Xnormid directly

Signed-off-by: Philip Pokorny <ppokorny@mindspring.com>

--------------050205020104030408050005
Content-Type: text/plain;
 name="cogito-0.8-parent-id.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cogito-0.8-parent-id.patch"

Index: parent-id
===================================================================
--- 6ad600e20c89323c1d3049f75b8ca9b0a2d72167/parent-id  (mode:100755 sha1:f35877a6aa5b68d2fb4a388dcfa9b3e64262604e)
+++ uncommitted/parent-id  (mode:100775)
@@ -1,12 +1,19 @@
 #!/usr/bin/env bash
 #
 # Get ID of parent commit to a given revision or HEAD.
+# NOTE: will return multiple SHA1s if ID is a commit with multiple parents
+#
 # Copyright (c) Petr Baudis, 2005
 #
-# Takes ID of the current commit, defaults to HEAD.
 
-PARENT="^parent [A-Za-z0-9]{40}$"
+# Save for later error message
+orig="$1"
 
-id=$(commit-id $1) || exit 1
+# Normalize to SHA1 form and verify its a commit
+id=$(commit-id "$1")
+if [ ! "$id" ]; then
+	# commit-id already reported the error
+	exit 1
+fi
 
-cat-file commit $id | egrep "$PARENT" | cut -d ' ' -f 2
+cat-file commit $id | awk '/^parent/{print $2};/^$/{exit}'

--------------050205020104030408050005--
