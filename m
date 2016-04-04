From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] config --show-origin: report paths with forward slashes
Date: Mon, 04 Apr 2016 08:51:15 -0700
Message-ID: <xmqqd1q574p8.fsf@gitster.mtv.corp.google.com>
References: <cover.1458668543.git.johannes.schindelin@gmx.de>
	<8beb1c208e33e1de8f272caa22fb7a0b662ca4cc.1458668543.git.johannes.schindelin@gmx.de>
	<56F8E435.3020304@kdbg.org>
	<alpine.DEB.2.20.1603281712470.4690@virtualbox>
	<56FAD506.4050701@kdbg.org>
	<xmqqwpolvyml.fsf@gitster.mtv.corp.google.com>
	<57001772.7090007@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
	Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>,
	Eric Wong <normalperson@yhbt.net>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Apr 04 17:51:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1an6mj-0005Tn-PL
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 17:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755873AbcDDPvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 11:51:21 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:63185 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755439AbcDDPvT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 11:51:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8A8634FEB3;
	Mon,  4 Apr 2016 11:51:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I+2AAqMPYFaH7JPvXBrxh7VBF6E=; b=MybxUn
	bjRQEriovhcSkV4MJkNgXfLqMQ2UK5lDbAPhX8LqqtZ7ji8JHHub050UqIz3yxRM
	Oku+gcpjDzTQ3+SapbKWIoD880wCIqWaKRRVMAzgZasirNzwKS3YR2FCRv/VTNbj
	oUCtupkI2If/XulAiY6pqaDH1Vlue1AraaEZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tbH0pMDoltvcJs4nFdrDjfKro3gnN4LJ
	3R5L9uf0VFUDzcOGW1s59716jONs7C4Gcn/WCp/hKQeKU/+USmOZulXuelWFMkhq
	UX8U/j5ZQ40K4+CEwL+EE8DnyB9hjpJm7OiKPiCI+SmVw48LJpk8XFp7NrrjzEyg
	/BoOViBB9kI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 82FDC4FEB2;
	Mon,  4 Apr 2016 11:51:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0642F4FEB1;
	Mon,  4 Apr 2016 11:51:16 -0400 (EDT)
In-Reply-To: <57001772.7090007@kdbg.org> (Johannes Sixt's message of "Sat, 2
	Apr 2016 21:03:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 11292BFE-FA7D-11E5-A7A2-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290692>

Johannes Sixt <j6t@kdbg.org> writes:

> Although I am convinced that the change is not necessary for
> correctness, I can buy the justification that we should produce forward
> slashes for consistency. There are a number of occasions where we
> present paths to the user, and we do show forward-slashes in all cases
> that I found. We should keep the commit.
>
> But then let's do this:

Sounds like a plan; even though I am mildly against adding more
platform specific #ifdef to files outside compat/, this patch does
not.

Dscho?

>
> ---- 8< ----
> Subject: [PATCH] Windows: shorten code by re-using convert_slashes()
>
> Make a few more spots more readable by using the recently introduced,
> Windows-specific helper.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  abspath.c      | 5 +----
>  compat/mingw.c | 9 ++-------
>  2 files changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/abspath.c b/abspath.c
> index 5edb4e7..2825de8 100644
> --- a/abspath.c
> +++ b/abspath.c
> @@ -167,7 +167,6 @@ const char *prefix_filename(const char *pfx, int pfx_len, const char *arg)
>  	strbuf_add(&path, pfx, pfx_len);
>  	strbuf_addstr(&path, arg);
>  #else
> -	char *p;
>  	/* don't add prefix to absolute paths, but still replace '\' by '/' */
>  	strbuf_reset(&path);
>  	if (is_absolute_path(arg))
> @@ -175,9 +174,7 @@ const char *prefix_filename(const char *pfx, int pfx_len, const char *arg)
>  	else if (pfx_len)
>  		strbuf_add(&path, pfx, pfx_len);
>  	strbuf_addstr(&path, arg);
> -	for (p = path.buf + pfx_len; *p; p++)
> -		if (*p == '\\')
> -			*p = '/';
> +	convert_slashes(path.buf + pfx_len);
>  #endif
>  	return path.buf;
>  }
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 54c82ec..0413d5c 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -763,15 +763,12 @@ struct tm *localtime_r(const time_t *timep, struct tm *result)
>  
>  char *mingw_getcwd(char *pointer, int len)
>  {
> -	int i;
>  	wchar_t wpointer[MAX_PATH];
>  	if (!_wgetcwd(wpointer, ARRAY_SIZE(wpointer)))
>  		return NULL;
>  	if (xwcstoutf(pointer, wpointer, len) < 0)
>  		return NULL;
> -	for (i = 0; pointer[i]; i++)
> -		if (pointer[i] == '\\')
> -			pointer[i] = '/';
> +	convert_slashes(pointer);
>  	return pointer;
>  }
>  
> @@ -2112,9 +2109,7 @@ static void setup_windows_environment()
>  		 * executable (by not mistaking the dir separators
>  		 * for escape characters).
>  		 */
> -		for (; *tmp; tmp++)
> -			if (*tmp == '\\')
> -				*tmp = '/';
> +		convert_slashes(tmp);
>  	}
>  
>  	/* simulate TERM to enable auto-color (see color.c) */
