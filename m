From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH/WIP v3 01/31] wrapper: implement xopen()
Date: Wed, 24 Jun 2015 18:28:48 +0200
Organization: gmx
Message-ID: <ed4f6565ed610a337244e06cc15b41bb@www.dscho.org>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
 <1434626743-8552-2-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 18:31:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7nZn-0000XY-94
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 18:31:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754064AbbFXQ25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 12:28:57 -0400
Received: from mout.gmx.net ([212.227.17.20]:64784 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753199AbbFXQ2x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 12:28:53 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LorB9-1YaMPK27R5-00glsB; Wed, 24 Jun 2015 18:28:49
 +0200
In-Reply-To: <1434626743-8552-2-git-send-email-pyokagan@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:Uc85bq9Fwvw0lLjUWdyip9C3Dv1Qpx59aL9lbkxFfboKARitL6g
 aG3+CCbxzG3ERWqv/BrEiHpIkwvZeC6g1W6iwJEnTk63h4jbPnn6SR5XvHWjKi0ZAZPIPoQ
 Mx7RCWHOfwDJ7IKfAAiYtPY0NFfMl9b7NOQd92HkO40gdJ0abEpHS6/Z35hdjX5p7dRXhmx
 HK9Lp209BUW1b6Wjes6/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xbtXZwRkkaE=:sKQZjl7HF6ozcdQYl/ocf+
 TuYtzYT+qoHx8DMoth2e6ULpFgiW+7SY6QOW6LcXhhpUVusVIvUaW+0Zwmd38swWJQ/tN5YiT
 NyjjU8r6HO798/AEHB79U5qNF1m3z9ceZ5da7FVzYsH3iM971ZdGRsPS28iB0fh/gtl8Yd6U2
 kgPO1YCezV/EcsA6YbIH+wxYcVaiRSIvuIHXt38zD/1JdAjksD6l2gkso58x2unVEmnYsPFma
 HWSe4Juztzb/afOwqG6zg1QV8ChiAzvqMqypi/wFXw2JxC45FhTod7lAjmoAIgFbrNmAO/o/r
 17+ytweWmuxUhJ0j1+unSQfVdLBHc/HZYNUDI1EkmJtIWBMAs5/asmz+GsIiWa5GYQrc8LbaD
 n3E0r3A8Ky/roiAaMBeLIkWqs/4VExxzxcWRqVeMU6kIYAMtgO0HoWodacdW5xGuiukri7KLS
 qlYva01UlDFB5X6v2L4lR0cXuF8seEYJVs1lgudqrJZVu1x4AMLvaY1LwbtYX9xwKWaZ107Ty
 qkg278XWhNtv7ST0xhWNlhzW1h7MFMLT9AIEW5iZQNyCjUppvY3qUsrSgSEADjokTEG/RAJ9J
 ONmxnD0+6ZaruV0z1g2EDeiI/M+Du0GwimIskfdGcpTF/rMWguElT+IVJ3HZy1/ZtFSovi/R1
 PfTVlMcD2Z9vV6INWBi5DJw1tbTa3n/n9YDf5DuDkUHodZGEhQEZypBNE6VcEWMh+bJA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272563>

Hi Paul,

On 2015-06-18 13:25, Paul Tan wrote:

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 0cc7ae8..bc77d77 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -719,6 +719,7 @@ extern void *xrealloc(void *ptr, size_t size);
>  extern void *xcalloc(size_t nmemb, size_t size);
>  extern void *xmmap(void *start, size_t length, int prot, int flags,
> int fd, off_t offset);
>  extern void *xmmap_gently(void *start, size_t length, int prot, int
> flags, int fd, off_t offset);
> +extern int xopen(const char *path, int flags, ...);

I wonder whether it is worth it to make this a varargs function. It is not too much to ask callers to specify a specific mode everytime they call `xopen()`, no?

> diff --git a/wrapper.c b/wrapper.c
> index c1a663f..82658b3 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -189,6 +189,31 @@ void *xcalloc(size_t nmemb, size_t size)
>  # endif
>  #endif
>  
> +/**
> + * xopen() is the same as open(), but it die()s if the open() fails.
> + */
> +int xopen(const char *path, int oflag, ...)
> +{
> +	mode_t mode = 0;
> +	va_list ap;
> +
> +	va_start(ap, oflag);
> +	if (oflag & O_CREAT)
> +		mode = va_arg(ap, mode_t);
> +	va_end(ap);
> +
> +	assert(path);
> +
> +	for (;;) {
> +		int fd = open(path, oflag, mode);
> +		if (fd >= 0)
> +			return fd;
> +		if (errno == EINTR)
> +			continue;
> +		die_errno(_("could not open '%s'"), path);

It is often helpful to know whether a path was opened for reading or writing, so maybe we should have something like

if (oflag & O_WRITE)
    die_errno(_("could not open '%s' for writing"), path);
else if (oflag & O_READ)
    die_errno(_("could not open '%s' for reading"), path);
else
    die_errno(_("could not open '%s'"), path);

? I know it is a bit of duplication, but I fear we cannot get around that without breaking i18n support.

Ciao,
Dscho
