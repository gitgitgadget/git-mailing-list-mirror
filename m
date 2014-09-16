From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 12/35] prepare_index(): declare return value to be (const char *)
Date: Tue, 16 Sep 2014 21:33:33 +0200
Message-ID: <1410896036-12750-13-git-send-email-mhagger@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Ronnie Sahlberg <sahlberg@google.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:34:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTyWN-0000Ei-LD
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 21:34:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755137AbaIPTef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 15:34:35 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:50536 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755133AbaIPTee (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2014 15:34:34 -0400
X-AuditID: 12074412-f792e6d000005517-0d-541890c92a09
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 47.45.21783.9C098145; Tue, 16 Sep 2014 15:34:33 -0400 (EDT)
Received: from michael.fritz.box (p5DDB27D9.dip0.t-ipconnect.de [93.219.39.217])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8GJYBcG001163
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Sep 2014 15:34:32 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsUixO6iqHtygkSIwe67shZdV7qZLBp6rzBb
	PJl7l9ni9or5zBY/WnqYLf5NqLHo7PjK6MDu8ff9ByaPBZtKPR6+6mL3eNa7h9Hj4iVlj8+b
	5DxuP9vGEsAexW2TlFhSFpyZnqdvl8Cd8erlYaaCyRwVO1ctZW5gvMrWxcjJISFgItGwcjeU
	LSZx4d56IJuLQ0jgMqPErZ7nrBDOCSaJLx9/sYJUsQnoSizqaWYCSYgItDFK7Lq4GayKWaCb
	UeL9idNMIFXCAiES5781gHWwCKhK7NrzEszmFXCV2HvvHAvEPjmJDbv/M3YxcnBwAsW/7isA
	MYUEXCQO3vWbwMi7gJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGumV5uZoleakrpJkZI4Ant
	YFx/Uu4QowAHoxIPr8cj8RAh1sSy4srcQ4ySHExKorz/uiVChPiS8lMqMxKLM+KLSnNSiw8x
	SnAwK4nw/vAFyvGmJFZWpRblw6SkOViUxHl/Llb3ExJITyxJzU5NLUgtgsnKcHAoSfDe7Adq
	FCxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAfFRnwxMDpAUjxAez+CtPMWFyTmAkUh
	Wk8x6nKs6/zWzyTEkpeflyolzmsDUiQAUpRRmge3ApZmXjGKA30szPsOpIoHmKLgJr0CWsIE
	tORsjxjIkpJEhJRUA+NEg1SVa3OnJZqesXDX4uxaXHYmuDpH5bzUmo9mRxsOqQmtr8ufMfmE
	b8HSZ6Is4lqnBeZffTbXsz//26oz3KLXTdWSLXX+vW7RFNftfn/o12mhrmW2ugGq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257149>

Declare the return value to be const to make it clear that we aren't
giving callers permission to write over the string that it points at.
(The return value is the filename field of a struct lock_file, which
can be used by a signal handler at any time and therefore shouldn't be
tampered with.)

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/commit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 41f481b..d4228c9 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -315,8 +315,8 @@ static void refresh_cache_or_die(int refresh_flags)
 		die_resolve_conflict("commit");
 }
 
-static char *prepare_index(int argc, const char **argv, const char *prefix,
-			   const struct commit *current_head, int is_status)
+static const char *prepare_index(int argc, const char **argv, const char *prefix,
+				 const struct commit *current_head, int is_status)
 {
 	struct string_list partial;
 	struct pathspec pathspec;
-- 
2.1.0
