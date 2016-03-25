From: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
Subject: Re: [PATCH v3/GSoC 2/5] path.c: implement xdg_runtime_dir()
Date: Fri, 25 Mar 2016 22:21:48 +0800
Message-ID: <CAKqreux8FHdJoKDishjQkbi9g1oUc265EUK4nOJ_sgeFivGSNA@mail.gmail.com>
References: <1458728005-22555-1-git-send-email-huiyiqun@gmail.com>
	<1458728005-22555-2-git-send-email-huiyiqun@gmail.com>
	<20160325095923.GB8880@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Your friend <pickfire@riseup.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 25 15:29:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajScc-0008BU-Vo
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 15:21:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989AbcCYOVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 10:21:50 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34774 "EHLO
	mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683AbcCYOVt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 10:21:49 -0400
Received: by mail-oi0-f67.google.com with SMTP id f188so9020371oig.1
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 07:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=arHXTvB/dnkGC+bmE/U5rSos31OohRr8FiwSbfrKd9w=;
        b=EQGPFovhluVqiKhi3pTmQ79EyCJX2HoWYafIUNMxO7nRynjT15XIitxebiLFKK1Yeq
         T54BzZpKP1c0OaTUJQJMNIUVbVesYOBksDpAp2aIwF+8CnY6WHMTumVoM7mR7g5Qmm5U
         A5Pwgb7MBvHibC+wa6gJSwcl7nQBhDz0VfMW0MFDRaDe9BWPNUEVSGMthMUBM92w/SNa
         dGYRKJuxU6ggSLXFOUg9N13aYhkXocRRepxFFwV6cBexnOYoE19kKZFsmpvFElRq7G1n
         Jfx+M0S4Ikc7/yxoGV82vU8xccK7VgUSmgos2rYjjA9yuIbCbN25LEowMbRN3Ch7hxm3
         xT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=arHXTvB/dnkGC+bmE/U5rSos31OohRr8FiwSbfrKd9w=;
        b=jrPu68GNfM16PLyBDGQ+IjWWW4nTzqZk/OsCsBl00oxcmJ0DK7fbKg7MVW0T7F40UT
         YZSl5b2ygwNKReaSXTXkmpfpGkZ5V9El2EfE6xsJu7MU1f7k5auSdFk7GBDZRCex6dzJ
         52JTv+Q4Z2G99okHGhaNSLQJSYJaP1pxv+gLgLOvSf85kmupl2ouMKWnrNRaV6kvWnTe
         inmBsLRByw9SKASSi/kKLxinZ4jTW1nJpbzKn9mf3SjcDX1mg+OwZlHrpknD9cL2kZnL
         DBGgEKRTWjCFZwjvu806mkmTq0GBcr3sZ/BPiJj1iaRQL/a/nnEr+VapmOEkUXDBIZhN
         9A6A==
X-Gm-Message-State: AD7BkJJKp5KTMeNrGumYa5dMLAGRuq7BN1NyKJRBFkP2YiE5oDTteNaqdvptVa3F17Zco5JrMQj5VWE21bIqTQ==
X-Received: by 10.202.85.14 with SMTP id j14mr6575796oib.45.1458915708893;
 Fri, 25 Mar 2016 07:21:48 -0700 (PDT)
Received: by 10.157.27.250 with HTTP; Fri, 25 Mar 2016 07:21:48 -0700 (PDT)
In-Reply-To: <20160325095923.GB8880@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289889>

2016-03-25 17:59 GMT+08:00 Jeff King <peff@peff.net>:
> On Wed, Mar 23, 2016 at 06:13:22PM +0800, Hui Yiqun wrote:
>
>> +/**
>> + * this function does the following:
>> + *
>> + * 1. if $XDG_RUNTIME_DIR is non-empty, `$XDG_RUNTIME_DIR/git` is used in next
>> + * step, otherwise `/tmp/git-$uid` is taken.
>> + * 2. ensure that above directory does exist. what's more, it must has correct
>> + * permission and ownership.
>> + * 3. a newly allocated string consisting of the path of above directory and
>> + * $filename is returned.
>> + *
>> + * Under following situation, NULL will be returned:
>> + *
>> + * + the directory mentioned in step 1 exists but have wrong permission or
>> + * ownership.
>> + * + the directory or its parent cannot be created.
>> + *
>> + * Notice:
>> + *
>> + * + the caller is responsible for deallocating the returned string.
>> + *
>> + */
>> +extern char *xdg_runtime_dir(const char *filename);
>
> There's a lot of "what" here that the caller doesn't really care about,
> and which may go stale with respect to the implementation over time. Can
> we make something more succinct like:
>
>   /*
>    * Return a path suitable for writing run-time files related to git,
>    * or NULL if no such path can be established. The resulting string
>    * should be freed by the caller.
>    */
>
> ?

That's clearer, but if I were the caller, I would worry about the
security of the path.
How about adding:

The security of the path is ensured by file permission.

>
>> --- a/path.c
>> +++ b/path.c
>> @@ -5,6 +5,7 @@
>>  #include "strbuf.h"
>>  #include "string-list.h"
>>  #include "dir.h"
>> +#include "git-compat-util.h"
>
> Why do we need this? It should generally be the first file included, as
> it sets up defines used by other header files. It looks like we include
> "cache.h" in this file, which is enough (it explicitly includes
> git-compat-util.h first to cover this case).

I include this header for `getuid` and `stat`. Now that there is an indirect
including, I will delete this one.

>
>> +char *xdg_runtime_dir(const char *filename)
>> +{
>> +     struct strbuf sb = STRBUF_INIT;
>> +     char *runtime_dir;
>> +     struct stat st;
>> +     uid_t uid = getuid();
>> +
>> +     assert(filename);
>> +     runtime_dir = getenv("XDG_RUNTIME_DIR");
>> +     if (runtime_dir && *runtime_dir)
>> +             strbuf_mkpath(&sb, "%s/git/", runtime_dir);
>> +     else
>> +             strbuf_mkpath(&sb, "/tmp/git-%d", uid);
>> +
>> +     if (!lstat(sb.buf, &st)) {
>> +             /*
>> +              * As described in XDG base dir spec[1], the subdirectory
>> +              * under $XDG_RUNTIME_DIR or its fallback MUST be owned by
>> +              * the user, and its unix access mode MUST be 0700.
>> +              *
>> +              * Calling chmod or chown silently may cause security
>> +              * problem if somebody chdir to it, sleep, and then, try
>> +              * to open our protected runtime cache or socket.
>> +              * So we just put warning and left it to user to solve.
>> +              *
>
> There are some minor English problems here (and elsewhere). E.g., you
> probably want "So we just issue a warning and leave it to the user to
> solve.".

Sorry for my English.

>> +             if ((st.st_mode & 0777) != S_IRWXU) {
>> +                     warning("permission of runtime directory '%s' "
>> +                                     "MUST be 0700 instead of 0%o\n",
>> +                                     sb.buf, (st.st_mode & 0777));
>> +                     return NULL;
>> +             } else if (st.st_uid != uid) {
>> +                     warning("owner of runtime directory '%s' "
>> +                                     "MUST be %d instead of %d\n",
>> +                                     sb.buf, uid, st.st_uid);
>> +                     return NULL;
>> +             }
>
> These cases still leak "sb", I think.
>
>> +             /* TODO: check whether st.buf is an directory */
>
> Should we complete this todo? It's should just be S_ISDIR(st.st_mode).
>
>> +     } else {
>> +             if (safe_create_leading_directories_const(sb.buf) < 0) {
>> +                     warning("unable to create directories for '%s'\n",
>> +                                     sb.buf);
>> +                     return NULL;
>> +             }
>> +             if (mkdir(sb.buf, 0700) < 0) {
>> +                     warning("unable to mkdir '%s'\n", sb.buf);
>> +                     return NULL;
>> +             }
>
> These ones leak, too.

I will deal with it.

I find there are some similar leakage in this file. I'll fix them in
another patch.

Do you think we need some additional comments for the release of strbuf?
>
> -Peff
