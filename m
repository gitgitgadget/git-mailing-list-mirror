From: epilys <epilys@norn.io>
Subject: [PATCH] forbid log --graph --no-walk
Date: Sat, 14 Mar 2015 23:31:59 +0200
Message-ID: <5504A8CF.9080202@norn.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 14 22:31:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWteD-0004b3-5A
	for gcvg-git-2@plane.gmane.org; Sat, 14 Mar 2015 22:31:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098AbbCNVat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2015 17:30:49 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:43947 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032AbbCNVal (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2015 17:30:41 -0400
Received: from mfilter40-d.gandi.net (mfilter40-d.gandi.net [217.70.178.171])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id 17A52172074;
	Sat, 14 Mar 2015 22:30:40 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter40-d.gandi.net
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
	by mfilter40-d.gandi.net (mfilter40-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id CtnFu8xIsUC0; Sat, 14 Mar 2015 22:30:38 +0100 (CET)
X-Originating-IP: 5.54.110.208
Received: from [192.168.2.2] (ppp005054110208.access.hol.gr [5.54.110.208])
	(Authenticated sender: epilys@norn.io)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id A2B08172077;
	Sat, 14 Mar 2015 22:30:37 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265459>

In git-log, --graph shows a graphical representation of a
continuous commit history, and --no-walk shows discrete specified
commits without continuity. This doesn't make sense, so we forbid the
combined use of these flags.

Signed-off-by: Manos Pitsidianakis <epilys@norn.io>
---
 builtin/log.c  | 2 ++
 t/t4202-log.sh | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index dd8f3fc..0194133 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -155,6 +155,8 @@ static void cmd_log_init_finish(int argc, const char
**argv, const char *prefix,
 	memset(&w, 0, sizeof(w));
 	userformat_find_requirements(NULL, &w);
 +    if (rev->graph && rev->no_walk)
+        die("--graph and --no-walk are incompatible");
 	if (!rev->show_notes_given && (!rev->pretty_given || w.notes))
 		rev->show_notes = 1;
 	if (rev->show_notes)
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 5f2b290..4dd939b 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -887,4 +887,8 @@ test_expect_success GPG 'log --graph
--show-signature for merged tag' '
 	grep "^| | gpg: Good signature" actual
 '
 +test_expect_success 'forbid log --graph --no-walk' '
+    test_must_fail git log --graph --no-walk
+'
+
 test_done
-- 
2.1.4
