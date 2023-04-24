Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F153C7618E
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 21:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjDXVkF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 17:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjDXVkD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 17:40:03 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BD34C02
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 14:40:01 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-63b7b54642cso3741867b3a.0
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 14:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682372401; x=1684964401;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U4qENiC4wG/+G4G7yhobfR7FGyUlUxZYeM1KrzAkQyA=;
        b=BhHVSnR8aPi4b1PWjJnz5rhQE8LFYLoAXjrGfBJnt3Iwk9gvENCuyjiyKtKsY59BAl
         3VGQwleeNsjl85kvehxCz5ZAHWmGSWI388SRPI2c2UwXS1w8fX8YFLRqSxIPwyxx/y0i
         p10yDI9Vd/9vZFMQq4Iln39mY0F2D2jYBwHbkY3z3tNnSH0tc8lfpxM2BodaMsI68QCO
         nKUjXPQ3TMnVZLX+MXj2WhSDgB7656iDlN5sWztrUZmSULagti2z+PMHXdTVCqb5vhpB
         ApjZwf//qt7aCFVmXwdGd3AHxYCEpMqmLOcmIutmo31peiNcjiTU/5XYYacyyaq29Aw2
         8vXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682372401; x=1684964401;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U4qENiC4wG/+G4G7yhobfR7FGyUlUxZYeM1KrzAkQyA=;
        b=IfgjDEAWKIIBbKLwT6FWx5iVZJFro+L2r3HZiIaPSppGpzguiy5W9KDG8oPgRhiusW
         gFGJ8XM62nrRAQV/LaMKS39ZSILbREn1noaKRHV1PyRp2UFIt6nQx2L86R9ljPqkBlmD
         aQbPFRz5xAVgh0tqerYa/UONWg4F/NDGPUjEVOcAKLZklVfWeTnN0BLBLqI7gHN0iyJH
         wJzPsdfiXihZbD/HoHUbPHP/c81cApOggWCSrU2VGaCJJsOM1Sv2C343y7wdjeQgpaM3
         /dbuNmV5XmGaefvwDHaE+Iz/0R9OuzsEhQD1j+omYwkzmMbS4MSM/nctCkV+TazAln3Q
         MS+g==
X-Gm-Message-State: AAQBX9dQKHqM4J7MlsgVH7tS1cO/K/g+IAbYxCnbFzMLsd2JVov0eplp
        JGi30hRoxEGcqdrRV5pszzPgeCB0INk=
X-Google-Smtp-Source: AKy350ZxRokOCzIWH+AkgtT4JFfW9kltz/CjDKrl+Ie9Sblq913DC+5cI3c/Ngt6Urfbi9/JAq4N1g==
X-Received: by 2002:a05:6a20:6a21:b0:f0:6517:2fd with SMTP id p33-20020a056a206a2100b000f0651702fdmr20429464pzk.2.1682372401253;
        Mon, 24 Apr 2023 14:40:01 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id y4-20020a17090a1f4400b00247a942313bsm6742442pjy.56.2023.04.24.14.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 14:40:00 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Handle compiler versions containing a dash
References: <20230423091249.2591136-1-mh@glandium.org>
Date:   Mon, 24 Apr 2023 14:40:00 -0700
In-Reply-To: <20230423091249.2591136-1-mh@glandium.org> (Mike Hommey's message
        of "Sun, 23 Apr 2023 18:12:49 +0900")
Message-ID: <xmqqo7nd9cy7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Hommey <mh@glandium.org> writes:

> The version reported by e.g. x86_64-w64-mingw32-gcc on Debian bullseye
> looks like:
>   gcc version 10-win32 20210110 (GCC)
>
> This ends up with detect-compiler failing with:
>   ./detect-compiler: 30: test: Illegal number: 10-win32
>
> This change removes the -win32 part by excluding the dash and everything
> that follows from the version.

This may help the "test "$version" -gt 0" check and $((version - 1))
to pass.  It is not quite clear if/why it gives sensible results,
though.

> ---
>  detect-compiler | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Missing sign-off?

> diff --git a/detect-compiler b/detect-compiler
> index 50087f5670..d961df5fb5 100755
> --- a/detect-compiler
> +++ b/detect-compiler
> @@ -17,7 +17,7 @@ get_family() {
>  }
>  
>  get_version() {
> -	get_version_line | sed 's/^.* version \([0-9][^ ]*\).*/\1/'
> +	get_version_line | sed 's/^.* version \([0-9][^ -]*\).*/\1/'

The original is bad enough in that it says "We take anything that
begins with a digit up to (but not including) the first SP, and then
it assumes that it is getting an integer.  This one is not all that
better in that it can still accept a garbage like "version 01xx-foo"
and "test "$version" -gt 0" would fail the same way, no?

If we are sure that "version N-win32" is always equivalent to
"version N" for the purpose of print_flags() helper function, it may
be more prudent to allow the known-good ones, with something like

	# A string that begins with a digit up to the next SP
	ver=$(get_version_line | sed 's/^.* version \([0-9][^ ]*\).*/\1/')

	# There are known -variant suffixes that do not affect the
	# meaning of the main version number.  Strip them.
	ver=${ver%-win32}
	ver=${ver%-win64}
	...
	echo "$ver"

while keeping the ones that are not "known-to-be-good" as-is.

That way, non-numeric numbers that we do not know about how to
interpret will continue to stop detect-compiler from giving a bogus
answer, which would be better than silently accepting anything with
dash and treat as if the string after the number does not make any
difference.

One thing I am worried about is "10-prerelease" that is not quite
"10" yet to be treated just like "10" and causing problems.

Thanks.


