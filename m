From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 04/29] refname_is_safe(): don't allow the empty string
Date: Wed, 27 Apr 2016 18:57:21 +0200
Message-ID: <51574acf932c4650110d9f7be0601532879f624c.1461768689.git.mhagger@alum.mit.edu>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org, David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 18:58:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avSnA-0003f6-LS
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 18:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753035AbcD0Q6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 12:58:11 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:59397 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752866AbcD0Q6K (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2016 12:58:10 -0400
X-AuditID: 12074413-487ff700000008c7-91-5720efa12b1c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 37.48.02247.1AFE0275; Wed, 27 Apr 2016 12:58:09 -0400 (EDT)
Received: from michael.fritz.box (p548D622A.dip0.t-ipconnect.de [84.141.98.42])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3RGvw6H022189
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 27 Apr 2016 12:58:08 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1461768689.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqLvwvUK4wc8WZYv5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxq7cDu8ff9ByaPnbPusns8693D6HHxkrLH/qXb2DwW
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd8bqQ2vYCtazVEw41sLawLiSuYuRk0NCwETiyKTd
	rF2MXBxCAlsZJS4d3McCkhASOM4kMeWyOojNJqArsainmQnEFhFwkFi+8hc7SAOzQBOTxPfl
	TWANwgJuEtMb1oAVsQioSjQeuQhm8wpESbxfNosFYpucxOXpD9hAbE4BC4kvrW8ZIZaZSyx5
	sJp9AiPPAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW65nq5mSV6qSmlmxghISa8g3HXSblD
	jAIcjEo8vAUSCuFCrIllxZW5hxglOZiURHmXnAUK8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuGd
	/gYox5uSWFmVWpQPk5LmYFES51Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4C1/B9QoWJSanlqR
	lplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4qB+GJgFICkeID2loK08xYXJOYCRSFaTzHqciz4
	cXstkxBLXn5eqpQ47wKQIgGQoozSPLgVsITyilEc6GNh3qkgVTzAZAQ36RXQEiagJZcPyYIs
	KUlESEk1MM6zUlllplojErtn2curK0oqv3yJbmkPKt0dv/AMxwVH/ebomt3fZn1L8tItKOQ+
	Ynjy85arUz+ra7av6J5QzlLxdJ+FolzPCfMNBZWvlt4621vSuqpDOqJWZ5XzZyO3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292745>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
This fixes a coding error from the original implementation.

 refs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 5789152..ca0280f 100644
--- a/refs.c
+++ b/refs.c
@@ -136,11 +136,12 @@ int refname_is_safe(const char *refname)
 		free(buf);
 		return result;
 	}
-	while (*refname) {
+
+	do {
 		if (!isupper(*refname) && *refname != '_')
 			return 0;
 		refname++;
-	}
+	} while (*refname);
 	return 1;
 }
 
-- 
2.8.1
