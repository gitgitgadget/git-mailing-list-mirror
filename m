From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 60/68] prefer memcpy to strcpy
Date: Sun, 27 Sep 2015 13:19:05 +0200
Message-ID: <5607D0A9.4000506@web.de>
References: <20150924210225.GA23624@sigill.intra.peff.net>
 <20150924210818.GE30946@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 27 13:19:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zg9zE-0001Z2-0o
	for gcvg-git-2@plane.gmane.org; Sun, 27 Sep 2015 13:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755507AbbI0LTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Sep 2015 07:19:16 -0400
Received: from mout.web.de ([212.227.17.12]:50109 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755483AbbI0LTO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Sep 2015 07:19:14 -0400
Received: from [192.168.178.36] ([79.253.148.147]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MSads-1a5Qcr1pdk-00RaAT; Sun, 27 Sep 2015 13:19:09
 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <20150924210818.GE30946@sigill.intra.peff.net>
X-Provags-ID: V03:K0:ax9lzRDlCs5oohP/ODMve5SMDId2owcAPC5umVTuxOX7AQq4YNV
 v31yEQwE5iexxuMGlCeTRN/Afs5WAevkwq2t50PlYhr9VlR3YFL9y6rvmqPjho/Es5MY/49
 dofBGH1v4oUo3BE/7PRNXFliZex7sckyCarQovfGczoPHOZG7r6FKNcfwlhdCvsjr0oJJ8Y
 /kKbHwajAD38BzBuTKWow==
X-UI-Out-Filterresults: notjunk:1;V01:K0:j69j+umMBfc=:b3yKOoMtmnfQyNYEI51SWi
 z0InBaDwfugEaNFZ1LkHf5nynDgsgan/GC6KbM7LeYaA+cwsqIssWOqXNCbsnLgFgnLb/Fay5
 fLMmtu69rxom3x6C62B97xSMjgS3vgZ+thNHapmSXCeB5BBxAAazvmWmIzElWQwo5ojSSqMv5
 52V+Fg4HXLp1MnMZ/AXdb0/q0ONUrFQXORDGPinHAvIov3mRUi/KNB2EoqAkNkUf67ebvCnHM
 94i7YXsiSSS7yF2lP9jp/u2APn+vla9LQkEoOsgh9wbjc95E+f8rvENkAUR9c7MYVB6X8X+oI
 iUHZTgbNi/FpbSEcOYph9tCN0ZA/hDE+LbQO2PO6S3wuDGAb20KlWkoxD7KaXTT0GtBZNaL6d
 q5L1wSJod235KewrXp2F+Zhe5dz/WBnblLaNgNWLmnBZ+q7LgjelIQcofQ1E2xDb7cfaOY7NA
 XHufoygBfXPAxgh7KtsMzGklK86Xwm9mFTGKQf1n3gTvySNmdarUVL0QRa6vVkb3ZqdXKqc7f
 zGXNH0cDphsMsn0UZnDKhIgIpP1Z83XQsS8XV18M1iJYc0dRUb4PGPn0v98Nn8xVeh9JG3bx/
 M7AQ1TD/iRiZcaEIUJFY4QkF1hDJn0RVHeVHNl/LBk62p+4Bq4Ot1Qdovo+Lhjyyr8eBg/S82
 B8S6eGQrn9exqkDa3rka6cFD8+yUbA6aCU68WexdnZmwOrFbx0Lg2Gsm2bR7m3ZJHsnVG2MHL
 qnx23XEhKiEBvccdtjtEEAf/wB1c8MAxu30BxQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278701>

Am 24.09.2015 um 23:08 schrieb Jeff King:
> When we already know the length of a string (e.g., because
> we just malloc'd to fit it), it's nicer to use memcpy than
> strcpy, as it makes it more obvious that we are not going to
> overflow the buffer (because the size we pass matches the
> size in the allocation).
>
> This also eliminates calls to strcpy, which make auditing
> the code base harder.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>   compat/nedmalloc/nedmalloc.c | 5 +++--
>   fast-import.c                | 5 +++--
>   revision.c                   | 2 +-
>   3 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/compat/nedmalloc/nedmalloc.c b/compat/nedmalloc/nedmalloc.c
> index 609ebba..a0a16eb 100644
> --- a/compat/nedmalloc/nedmalloc.c
> +++ b/compat/nedmalloc/nedmalloc.c
> @@ -957,8 +957,9 @@ char *strdup(const char *s1)
>   {
>   	char *s2 = 0;
>   	if (s1) {
> -		s2 = malloc(strlen(s1) + 1);
> -		strcpy(s2, s1);
> +		size_t len = strlen(s1) + 1;
> +		s2 = malloc(len);
> +		memcpy(s2, s1, len);

This leaves the last byte uninitialized; it was set to NUL by strcpy() 
before.

>   	}
>   	return s2;
>   }
> diff --git a/fast-import.c b/fast-import.c
> index 895c6b4..cf6d8bc 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -644,8 +644,9 @@ static void *pool_calloc(size_t count, size_t size)
>
>   static char *pool_strdup(const char *s)
>   {
> -	char *r = pool_alloc(strlen(s) + 1);
> -	strcpy(r, s);
> +	size_t len = strlen(s) + 1;
> +	char *r = pool_alloc(len);
> +	memcpy(r, s, len);

Same here.

>   	return r;
>   }
>
> diff --git a/revision.c b/revision.c
> index af2a18e..2236463 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -38,7 +38,7 @@ char *path_name(const struct name_path *path, const char *name)
>   	}
>   	n = xmalloc(len);
>   	m = n + len - (nlen + 1);
> -	strcpy(m, name);
> +	memcpy(m, name, nlen + 1);

This copies the NUL byte terminating the string, so it's OK.  However, I 
wonder if using a strbuf for building the path in one go instead would 
simplify this function without too much of a performance impact.

>   	for (p = path; p; p = p->up) {
>   		if (p->elem_len) {
>   			m -= p->elem_len + 1;
>
