Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE4EC3A5A7
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 01:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiLGBMQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 20:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiLGBMP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 20:12:15 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E186ADE90
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 17:12:14 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d82so7407339pfd.11
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 17:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mJuL4iBI/fjIQQGIrpapwkuRstAncVZWjUnPnD3bgIs=;
        b=XylQSj8c3+Jqsrt7+s+40Pp11MZR80DdedVzaW5qchbHELW9Xi7p/2ftOqbIwjisEm
         suoV2BD/0wfCVhy9XHdx8qIwLokROe/OMdTVj7Mg9dndUVFq5OelnBDwUfoHoJ98wYXd
         phCoBxpA3jPb+y/8ljfBo3KUApyaBH5I3c2zdUJZOeOWzUPpbkMcQHs+0AJ0yttxZ8s0
         hy1q+l4KGLnWrZPbcKpkpMdtAUqfCK3Ifb+T+VN5XYLTBz/GCPTGivjHxmQ6oOXV/Qu0
         DqqU/Rqn0XjwaDHAC9EWEWPQ2kPv9GM6RbNsJsT7UR/+dpwtEH76+sZ6yf1/k2UNlQ4o
         YAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mJuL4iBI/fjIQQGIrpapwkuRstAncVZWjUnPnD3bgIs=;
        b=ksJZ9UDgM6QQ4Y0mLIN5+MG+J2dYyx0XSRzjpjIRNVFtOMVt/AWOfMZwSH+X0uesfa
         fZtpjD4/nxjgyQ0LyBGql9VxUftIwZMEMsY8UYjCN8o0vgHKCQpE+cqAatmg6Nhfwp7j
         8JXfz9wwL98pq0bt5OPMB2LGeB5QyAJi4oa8bfWqbJ6YQZt18Li3RZu28Qe05mpJVo6B
         NImV1Js68hzGr/8QAAVBF2FKwoIEpdGhduzpANfzz03zMXuqz1jTjdp8UPvs+B3FSs7b
         OZtO+olZvepawKRUdPBI57z/eciOb7bn40DAP358C4Y7uo5VPalpMq91RwmzW4V+IiCa
         b2QA==
X-Gm-Message-State: ANoB5pnM0hfDwpv1iNqslTstrPZugMWTXUZF9OUxOmDsAnHAwWT0zolK
        MYR3nRhPSKg7SbJGD6csE9U=
X-Google-Smtp-Source: AA0mqf5EezIfJs2CgF2IbtV6zxhzbVs+aqx7efho9/yMnR6ucrJFvoyQE6CW13ItWQAZWJ84Wm2Lgw==
X-Received: by 2002:a63:dd13:0:b0:46e:ccbd:b136 with SMTP id t19-20020a63dd13000000b0046eccbdb136mr67283164pgg.515.1670375534338;
        Tue, 06 Dec 2022 17:12:14 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id b10-20020a170902d88a00b001868981a18esm13272447plz.6.2022.12.06.17.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 17:12:14 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2 1/3] object-file: don't exit early if skipping loose
References: <cover.1669839849.git.jonathantanmy@google.com>
        <cover.1670373420.git.jonathantanmy@google.com>
        <9ad34a1dce977044066de0bfa6e25977215e8dc9.1670373420.git.jonathantanmy@google.com>
Date:   Wed, 07 Dec 2022 10:12:13 +0900
In-Reply-To: <9ad34a1dce977044066de0bfa6e25977215e8dc9.1670373420.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 6 Dec 2022 16:40:51 -0800")
Message-ID: <xmqqy1rk6mqa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Instead, also search the submodule object stores and promisor remotes.
>
> This also centralizes what happens when the object is not found (the
> "return -1"), which is useful for a subsequent patch.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  object-file.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index 26290554bb..596dd049fd 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1575,18 +1575,17 @@ static int do_oid_object_info_extended(struct repository *r,
>  		if (find_pack_entry(r, real, &e))
>  			break;
>  
> -		if (flags & OBJECT_INFO_IGNORE_LOOSE)
> -			return -1;
> -
> -		/* Most likely it's a loose object. */
> -		if (!loose_object_info(r, real, oi, flags))
> -			return 0;
> -
> -		/* Not a loose object; someone else may have just packed it. */
> -		if (!(flags & OBJECT_INFO_QUICK)) {
> -			reprepare_packed_git(r);
> -			if (find_pack_entry(r, real, &e))
> -				break;
> +		if (!(flags & OBJECT_INFO_IGNORE_LOOSE)) {
> +			/* Most likely it's a loose object. */
> +			if (!loose_object_info(r, real, oi, flags))
> +				return 0;
> +
> +			/* Not a loose object; someone else may have just packed it. */
> +			if (!(flags & OBJECT_INFO_QUICK)) {
> +				reprepare_packed_git(r);
> +				if (find_pack_entry(r, real, &e))
> +					break;
> +			}
>  		}

Hmph, who passes IGNORE_LOOSE and why?  Explaining the answer to
that question would give us confidence why this change is safe.

If the reason IGNORE_LOOSE is set by the callers is because they are
interested only in locally packed objects, then this change would
break them because they end up triggering the lazy fetch in the
updated code, no?  Or do all callers that set IGNORE_LOOSE drop the
fetch_if_missing global before calling us?

Thanks.

