From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 6/6] completion: simplify __gitcomp() test helper
Date: Sun, 11 Nov 2012 15:35:58 +0100
Message-ID: <1352644558-9410-7-git-send-email-felipe.contreras@gmail.com>
References: <1352644558-9410-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 15:36:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXYea-00065I-7J
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 15:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753137Ab2KKOgi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Nov 2012 09:36:38 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:41620 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753066Ab2KKOgh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 09:36:37 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2066470bkc.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 06:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=oC1B41/ckBm69jSfZjZuxgdwJBr0ieMrzkpOPeb0hgI=;
        b=o9H+Zq+6j0JG1PnP0iEx4W5sfJN7PuNrtP3z73s9/vN2nTgmDowlpAb9dGGuZlrJf0
         dDY2YpB69ebMZGI7eJhG/NVRa2/QSAlO/j/EBBPczbKQ06eT8pTIicmlPyFnKUktJCa6
         ytx/d7VpGN466a/bhp7vVo+B9YzFG8SmYANSJYPRWwd5jz3Guj3cdrwHvFEq+/0aQgZD
         XtcksX9sGqNnZFaegTfdXM52QOHCHbtvIviM/llM6CU+ZMibiUSQcDVCcuH9Do8wbQKq
         NbRER3JO9T8p2a+WoWO2ptlZ5Aiva+YcZGqWedwxh9tvuBnUn6GooHH4KnsxjG016D7u
         Rwlw==
Received: by 10.204.11.213 with SMTP id u21mr5935571bku.42.1352644597078;
        Sun, 11 Nov 2012 06:36:37 -0800 (PST)
Received: from localhost (ip-109-43-0-127.web.vodafone.de. [109.43.0.127])
        by mx.google.com with ESMTPS id gz6sm1206130bkc.16.2012.11.11.06.36.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 06:36:36 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352644558-9410-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209388>

By using print_comp as suggested by SZEDER G=C3=A1bor.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 66c7af6..9b38b69 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -69,23 +69,18 @@ test_completion ()
 	test_cmp expected out
 }
=20
-newline=3D$'\n'
-
 # Test __gitcomp.
 # Arguments are:
 # 1: typed text so far (cur)
 # *: arguments to pass to __gitcomp
 test_gitcomp ()
 {
+	local -a COMPREPLY &&
 	sed -e 's/Z$//' > expected &&
-	(
-		local -a COMPREPLY &&
-		cur=3D"$1" &&
-		shift &&
-		__gitcomp "$@" &&
-		IFS=3D"$newline" &&
-		echo "${COMPREPLY[*]}" > out
-	) &&
+	cur=3D"$1" &&
+	shift &&
+	__gitcomp "$@" &&
+	print_comp &&
 	test_cmp expected out
 }
=20
--=20
1.8.0
