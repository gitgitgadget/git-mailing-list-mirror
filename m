Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42137C77B75
	for <git@archiver.kernel.org>; Mon,  8 May 2023 22:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbjEHWgt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 18:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjEHWgr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 18:36:47 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67F019AA
        for <git@vger.kernel.org>; Mon,  8 May 2023 15:36:46 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6436e075166so3812340b3a.0
        for <git@vger.kernel.org>; Mon, 08 May 2023 15:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683585406; x=1686177406;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GHw6lQK3MJdqzknEoak11oXQaunWOprgJoa3QpSNHPc=;
        b=BFVWCsm+o3PLHA2z4o5K+RFiVHhlSxjU0wt2FNfVaEVDUNPsYwbouRBkRIQbql+VXQ
         T/ymUUHpEMI1mupR6g0yLKCIBHcLzCs+UOJDEiNAFsqPJiT2wE1gMeAwRY9ESXsgBIE6
         g0Q78aTC+ZJtvfMGROr1eS4uV6ByPTuyWxjQ3iIyrIvbv457xpXiRj+iUGJyEHkL2PQp
         7InF9W+szN7qAyLIucaKrmZu+HW5EwTjL8zDamE0MvByqceNSciUD85gvlkFuQPGq+67
         IqdfLKhDq+emOqWo2j0yiHXr1e1RGuD4MyW3DGK6XwEG6LCYP8vaVeSrjmxIvwsmEGAU
         2Thg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683585406; x=1686177406;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GHw6lQK3MJdqzknEoak11oXQaunWOprgJoa3QpSNHPc=;
        b=ayNWBFRD3VC8KMNKutBarolWtuegzh3Vxps7v2/BP93vZqTEbspjYK1vTVQzbeDFpf
         /krYeswvQwqJvvjYby0DuOlEs7FO2wDKMLPhEwOftpKTuprtXwAL0LgVfBy/PG4Yh8PP
         D5t575V8vpXh8Cxu912copB4TIDtxOYxfoPPCyHKSmo4+4qvAHxg7kUiufg0TpjeEUln
         bN3sBzYue4a712QL9F2QGYuroid1K+8ucVZ5WXbpwcfiKwKfDeiPLluspF3R4FphMxfr
         Sv7w5290Xvqp1VioFaRxgdgzEKJNYnluplPue50v2AagzLa74yRXpVN6r5oDW7CdHxdX
         lgfQ==
X-Gm-Message-State: AC+VfDxa0VypJvR8e7gvEmynoJ5FAtMh1cDrP3AAUTdeJiG6o0PYLA+v
        ngN180C64vPYgVURqC7B/e0=
X-Google-Smtp-Source: ACHHUZ7RJ1uoiZhjEn1dtBhzyC6zGpDd7nyhEmTrhzCFyVo5dHGNT8PNMpnMqJSN8jYVdPxnidtD7Q==
X-Received: by 2002:a05:6a00:22d4:b0:643:558d:9ce2 with SMTP id f20-20020a056a0022d400b00643558d9ce2mr17300334pfj.21.1683585406148;
        Mon, 08 May 2023 15:36:46 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id s9-20020a63f049000000b005287b22ea8esm6817889pgj.88.2023.05.08.15.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 15:36:45 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 05/15] ref-filter.c: parameterize match functions over
 patterns
References: <cover.1683581621.git.me@ttaylorr.com>
        <c54000f5f5122c4ca3ac9b16828a8fd77050768c.1683581621.git.me@ttaylorr.com>
Date:   Mon, 08 May 2023 15:36:45 -0700
In-Reply-To: <c54000f5f5122c4ca3ac9b16828a8fd77050768c.1683581621.git.me@ttaylorr.com>
        (Taylor Blau's message of "Mon, 8 May 2023 17:59:55 -0400")
Message-ID: <xmqqmt2e4fia.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> -static int match_pattern(const struct ref_filter *filter, const char *refname)
> +static int match_pattern(const struct ref_filter *filter,
> +			 const char **patterns,
> +			 const char *refname)
>  {
> -	const char **patterns = filter->name_patterns;
>  	unsigned flags = 0;
>  
>  	if (filter->ignore_case)
> @@ -2132,9 +2133,10 @@ static int match_pattern(const struct ref_filter *filter, const char *refname)
>   * matches a pattern "refs/heads/" but not "refs/heads/m") or a
>   * wildcard (e.g. the same ref matches "refs/heads/m*", too).
>   */
> -static int match_name_as_path(const struct ref_filter *filter, const char *refname)
> +static int match_name_as_path(const struct ref_filter *filter,
> +			      const char **pattern,
> +			      const char *refname)
>  {
> -	const char **pattern = filter->name_patterns;
>  	int namelen = strlen(refname);
>  	unsigned flags = WM_PATHNAME;
>  

These hint that we'd eventually lose .name_patterns member from the
structure so that we can pass pattern array that is not necessarily
tied to any instance of a filter?

> @@ -2163,8 +2165,8 @@ static int filter_pattern_match(struct ref_filter *filter, const char *refname)
>  	if (!*filter->name_patterns)
>  		return 1; /* No pattern always matches */
>  	if (filter->match_as_path)
> -		return match_name_as_path(filter, refname);
> -	return match_pattern(filter, refname);
> +		return match_name_as_path(filter, filter->name_patterns, refname);
> +	return match_pattern(filter, filter->name_patterns, refname);

And we are not there yet, so we hoist the use of .name_patterns
member one level up to the only caller?

Without seeing how it evolves, we can tell this does not make
anything break, but we cannot tell how this helps anything (yet).

Let's read on.

