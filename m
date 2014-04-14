From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 11/25] prepare_index(): declare return value to be (const char *)
Date: Mon, 14 Apr 2014 15:54:41 +0200
Message-ID: <1397483695-10888-12-git-send-email-mhagger@alum.mit.edu>
References: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 15:57:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZhO1-000306-4r
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 15:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755307AbaDNN5D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 09:57:03 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:59725 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755173AbaDNNzZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Apr 2014 09:55:25 -0400
X-AuditID: 12074413-f79076d000002d17-8d-534be8ccf771
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 86.40.11543.CC8EB435; Mon, 14 Apr 2014 09:55:24 -0400 (EDT)
Received: from michael.fritz.box (p4FC96FF6.dip0.t-ipconnect.de [79.201.111.246])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3EDt09B010903
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 14 Apr 2014 09:55:23 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqHvmhXewQesNc4uuK91MFg29V5gt
	Vv6ssbi9Yj6zxa/DT9gtfrT0MFucedPIaNHZ8ZXRgcPj7/sPTB47Z91l93jWu4fR4+IlZY/F
	D7w8Pm+S87j7fyeTx+1n21gCOKK4bZISS8qCM9Pz9O0SuDMmTl3MWtDIUfHo4iKWBsYjbF2M
	nBwSAiYSK3d+ZYWwxSQu3FsPFOfiEBK4zChx+t5bRpCEkMBJJom2RWUgNpuArsSinmYmEFtE
	QE1iYtshFpAGZoF2JolDO3rBEsICIRI/Lx1kBrFZBFQl7p7fyg5i8wq4Sty42s0EsU1O4uSx
	yUCbOTg4geILP2RB7HKRuPtlCusERt4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3TN9XIz
	S/RSU0o3MUJCUXgH466TcocYBTgYlXh4O+Z4BwuxJpYVV+YeYpTkYFIS5c24ARTiS8pPqcxI
	LM6ILyrNSS0+xCjBwawkwuu6FSjHm5JYWZValA+TkuZgURLnVVui7ickkJ5YkpqdmlqQWgST
	leHgUJLgrXkO1ChYlJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPioz4YmBsgKR4gPYm
	gbTzFhck5gJFIVpPMSpKifOWgCQEQBIZpXlwY2EJ5hWjONCXwrxpIFU8wOQE1/0KaDAT0GCW
	drDBJYkIKakGxiKXFwqqxo6tsf0q1w7u7tteFsvps+T2BLcZfzxX335yjsVrjliGu6SywYcZ
	dy/mcJdatijwyzpolnCoJX552pirsCx5rqKR4efdZv1rsx4KpGeJRIpv/Dz1/tz8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246244>

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
index 9cfef6c..8ffb3ef 100644
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
