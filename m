From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 19/25] try_merge_strategy(): remove redundant lock_file allocation
Date: Mon,  7 Apr 2014 01:34:01 +0200
Message-ID: <1396827247-28465-20-git-send-email-mhagger@alum.mit.edu>
References: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 01:36:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWwc5-00074B-4B
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 01:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754707AbaDFXgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2014 19:36:10 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:46564 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754653AbaDFXfT (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Apr 2014 19:35:19 -0400
X-AuditID: 1207440c-f79656d000003eba-4d-5341e4b6c1e6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 34.41.16058.6B4E1435; Sun,  6 Apr 2014 19:35:18 -0400 (EDT)
Received: from michael.fritz.box (p4FDD47DB.dip0.t-ipconnect.de [79.221.71.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s36NYbX6011578
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 6 Apr 2014 19:35:17 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqLvtiWOwwZVT6hZdV7qZLBp6rzBb
	3F4xn9ni1+En7BY/WnqYLc68aWS06Oz4yujA7vH3/Qcmj52z7rJ7POvdw+hx8ZKyx+IHXh6f
	N8l53H62jSWAPYrbJimxpCw4Mz1P3y6BO+Py2n+sBUfZK5ra7jA3ME5g62Lk5JAQMJF4d/EV
	M4QtJnHh3nqgOBeHkMBlRonF7VugnONMEhMvTGEEqWIT0JVY1NPMBGKLCKhJTGw7xAJSxCxw
	g1Hi3b7DLCAJYYFQiVcfHoOtYBFQlTi6eDNYnFfAVaJx4kJWiHVyEiePTQazOYHi6ybPBasR
	EnABmnOPbQIj7wJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFuoZ6uZkleqkppZsYIcHHs4Px
	2zqZQ4wCHIxKPLwrDjkGC7EmlhVX5h5ilORgUhLlffAYKMSXlJ9SmZFYnBFfVJqTWnyIUYKD
	WUmE98ANoBxvSmJlVWpRPkxKmoNFSZxXdYm6n5BAemJJanZqakFqEUxWhoNDSYK3D2SoYFFq
	empFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPCg64ouB8QGS4gHaOx2knbe4IDEXKArReopR
	UUqcd+YjoIQASCKjNA9uLCylvGIUB/pSmHcZSDsPMB3Bdb8CGswENLghzA5kcEkiQkqqgbGc
	f8c/36I1/c0Gh5bVxIspr7RLZWW0/N5W0L9wgUSa9PsLLOyH5itIcEceqMxcWq+9anejx+VP
	J7WlLebk8W3dY9zd6tWVb2fUvCn2mHOs5tqVgunVvjIWom69kosYv5ss1ty4XOKv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245826>

By the time the "if" block is entered, the lock_file instance from the
main function block is no longer in use, so re-use that one instead of
allocating a second one.

Note that the "lock" variable in the "if" block shadowed the "lock"
variable at function scope, so the only change needed is to remove the
inner definition.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/merge.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index e15d0e1..f714961 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -671,7 +671,6 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 	if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree")) {
 		int clean, x;
 		struct commit *result;
-		struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
 		int index_fd;
 		struct commit_list *reversed = NULL;
 		struct merge_options o;
-- 
1.9.1
