From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: [PATCH v2] Don't use curl_easy_strerror prior to curl-7.12.0
Date: Fri, 24 Aug 2012 11:58:25 +0200
Message-ID: <003001cd81df$0158cf60$040a6e20$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 24 11:58:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4qf4-0004rX-Aw
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 11:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218Ab2HXJ6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 05:58:37 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:54243 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753718Ab2HXJ6f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 05:58:35 -0400
Received: from DualCore (dsdf-4db5d8d2.pool.mediaWays.net [77.181.216.210])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0M9eBT-1SwNHR1PSB-00COYL; Fri, 24 Aug 2012 11:58:34 +0200
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac2B3m33Gh1uOiLgTCKo06MV3BrNnQ==
Content-Language: de
X-Provags-ID: V02:K0:aaDqtkjYUb2LRiRqmmp8WpGIxAj6aOEpEOX2m9ZsT/z
 BPJKO0wunJBqmVG6qMpPrLfzXZ0fL+zI6kXLcX9AYGT04dKw3L
 Q2zslvvn/FeYkfZJaHT6p4k27/uYGSLDQcnQBRrXrWQPSXO98k
 Zwk2mvwpwQ6XLr4BfdnVvuhpZ3bQG1W9fZmIkKC73gq23q1yIN
 CujvKK3dq8PCEH1eTkKxel31/88ZTTDke2XhKYyOa7bs2/henZ
 28ObfkybyIYObgEvUSLd0MOkrZ5PFfWsGpXDgUY1/5dUCYRvQX
 RTmr9M08+d2k+9OoQiBh+BkouqUHpA1Pnx1BJXK88V8Pymc4I0
 UXgJL11Xm0jUGWWFoR64alYXV5zRp5IogAUYJt3sj9hSi0SfN6
 OpY/N5OhwcmQA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204199>

This reverts be22d92 (http: avoid empty error messages for some curl errors,
2011-09-05) on platforms with older versions of libcURL.

Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
---
Resend, regardless that Junio said this not to be needed, as I don't see it applied yet.
Also tried to fix the formatting issues too, to practice submissions ;-)

 http.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/http.c b/http.c
index b61ac85..18bc6bf 100644
--- a/http.c
+++ b/http.c
@@ -806,10 +806,12 @@ static int http_request(const char *url, void *result, int target, int options)
 				ret = HTTP_REAUTH;
 			}
 		} else {
+#if LIBCURL_VERSION_NUM >= 0x070c00
 			if (!curl_errorstr[0])
 				strlcpy(curl_errorstr,
 					curl_easy_strerror(results.curl_result),
 					sizeof(curl_errorstr));
+#endif
 			ret = HTTP_ERROR;
 		}
 	} else {
-- 
1.7.12
