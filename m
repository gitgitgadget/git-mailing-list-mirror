From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH] Don't use curl_easy_strerror prior to curl-7.12.0
Date: Wed, 22 Aug 2012 19:59:58 +0200
Message-ID: <003c01cd808f$f24e2a60$d6ea7f20$@schmitz-digital.de>
References: <002201cd807d$0e83d300$2b8b7900$@schmitz-digital.de> <7v8vd6alqe.fsf@alter.siamese.dyndns.org> <003001cd808b$9d505730$d7f10590$@schmitz-digital.de> <7vk3wq964r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 20:00:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4FEC-0005Re-0Q
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 20:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758641Ab2HVSAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 14:00:22 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:50736 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758495Ab2HVSAU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 14:00:20 -0400
Received: from DualCore (dsdf-4d0a052e.pool.mediaWays.net [77.10.5.46])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0M3jZR-1TuySz3Up7-00rIhS; Wed, 22 Aug 2012 20:00:05 +0200
In-Reply-To: <7vk3wq964r.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQHjEtoBTcn41aOpScwQkPT+c62HTAJeVUchAO6Wu9cBkiD+9ZcUACOQ
Content-Language: de
X-Provags-ID: V02:K0:618VZTw3Xxydo9D7X9rx7D+fwNHvVmhJDAEiXpKaTFg
 VJDzPMVkMcD9UimH/ae2yvDE56enk1fTkNKKtoNIBAiROV/1BP
 6rRqs0tMYhhdGAGBYOUypo8eVwVKRhFZanqBlFElv156aJp2vN
 RH8Jj13OAd2aWsOVNginHezfAKd8yOvTbNdQdgVa5LD8yKizxD
 J7gZ7+TJ3CO2Cz9jC3vysrIC4OWCxeLfAQ2uPcNOvKLBLvfcOf
 epSyJItDNKGkkrbFHv/Ju6ku+TjxnWI2qgSOHZ64rmcSU+G2To
 0OaGgIHFcPWYMpdxThW5MfG2Gy9QtJQE5aWjZbamRkDPK+qFD6
 Dt+IjOoJtnvbQiQImnZfgcbzoqdVM+P3Rhr3jojSEAVLHf4UEw
 WGQa7HhtHNRYQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204051>

> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Wednesday, August 22, 2012 7:41 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org
> Subject: Re: [PATCH] Don't use curl_easy_strerror prior to curl-7.12.0
> 
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> 
> > Like this:
> > ----
> >
> > This reverts be22d92 (http: avoid empty error messages for some curl
> > errors,
> > 2011-09-05) on platforms with older versions of libcURL.
> >
> > Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
> > ---
> 
> Perfect ;-)
> 
> >  http.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/http.c b/http.c
> > index b61ac85..18bc6bf 100644
> > --- a/http.c
> > +++ b/http.c
> > @@ -806,10 +806,12 @@ static int http_request(const char *url, void
> > *result, int target, int options)
> >                                 ret = HTTP_REAUTH;
> >                         }
> 
> Now we need to see where these whitespace breakages are coming from and
> fix it, and I think it should be done earlier than later, as I expect we
will be
> seeing more patches from you in the coming weeks.

OK, next attempt (this time I downloaded the patch file to my PC first and
used Wordpad for copy/past rather than cat in a PuTTY session)
---

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

Better?

Bye, Jojo
