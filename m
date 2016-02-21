From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 2/2] t9200: avoid grep on non-ASCII data
Date: Sun, 21 Feb 2016 17:32:22 +0000
Message-ID: <42c95c23bffcbb526aaae302f80667867d164876.1456075680.git.john@keeping.me.uk>
References: <cover.1456075680.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 21 18:33:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXXss-0004v4-GL
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 18:33:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753178AbcBURdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 12:33:19 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:45746 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736AbcBURdR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 12:33:17 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id C802BCDA5E1;
	Sun, 21 Feb 2016 17:33:16 +0000 (GMT)
X-Quarantine-ID: <UeF2RdGDUvtd>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=5
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UeF2RdGDUvtd; Sun, 21 Feb 2016 17:33:16 +0000 (GMT)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 4056ECDA5DE;
	Sun, 21 Feb 2016 17:33:01 +0000 (GMT)
X-Mailer: git-send-email 2.7.1.503.g3cfa3ac
In-Reply-To: <cover.1456075680.git.john@keeping.me.uk>
In-Reply-To: <cover.1456075680.git.john@keeping.me.uk>
References: <20160219193310.GA1299@sigill.intra.peff.net> <cover.1456075680.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286806>

GNU grep 2.23 detects the input used in this test as binary data so it
does not work for extracting lines from a file.  We could add the "-a"
option to force grep to treat the input as text, but not all
implementations support that.  Instead, use sed to extract the desired
lines since it will always treat its input as text.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 t/t9200-git-cvsexportcommit.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index 812c9cd..0765d52 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -35,7 +35,7 @@ exit 1
 
 check_entries () {
 	# $1 == directory, $2 == expected
-	grep '^/' "$1/CVS/Entries" | sort | cut -d/ -f2,3,5 >actual
+	sed -ne '\!^/!p' "$1/CVS/Entries" | sort | cut -d/ -f2,3,5 >actual
 	if test -z "$2"
 	then
 		>expected
-- 
2.7.1.503.g3cfa3ac
