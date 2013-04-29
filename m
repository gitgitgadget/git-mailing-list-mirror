From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] git-remote-testgit: further remove some bashisms
Date: Mon, 29 Apr 2013 10:41:54 -0700
Message-ID: <1367257315-12009-3-git-send-email-gitster@pobox.com>
References: <7vehdtjl2n.fsf@alter.siamese.dyndns.org>
 <1367257315-12009-1-git-send-email-gitster@pobox.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 29 19:42:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWs5t-0003p7-Cc
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 19:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757967Ab3D2RmE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 13:42:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58293 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757863Ab3D2RmB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 13:42:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36D761ABBA;
	Mon, 29 Apr 2013 17:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=MX2D
	oUxVdLo6TjGdgw9RTIwqNbE=; b=svLW55DqDZfg3B3c+nacPOQEtIzmvqD54oDV
	CXoM1bFxs7xqcfPSnDgd17oNPMzZQvPxqwGlJ6ojKi+9llTxAfeAqth8sV5FsFWQ
	vGdXUoUp2FK18MykPkJHWP3LxGcq/1VMdv8NS/7fG581BCXTGx9IqISD5uKckWGT
	XxRb53o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	Q3GJrttPF/R3Wmta6cT0UP9YjExqBAqjBsz1NL5TiIV+UuQgAJJvIihGsd8PssbT
	Ow0v70LtEFWlCfHBndRKqDfF+W8yzgrJ2dJtWciN0AQuxpnw1cfSmRXPn0pPBAH7
	nRO9o5kjikPVV2ymQcIk9KPrHDkL505K7rdM18FpA8s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DAE91ABB8;
	Mon, 29 Apr 2013 17:42:01 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 89B661ABAA;
	Mon, 29 Apr 2013 17:42:00 +0000 (UTC)
X-Mailer: git-send-email 1.8.3-rc0-121-gda9b90f
In-Reply-To: <1367257315-12009-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1899257C-B0F4-11E2-B6BE-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222826>

From: Johannes Sixt <j.sixt@viscovery.net>

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 git-remote-testgit | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/git-remote-testgit b/git-remote-testgit
index 643e4ae..b528949 100755
--- a/git-remote-testgit
+++ b/git-remote-testgit
@@ -1,4 +1,4 @@
-#!/usr/bin/env bash
+#!/bin/sh
 # Copyright (c) 2012 Felipe Contreras
 
 alias=$1
@@ -23,7 +23,6 @@ then
 	testgitmarks="$dir/testgit.marks"
 	test -e "$gitmarks" || >"$gitmarks"
 	test -e "$testgitmarks" || >"$testgitmarks"
-	testgitmarks_args=( "--"{import,export}"-marks=$testgitmarks" )
 fi
 
 while read line
@@ -69,7 +68,10 @@ do
 		fi
 
 		echo "feature done"
-		git fast-export "${testgitmarks_args[@]}" $refs |
+		git fast-export \
+			${testgitmarks:+"--import-marks=$testgitmarks"} \
+			${testgitmarks:+"--export-marks=$testgitmarks"} \
+			$refs |
 		sed -e "s#refs/heads/#${prefix}/heads/#g"
 		echo "done"
 		;;
@@ -88,7 +90,10 @@ do
 
 		before=$(git for-each-ref --format=' %(refname) %(objectname) ')
 
-		git fast-import "${testgitmarks_args[@]}" --quiet
+		git fast-import \
+			${testgitmarks:+"--import-marks=$testgitmarks"} \
+			${testgitmarks:+"--export-marks=$testgitmarks"} \
+			--quiet
 
 		# figure out which refs were updated
 		git for-each-ref --format='%(refname) %(objectname)' |
-- 
1.8.3-rc0-121-gda9b90f
