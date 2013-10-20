From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] Prevent buffer overflows when path is too big
Date: Sun, 20 Oct 2013 07:47:06 +0200
Message-ID: <52636E5A.1080909@web.de>
References: <CABPQNSaqjKPGAQ4EKBSk+bQP2WMksc6M0YQxSkB91UrnFF28xQ@mail.gmail.com> <1382179954-5169-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Wataru Noguchi <wnoguchi.0727@gmail.com>, 
 Erik Faye-Lund <kusmabite@gmail.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, =?ISO-8859-1?Q?Ren=E9_?=
 =?ISO-8859-1?Q?Scharfe?= <l.s.r@web.de>, 
 msysGit <msysgit@googlegroups.com>
To: Antoine Pelisse <apelisse@gmail.com>, git@vger.kernel.org
X-From: msysgit+bncBCUZ3EUT2ADRBZO4RWJQKGQEGOAJWSQ@googlegroups.com Sun Oct 20 07:47:18 2013
Return-path: <msysgit+bncBCUZ3EUT2ADRBZO4RWJQKGQEGOAJWSQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ea0-f187.google.com ([209.85.215.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCUZ3EUT2ADRBZO4RWJQKGQEGOAJWSQ@googlegroups.com>)
	id 1VXlrB-0001bR-Py
	for gcvm-msysgit@m.gmane.org; Sun, 20 Oct 2013 07:47:17 +0200
Received: by mail-ea0-f187.google.com with SMTP id r16sf547808ead.24
        for <gcvm-msysgit@m.gmane.org>; Sat, 19 Oct 2013 22:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=5mAhuKJjd/c7V0tSc7qf0Igfl7AEbmOhP7DeNRvhx3w=;
        b=VKQy93EyknFURNU0DviHLZHVhvy2wo8psAenFRJCab3k1pbYiXhfSjdFiIAOW7c74+
         hxii4obfQ8UHLfhFqwdfi9lfJylpp+BcAKyTxXqOwk5lvE/uRIiw8uBG8qysA6Vavf2T
         Wl6CUpmHrc/NSJymGQnWrPUS1O0xRK3EM9nIYbmJY0zdDpuvhVCk6XKpafGL5v2snZ7b
         EqCx4IFdAqavVjNJiEBiDDFJC5Jgfr5lolg8+6GvzV6K0USM5JctKVUkieDyoMNmjci9
         SpV2JhTa2j740W9zgdREVMhmvAZ4MrQ7h+XnUtPydaCm/aXfh9KKykasmZEljFyTf9gS
         bIiA==
X-Received: by 10.152.2.41 with SMTP id 9mr1888lar.6.1382248037460;
        Sat, 19 Oct 2013 22:47:17 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.21.165 with SMTP id w5ls306915lae.78.gmail; Sat, 19 Oct
 2013 22:47:16 -0700 (PDT)
X-Received: by 10.112.171.230 with SMTP id ax6mr67898lbc.20.1382248036052;
        Sat, 19 Oct 2013 22:47:16 -0700 (PDT)
Received: from mout.web.de (mout.web.de. [212.227.17.11])
        by gmr-mx.google.com with ESMTPS id cd45si1859533eeb.0.2013.10.19.22.47.16
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Oct 2013 22:47:16 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of tboegi@web.de designates 212.227.17.11 as permitted sender) client-ip=212.227.17.11;
Received: from [192.168.209.20] ([78.72.74.102]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0MDgPG-1VW5Yz24kQ-00H7vH for
 <msysgit@googlegroups.com>; Sun, 20 Oct 2013 07:47:15 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
In-Reply-To: <1382179954-5169-1-git-send-email-apelisse@gmail.com>
X-Provags-ID: V03:K0:QHIillUD0LiKGXYxHagpzPDKxQX3pzUwvwiOoJin7crca09IHBe
 58Lf3uCjNurZsZwjbSl+Os1YVAeRN9JKQhaRaZEoIO3YAfwy/l0UC5oNn2vKs3SVbjhCQDE
 xte+DiZ0SHBLF5GoRCirNF2/7Yr3h2Ej8LMwzXZ6TZfsuUPH3bmAanHZU9x7HGB8vFS/RwV
 Ghw2+EWbXiB202Fb5c5cQ==
X-Original-Sender: tboegi@web.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: best guess record for domain of tboegi@web.de designates
 212.227.17.11 as permitted sender) smtp.mail=tboegi@web.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236413>

(may be s/path is too big/path is too long/ ?)

On 19.10.13 12:52, Antoine Pelisse wrote:
> Currently, most buffers created with PATH_MAX length, are not checked
> when being written, and can overflow if PATH_MAX is not big enough to
> hold the path.
> 
> Fix that by using strlcpy() where strcpy() was used, and also run some
> extra checks when copy is done with memcpy().
> 
> Reported-by: Wataru Noguchi <wnoguchi.0727@gmail.com>
> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
> ---
>  abspath.c        | 10 +++++++---
>  diffcore-order.c |  2 +-
>  entry.c          | 14 ++++++++++----
>  unpack-trees.c   |  2 ++
>  4 files changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/abspath.c b/abspath.c
> index 64adbe2..0e60ba4 100644
> --- a/abspath.c
> +++ b/abspath.c
> @@ -216,11 +216,15 @@ const char *absolute_path(const char *path)
>  const char *prefix_filename(const char *pfx, int pfx_len, const char *arg)
>  {
>  	static char path[PATH_MAX];
> +
> +	if (pfx_len > PATH_MAX)
I think this should be 
if (pfx_len > PATH_MAX-1) /* Keep 1 char for '\0'
> +		die("Too long prefix path: %s", pfx);
> +
>  #ifndef GIT_WINDOWS_NATIVE
>  	if (!pfx_len || is_absolute_path(arg))
>  		return arg;
>  	memcpy(path, pfx, pfx_len);
> -	strcpy(path + pfx_len, arg);
> +	strlcpy(path + pfx_len, arg, PATH_MAX - pfx_len);

I'm not sure how to handle overlong path in general, there are several ways:
a) Silently overwrite memory (with help of memcpy() and/or strcpy()
b) Silently shorten the path using strlcpy() instead of strcpy()
c) Avoid the overwriting and call die().
d) Prepare a longer buffer using xmalloc()

Today we do a), this is not a good thing and the worst choice.


A little side note:
  It would be good to have test cases for either b), c) or d).

  As PATH_MAX is OS dependend, we need both a main program written in c
  and a test case written in t/txxxx.sh.
  Some existing code can be used for inspiration, e.g. 
  test-wildmatch.c in combination with t/t3070-wildmatch.sh
  This willl allow us to reproduce the error, and define how git should behave.

End of the side note, let's look closer at the suggested patch, implementing b)

Silently shortening an overlong path like
"/foo/bar/baz" could result something like

"/foo/bar/ba" /* That filename may be part of the repo too */
or
"/foo/bar/" /*  This is a directory, not a file name */

In either case the end user has no idea why git choose another file name.
And this could be hard to debug.
After a couple of hours she/he may send a message asking for help to the mailing list,
and we end up in more people doing debugging.

c) Is much easier to debug:
  Git can not handle this situation, and we print out the parameters in die()

I would prefer c) over b), make clear that git can't handle that situation.

d) Would mean some more re-factoring: Check all callers to prefix_filename().
Some of them call xstrdup() after prefix_filename(), which mean that we could
change prefix_filename() to always return new string which is long enough via xmalloc(),
and not a static buffer.

So we come to the next point (and this is my personal experience,
so please don't get me wrong):
how much time can you spend on this?

If the answer is kind of "very little", I would go for c)
  Avoid the silent memory corruption, and say to the user "we can not handle this"

If the answer is kind of "little", I would go for c) and a test program,
  covering all the different code path in abspath()
  (WHich may deserve a refactoring as well, since the code for GIT_WINDOWS_NATIVE
  is very similar to the non-GIT_WINDOWS_NATIVE)

If the answer is kind of "more than little", a different strategie may be better:
  Start sending a patch for c)
  I think we have enough volunteers here for a review, so we can life without the test code.
  On top of that, some volunteer can develop d).
  
So far I have only looked at abspath(), and your patch touches more places.
I think more and more that calling die()
with all information included why we call die() is a good starting point.

It will allow the users to see what is going on.
May be the repo can be re-arranged to use shorter path names than what we can handle.
[snip]
 
/Torsten

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
