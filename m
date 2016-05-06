From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 07/33] refname_is_safe(): don't allow the empty string
Date: Fri,  6 May 2016 18:13:48 +0200
Message-ID: <35db25c65f6f77c153ef2b1183ea7821236201c8.1462550456.git.mhagger@alum.mit.edu>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 06 18:14:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayiOv-00085v-La
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 18:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758635AbcEFQOl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 12:14:41 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:48392 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758562AbcEFQOj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 12:14:39 -0400
X-AuditID: 12074414-62bff700000008e6-c4-572cc2e99ce7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 01.12.02278.9E2CC275; Fri,  6 May 2016 12:14:33 -0400 (EDT)
Received: from michael.fritz.box (p508EA663.dip0.t-ipconnect.de [80.142.166.99])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u46GEHUn031758
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 6 May 2016 12:14:32 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1462550456.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsUixO6iqPvykE64waF+E4v5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxq7cDu8ff9ByaPnbPusns8693D6HHxkrLH/qXb2DwW
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd8aWb3PZCj4wV6zt+87ewPiNqYuRk0NCwETi2fpe
	IJuLQ0hgK6PEjWs32CCc40wS31b3sIJUsQnoSizqaQbrEBGIkGh41cLYxcjBwSzwmVFiJTdI
	WFjAU2Jdz0wWEJtFQFWi98dGMJtXIEpi3dseZohlchKXpz9gA7E5BSwkDvUeBxspJGAu0bH2
	BvsERp4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3Qt9HIzS/RSU0o3MUICTGQH45GTcocY
	BTgYlXh4M05qhwuxJpYVV+YeYpTkYFIS5f1eoBMuxJeUn1KZkVicEV9UmpNafIhRgoNZSYT3
	yj6gHG9KYmVValE+TEqag0VJnPfbYnU/IYH0xJLU7NTUgtQimKwMB4eSBG8zMJKEBItS01Mr
	0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kEREF8MjAGQFA/QXj6Qdt7igsRcoChE6ylGY44F
	P26vZeI4sv/eWiYhlrz8vFQpcd65B4FKBUBKM0rz4BbBUssrRnGgv4V5L4NU8QDTEty8V0Cr
	mIBWvZ+rCbKqJBEhJdXAqFOwY0Ouw16Bj5subFg96wTfkpeelivi+k6/P1v0yuvU3wnfbjpt
	usK99aosq3Py7IiZVrevJN+f8bNCe7n7vsUvu4xf7rl6rF7EuHKOUPJqpkVbNdiP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293803>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
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
