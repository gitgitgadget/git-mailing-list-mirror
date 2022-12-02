Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF67C4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 10:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbiLBKFV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 05:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbiLBKFT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 05:05:19 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7C14E691
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 02:05:18 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id c15so4440277pfb.13
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 02:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z71DlPEtK8YQeHV+eEO+ugV+tEWel10LzMvHAu/R/0k=;
        b=LNy1xjWDEPS4klYQaquZ40upJlbQ/phx0P1qAL2yZTEpmK/XfQUm/IJnpKJ5YOfg3b
         0lO2rMGoxYlWKQ9GL27ylmKeks7h5OA+6gLxZzOTXEaGrtKRS8W44j6GGacPIIZq+IQG
         IpHIqtNN893YGIy05mb1ncpAdNv2usRvGTOJDuN6NDMLGhLp6KDdybiHA9mOO7sRtOAg
         KTyZ3jLRwyH9JQx1DGpRBBKeeBzCp51UPBzJ+cYV/07xj29BdRTVxVPx/55Hovk8tM6W
         Rb+qebPtZy/VhNoXlpwQz16e3+xBerkdaIVeB+bfexE8RygmgCiDVzQP8n/YYkmbs8kz
         /mAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z71DlPEtK8YQeHV+eEO+ugV+tEWel10LzMvHAu/R/0k=;
        b=yQGl1gaGTLDb81ZdPdpjK4j1TbyuURWboSo707x62DNvQmYQ+6N9cAR1g8SHF+3Z3P
         kcbwkkzYWBlchsyRgYF27llu62HMe0r8evWQ7lT7KJi5Wj60cMYbGG8BnOn1ip7K91Bq
         1RxLxbGe1YkDuLmswQ5f23j+k7G/UTsEM7W0BJppYLaBXIF2IeDJPhc73lup9CQ48Anm
         uyniO3DraosfxXLBLc5oKfu6LCCcQPwrHmu4nuwjLmUBwwVaeltrEFbnpKobRDriMk1e
         q5QQXIHOUBOppncAZDb1zYxQP0f1BE9TO6JxkIffKtvUKkQ06a5Xm6AJlXkHWJLZaUi2
         4PLg==
X-Gm-Message-State: ANoB5pnCZzflP8T6QOq1bMvbBSSJcVL9XhLEqMXRT5oa69ESGbg2rcu8
        OMD1eInTAkRVxlBEocYi4SS+zpKuZ8Y=
X-Google-Smtp-Source: AA0mqf6X8aVKy40HBRUHSxk+q0TUbYnr4CJBCzt5dVR5lQ42WSC9vanXWgvTYpp5JjolZyRqaWfkFw==
X-Received: by 2002:a63:5108:0:b0:477:9a46:d051 with SMTP id f8-20020a635108000000b004779a46d051mr43674613pgb.160.1669975517741;
        Fri, 02 Dec 2022 02:05:17 -0800 (PST)
Received: from debian.me (subs03-180-214-233-94.three.co.id. [180.214.233.94])
        by smtp.gmail.com with ESMTPSA id c13-20020a631c0d000000b00476db6fe510sm3802169pgc.75.2022.12.02.02.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 02:05:17 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 74A031042C5; Fri,  2 Dec 2022 17:05:14 +0700 (WIB)
Date:   Fri, 2 Dec 2022 17:05:14 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Fabrice Fontaine <fontaine.fabrice@gmail.com>
Subject: Re: [PATCH] git-compat-util: avoid redefining system function names
Message-ID: <Y4nN2h4FIYGNjCSI@debian.me>
References: <20221125092339.29433-1-bagasdotme@gmail.com>
 <Y4RAr04vS/TOM5uh@coredump.intra.peff.net>
 <Y4fH4rhcSztHwKvK@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y4fH4rhcSztHwKvK@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 30, 2022 at 04:15:14PM -0500, Jeff King wrote:
> -- >8 --
> Subject: [PATCH] git-compat-util: avoid redefining system function names
> 
> Our git-compat-util header defines a few noop wrappers for system
> functions if they are not available. This was originally done with a
> macro, but in 15b52a44e0 (compat-util: type-check parameters of no-op
> replacement functions, 2020-08-06) we switched to inline functions,
> because it gives us basic type-checking.
> 
> This can cause compilation failures when the system _does_ declare those
> functions but we choose not to use them, since the compiler will
> complain about the redeclaration. This was seen in the real world when
> compiling against certain builds of uclibc, which may leave
> _POSIX_THREAD_SAFE_FUNCTIONS unset, but still declare flockfile() and
> funlockfile().
> 
> It can also be seen on any platform that has setitimer() if you choose
> to compile without it (which plausibly could happen if the system
> implementation is buggy). E.g., on Linux:
> 
>   $ make NO_SETITIMER=IWouldPreferNotTo git.o
>       CC git.o
>   In file included from builtin.h:4,
>                    from git.c:1:
>   git-compat-util.h:344:19: error: conflicting types for ‘setitimer’; have ‘int(int,  const struct itimerval *, struct itimerval *)’
>     344 | static inline int setitimer(int which UNUSED,
>         |                   ^~~~~~~~~
>   In file included from git-compat-util.h:234:
>   /usr/include/x86_64-linux-gnu/sys/time.h:155:12: note: previous declaration of ‘setitimer’ with type ‘int(__itimer_which_t,  const struct itimerval * restrict,  struct itimerval * restrict)’
>     155 | extern int setitimer (__itimer_which_t __which,
>         |            ^~~~~~~~~
>   make: *** [Makefile:2714: git.o] Error 1
> 
> Here I think the compiler is complaining about the lack of "restrict"
> annotations in our version, but even if we matched it completely (and
> there is no way to match all platforms anyway), it would still complain
> about a static declaration following a non-static one. Using macros
> doesn't have this problem, because the C preprocessor rewrites the name
> in our code before we hit this level of compilation.
> 
> One way to fix this would just be to revert most of 15b52a44e0. What we
> really cared about there was catching build problems with
> precompose_argv(), which most platforms _don't_ build, and which is our
> custom function. So we could just switch the system wrappers back to
> macros; most people build the real versions anyway, and they don't
> change. So the extra type-checking isn't likely to catch bugs.
> 
> But with a little work, we can have our cake and eat it, too. If we
> define the type-checking wrappers with a unique name, and then redirect
> the system names to them with macros, we still get our type checking,
> but without redeclaring the system function names.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I confirmed that this builds on Linux with NO_SETITIMER, and still
> catches type problems if you intentionally break one of the callers.
> 
> Technically these should probably all have "#undef flockfile" and so on,
> but we've never done that, and we haven't seen an actual platform that
> complains. So I didn't include that here. I don't mind if somebody wants
> to, but it should be a separate patch on top.
> 
>  git-compat-util.h | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/git-compat-util.h b/git-compat-util.h
> index a76d0526f7..83ec7b7941 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -341,11 +341,12 @@ struct itimerval {
>  #endif
>  
>  #ifdef NO_SETITIMER
> -static inline int setitimer(int which UNUSED,
> -			    const struct itimerval *value UNUSED,
> -			    struct itimerval *newvalue UNUSED) {
> +static inline int git_setitimer(int which UNUSED,
> +				const struct itimerval *value UNUSED,
> +				struct itimerval *newvalue UNUSED) {
>  	return 0; /* pretend success */
>  }
> +#define setitimer(which,value,ovalue) git_setitimer(which,value,ovalue)
>  #endif
>  
>  #ifndef NO_LIBGEN_H
> @@ -1471,14 +1472,16 @@ int open_nofollow(const char *path, int flags);
>  #endif
>  
>  #ifndef _POSIX_THREAD_SAFE_FUNCTIONS
> -static inline void flockfile(FILE *fh UNUSED)
> +static inline void git_flockfile(FILE *fh UNUSED)
>  {
>  	; /* nothing */
>  }
> -static inline void funlockfile(FILE *fh UNUSED)
> +static inline void git_funlockfile(FILE *fh UNUSED)
>  {
>  	; /* nothing */
>  }
> +#define flockfile(fh) git_flockfile(fh)
> +#define funlockfile(fh) git_funlockfile(fh)
>  #define getc_unlocked(fh) getc(fh)
>  #endif
>  

Hi Jeff,

I got many of redefinition warnings when cross-compiling on Buildroot
with the patch above, like:

In file included from cache.h:4,
                 from common-main.c:1:
git-compat-util.h:1485: warning: "getc_unlocked" redefined
 1485 | #define getc_unlocked(fh) getc(fh)
      | 
In file included from git-compat-util.h:216,
                 from cache.h:4,
                 from common-main.c:1:
/home/bagas/repo/buildroot/output/host/aarch64-buildroot-linux-uclibc/sysroot/usr/include/stdio.h:835: note: this is the location of the previous definition
  835 | #define getc_unlocked(_fp) __GETC_UNLOCKED(_fp)

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
