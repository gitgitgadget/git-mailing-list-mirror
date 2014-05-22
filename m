From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH 2/9] strbuf: add strbuf_tolower function
Date: Wed, 21 May 2014 17:07:36 -0700
Message-ID: <AD42BA87-3C73-4EB2-AF88-96C4F7E6FA0C@gmail.com>
References: <20140521102524.GA30301@sigill.intra.peff.net> <20140521102742.GB30464@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 22 02:07:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnGXu-0007ke-RL
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 02:07:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039AbaEVAHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 20:07:39 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:38989 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524AbaEVAHi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 20:07:38 -0400
Received: by mail-pb0-f51.google.com with SMTP id ma3so1886373pbc.24
        for <git@vger.kernel.org>; Wed, 21 May 2014 17:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=OemF19uq0e0opjdTJjppEhIpk6fhHdXvQ2bv0DkBC6E=;
        b=jWnTt6ioVEVsoG+8OjtRaQ2ivJWPkdSEm/PxIYX/FfeqMNl/UZ6nGBt2hFZazEaw6q
         46GViRed2ZAbh8xGI1z8/i9bUzvScxB9c1hfKtOaxqwoh0AcbkqMuB/lBjr0TtSXdhht
         UScW6FQmPNgqYlqakAesTahx9qlW7VmpihIMV97HEZi2iD1q4Cpeo+qBzYwGUj2g/5gG
         xAr+dxHQDYi+5CMXsDVsqAUR62P3gL3yZHhokeNqkYZlGeZzpoaGwqrjdJXa/kBxRTbg
         voLa6F1wWR0nE93FFBlzf8Wrmvn+gPX9QPmRfpCDWMUoZwkWMhq+IJWlDmURnI0d1Ndv
         vOLw==
X-Received: by 10.66.180.200 with SMTP id dq8mr63509585pac.104.1400717257854;
        Wed, 21 May 2014 17:07:37 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id yv7sm111449051pac.33.2014.05.21.17.07.36
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 21 May 2014 17:07:37 -0700 (PDT)
In-Reply-To: <20140521102742.GB30464@sigill.intra.peff.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249863>

On May 21, 2014, at 03:27, Jeff King wrote:

> This makes config's lowercase() function public.
>
> Note that we could continue to offer a pure-string
> lowercase, but there would be no callers (in most
> pure-string cases, we actually duplicate and lowercase the
> duplicate).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This ones gets used later on...
>
> Documentation/technical/api-strbuf.txt | 4 ++++
> config.c                               | 8 +-------
> strbuf.c                               | 7 +++++++
> strbuf.h                               | 1 +
> 4 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/ 
> technical/api-strbuf.txt
> index 3350d97..8480f89 100644
> --- a/Documentation/technical/api-strbuf.txt
> +++ b/Documentation/technical/api-strbuf.txt
> @@ -125,6 +125,10 @@ Functions
>
> 	Strip whitespace from the end of a string.
>
> +`strbuf_tolower`::
> +
> +	Lowercase each character in the buffer using `tolower`.
> +
> `strbuf_cmp`::
>
> 	Compare two buffers. Returns an integer less than, equal to, or  
> greater
> diff --git a/config.c b/config.c
> index a30cb5c..03ce5c6 100644
> --- a/config.c
> +++ b/config.c
> @@ -147,12 +147,6 @@ int git_config_include(const char *var, const  
> char *value, void *data)
> 	return ret;
> }
>
> -static void lowercase(char *p)
> -{
> -	for (; *p; p++)
> -		*p = tolower(*p);
> -}
> -
> void git_config_push_parameter(const char *text)
> {
> 	struct strbuf env = STRBUF_INIT;
> @@ -180,7 +174,7 @@ int git_config_parse_parameter(const char *text,
> 		strbuf_list_free(pair);
> 		return error("bogus config parameter: %s", text);
> 	}
> -	lowercase(pair[0]->buf);
> +	strbuf_tolower(pair[0]);
> 	if (fn(pair[0]->buf, pair[1] ? pair[1]->buf : NULL, data) < 0) {
> 		strbuf_list_free(pair);
> 		return -1;
> diff --git a/strbuf.c b/strbuf.c
> index ee96dcf..a1b8a47 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -106,6 +106,13 @@ void strbuf_ltrim(struct strbuf *sb)
> 	sb->buf[sb->len] = '\0';
> }
>
> +void strbuf_tolower(struct strbuf *sb)
> +{
> +	size_t i;
> +	for (i = 0; i < sb->len; i++)
> +		sb->buf[i] = tolower(sb->buf[i]);
> +}
> +

Wouldn't a direct transfer of the lowercase function be something more  
like:


void strbuf_tolower(struct strbuf *sb)
{
	char *p = sb->buf;
	for (; *p; p++)
		*p = tolower(*p);
}

That seems to me to be a bit more efficient.  According to the  
comments in strbuf.c, "people can always assume buf is non NULL and - 
 >buf is NUL terminated even for a freshly initialized strbuf."

> struct strbuf **strbuf_split_buf(const char *str, size_t slen,
> 				 int terminator, int max)
> {
> diff --git a/strbuf.h b/strbuf.h
> index 39c14cf..6b6f745 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -45,6 +45,7 @@ static inline void strbuf_setlen(struct strbuf  
> *sb, size_t len)
> extern void strbuf_trim(struct strbuf *);
> extern void strbuf_rtrim(struct strbuf *);
> extern void strbuf_ltrim(struct strbuf *);
> +extern void strbuf_tolower(struct strbuf *sb);
> extern int strbuf_cmp(const struct strbuf *, const struct strbuf *);
>
> /*
> -- 
> 2.0.0.rc1.436.g03cb729
>
