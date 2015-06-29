From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 01/44] wrapper: implement xopen()
Date: Sun, 28 Jun 2015 22:04:02 -0700
Message-ID: <CAGZ79kYYGpB6wGO6r67P0NLP9fda_UjZtLfwqmrWZrCKOYqZWQ@mail.gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
	<1435500366-31700-2-git-send-email-pyokagan@gmail.com>
	<5590CE10.3020104@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Tan <pyokagan@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 29 07:04:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9REm-0002n6-MA
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 07:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753022AbbF2FEE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Jun 2015 01:04:04 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:32768 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbbF2FED convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Jun 2015 01:04:03 -0400
Received: by ykdt186 with SMTP id t186so105448026ykd.0
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 22:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Bw8e3uF28/cdEdxvCMCdA0bblEbgDS1BAPEf0+obtYU=;
        b=cidf1XYUleP4EP/ewKUaYkn69/8f9prhjo5rXM8aEG+8dfe1+F1MJgOAGmiz+unWkf
         4uZmRBNFGK2C0nhcXXh3ZKWQE2itvNsp22ttusX4KERvO4ECwnptf0FEvpaQFiMoBJRf
         bOCDer5P/WvYLAlmaMo/eQhG2kQrnZiLpCRJ5uLVTEpfj0yrgZba0+b5Ya/juUXqFWiF
         k+g4/m201StQvUft4XdI2lOiNphf+q2AuvMaJvugppGkTmYPYxPWQ/dqYOBr6C/xFA4K
         /deRzUn4dSnvLk55omD8dZvbzW7YMBrikjhCmeVkzx5l89/yjW87czvM9DaYZSnnACxH
         70XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Bw8e3uF28/cdEdxvCMCdA0bblEbgDS1BAPEf0+obtYU=;
        b=SEhR1rJwDtjK0iqf3pTPPSubwe2zHrbmok7jA6+/CAPcs9F9xRYgDmf3NcBRn+r9n2
         Y9QAUqqFlvl3hXvYbfI5FvynUCGwkXOOuvDvUvbe83f0imB2sIbU5aZWQirKUKeTZsUN
         Db30MJ4F6LG/EcvXUbR7Qt46UiRVu0f3KLeQ6riAiwCf9fKCHq+ehmJaF/LcWkdly00H
         +ENJKDTc2rjSnRea4vLeZnsrUIpYZNjyMDcKoGk42Gb4xw3K9qExPe3qvtD4gL4dZIof
         gexU+zGUNyJXgCzlYLdev7Nl/tVY78q0y/Mksy5KdWZng06xrevOrHB/kNqbgNRAI8+h
         h+fA==
X-Gm-Message-State: ALoCoQkSJVHtfmj+YQUJCQGg8bZeVtKugj09vX92F/CkMYjyTS6HtNqgzWC2Pl6TmAE2Q6fdhSHx
X-Received: by 10.13.238.71 with SMTP id x68mr17252758ywe.129.1435554242492;
 Sun, 28 Jun 2015 22:04:02 -0700 (PDT)
Received: by 10.37.4.80 with HTTP; Sun, 28 Jun 2015 22:04:02 -0700 (PDT)
In-Reply-To: <5590CE10.3020104@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272936>

On Sun, Jun 28, 2015 at 9:48 PM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> On 06/28/2015 04:05 PM, Paul Tan wrote:
>>
>> A common usage pattern of open() is to check if it was successful, a=
nd
>> die() if it was not:
>>
>>         int fd =3D open(path, O_WRONLY | O_CREAT, 0777);
>>         if (fd < 0)
>>                 die_errno(_("Could not open '%s' for writing."), pat=
h);
>>
>> Implement a wrapper function xopen() that does the above so that we =
can
>> save a few lines of code, and make the die() messages consistent.
>>
>> Helped-by: Torsten B=C3=B6gershausen <tboegi@web.de>
>> Helped-by: Jeff King <peff@peff.net>
>> Signed-off-by: Paul Tan <pyokagan@gmail.com>
>> ---
>>   git-compat-util.h |  1 +
>>   wrapper.c         | 25 +++++++++++++++++++++++++
>>   2 files changed, 26 insertions(+)
>>
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index c6d391f..e168dfd 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -717,6 +717,7 @@ extern void *xrealloc(void *ptr, size_t size);
>>   extern void *xcalloc(size_t nmemb, size_t size);
>>   extern void *xmmap(void *start, size_t length, int prot, int flags=
, int
>> fd, off_t offset);
>>   extern void *xmmap_gently(void *start, size_t length, int prot, in=
t
>> flags, int fd, off_t offset);
>> +extern int xopen(const char *path, int flags, ...);
>>   extern ssize_t xread(int fd, void *buf, size_t len);
>>   extern ssize_t xwrite(int fd, const void *buf, size_t len);
>>   extern ssize_t xpread(int fd, void *buf, size_t len, off_t offset)=
;
>> diff --git a/wrapper.c b/wrapper.c
>> index ff49807..7e13ae0 100644
>> --- a/wrapper.c
>> +++ b/wrapper.c
>> @@ -189,6 +189,31 @@ void *xcalloc(size_t nmemb, size_t size)
>>   # endif
>>   #endif
>>   +/**
>> + * xopen() is the same as open(), but it die()s if the open() fails=
=2E
>> + */
>> +int xopen(const char *path, int oflag, ...)
>> +{
>> +       mode_t mode =3D 0;
>> +       va_list ap;
>> +
>> +       va_start(ap, oflag);
>> +       if (oflag & O_CREAT)
>> +               mode =3D va_arg(ap, mode_t);
>> +       va_end(ap);
>> +
>> +       assert(path);
>> +
>
> 2 remarks:
> - I don't know if and why we need the assert() here (but don't know i=
f we
> have a strategie in Git for assert())

Yeah I think we usually do

    if (!assertion)
        die("BUG: assertion not met");

> - Having xopen() with 2 or 3 parameter is good, but the current may n=
eed
> some tweaks for better portability:
>
> int xopen(const char *path, int oflag, ...)
> {
>         mode_t mode =3D 0;
>         if (oflag & O_CREAT) {
>                 va_list ap;
>                 va_start(ap, oflag);
>                 mode =3D va_arg(ap, int);
>                 va_end(ap);
>
>             }
>
> See e.g.
> <http://blitiri.com.ar/git/r/libfiu/c/37f6a98110e3bb59bbb4971241baa3a=
385c3f724/>
> why va_arg(ap, int) should be used:
>
>
> +
> +               /* va_arg() can only take fully promoted types, and m=
ode_t
> +                * sometimes is smaller than an int, so we should alw=
ays
> pass
> +                * int to it, and not mode_t. Not doing so would may =
result
> in
> +                * a compile-time warning and run-time error. We asum=
e that
> it
> +                * is never bigger than an int, which holds in practi=
se. */
> +               mode =3D va_arg(l, int);
> +
>
>
