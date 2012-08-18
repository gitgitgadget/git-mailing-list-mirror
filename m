From: mhagger@alum.mit.edu
Subject: [RFC 3/3] Change naming convention for the reflog graveyard
Date: Sat, 18 Aug 2012 19:14:46 +0200
Message-ID: <1345310086-20089-4-git-send-email-mhagger@alum.mit.edu>
References: <1345310086-20089-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Alexey Muranov <alexey.muranov@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 18 19:22:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2mjb-0007AD-Bd
	for gcvg-git-2@plane.gmane.org; Sat, 18 Aug 2012 19:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195Ab2HRRWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Aug 2012 13:22:47 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:47412 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752222Ab2HRRWM (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Aug 2012 13:22:12 -0400
X-AuditID: 1207440e-b7f036d0000008b5-3c-502fcd9d3ba6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 40.4A.02229.D9DCF205; Sat, 18 Aug 2012 13:15:10 -0400 (EDT)
Received: from michael.fritz.box (p57A25507.dip.t-dialin.net [87.162.85.7])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7IHEnrU001968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 18 Aug 2012 13:15:08 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345310086-20089-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqDvvrH6Awbq7TBYL+/qZLbqudDNZ
	NPReYbaYcL+B2eL2ivnMFj9aepgtVu5ayOTA7vH3/Qcmj52z7rJ7POvdw+hx8ZKyx9xPi1g9
	Pm+SC2CL4rZJSiwpC85Mz9O3S+DOODRnE1vBFpmK46eOMjcwfhHrYuTgkBAwkVh/RbeLkRPI
	FJO4cG89WxcjF4eQwGVGiYWNb1ggnNNMEs1PPzCCVLEJSEm8bOxhB7FFBGQlvh/eyAhSxCww
	kUli1845zCAJYQEXiQk/9jOB2CwCqhKbH70Hi/MCxWfd/80KsU5R4sf3NWBxTgFXiVd3t4LZ
	QkA10068Z57AyLuAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6xXm5miV5qSukmRkjI8e1g
	bF8vc4hRgINRiYdXYY1egBBrYllxZe4hRkkOJiVR3vdn9AOE+JLyUyozEosz4otKc1KLDzFK
	cDArifDqngAq501JrKxKLcqHSUlzsCiJ86otUfcTEkhPLEnNTk0tSC2CycpwcChJ8OoDY0tI
	sCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhQb8cXA6ABJ8QDtZQFp5y0uSMwFikK0
	nmLU5Tj49exdRiGWvPy8VClxXgWQIgGQoozSPLgVsATzilEc6GNhXmGQKh5gcoKb9ApoCRPQ
	kpUiuiBLShIRUlINjKHTbsWzmm3lWrNy9Z+33R5/9oYsS050/KaTyr+sKbPpmsf5IA+zuPM1
	j1cu79j5OGlWi9nvv/lN178q9XItUL9z/c+cc2ckz6Wc+vZpy6bkk7Vcb1w36Ti8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203677>

From: Michael Haggerty <mhagger@alum.mit.edu>

Store reflogs for dead references among those for live references, in
a scheme that could in the future be extended to prevent
file/directory conflicts for live reference names, as well.  Store the
reflog for a dead reference "refs/foo/bar/baz" in file
"$GIT_DIR/logs/refs~d/heads~d/foo~d/bar~d/baz~f", where the suffix
"~d" is appended to "directory" names and "~f" is append to "file"
names.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c                               | 31 ++++++++++++++++++++++++-------
 t/t7701-repack-unpack-unreachable.sh |  4 ++--
 t/t9300-fast-import.sh               |  2 +-
 3 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index 551a0f9..4797b20 100644
--- a/refs.c
+++ b/refs.c
@@ -2580,20 +2580,37 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 
 char *refname_to_graveyard_reflog(const char *ref)
 {
-	return git_path("logs/graveyard/%s~", ref);
+	static struct strbuf buf = STRBUF_INIT;
+
+	const char *p, *slash;
+	strbuf_reset(&buf);
+	for (p = ref; (slash = strchr(p, '/')); p = slash + 1) {
+		strbuf_add(&buf, p, slash - p);
+		strbuf_addstr(&buf, "~d/");
+	}
+	strbuf_addstr(&buf, p);
+	strbuf_addstr(&buf, "~f");
+
+	return git_path("logs/%s", buf.buf);
 }
 
 char *graveyard_reflog_to_refname(const char *log)
 {
 	static struct strbuf buf = STRBUF_INIT;
 
-	if (!prefixcmp(log, "graveyard/"))
-		log += 10;
-
+	const char *p, *slash;
 	strbuf_reset(&buf);
-	strbuf_addstr(&buf, log);
-	if (buf.len > 0 && buf.buf[buf.len-1] == '~')
-		strbuf_setlen(&buf, buf.len - 1);
+	for (p = log; (slash = strchr(p, '/')); p = slash + 1) {
+		if (slash - p > 2 && slash[-2] == '~' && slash[-1] == 'd')
+			strbuf_add(&buf, p, slash - p - 2);
+		else
+			strbuf_add(&buf, p, slash - p);
+		strbuf_addch(&buf, '/');
+	}
+
+	strbuf_addstr(&buf, p);
+	if (buf.len > 2 && !strcmp(buf.buf + buf.len - 2, "~f"))
+		strbuf_setlen(&buf, buf.len - 2);
 
 	return buf.buf;
 }
diff --git a/t/t7701-repack-unpack-unreachable.sh b/t/t7701-repack-unpack-unreachable.sh
index c06b715..f8d02db 100755
--- a/t/t7701-repack-unpack-unreachable.sh
+++ b/t/t7701-repack-unpack-unreachable.sh
@@ -40,7 +40,7 @@ test_expect_success '-A with -d option leaves unreachable objects unpacked' '
 	# now expire the reflog, while keeping reachable ones but expiring
 	# unreachables immediately; also remove any graveyard reflogs
 	# from deleted branches that would keep things reachable
-	rm -rf .git/logs/graveyard &&
+	rm -rf .git/logs/*~? &&
 	test_tick &&
 	sometimeago=$(( $test_tick - 10000 )) &&
 	git reflog expire --expire=$sometimeago --expire-unreachable=$test_tick --all &&
@@ -78,7 +78,7 @@ test_expect_success '-A without -d option leaves unreachable objects packed' '
 	test 1 = $(ls -1 .git/objects/pack/pack-*.pack | wc -l) &&
 	packfile=$(ls .git/objects/pack/pack-*.pack) &&
 	git branch -D transient_branch &&
-	rm -rf .git/logs/graveyard &&
+	rm -rf .git/logs/*~? &&
 	test_tick &&
 	git repack -A -l &&
 	test ! -f "$fsha1path" &&
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index dc6c67d..8d88f5f 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1700,7 +1700,7 @@ INPUT_END
 
 test_expect_success 'P: verbatim SHA gitlinks' '
 	git branch -D sub &&
-	rm -rf .git/logs/graveyard &&
+	rm -rf .git/logs/*~? &&
 	git gc && git prune &&
 	git fast-import <input &&
 	test $(git rev-parse --verify subuse2) = $(git rev-parse --verify subuse1)
-- 
1.7.11.3
