From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 08/12] ref_transaction_create(): check that new_sha1 is valid
Date: Thu, 12 Feb 2015 12:12:19 +0100
Message-ID: <1423739543-1025-9-git-send-email-mhagger@alum.mit.edu>
References: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 12:19:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLroF-0007QT-O4
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 12:19:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755381AbbBLLTs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 06:19:48 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:48652 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755302AbbBLLTq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Feb 2015 06:19:46 -0500
X-AuditID: 1207440c-f79376d00000680a-c0-54dc8aabddc2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id FE.3C.26634.BAA8CD45; Thu, 12 Feb 2015 06:12:43 -0500 (EST)
Received: from michael.fritz.box (p4FC96396.dip0.t-ipconnect.de [79.201.99.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1CBCT7b003107
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 12 Feb 2015 06:12:42 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqLu6606IwfvHxhZdV7qZLBp6rzBb
	vL25hNHi9or5zBbdU94yWvT2fWK12Ly5ncWB3ePv+w9MHjtn3WX3WLCp1OPiJWWPz5vkAlij
	uG2SEkvKgjPT8/TtErgzbjx0LDjKWnH7UWQD4zaWLkZODgkBE4n2dYvZIGwxiQv31gPZXBxC
	ApcZJT6smcYO4Zxgkjjz8RgjSBWbgK7Eop5mJhBbREBNYmLbIbBJzAKrmSS23gWbJCwQIHF9
	xRmwehYBVYnd+/6B1fMKOEvsWTiTFWKbnMT54z+ZQWxOAReJd5cawOqFgGp2tW1hncDIu4CR
	YRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrqFebmaJXmpK6SZGSIjx7GD8tk7mEKMAB6MSD2+A
	8Z0QIdbEsuLK3EOMkhxMSqK8XK1AIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8vk1AOd6UxMqq
	1KJ8mJQ0B4uSOK/qEnU/IYH0xJLU7NTUgtQimKwMB4eSBO+/TqBGwaLU9NSKtMycEoQ0Ewcn
	yHAuKZHi1LyU1KLE0pKMeFBcxBcDIwMkxQO0Vwyknbe4IDEXKArReopRl2NB+/6ZTEIsefl5
	qVLivPdBigRAijJK8+BWwBLKK0ZxoI+FeZNBqniAyQhu0iugJUxASybOuA2ypCQRISXVwDgr
	cqKxjI3SVLZTuXlRnCKC86rLeXJ0RO8d2hgfLGjGUJeyxeGLaO/LPPcyib8eXjXxT144PzkV
	/jL8ppGExcNVpqYd1m1bWVjORR0rddGczP/sSaPuuatt7XeXN/Hw6VV6zlHe9kNA 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263726>

Creating a reference requires a new_sha1 that is not NULL and not
null_sha1.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/refs.c b/refs.c
index ddb8bca..3f78fac 100644
--- a/refs.c
+++ b/refs.c
@@ -3690,6 +3690,8 @@ int ref_transaction_create(struct ref_transaction *transaction,
 			   int flags, const char *msg,
 			   struct strbuf *err)
 {
+	if (!new_sha1 || is_null_sha1(new_sha1))
+		die("BUG: create called without valid new_sha1");
 	return ref_transaction_update(transaction, refname, new_sha1,
 				      null_sha1, flags, msg, err);
 }
-- 
2.1.4
