From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 12/25] prepare_index(): declare return value to be (const char *)
Date: Mon,  7 Apr 2014 01:33:54 +0200
Message-ID: <1396827247-28465-13-git-send-email-mhagger@alum.mit.edu>
References: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 01:35:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWwbS-000602-21
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 01:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754586AbaDFXft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2014 19:35:49 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:61999 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754637AbaDFXfF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Apr 2014 19:35:05 -0400
X-AuditID: 12074412-f79d46d000002e58-a8-5341e4a95416
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id D5.8D.11864.9A4E1435; Sun,  6 Apr 2014 19:35:05 -0400 (EDT)
Received: from michael.fritz.box (p4FDD47DB.dip0.t-ipconnect.de [79.221.71.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s36NYbWx011578
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 6 Apr 2014 19:35:03 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqLvyiWOwwZ/VLBZdV7qZLBp6rzBb
	3F4xn9ni1+En7BY/WnqYLc68aWS06Oz4yujA7vH3/Qcmj52z7rJ7POvdw+hx8ZKyx+IHXh6f
	N8l53H62jSWAPYrbJimxpCw4Mz1P3y6BO2PBrzb2gkaOig2bupkaGI+wdTFyckgImEjcntbJ
	BGGLSVy4tx4ozsUhJHCZUWLq8S4mCOc4k8SjX11gVWwCuhKLeprBbBEBNYmJbYdYQIqYBW4w
	SrzbdxjI4eAQFgiRuHYyD6SGRUBVYtfkkywgNq+Aq0TD46/sENvkJE4em8wKYnMCxddNngtW
	IyTgAjTmHtsERt4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3TN9HIzS/RSU0o3MUJCT2gH
	4/qTcocYBTgYlXh4VxxyDBZiTSwrrsw9xCjJwaQkymt5DyjEl5SfUpmRWJwRX1Sak1p8iFGC
	g1lJhPfADaAcb0piZVVqUT5MSpqDRUmc9+didT8hgfTEktTs1NSC1CKYrAwHh5IEb99joEbB
	otT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UGzEFwOjAyTFA7Q3AqSdt7ggMRcoCtF6
	ilFRSpx35iOghABIIqM0D24sLKG8YhQH+lKY1wCknQeYjOC6XwENZgIa3BBmBzK4JBEhJdXA
	2BD2IKxlkfOZjpmlokGBXMrC98uY3r3/yO71cEtQ5bcfj48c+NawJe+dz9Gu+DVqAaJtP9bP
	439YVrqkc44hp/xvsVv2KyP+Xj+4Nn9Z8CFpuR/vNzDmiW/ji/+nf/llr9qp2Jry 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245813>

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
index d9550c5..2e2d8bb 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -302,8 +302,8 @@ static void refresh_cache_or_die(int refresh_flags)
 		die_resolve_conflict("commit");
 }
 
-static char *prepare_index(int argc, const char **argv, const char *prefix,
-			   const struct commit *current_head, int is_status)
+static const char *prepare_index(int argc, const char **argv, const char *prefix,
+				 const struct commit *current_head, int is_status)
 {
 	int fd;
 	struct string_list partial;
-- 
1.9.1
