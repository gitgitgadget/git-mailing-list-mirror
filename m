Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3098AC4332F
	for <git@archiver.kernel.org>; Tue, 27 Dec 2022 15:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiL0PAS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Dec 2022 10:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiL0PAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2022 10:00:16 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9367B1005
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 07:00:14 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id tz12so32442093ejc.9
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 07:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bs7XS1rGtplWqwzK6yD08fiYUEtsHnA/Zt9wXaJPBu8=;
        b=bvty5v0WjdHkJAU3E1nxVhtzZWPI/s3cXlebz509AEMHR/SZTZX+n87QKreYeq40Hy
         KbU2lY2vXsjtPQx+JYLK55z4+4Djx0VMXSFX8RaeM6GS1nxSDI+Rev0ClYbNhu6Pz7l4
         ckgBBk66iasIR0vMRnzccTakDiqwXsdX4LzCCHC2eBXKPTj5PgjS06GY4bznJRhLkaNW
         zjmTi9p/EYfVRoycBBOZasA+cxSsVB4PoH372+zgsaP/Rx/H1bAV/0ericiaoAZ6Bm/3
         AJp5yMKEkwlNMGcFItFaS8qF9soL+OAJkEgIeKtfkXQGzYeGY9mlwAhFvk4y0+n/cQVg
         q+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bs7XS1rGtplWqwzK6yD08fiYUEtsHnA/Zt9wXaJPBu8=;
        b=AgS/XF+qGzdR2o7qesxwXAAbNXi0dpqplxPC1TExTfDOJJSGSpa9vJZZaQQDlbn9U9
         DGD8qo/Jk5nbWBOnj8m8dsdnnDX9zNUra4nS9ReQoUB7H6/0skyFajvuHI2kfPcseRJc
         FaMIJ/sJFPvTZtgfQkUyXr2AAPZDjn0cAcxs1s5+68aPH+IAA6O7YjEEbymF5BFq5XZV
         5uyClY12sGav3HM21Hb+0XPoNA9Hlv5MkBHsuFAXvHB608QCmzh/+fva/dL8OC3wozJv
         sQ/br4UdqSTEAo1yFQ94P9eS9Kc8TGJlCes8d9Tt7cpOyo1fpIcjNXjMxFyrzx3aKfNZ
         iMTQ==
X-Gm-Message-State: AFqh2kq+7vgH4BGlCWCIoBwJxesDnWAOsGiS3osZQRlAMdBOTu13INUD
        4E6YounXwaZgxy2jYxd1nNngcIYXN9A=
X-Google-Smtp-Source: AMrXdXszVkJWfXMCN6fQv7AxtyTU5cF99iJQ7XoRs6J/Mxg9+OXs9DCkZ6BbVJ8b8JxJ/AU1mAD7Tw==
X-Received: by 2002:a17:906:60cd:b0:845:bb21:f638 with SMTP id f13-20020a17090660cd00b00845bb21f638mr14989425ejk.75.1672153213012;
        Tue, 27 Dec 2022 07:00:13 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id m9-20020a1709062ac900b007c0d41736c0sm6158410eje.39.2022.12.27.07.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 07:00:12 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pABR6-009G1I-0Z;
        Tue, 27 Dec 2022 16:00:12 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH v2] setup: avoid unconditional open syscall with
 write flags
Date:   Tue, 27 Dec 2022 15:40:59 +0100
References: <20221227143200.1182341-1-cgzones@googlemail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221227143200.1182341-1-cgzones@googlemail.com>
Message-ID: <221227.86lemsvqmb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 27 2022, Christian G=C3=B6ttsche wrote:

When you submit a re-roll to the git ML please use the "--in-reply-to"
option to format-patch, or equivalent.

I see the original thread is at
https://lore.kernel.org/git/20221205190019.52829-1-cgzones@googlemail.com/,
but this is now detached from it.

> Commit 57f5d52a942 ("common-main: call sanitize_stdfds()") added the
> sanitization for standard file descriptors (stdin, stdout, stderr) to
> all binaries.  The lead to all binaries unconditionally opening
> /dev/null with the flag O_RDWR (read and write).  Most of the time the
> standard file descriptors should be set up properly and the sanitization
> ends up doing nothing.
>
> There are many git operations, like `git status` or `git stash list`,
> which might be called by a parent to gather information about the
> repository and should work on a read-only repository.  That parent might
> run under a seccomp filter to avoid accidental modification or unwanted
> command execution on memory corruptions.  As part of that seccomp filter
> open(2) and openat(2) might be only allowed in read-only mode
> (O_RDONLY), thus preventing git's sanitation and stopping the
> application.
>
> Check the need of sanitization with a file descriptor in read-only mode,
> keep it as replacement for stdin and open replacement file descriptors
> for stdout and stderr in write-only mode.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>
> v2:
>   - switch to xopen("/dev/null", O_RDONLY) to stay at 2 syscalls in the
>     common case and use O_WRONLY for stdout and stderr, as suggested
>     by Ren=C3=A9 Scharfe
> ---
>  setup.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/setup.c b/setup.c
> index cefd5f6..c57582b 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1669,7 +1669,15 @@ const char *resolve_gitdir_gently(const char *susp=
ect, int *return_error_code)
>  /* if any standard file descriptor is missing open it to /dev/null */
>  void sanitize_stdfds(void)
>  {
> -	int fd =3D xopen("/dev/null", O_RDWR);
> +	int fd;

Aside from the meaningful part of this change, please change this to
avoid refactoring the "int fd =3D open(...)" part of this.

In your v1 you needed to do that, as we had code between the "int fd"
and "xopen".

But in your v2 here that code has gone away, but you kept the
now-unnecessary refactoring.

> +	fd =3D xopen("/dev/null", O_RDONLY);
> +	if (fd > 0)
> +		close(fd);
> +	if (fd > 2)
> +		return;
> +
> +	fd =3D xopen("/dev/null", O_WRONLY);
>  	while (fd < 2)
>  		fd =3D xdup(fd);
>  	if (fd > 2)

I don't really get this, if it's safe under seccomp to open this
O_RDONLY wasn't it always redundant to use O_WRONLY, and this change
should just be switching to O_RDONLY?

If I just make this function "return;" (and do nothing else) I get test
failures in t6500-gc.sh, which matches the description of 1d999ddd1da
(daemon/shell: refactor redirection of 0/1/2 from /dev/null,
2013-07-16).

This will have the tests pass:
=09
	diff --git a/setup.c b/setup.c
	index cefd5f63c46..8a218961cb1 100644
	--- a/setup.c
	+++ b/setup.c
	@@ -1669,7 +1669,7 @@ const char *resolve_gitdir_gently(const char *suspec=
t, int *return_error_code)
	 /* if any standard file descriptor is missing open it to /dev/null */
	 void sanitize_stdfds(void)
	 {
	-	int fd =3D xopen("/dev/null", O_RDWR);
	+	int fd =3D xopen("/dev/null", O_RDONLY);
	 	while (fd < 2)
	 		fd =3D xdup(fd);
	 	if (fd > 2)
=09
Now, I'm not saying that's safe, we may just have missing test coverage,
but if it isn't safe and results in some subtle issue isn't that the
issue you're going to be exposing here?

Another thing that passes tests for me is:
=09
	diff --git a/common-main.c b/common-main.c
	index 0a22861f1ce..7b6059e4ee0 100644
	--- a/common-main.c
	+++ b/common-main.c
	@@ -30,12 +30,6 @@ int main(int argc, const char **argv)
=09=20
	 	trace2_initialize_clock();
=09=20
	-	/*
	-	 * Always open file descriptors 0/1/2 to avoid clobbering files
	-	 * in die().  It also avoids messing up when the pipes are dup'ed
	-	 * onto stdin/stdout/stderr in the child processes we spawn.
	-	 */
	-	sanitize_stdfds();
	 	restore_sigpipe_to_default();
=09=20
	 	git_resolve_executable_dir(argv[0]);
	diff --git a/setup.c b/setup.c
	index cefd5f63c46..27828f6f076 100644
	--- a/setup.c
	+++ b/setup.c
	@@ -1695,6 +1695,12 @@ int daemonize(void)
	 	close(0);
	 	close(1);
	 	close(2);
	+
	+	/*
	+	 * Always open file descriptors 0/1/2 to avoid clobbering files
	+	 * in die().  It also avoids messing up when the pipes are dup'ed
	+	 * onto stdin/stdout/stderr in the child processes we spawn.
	+	 */
	 	sanitize_stdfds();
	 	return 0;
	 #endif

Which would avoid changing the behavior away from O_RDWR, but mov it to
daemonize().

Which again, may be horribly broken, I don't know, I'm just noting these
for discussion, as it seems to me that your proposed change is
implicitly suggesting that doing some version of of these is safe.
