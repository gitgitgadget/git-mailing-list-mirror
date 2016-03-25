From: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
Subject: Re: [PATCH v3/GSoC 1/5] path.c: implement strbuf_mkpath()
Date: Fri, 25 Mar 2016 15:13:41 +0800
Message-ID: <CAKqreuzQgnL8G-UpXs_UOgPCOc1gVxxUgmVzY_LbpYpsB+pS4Q@mail.gmail.com>
References: <1458728005-22555-1-git-send-email-huiyiqun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Your friend <pickfire@riseup.net>,
	Hui Yiqun <huiyiqun@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 25 08:13:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajLwI-0000cR-LE
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 08:13:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072AbcCYHNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 03:13:42 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:32820 "EHLO
	mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993AbcCYHNm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 03:13:42 -0400
Received: by mail-oi0-f68.google.com with SMTP id i21so3810456oig.0
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 00:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=rQtAF7BgdZTbTjHx5JnJ6VFvBPC2lhJHsHJBf4s2ERc=;
        b=igbsQFXmfXqL6vFbX/BDZ+dibU1kFzM/h/jtXp1tsJSZxYgfpoEtw8/m1WeGd30r0G
         1M8u3ndfLIjzHfxSMcC38HcyVdQIB23K1zCjLLeOzv02QY8Il5emkbJYC5h6RreRwCZD
         6Ehkrl5VGo9f9yjU7FXH69y34PgWj2ScoSvf1i7AK5JOpOu0ktltLcVNTXDcz69tb/52
         btJ8p6RfuMY9zzWASfs54qnIyyKfbBc9J196MTw4PAFDlkpHibr3LDxM31Cr8XEkmd75
         3TzQ9K1i2XbHKyJDj5y5nTXlRBJsyOTlpvg5u/w4glLU/8Gyg7+EF877sHS6pDw/K6ZY
         u9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=rQtAF7BgdZTbTjHx5JnJ6VFvBPC2lhJHsHJBf4s2ERc=;
        b=kZ3r/B4s0Cs8yWoV+J8JJJugg+KNB8OwdSXVFQyslG5ccZqi89rN3AInYt1xizx2jR
         lE0i/ZbMMl3Ruc7BPS2hWTE75LSNC2z4hUvv2s+EN0AZv6Ij5+F6T7C38BjKxaiCpjJd
         coc61HO9HjLXb3niRd1vkprr8HJ2E+BCrOXpr2/um9G4xOLVGoCfyghj9w9mYRK/F1bR
         LjqgunkRlZUloFFgRybD9nUxsa1ybxZIXnjEkdtkZAg6MiKAd3nF1dikr1zNxSkmOhM5
         lY51U56PNrqrPa/15O6OiQwkp4FVKh47yNuebaeSBXEiuTXzGmYHL3Es35/aH2PkwTes
         P2rQ==
X-Gm-Message-State: AD7BkJKWBEGxqKkCniHAdBmEbSvoxwXlRa6mUGDmp2gV6Si6LEyPO4oDSFNoZzCJlq+OR08JSXjbsQq7XWngiA==
X-Received: by 10.157.44.66 with SMTP id f60mr5761124otb.163.1458890021164;
 Fri, 25 Mar 2016 00:13:41 -0700 (PDT)
Received: by 10.157.27.250 with HTTP; Fri, 25 Mar 2016 00:13:41 -0700 (PDT)
In-Reply-To: <1458728005-22555-1-git-send-email-huiyiqun@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289858>

So, are there some additional points I could improve?

2016-03-23 18:13 GMT+08:00 Hui Yiqun <huiyiqun@gmail.com>:
> There were already `mkpath`, `mkpathdup` and `mksnpath` for build
> filename, but lacked a version of `strbuf_` just like `strbuf_git_path`.
>
> It is convenient to build a path and manipulate the result later with
> strbuf.
>
> Signed-off-by: Hui Yiqun <huiyiqun@gmail.com>
> ---
>  cache.h |  2 ++
>  path.c  | 21 +++++++++++++++++----
>  2 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index b829410..ef843c1 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -781,6 +781,8 @@ extern char *git_pathdup(const char *fmt, ...)
>         __attribute__((format (printf, 1, 2)));
>  extern char *mkpathdup(const char *fmt, ...)
>         __attribute__((format (printf, 1, 2)));
> +extern void strbuf_mkpath(struct strbuf *sb, const char *fmt, ...)
> +       __attribute__((format (printf, 2, 3)));
>  extern char *git_pathdup_submodule(const char *path, const char *fmt, ...)
>         __attribute__((format (printf, 2, 3)));
>
> diff --git a/path.c b/path.c
> index 8b7e168..699af68 100644
> --- a/path.c
> +++ b/path.c
> @@ -433,14 +433,19 @@ char *git_pathdup(const char *fmt, ...)
>         return strbuf_detach(&path, NULL);
>  }
>
> +static void do_mkpath(struct strbuf *buf, const char *fmt, va_list args)
> +{
> +       strbuf_vaddf(buf, fmt, args);
> +       strbuf_cleanup_path(buf);
> +}
> +
>  char *mkpathdup(const char *fmt, ...)
>  {
>         struct strbuf sb = STRBUF_INIT;
>         va_list args;
>         va_start(args, fmt);
> -       strbuf_vaddf(&sb, fmt, args);
> +       do_mkpath(&sb, fmt, args);
>         va_end(args);
> -       strbuf_cleanup_path(&sb);
>         return strbuf_detach(&sb, NULL);
>  }
>
> @@ -449,9 +454,17 @@ const char *mkpath(const char *fmt, ...)
>         va_list args;
>         struct strbuf *pathname = get_pathname();
>         va_start(args, fmt);
> -       strbuf_vaddf(pathname, fmt, args);
> +       do_mkpath(pathname, fmt, args);
> +       va_end(args);
> +       return pathname->buf;
> +}
> +
> +void strbuf_mkpath(struct strbuf *buf, const char *fmt, ...)
> +{
> +       va_list args;
> +       va_start(args, fmt);
> +       do_mkpath(buf, fmt, args);
>         va_end(args);
> -       return cleanup_path(pathname->buf);
>  }
>
>  static void do_submodule_path(struct strbuf *buf, const char *path,
> --
> 2.7.4
>
