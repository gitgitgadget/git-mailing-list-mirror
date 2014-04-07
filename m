From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 08/27] parse_cmd_verify(): copy old_sha1 instead of evaluating <oldvalue> twice
Date: Mon,  7 Apr 2014 15:47:59 +0200
Message-ID: <1396878498-19887-9-git-send-email-mhagger@alum.mit.edu>
References: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 15:48:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WX9uu-0002aQ-AM
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 15:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755369AbaDGNss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 09:48:48 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:47887 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755352AbaDGNsk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2014 09:48:40 -0400
X-AuditID: 12074414-f79d96d000002d2b-8a-5342acb7ed8c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 65.9A.11563.7BCA2435; Mon,  7 Apr 2014 09:48:39 -0400 (EDT)
Received: from michael.fritz.box (p5B156B1D.dip0.t-ipconnect.de [91.21.107.29])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s37DmJaF026029
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 7 Apr 2014 09:48:37 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqLt9jVOwwdNvShY710lYdF3pZrJo
	6L3CbDHv7i4mi9sr5jNb/GjpYbb42LmA2YHd4+/7D0weO2fdZfe49PI7m8fHZ8vZPZ717mH0
	uHhJ2ePzJrkA9ihum6TEkrLgzPQ8fbsE7oxTUxexF8xlr5jXc4+lgbGBrYuRk0NCwERi6uHv
	ULaYxIV764FsLg4hgcuMEluW/WWFcI4xScw/OZsFpIpNQFdiUU8zE4gtIqAmMbHtEAtIEbPA
	FUaJKx+3gxUJCyRJdBxoACtiEVCV+D5rMiOIzSvgIvF25UFGiHVyEiePTWYFsTkFXCVmHLoF
	FhcCqrm/5hjLBEbeBYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0LfRyM0v0UlNKNzFCgk9k
	B+ORk3KHGAU4GJV4eFcccgwWYk0sK67MPcQoycGkJMr7fJlTsBBfUn5KZUZicUZ8UWlOavEh
	RgkOZiURXq7VQDnelMTKqtSifJiUNAeLkjjvt8XqfkIC6YklqdmpqQWpRTBZGQ4OJQnelyCN
	gkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aDoiC8GxgdIigdo71ywvcUFiblAUYjW
	U4yKUuK8JSAJAZBERmke3FhYSnnFKA70pTDvc5AqHmA6gut+BTSYCWiwoSvY4JJEhJRUA6Nu
	1S3nG7aREVL8/jnq7+ounT05P5M3xuNhs2JQqd/ur6LXd01xVYuf3r7x2I3o72ukaiTeb/Z1
	r9c6o7Jji53d439Od0/O3Ou94fOvB7t/nV6lr8E++VBuibfatLPu29Yv7rtvqulQ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245841>

Aside from avoiding a tiny bit of work, this makes it transparently
obvious that old_sha1 and new_sha1 are identical.  It is arguably a
bit silly to have to set new_sha1 in order to verify old_sha1, but
that is a problem for another day.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/update-ref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 5f197fe..51adf2d 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -249,7 +249,7 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
 
 	if (!parse_next_arg(input, &next, &value)) {
 		update_store_old_sha1(update, value.buf);
-		update_store_new_sha1(update, value.buf);
+		hashcpy(update->new_sha1, update->old_sha1);
 	} else if (!line_termination)
 		die("verify %s missing [<oldvalue>] NUL", ref.buf);
 
-- 
1.9.1
