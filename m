From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH] Don't use curl_easy_strerror prior to curl-7.12.0
Date: Wed, 22 Aug 2012 19:28:58 +0200
Message-ID: <003001cd808b$9d505730$d7f10590$@schmitz-digital.de>
References: <002201cd807d$0e83d300$2b8b7900$@schmitz-digital.de> <7v8vd6alqe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 19:29:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Ejx-00019C-NT
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 19:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959Ab2HVR3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 13:29:07 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:60225 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964869Ab2HVR3G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 13:29:06 -0400
Received: from DualCore (dsdf-4d0a052e.pool.mediaWays.net [77.10.5.46])
	by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
	id 0LkQN1-1Tg3Ol1F9f-00cNtW; Wed, 22 Aug 2012 19:29:04 +0200
In-Reply-To: <7v8vd6alqe.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQHjEtoBTcn41aOpScwQkPT+c62HTAJeVUchlyf9mwA=
Content-Language: de
X-Provags-ID: V02:K0:I1NJi8RVwj7aHwYoy9fz+OEXN5uxHvA4ineuP0/t8mM
 UtQBLbP/pilS2x78Dq3Yyo3CyAKhlsgbpAaBcGWzt67lc4dUPi
 KzV9mIshnJF/twGnylvYkozsKL5lwMIa7R/xItOsFEH/tWIaL6
 ez6TNdn9HYBjZqILLYRi2+dXWkdwASjuWMu4LJtmykm1zAfqbL
 meUCC5EkpBa2ff9I9kqb1BChnV5BrsX6toAOjHR0BNHvbIZudi
 xmKxo12aDePWUfKy6UN+wbGHh7ufwrl5m0eq2LVnbqY/50KRjl
 1edadBTS7BuUXvpLX3X3rBgakkMP/OOSMMfHLfmVvTfK4eON9b
 UYFcz6+pZWdXVKzwRjql+rV8G80gYdZu3GMGd3htoj/s5K3P9W
 DgfTLnHrvxU5g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204040>

> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Wednesday, August 22, 2012 7:19 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org
> Subject: Re: [PATCH] Don't use curl_easy_strerror prior to curl-7.12.0
> 
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> 
> > Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
> 
> At the very least, please mention that this reverts be22d92 (http:
> avoid empty error messages for some curl errors, 2011-09-05) on platforms
> with older versions of libcURL.

a) Of course I didn't know that, thanks for telling me.
b) How and where to add that? In the Subject of an email, in the body, right
at the front?
Like this:
----

This reverts be22d92 (http: avoid empty error messages for some curl errors,
2011-09-05) on platforms with older versions of libcURL.

Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
---
 http.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/http.c b/http.c
index b61ac85..18bc6bf 100644
--- a/http.c
+++ b/http.c
@@ -806,10 +806,12 @@ static int http_request(const char *url, void *result,
int target, int options)
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

Bye, Jojo
