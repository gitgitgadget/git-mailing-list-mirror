Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 372401F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 10:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfDWKcL (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 06:32:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54500 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfDWKcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 06:32:09 -0400
Received: by mail-wm1-f66.google.com with SMTP id c1so17983785wml.4
        for <git@vger.kernel.org>; Tue, 23 Apr 2019 03:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nlP5ulyZbs1RTN8PURxJw6Zj4nujjVMuCC5ccX0OQCA=;
        b=Oim8Cl6rfzk4aLnK8XSBbq3YuuHy981JAuiXYm65ySPljL7913bLALefUij8YrvACl
         OY36CIZtnOWUbRl0yJ37eQw30FT1z4UFXTqxwaRDdEWH21j0/9SknHkDGKUU9mMOLdXf
         k9ppFDjyW3+t2+EA4AmrVK2XGLx8UYlteF1bZ8wXK8I4SDJuWdVyGH/GMNPatXTHWvFw
         BrFx4rESM+V08ehatTA5WW0hbFhHuBMKBE502r3P+8vvzQqq6bcADv84nboxawDn0FTX
         tVZ8zmaqdk58iF6FJdewmM/5enEQJbdWSb0ul8cy4H4qaqghXTiWf3DI4sLH6SojYcjb
         OBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nlP5ulyZbs1RTN8PURxJw6Zj4nujjVMuCC5ccX0OQCA=;
        b=IABnzKEWDBTxNNCtOlRzAXshbhoeV8rEyiQyXkZ6TB6x1lqSW1mit/e74Fz8uDYlWJ
         PYhZqJrufK/aRX97QeD3LwhFJuAhS9z/4lrR1dZHVM/IOH9RRn+8Rb2u3OzQW9LTBjQM
         G3aresn/9OUW6Iupbxtm5GQ/BrCkmIJuxu1JSjSCU2P/0ULmuqpnLNCSEYSKc8yFv5M0
         SblOLpauWBcOSRNNpPEQdet5tPRdQLjqB9S8XoCfIoRYBU0Q/poIszEriswH2d0eYExQ
         HGvIElqVD4I05ytQJ3TNKXgckdKmnpad88Yumz8W7ESBjLwg8r/HD4b83KBVP9xnWylI
         pp/Q==
X-Gm-Message-State: APjAAAX1naHgEBvsynAFK9rhPHH/w9jpzKElxqdPgSEv74GgVgSABL4Z
        8/+ZFpBzC9Oxs6okSfoI4Fg=
X-Google-Smtp-Source: APXvYqxdl6+5B5oGkGBPjJZzZYj97c7M0X81D3HA5q83P1fYJ4ciM61hlKpzLirMEKQvUyTHjJFzUA==
X-Received: by 2002:a1c:be13:: with SMTP id o19mr1721545wmf.19.1556015527327;
        Tue, 23 Apr 2019 03:32:07 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id p6sm12966026wrs.6.2019.04.23.03.32.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 03:32:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "CHIGOT\, CLEMENT" <clement.chigot@atos.net>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] git-compat-util: work around for access(X_OK) under root
References: <AM6PR02MB4950BB0152893633FF95DC99EA230@AM6PR02MB4950.eurprd02.prod.outlook.com>
Date:   Tue, 23 Apr 2019 19:32:05 +0900
In-Reply-To: <AM6PR02MB4950BB0152893633FF95DC99EA230@AM6PR02MB4950.eurprd02.prod.outlook.com>
        (CLEMENT CHIGOT's message of "Tue, 23 Apr 2019 08:38:38 +0000")
Message-ID: <xmqq4l6p57x6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"CHIGOT, CLEMENT" <clement.chigot@atos.net> writes:

> On some OSes like AIX, access with X_OK is always true if launched under
> root.

That may be the case, but you'd need to describe why it is a problem
here, before talking about the need for a "work around".

For example, if a directory on $PATH has a file called git-frotz
that has no executable bit, perhaps "git frotz" would execute that
file but only when you are running it as the root user, but not as
any other user.

But that by itself does not sound like a problem to me.  After all,
a user with such a set-up on AIX may deliberately wanted to make
sure that a program like "git-frotz" that is only useful for
administrative purposes does not get in the way when using "git"
normally, but becomes available only when the user does "su".  IOW,
that sounds more like a feature an AIX user might want to take
advantage of.

Perhaps the reason why you do not want to use access(X_OK) that
returns true for root may be different from the above, but without
knowing what it is, it is far from clear to me why this patch is a
good idea.  The patch needs to be justified a lot better.

Everything below may become a moot point, as it is unclear if the
(untold) motivation behind this change makes sense in the first
place, but assuming that it is a good change that merely is poorly
explained, let's read on.

> diff --git a/compat/access.c b/compat/access.c
> new file mode 100644
> index 0000000000..e4202d4585
> --- /dev/null
> +++ b/compat/access.c
> @@ -0,0 +1,29 @@
> +#include "../git-compat-util.h"

This will get interesting.

> +/* Do the same thing access(2) does, but use the effective uid and gid,
> +   and don't make the mistake of telling root that any file is
> +   executable.  This version uses stat(2). */

	/*
	 * Our multi-line comment looks more like
	 * this.  A slash-asterisk without anything else
	 * on its own line begins it, and it is concluded
         * with  an asterisk-slash on its own line.
	 * Each line in between begins with an asterisk,
	 * and the asterisks align on a monospace terminal.
	 */

> +int git_access (const char *path, int mode)

No SP after function name before the parens that begins the
parameter list.

> +{
> +	struct stat st;
> +	uid_t euid = geteuid();
> +	uid_t uid = getuid();
> +
> +	if (stat(path, &st) < 0)
> +		return -1;

This stat is a wasted syscall if the running user is not root.
Structure the function more like


	int git_access(const char *path, int mode)
	{
		struct stat st;

		/* do not interfere a normal user */
		if (geteuid())
			return access(path, mode);

		if (stat(path, &st) < 0)
			return -1; /* errno apprpriately set by	stat() */
		... other stuff needed for the root user ...
	}

Does the true UID matter for the purpose of permission/privilege
checking?  Why do we have to check anything other than the effective
UID?

> +	if (!(uid) || !(euid)) {
> +		/* Root can read or write any file. */
> +		if (!(mode & X_OK))
> +			return 0;
> +
> +		/* Root can execute any file that has any one of the execute
> +		   bits set. */
> +		if (st.st_mode & (S_IXUSR | S_IXGRP | S_IXOTH))
> +			return 0;
> +		errno = EACCES;
> +		return -1;
> +	}
> +
> +	return access(path, X_OK);

I think the last "fallback to the system access()" is wrong, as the
"special case for root" block seems to except that the function may
be called to check for Read or Write permission, not just for X_OK.

> +}
> diff --git a/config.mak.uname b/config.mak.uname
> index 86cbe47627..ce13ab8295 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -270,6 +270,7 @@ ifeq ($(uname_S),AIX)
>  	NEEDS_LIBICONV = YesPlease
>  	BASIC_CFLAGS += -D_LARGE_FILES
>  	FILENO_IS_A_MACRO = UnfortunatelyYes
> +	NEED_ACCESS_ROOT_HANDLER = UnfortunatelyYes
>  	ifeq ($(shell expr "$(uname_V)" : '[1234]'),1)
>  		NO_PTHREADS = YesPlease
>  	else
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 31b47932bd..bb8df9d2e5 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1242,6 +1242,14 @@ int git_fileno(FILE *stream);
>  # endif
>  #endif

As I promised earlier, this will get interesting.

> +#ifdef NEED_ACCESS_ROOT_HANDLER
> +#ifdef access
> +#undef access
> +#endif

If a platform that needs git_access() wrapper happens to define
access(2) as a macro in its system header, you would lose the real
name of that function with this.

> +#define access git_access
> +extern int git_access(const char *path, int mode);

And in any source file that includes git-compat-util.h, when you
make a call to access(2), you'll end up calling git_access()
instead.

Remember what was in the end (in your original) or the early part of
git_access() that handled the case where the function is called for
a non-root user?  Yes, we write "access(path, mode)", expecting to
make a fallback call to the system-supplied access(2).  With this
include file, that will never happen---instead, it will recurse in
itself forever.

See how FILENO_IS_A_MACRO defined immediately before this part uses
the "#ifndef COMPAT_CODE" to guard against exactly the same problem.


Thanks.
