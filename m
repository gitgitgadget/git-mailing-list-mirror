From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] crlf: Add test showing double warning on commit
Date: Sat, 14 May 2016 18:20:22 +0200
Message-ID: <baea5604-e786-5773-aa68-f311efb23752@web.de>
References: <20160514111755.GG2345@dinwoodie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 18:21:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1cJN-00022Y-28
	for gcvg-git-2@plane.gmane.org; Sat, 14 May 2016 18:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752745AbcENQVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2016 12:21:00 -0400
Received: from mout.web.de ([212.227.17.11]:62792 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751363AbcENQU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2016 12:20:59 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MNcMo-1ayrQO0jYg-007A2e; Sat, 14 May 2016 18:20:50
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.0
In-Reply-To: <20160514111755.GG2345@dinwoodie.org>
X-Provags-ID: V03:K0:/YYIyxNf/2lI46Dz7iG+kYb0rbNp7sgxDCLa/kE2BSQ63rJBKvT
 LJpGkNzuFnzwkbStqAjnGlJ/AeVle3Pcfa77Qadt4p/1bQITyYPES923S5UO6vda+dBwjq5
 4g+3Vb7VioGv5sJAEwYK8DjeEPBH+JDaJ4U99AHQ5LO8vvnnsPXiYCbUXAUbMz2ZECZ6VKh
 o9CiDb9UJq04ihAkR7kLg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Jlvzr3NAHK8=:pWAwgGEOz7ENqSan3XFiHm
 GpdD87TbQ9iO5I2A51dNq6uh0mPcnDeTouMqDBc8l/AbgCZ65zB+u0AFcRGZwvIlO1+vvvBWv
 cnqbhCw6q5KRHjI4m1gpk8agHL+fsGyi5xe8XaQnx3LsllkQw9x0FXr1tDaYCl4OWN3Q2yOT0
 Im48VzfLEaK208QRe9oreGpvQu3pYxnxYMuSnsxpYV+RLuQ9wJ5l8hL+BdB07Nk53X5anG/3L
 owAC7zpD/yoegOQOjtGz/PhiSvSPt2lOM22g179gZEZr1J9Xh++NQksoVvR2mSpfPzArVKWfD
 KnvwU10FJ7Fo4TP0SbT4UXLTQj0QdwxLS+SRauuTN3a7N2bNF16xNEYZBEH6NwGhCB/Dbgzoe
 UYcARRDxqoVfCdJ9a8N3t9TRLNuV3xvgW8NKaWMrBF4R10C6cx0LJIhhfFg9/PCOiklmdFpTo
 qgsI4eEUNCFJEf9U5ghs1PQkZ/cchf+XNB6iOnG/DGRy4CAaxXmh1orkxv9Eh8sOuRH48IEyh
 KH5YZNdLLHuzCLMf1tzUj48hmzaavKtrlnF2AqbLq511cR+9YyUsAiZ0R021H9nrgD3f+Gt/V
 DOS4Eamv668iYVtfQewTA7/rvBn1jJPRlanOJJMCFo+CR0iDmCVBFlfie8VjSysOCDJKXdbG/
 PnUmUjU56yHefWQMhkGcPT8aj0Ve9KHRDyG8RdAPQ+1yC1wVzzJ7j8MMVgCeQVN/MECAQJkpw
 wtszI/Jp2z1kQSijJy4Q20gWiWeGizT7/hTlSX5Ck4RYLRycyKmtRCx8cpSAyCfafiGFkNjC 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294615>

On 14.05.16 13:17, Adam Dinwoodie wrote:
> Add failing test case showing CRLF -> LF rewrite warnings being printed
> multiple times when running "git commit".
>

The problem seems to come from this line:

index 5473493..59d4106 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -61,9 +61,18 @@ static int should_break(struct diff_filespec *src,
            !hashcmp(src->sha1, dst->sha1))
                return 0; /* they are the same */
 
+       fprintf(stderr, "%s:%d src-path=%s dst-path=%s\n",
+               __FILE__, __LINE__, src->path, dst->path);
+#if 0
        if (diff_populate_filespec(src, 0) || diff_populate_filespec(dst, 0))
                return 0; /* error but caught downstream */
+#else
 
+       if (diff_populate_filespec(src, 0))
+               return 0; /* error but caught downstream */
+       if (strcmp(src->path, dst->path) && diff_populate_filespec(dst, 0))
+               return 0; /* error but caught downstream */
+#endif
        max_size = ((src->size > dst->size) ? src->size : dst->size);

Do we need to run diff_populate_filespec() twice when src==dst ?
If yes, we may need to introduce a flag besides
#define CHECK_SIZE_ONLY 1
#define CHECK_BINARY    2
to suppress the conversion warning ??

If no, the fix from above should do ?
