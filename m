From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH v2 08/18] do_for_each_reflog(): use a strbuf to hold logfile name
Date: Thu, 26 Apr 2012 16:25:41 -0700
Message-ID: <xmqqaa1y6poq.fsf@junio.mtv.corp.google.com>
References: <1335479227-7877-1-git-send-email-mhagger@alum.mit.edu>
	<1335479227-7877-9-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Apr 27 01:25:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNY4M-00075C-B9
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 01:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759385Ab2DZXZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 19:25:45 -0400
Received: from mail-lpp01m010-f74.google.com ([209.85.215.74]:60626 "EHLO
	mail-lpp01m010-f74.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754123Ab2DZXZo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Apr 2012 19:25:44 -0400
Received: by laai8 with SMTP id i8so4704laa.1
        for <git@vger.kernel.org>; Thu, 26 Apr 2012 16:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=lliAKUtzvRXJy9GmZSclAVGLZ0m1QOdl17qOk5hpl30=;
        b=j8MXR32ZLLtu7v7B3KAb4Fo9NfVkh/HfYO5j05204OpSurL1Vp5FqhqmzVTuCYVMJI
         IhdxLBuOtkpLJgpA7vmWjm7ud7cQBXf0FDlCRXACqAxPz53GkQZxwgUyL453PIG5Att1
         riLBx8ogxbznsqvjYQm/8uv9qry3hCFHj9/fuQdybaYaNOkCJTdTt4CPCH25/99aVEmp
         pTAbYqhGyCD6K+ZH2R6Uv469vnWEdZebtf1bUdv8znrDIr4vSMwIwg7zmmRVpo0NpB0D
         4uirv6z+37+6kBTIXwxgV2++jSSkmZgyvYW1Q6uZrFKA+TpPXJ1riV47utfrb0ErBIpm
         AN9A==
Received: by 10.14.29.2 with SMTP id h2mr2687373eea.5.1335482742855;
        Thu, 26 Apr 2012 16:25:42 -0700 (PDT)
Received: by 10.14.29.2 with SMTP id h2mr2687343eea.5.1335482742721;
        Thu, 26 Apr 2012 16:25:42 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id s9si4217229eei.3.2012.04.26.16.25.42
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 26 Apr 2012 16:25:42 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id 8180C5C0050;
	Thu, 26 Apr 2012 16:25:42 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id CB087E125C; Thu, 26 Apr 2012 16:25:41 -0700 (PDT)
In-Reply-To: <1335479227-7877-9-git-send-email-mhagger@alum.mit.edu>
	(mhagger@alum.mit.edu's message of "Fri, 27 Apr 2012 00:26:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQkDzZKQoZktVjALuUZlED5ibQT6f94PqCj3DtOeLzRr6xVtKQRSNlyuELq4AEPSH4zV0ju9D4wROXFOEX+Hq8ViQfdDDxlsdR2Egf3rmXfbge2J6jsRCxHkdosyUg6C+xKuRZqMnT7tGdJ3SpF5ANJt/iPBshpWn3CtSxgzy97kSI1yMqE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196444>

mhagger@alum.mit.edu writes:

> From: Michael Haggerty <mhagger@alum.mit.edu>
>
> This simplifies the bookkeeping and allows an (artificial) restriction
> on refname component length to be removed.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c |   45 +++++++++++++++++++++++----------------------
>  1 file changed, 23 insertions(+), 22 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 1d25151..f43c255 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2248,44 +2248,45 @@ static int do_for_each_reflog(const char *base, each_ref_fn fn, void *cb_data)
>  	int retval = 0;
>  	struct dirent *de;
>  	int baselen;
> -	char *log;
> +	struct strbuf log;
>  
>  	if (!d)
>  		return *base ? errno : 0;
>  
>  	baselen = strlen(base);
> -	log = xmalloc(baselen + 257);
> -	memcpy(log, base, baselen);
> -	if (baselen && base[baselen-1] != '/')
> -		log[baselen++] = '/';
> +	strbuf_init(&log, baselen + 257);
> +	strbuf_add(&log, base, baselen);
> +	if (log.len && log.buf[log.len-1] != '/') {
> +		strbuf_addch(&log, '/');
> +		baselen++;
> +	}
>  
>  	while ((de = readdir(d)) != NULL) {
>  		struct stat st;
> -		int namelen;
>  
>  		if (de->d_name[0] == '.')
>  			continue;
> -		namelen = strlen(de->d_name);
> -		if (namelen > 255)
> -			continue;
>  		if (has_extension(de->d_name, ".lock"))
>  			continue;
> -		memcpy(log + baselen, de->d_name, namelen+1);
> -		if (stat(git_path("logs/%s", log), &st) < 0)
> -			continue;
> -		if (S_ISDIR(st.st_mode)) {
> -			retval = do_for_each_reflog(log, fn, cb_data);
> +		strbuf_addstr(&log, de->d_name);
> +		if (stat(git_path("logs/%s", log.buf), &st) < 0) {
> +			/* Silently ignore. */
>  		} else {

Please write this like this:

		if (...) {
			; /* silently ignore */
		}

to make the "emptyness" stand out (I amended the previous round when I
queued them to 'pu', but I forgot to point it out in my review message).
