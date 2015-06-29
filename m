From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v4 01/44] wrapper: implement xopen()
Date: Mon, 29 Jun 2015 06:48:16 +0200
Message-ID: <5590CE10.3020104@web.de>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com> <1435500366-31700-2-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 29 06:48:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9Qzg-0004Y9-Vg
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 06:48:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752787AbbF2Es2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Jun 2015 00:48:28 -0400
Received: from mout.web.de ([212.227.17.11]:60281 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751376AbbF2Es0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 00:48:26 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MSrgv-1ZbAck0w69-00RmNb; Mon, 29 Jun 2015 06:48:23
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <1435500366-31700-2-git-send-email-pyokagan@gmail.com>
X-Provags-ID: V03:K0:c1j21jfPiOX5DOFbrkNpkPu7oLlq8yeV0EXJyFVFi+eljtWAtP6
 6GMZIfhhkW9YDTGuvaBN4R3Fobhq1OncMlS2wTY5e68PpKoLY+YG9HlWz7r88B4SbFSZbgk
 Dq+gFk6ag4PQz5YNs8eWO4GKjVLkruwqCDl8ificL3wEUl+rGPQn0VsiuEVBPplIshbs/gC
 kWV45siF5BbGwIV90Oakg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9JKIvKHdnsQ=:q3fqBLoWsYSI/27PsvX/Bs
 MAUMKgGzdqfwj9Vw91tObPsxEnQYr6rSm9O/Pcve8em9fXggd+CDvp2SqS4CXeWv7AJvW5B7t
 s78Je4nwIki4mVMJyEqRuiiuQDbaJNqcc5j1+QLqf0oBKbNeWucUEQsqQurT4NSGPIOKW5mdw
 vQ67qElq4VDrYcSIKCnC5pVfpNnkidTZtYPh5hY/we/+MsTiRYhm5XptWd+3izuw+oItRNvb1
 yF/sYSyTyPdXTD/MoZXu6DOhMj4WN8EymFChP/1b6IDnGG2roLuffiAF9ZEtgZW6F1cCcTOEW
 5lzO9AItcFT0uV2BK/FRQx7oVnSEo+/+xEIjDS2iX4PWwzjjCNiVSZ1iaTrUuOeDAAHVvZihb
 p4wC5md/kVij+7vq+Xfd+QITVb0+4sMH7szVXiSu/7yPUBvhs62xL+iBPrPf/0UzIOPzGpjO/
 uxyW6C1/Mvk7phAhNt31zDgbXt4GKWm5/n9E+FxuhfH9z/pCnjTlJ64kFr5GCSWR8XX8Hjt7p
 DVzM0ur8bpZhv0ZNQ17a75kFQ4GDbvh9cHQ4BNUEKZbO0C6MhNTvm4Mik+jIr+1PE5gesxWEq
 rNPlRQ3z1SdNup3eOVI/2XI1M9C+4RZXaB5s/8OOFfLjDhuj++48hkSPuOzCwxRvIxT2/c4yk
 OThtW6rOG/3fSnSZMqCOkkyWsfl5rr6wUTD1USXB0i6l/vC1OsJyuwn73u+KraXjf1mM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272934>

On 06/28/2015 04:05 PM, Paul Tan wrote:
> A common usage pattern of open() is to check if it was successful, an=
d
> die() if it was not:
>
> 	int fd =3D open(path, O_WRONLY | O_CREAT, 0777);
> 	if (fd < 0)
> 		die_errno(_("Could not open '%s' for writing."), path);
>
> Implement a wrapper function xopen() that does the above so that we c=
an
> save a few lines of code, and make the die() messages consistent.
>
> Helped-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>   git-compat-util.h |  1 +
>   wrapper.c         | 25 +++++++++++++++++++++++++
>   2 files changed, 26 insertions(+)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index c6d391f..e168dfd 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -717,6 +717,7 @@ extern void *xrealloc(void *ptr, size_t size);
>   extern void *xcalloc(size_t nmemb, size_t size);
>   extern void *xmmap(void *start, size_t length, int prot, int flags,=
 int fd, off_t offset);
>   extern void *xmmap_gently(void *start, size_t length, int prot, int=
 flags, int fd, off_t offset);
> +extern int xopen(const char *path, int flags, ...);
>   extern ssize_t xread(int fd, void *buf, size_t len);
>   extern ssize_t xwrite(int fd, const void *buf, size_t len);
>   extern ssize_t xpread(int fd, void *buf, size_t len, off_t offset);
> diff --git a/wrapper.c b/wrapper.c
> index ff49807..7e13ae0 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -189,6 +189,31 @@ void *xcalloc(size_t nmemb, size_t size)
>   # endif
>   #endif
>  =20
> +/**
> + * xopen() is the same as open(), but it die()s if the open() fails.
> + */
> +int xopen(const char *path, int oflag, ...)
> +{
> +	mode_t mode =3D 0;
> +	va_list ap;
> +
> +	va_start(ap, oflag);
> +	if (oflag & O_CREAT)
> +		mode =3D va_arg(ap, mode_t);
> +	va_end(ap);
> +
> +	assert(path);
> +
2 remarks:
- I don't know if and why we need the assert() here (but don't know if=20
we have a strategie in Git for assert())
- Having xopen() with 2 or 3 parameter is good, but the current may nee=
d=20
some tweaks for better portability:

int xopen(const char *path, int oflag, ...)
{
	mode_t mode =3D 0;
	if (oflag & O_CREAT) {
		va_list ap;
		va_start(ap, oflag);
		mode =3D va_arg(ap, int);
		va_end(ap);

             }

See e.g.
<http://blitiri.com.ar/git/r/libfiu/c/37f6a98110e3bb59bbb4971241baa3a38=
5c3f724/>
why va_arg(ap, int) should be used:


+
+		/* va_arg() can only take fully promoted types, and mode_t
+		 * sometimes is smaller than an int, so we should always pass
+		 * int to it, and not mode_t. Not doing so would may result in
+		 * a compile-time warning and run-time error. We asume that it
+		 * is never bigger than an int, which holds in practise. */
+		mode =3D va_arg(l, int);
+
