Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA19C4332F
	for <git@archiver.kernel.org>; Sat,  3 Dec 2022 08:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiLCICO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Dec 2022 03:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiLCICL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Dec 2022 03:02:11 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037E19AE13
        for <git@vger.kernel.org>; Sat,  3 Dec 2022 00:02:11 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id k2-20020a17090a4c8200b002187cce2f92so10362143pjh.2
        for <git@vger.kernel.org>; Sat, 03 Dec 2022 00:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/mMykeCmbW1airAMQUIiT9urcrNcIymoxlrT/RAJJOk=;
        b=ITDxgDQneZOHj96HNLHr5R7BJkDGoODgfHlEk2ZypDHFnh5PjxPiOH79LK5eWQcdBn
         2ydyPgtNQMuIU0xSZ8EiTX3PKawYMMbpoB4iIVYwS3EQqZFfTtu8rcs5Z1cSjbDEM9H/
         HIy6DGJ7O1gSj6d7QUHmqcH4f7n0ebJcMIOwJrHQg1mcpj4kdDwI93I2dNXbnbM/tyK0
         HHJu61dIOoQNT14JGQQQwToNYoPsRctKqKdCtKJ5MvfeczYeSWQxXqXkhYh/wvmkRigc
         yTnISzk/QHQ6OP8uqpR2venUVWpa/CDZFGYi4ZFaUK1RSab4NdUwClt0+gzchVjm9Eip
         QW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mMykeCmbW1airAMQUIiT9urcrNcIymoxlrT/RAJJOk=;
        b=ejG71tiH5NS0aqqjergmJ8ArTsz+bUtyi5Fo0vWJhqGNNQqhGjSqioCr9o+j6BXLYq
         axUMsG9p1K8aAMYNatrSwf+X79Idnh7HRbGgcn0T8dvPP5962p8AqBBdLNvJ2ci4/z9y
         4tXGszgD5y3ziDvSZpYyNKDebAjAk/XmkSoddd1512ZpWC4sUIIPPDJ+8ydSLJO5k6Oq
         j55VFKlXB1a0wttUXs2Z+jvkdzNfhX4Nr5Sufht2/HP5lFmO+iJ/a4VU1soWgVphX4Nf
         PEE2D2GxhsmfF6h99XGdRkblI0FvSz1KbsOK6AqNiX/rcEsTNfYUJtGjz0xnI5C+qU3a
         HRqA==
X-Gm-Message-State: ANoB5pmv1uQmJ5guMBiLl3tDstX2gV/5ubukkEx7rX9DpmD7HbtWbIPm
        vcwDVmY4Xzn1AH8vh1K1hWooD1qt8cE=
X-Google-Smtp-Source: AA0mqf485tUYe80xhUNSfn+mN+uvwHb31nEW/159cVm51RnxVPrUrke+dV3uWeN2SPaFskX9leeNyw==
X-Received: by 2002:a17:90b:4fc2:b0:219:9da6:e93 with SMTP id qa2-20020a17090b4fc200b002199da60e93mr3809795pjb.203.1670054530426;
        Sat, 03 Dec 2022 00:02:10 -0800 (PST)
Received: from debian.me (subs03-180-214-233-30.three.co.id. [180.214.233.30])
        by smtp.gmail.com with ESMTPSA id r6-20020a635146000000b0043b565cb57csm5129381pgl.73.2022.12.03.00.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 00:02:09 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 4A84A104547; Sat,  3 Dec 2022 15:02:06 +0700 (WIB)
Date:   Sat, 3 Dec 2022 15:02:05 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Fabrice Fontaine <fontaine.fabrice@gmail.com>
Subject: Re: [PATCH] git-compat-util: avoid redefining system function names
Message-ID: <Y4sCfRdWAzjqw7cq@debian.me>
References: <20221125092339.29433-1-bagasdotme@gmail.com>
 <Y4RAr04vS/TOM5uh@coredump.intra.peff.net>
 <Y4fH4rhcSztHwKvK@coredump.intra.peff.net>
 <Y4nN2h4FIYGNjCSI@debian.me>
 <Y4ncAhIqHkckMljb@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y4ncAhIqHkckMljb@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 02, 2022 at 06:05:38AM -0500, Jeff King wrote:
> -- >8 --
> Subject: [PATCH] git-compat-util: undefine system names before redeclaring
>  them
> 
> When we define a macro to point a system function (e.g., flockfile) to
> our custom wrapper, we should make sure that the system did not already
> define it as a macro. This is rarely a problem, but can cause
> compilation failures if both of these are true:
> 
>   - we decide to define our own wrapper even though the system provides
>     the function; we know this happens at least with uclibc, which may
>     declare flockfile, etc, without _POSIX_THREAD_SAFE_FUNCTIONS
> 
>   - the system version is declared as a macro; we know this happens at
>     least with uclibc's version of getc_unlocked()
> 
> So just handling getc_unlocked() would be sufficient to deal with the
> real-world case we've seen. But since it's easy to do, we may as well be
> defensive about the other macro wrappers added in the previous patch.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> There may be other similar cases lurking throughout the code base, but I
> don't think it's worth anybody's time to go looking for them. If one of
> them triggers on a real platform, we can deal with it then.
> 
>  git-compat-util.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 83ec7b7941..76e4b11131 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -346,6 +346,7 @@ static inline int git_setitimer(int which UNUSED,
>  				struct itimerval *newvalue UNUSED) {
>  	return 0; /* pretend success */
>  }
> +#undef setitimer
>  #define setitimer(which,value,ovalue) git_setitimer(which,value,ovalue)
>  #endif
>  
> @@ -1480,6 +1481,9 @@ static inline void git_funlockfile(FILE *fh UNUSED)
>  {
>  	; /* nothing */
>  }
> +#undef flockfile
> +#undef funlockfile
> +#undef getc_unlocked
>  #define flockfile(fh) git_flockfile(fh)
>  #define funlockfile(fh) git_funlockfile(fh)
>  #define getc_unlocked(fh) getc(fh)

The warnings gone away, thanks!

For this patch and the previous one [1],

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

[1]: https://lore.kernel.org/git/Y4fH4rhcSztHwKvK@coredump.intra.peff.net/

-- 
An old man doll... just what I always wanted! - Clara
