From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH/WIP 1/8] wrapper: implement xopen()
Date: Wed, 27 May 2015 21:03:47 +0200
Message-ID: <55661513.8000306@web.de>
References: <1432733618-25629-1-git-send-email-pyokagan@gmail.com> <1432733618-25629-2-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 21:04:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxgcY-00013b-TT
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 21:04:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091AbbE0TEA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 15:04:00 -0400
Received: from mout.web.de ([212.227.15.14]:62769 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752268AbbE0TD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 15:03:58 -0400
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0LmxtE-1ZcVbq0lSO-00h2Nf; Wed, 27 May 2015 21:03:54
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <1432733618-25629-2-git-send-email-pyokagan@gmail.com>
X-Provags-ID: V03:K0:CFlq/319w763/cM+OzJ+bRJOmdl9/SUAxa25orgczrkpNsJ7LuC
 kFG/WrisCqOHHOdjhTK4GboPFQT/PKf1d/rLQNjz0ZU0+kacFX7skmLvnRFVrFcOv4G/TzT
 MA+9YbiggkMvnFsY2pa3CPv8TUM0HaaceI1NKuwx8cVUJKw7SaBjlFFffKehO/irBEfKB9+
 7kZ/gAffppy0wDOn7qmvw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:y2R/fnIqJSE=:0vmTtEMLQZ25oAFIEwe/LI
 16AN2jMU6Krz9RjgwPt+T1Zixw8RIHenJf3h22NUqa50AwpSwBBLBxu3sfWvFPZLYY71qBQAN
 yxfJj/O3r551ikOasM7SHA74mP1vW81EwqAaWYFeQXNQZ34Oc04PxpXvqmohFMy1MZElAamXV
 Hn9kKgv9wRNYgamF+rg6Wef5fktT8RQ6YcI1uoz8ssOQfILI1CrwYVuAlcw9oNtyXTEw+Q4hE
 sUDaLTU7j0GJpbOgGex9tGi4/4uQw+UDDYno8Zb+4tavODxqW+thsEWuGiNJzVwRhUs1giP4e
 BqiCm0ps/yc86VpKZy046b4W9YtRHJorK7LQIoXo52NaUx3JjW4f2UFmFpjPwgyE8FNlU4pVs
 WJmTJQfUhzKTrddpHibOlhelPMjea85IqoOudtYiy1/cZ+x7IJ7TZY7iUs5inWp7u/7uz9h1K
 BpUqdTSoRt/FrpUBAQlOg2d6JKyf0XnQVa1esbuJck7IgfG8+BGcn3bDp2bqGcfwmJN/0FTK0
 0HlyYu7idtVgXiWHJAU5ZXcQQlO4wbaj6TwASZJx4Zx+iR/XIvRHUA4JZSPswKMcej5VAI8be
 Q7GyKhqFZhddyU93LLlwPdOfZ+KRPA4x7fLof9kwDxTxH3GN3aLsQPvCwXRZwKHGcTh2auFZw
 iT18JG+FzxVh4lNI0iQBnWFpFaHUc7Advwgc8Dio++65LFCmpjAlaGB97O2xWFq7ELhk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270065>

On 2015-05-27 15.33, Paul Tan wrote:
> A common usage pattern of open() is to check if it was successful, and
> die() if it was not:
> 
> 	int fd = open(path, O_WRONLY | O_CREAT, 0777);
> 	if (fd < 0)
> 		die_errno(_("Could not open '%s' for writing."), path);
> 
> Implement a wrapper function xopen() that does the above so that we can
> save a few lines of code, and make the die() messages consistent.
> 
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>  git-compat-util.h |  1 +
>  wrapper.c         | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 17584ad..9745962 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -718,6 +718,7 @@ extern char *xstrndup(const char *str, size_t len);
>  extern void *xrealloc(void *ptr, size_t size);
>  extern void *xcalloc(size_t nmemb, size_t size);
>  extern void *xmmap(void *start, size_t length, int prot, int flags, int fd, off_t offset);
> +extern int xopen(const char *path, int flags, mode_t mode);
>  extern ssize_t xread(int fd, void *buf, size_t len);
>  extern ssize_t xwrite(int fd, const void *buf, size_t len);
>  extern ssize_t xpread(int fd, void *buf, size_t len, off_t offset);
> diff --git a/wrapper.c b/wrapper.c
> index c1a663f..971665a 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -189,6 +189,24 @@ void *xcalloc(size_t nmemb, size_t size)
>  # endif
>  #endif
>  
The original open can take 2 or 3 parameters, how about this:
int xopen(const char *path, int oflag, ... )
{
        va_list params;
        int mode;
        int fd;

        va_start(params, oflag);
        mode = va_arg(params, int);
        va_end(params);

        fd = open(path, oflag, mode);


> +/**
> + * xopen() is the same as open(), but it die()s if the open() fails.
> + */
> +int xopen(const char *path, int flags, mode_t mode)
> +{
> +	int fd;
> +
> +	assert(path);
> +	fd = open(path, flags, mode);
> +	if (fd < 0) {
> +		if ((flags & O_WRONLY) || (flags & O_RDWR))
> +			die_errno(_("could not open '%s' for writing"), path);
This is only partly true:
it could be either "writing" or "read write".
I don't know if the info "for reading" or "for writing" is needed/helpful at all,
or if a simple "could not open" would be enough.


Another thing:
should we handle EINTR ?
(Somewhere in the back of my head I remember that some OS
 returned EINTR when handling some foreign file system
 Mac OS / NTFS ?)
