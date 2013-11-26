From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Prevent buffer overflows when path is too long
Date: Tue, 26 Nov 2013 11:50:36 -0800
Message-ID: <xmqqwqjvuelv.fsf@gitster.dls.corp.google.com>
References: <CACsJy8AooiUNRfnqDLBmx=KPnztjdNuF4bYY2b=Egs3gdiW6KA@mail.gmail.com>
	<1385491163-18407-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org,  Torsten =?utf-8?Q?B=C3=B6gershausen?=
 <tboegi@web.de>,  Wataru Noguchi <wnoguchi.0727@gmail.com>,  Erik
 Faye-Lund <kusmabite@gmail.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  =?utf-8?Q?Ren=C3=A9?= Scharfe
 <l.s.r@web.de>,  msysGit <msysgit@googlegroups.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRBEXX2OKAKGQERYWIO2Q@googlegroups.com Tue Nov 26 20:50:48 2013
Return-path: <msysgit+bncBCG77UMM3EJRBEXX2OKAKGQERYWIO2Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vb0-f55.google.com ([209.85.212.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBEXX2OKAKGQERYWIO2Q@googlegroups.com>)
	id 1VlOeh-0000M2-Dj
	for gcvm-msysgit@m.gmane.org; Tue, 26 Nov 2013 20:50:43 +0100
Received: by mail-vb0-f55.google.com with SMTP id 11sf1637702vbe.20
        for <gcvm-msysgit@m.gmane.org>; Tue, 26 Nov 2013 11:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=jCIGLquJkjY9NYZU/bmqhej1YjiYAExadrZffIA0Bbo=;
        b=DrbM15PwcSzgxJnL2eJedDLmjZSPsE9lwJmPnQgCya8WGIOktvFXGU9dZ1RBtM1Le3
         r6G/GcM4Cc9XWYKFceyMu1C/VD+kq/t0fJUwGTZT8dDd8Qmpz7NQMe74z8DWserla4Rq
         720jklfitGuxy5J3xaES/RjRqXqYJy5uslixX0gET1kKmOIf7m2Dm3RgQcjAVok0AhoM
         3BJNYW0BEzFjZ/uSg3bZ5PD1CsXvRHkxcL+SZlJVEJBlniPXX/X40ed/29GNq7Xp6A0e
         Ah8xp77gPFOPg2m4xo9iXnw/d44OKoxcMae0/9xzMVsVwyM/THkDy3umEWNiWaopaftg
         YFRw==
X-Received: by 10.49.128.73 with SMTP id nm9mr61611qeb.37.1385495442603;
        Tue, 26 Nov 2013 11:50:42 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.128.41 with SMTP id nl9ls2789995qeb.56.gmail; Tue, 26 Nov
 2013 11:50:41 -0800 (PST)
X-Received: by 10.58.198.116 with SMTP id jb20mr11163589vec.4.1385495441777;
        Tue, 26 Nov 2013 11:50:41 -0800 (PST)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id ll7si7849779vdb.0.2013.11.26.11.50.41
        for <msysgit@googlegroups.com>;
        Tue, 26 Nov 2013 11:50:41 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of jch@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BE5854E66;
	Tue, 26 Nov 2013 14:50:41 -0500 (EST)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F43454E65;
	Tue, 26 Nov 2013 14:50:41 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 31A2454E63;
	Tue, 26 Nov 2013 14:50:40 -0500 (EST)
In-Reply-To: <1385491163-18407-1-git-send-email-apelisse@gmail.com> (Antoine
	Pelisse's message of "Tue, 26 Nov 2013 19:39:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 07110FA0-56D4-11E3-8257-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: best guess record for domain of jch@b-sasl-quonix.pobox.com
 designates 208.72.237.35 as permitted sender) smtp.mail=jch@b-sasl-quonix.pobox.com;
       dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238391>

Antoine Pelisse <apelisse@gmail.com> writes:

> Some buffers created with PATH_MAX length are not checked when being
> written, and can overflow if PATH_MAX is not big enough to hold the
> path.

Perhaps it is time to update all of them to use strbuf?  The callers
of prefix_filename() aren't that many, and all of them are prepared
to stash the returned value away when they keep it longer term, so
they would not notice if we used "static struct strbuf path" and
gave back "path.buf" (without strbuf_detach() on it).  The buffer
used in clear_ce_flags() and passed to clear_ce_flags_{1,dir} are
not seen outside the callchain, and can safely become strbuf, I
think.

>  abspath.c        | 10 ++++++++--
>  diffcore-order.c | 14 +++++++++-----
>  unpack-trees.c   |  2 ++
>  3 files changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/abspath.c b/abspath.c
> index e390994..29a5f9d 100644
> --- a/abspath.c
> +++ b/abspath.c
> @@ -216,11 +216,16 @@ const char *absolute_path(const char *path)
>  const char *prefix_filename(const char *pfx, int pfx_len, const char *arg)
>  {
>  	static char path[PATH_MAX];
> +
> +	if (pfx_len >= PATH_MAX)
> +		die("Too long prefix path: %s", pfx);

I do not think this is needed, and will reject a valid input that
used to be accepted (e.g. arg is absolute so pfx does not matter).

>  #ifndef GIT_WINDOWS_NATIVE
>  	if (!pfx_len || is_absolute_path(arg))
>  		return arg;
>  	memcpy(path, pfx, pfx_len);
> -	strcpy(path + pfx_len, arg);
> +	if (strlcpy(path + pfx_len, arg, PATH_MAX - pfx_len) > PATH_MAX)
> +		die("Too long path: %s", path);

Rather, have that "too long a prefix?" check before that memcpy().

>  #else
>  	char *p;
>  	/* don't add prefix to absolute paths, but still replace '\' by '/' */
> @@ -228,7 +233,8 @@ const char *prefix_filename(const char *pfx, int pfx_len, const char *arg)
>  		pfx_len = 0;
>  	else if (pfx_len)
>  		memcpy(path, pfx, pfx_len);

... and around here.

> -	strcpy(path + pfx_len, arg);
> +	if (strlcpy(path + pfx_len, arg, PATH_MAX - pfx_len) > PATH_MAX)
> +		die("Too long path: %s", path);
>  	for (p = path + pfx_len; *p; p++)
>  		if (*p == '\\')
>  			*p = '/';

The above is curious. Unless we are doing the short-cut for "no
prefix so we can just return arg" codepath, we know that the
resulting length is always pfx_len + strlen(arg), no?

> diff --git a/diffcore-order.c b/diffcore-order.c
> index 23e9385..87193f8 100644
> --- a/diffcore-order.c
> +++ b/diffcore-order.c
> @@ -73,20 +73,24 @@ struct pair_order {
>  static int match_order(const char *path)
>  {
>  	int i;
> -	char p[PATH_MAX];
> +	struct strbuf p = STRBUF_INIT;
>  
>  	for (i = 0; i < order_cnt; i++) {
> -		strcpy(p, path);
> -		while (p[0]) {
> +		strbuf_reset(&p);
> +		strbuf_addstr(&p, path);
> +		while (p.buf[0]) {
>  			char *cp;
> -			if (!fnmatch(order[i], p, 0))
> +			if (!fnmatch(order[i], p.buf, 0)) {
> +				strbuf_release(&p);
>  				return i;
> -			cp = strrchr(p, '/');
> +			}
> +			cp = strrchr(p.buf, '/');
>  			if (!cp)
>  				break;
>  			*cp = 0;
>  		}
>  	}
> +	strbuf_release(&p);
>  	return order_cnt;
>  }
>  
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 35cb05e..f93565b 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -918,6 +918,8 @@ static int clear_ce_flags_1(struct cache_entry **cache, int nr,
>  			int processed;
>  
>  			len = slash - name;
> +			if (len + prefix_len >= PATH_MAX)
> +				die("Too long path: %s", prefix);
>  			memcpy(prefix + prefix_len, name, len);
>  
>  			/*
> -- 
> 1.8.5.rc3.1.ga0b6b91
>
> -- 

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
