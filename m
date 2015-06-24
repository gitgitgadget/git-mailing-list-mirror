From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH/WIP v3 01/31] wrapper: implement xopen()
Date: Wed, 24 Jun 2015 09:59:26 -0700
Message-ID: <CAGZ79kYtF+rHozVQhNz8uguLZvArPiB2UdkPTFn=Vc+YCsA=UQ@mail.gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
	<1434626743-8552-2-git-send-email-pyokagan@gmail.com>
	<ed4f6565ed610a337244e06cc15b41bb@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Tan <pyokagan@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 24 18:59:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7o1M-0006fe-LA
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 18:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922AbbFXQ73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 12:59:29 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:36637 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbbFXQ71 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 12:59:27 -0400
Received: by ykdr198 with SMTP id r198so27132779ykd.3
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 09:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zdx1ufn4ab1Ofae0s8E7PYzVJ47Pwj+MG/dkFjF0oug=;
        b=ZGoXk2IS0bKXb0fskC7Q4XL369OlUGYmJdIAaYyvpHj9m13p27YJAsI3bCzHgtQ/ET
         kK9o+8NnJ+nq10tp5P7sJwNyW5F0Vq2qmEBT0ph3zwuCExSMSGnjTDRejEKwG7jVTpL+
         rmn/65L+gLKUHw0lj/0Rksj+vLLgEQY3e7/auTwVmNXsoVe3IOZlgxjSiQUFCnxPQlkf
         m9D5iBGQk7zMSoRa8CAldXSkg0CHQfidXIm2w5nJbYU1vsVSSSkayliIhkJYhnDbH5io
         SiZa0BwvNmm5BfJ4Q38PCChSv8dSTvYeTlQNAlSPDwXrIi5intscJ9m+6JDFLvtvMsrG
         bNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=zdx1ufn4ab1Ofae0s8E7PYzVJ47Pwj+MG/dkFjF0oug=;
        b=VWjaEgYxyNE88WBhTbJH38eE1NI0k3wKN0knQ1HnBsUWZPXzjv8W2PIqtwP+FqBS6n
         u27yE3NGWJcNBg64qLuokpjuaufYuTGIGez+jv7/d4HYLAcrloKbnbdBPAwdRzC7IXGU
         FIKyXQuRKu4bGlIC9umEDlGOYS507pxbN6A/Uod+xwHLQY37ku1wXe5lR+kdXg2NsOR7
         TKBYqBmkavgUKecZCcWtJY7E7ifkhYh9u84zMvaSpMe0ScYDeG88ekrAp27MdSRq9xMK
         D7rfzY2RXYSQPin4f0GgW3MHvkFGLKZGpEUvpO911vo52HvLy8kUsGcarjJFnLdAGrSY
         ORSw==
X-Gm-Message-State: ALoCoQnm9Yy8n7xVgfdWEMle1MGuqwP/dATqSi1Hh3wxS4C5t4cwE8z4lV9sbdJqk/6QhDBr4DtW
X-Received: by 10.170.56.83 with SMTP id 80mr45570985yky.16.1435165166425;
 Wed, 24 Jun 2015 09:59:26 -0700 (PDT)
Received: by 10.37.26.213 with HTTP; Wed, 24 Jun 2015 09:59:26 -0700 (PDT)
In-Reply-To: <ed4f6565ed610a337244e06cc15b41bb@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272565>

On Wed, Jun 24, 2015 at 9:28 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Hi Paul,
>
> On 2015-06-18 13:25, Paul Tan wrote:
>
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index 0cc7ae8..bc77d77 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -719,6 +719,7 @@ extern void *xrealloc(void *ptr, size_t size);
>>  extern void *xcalloc(size_t nmemb, size_t size);
>>  extern void *xmmap(void *start, size_t length, int prot, int flags,
>> int fd, off_t offset);
>>  extern void *xmmap_gently(void *start, size_t length, int prot, int
>> flags, int fd, off_t offset);
>> +extern int xopen(const char *path, int flags, ...);
>
> I wonder whether it is worth it to make this a varargs function. It is not too much to ask callers to specify a specific mode everytime they call `xopen()`, no?
>
>> diff --git a/wrapper.c b/wrapper.c
>> index c1a663f..82658b3 100644
>> --- a/wrapper.c
>> +++ b/wrapper.c
>> @@ -189,6 +189,31 @@ void *xcalloc(size_t nmemb, size_t size)
>>  # endif
>>  #endif
>>
>> +/**
>> + * xopen() is the same as open(), but it die()s if the open() fails.
>> + */
>> +int xopen(const char *path, int oflag, ...)
>> +{
>> +     mode_t mode = 0;
>> +     va_list ap;
>> +
>> +     va_start(ap, oflag);
>> +     if (oflag & O_CREAT)
>> +             mode = va_arg(ap, mode_t);
>> +     va_end(ap);
>> +
>> +     assert(path);
>> +
>> +     for (;;) {
>> +             int fd = open(path, oflag, mode);
>> +             if (fd >= 0)
>> +                     return fd;
>> +             if (errno == EINTR)
>> +                     continue;
>> +             die_errno(_("could not open '%s'"), path);
>
> It is often helpful to know whether a path was opened for reading or writing, so maybe we should have something like
>
> if (oflag & O_WRITE)
>     die_errno(_("could not open '%s' for writing"), path);
> else if (oflag & O_READ)
>     die_errno(_("could not open '%s' for reading"), path);
> else
>     die_errno(_("could not open '%s'"), path);
>
> ? I know it is a bit of duplication, but I fear we cannot get around that without breaking i18n support.

This distinction was part of earlier series, but Torsten Boegershausen
suggested to leave
it out. [compare
http://thread.gmane.org/gmane.comp.version-control.git/270048/focus=270049]

>
> Ciao,
> Dscho
>
>
