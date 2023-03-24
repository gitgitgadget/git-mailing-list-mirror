Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0B3C6FD1C
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 14:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjCXOos (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 10:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjCXOor (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 10:44:47 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E2A1633F
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 07:44:38 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id d13so1703641pjh.0
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 07:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679669077;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8XDeTrg2mREWcIMnnBA+B142WHlAgA4DqFu1GyY4HJQ=;
        b=C/R3JrEOkgsLt/WaetZqL4AYcEuq+74cdJiKAyUwyz4tCIx3orPUE94Dhkfyp53dhX
         /B0txlp9oAdaFRInYZYOkG0MpMstsA6udR4J7h9X8rmJnIOghc6rKcIluEwaljuv8bIA
         wKdYR9JKOzNBVX75xxYBJFLUYlwfahCCEqjOUq/SKxfHXQXK+82tqxWZDUZxX1a1J2bV
         AcoY8UxdZ6WFFLixdi7CmhEaFGtUOWhxzm8pWK4X1eeDFeJGnOh2sgw2fBe7VjDkRpIP
         naWLLuRekDFDJIKivCcviyUXdxikRhY4S1YTdNAK9AGWwmMZSzWYtLB4wpara2rIWO4C
         0jkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679669077;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8XDeTrg2mREWcIMnnBA+B142WHlAgA4DqFu1GyY4HJQ=;
        b=oqloRFPrAD2z3jKpdb6jqxZd6G5Imbx/od2jyqMIkMiHD32BJPM7h6rzWVx0sMBsLA
         C9YfaMCy1eOKbJy/k6TMljW73xTwthGlnVr7BhyJpijWmF3dtPi0QcoXP6/XFR7pfz9O
         2HaTErVir7ZXhneWarOp2fJy8EanxYP+mpzL6SGuCYwS3ZglgpAZVRnMVngqVdim3PLs
         2pVBNZfUbi9rIkfwoyVxqDSUHfqfhbtpichSWe/ItKDk9GhFlc5jBECldu/lwsT8dCi/
         ofkG1lqpERSnRTRLDJGraI/jQZzAmqEFWQwvBJr7CywZgsb+Kx72ia4Qm9TmGk+JpKvZ
         7X/w==
X-Gm-Message-State: AAQBX9eOn4LznrAcEI7iTepfam/TKhDoqLw1+PBNOmlNlSQZYlIG7NUx
        fIcYE2mY1BGnwkw1LJcTtCg=
X-Google-Smtp-Source: AKy350ZZNbgFcceRd9v45A1QZY0fQa4EVZtvKSKsqKoYGblW/B26FcwZ+QMT+ip+ydHurJKfp5bPiw==
X-Received: by 2002:a17:90b:4a81:b0:23d:1f5d:7181 with SMTP id lp1-20020a17090b4a8100b0023d1f5d7181mr3042429pjb.7.1679669077433;
        Fri, 24 Mar 2023 07:44:37 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id br16-20020a17090b0f1000b0023cfbe7d62esm7749684pjb.1.2023.03.24.07.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 07:44:36 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] advice: translate all actions in
 error_resolve_conflict()
References: <20230323162234.995485-1-oswald.buddenhagen@gmx.de>
        <20230323162234.995485-3-oswald.buddenhagen@gmx.de>
Date:   Fri, 24 Mar 2023 07:44:36 -0700
In-Reply-To: <20230323162234.995485-3-oswald.buddenhagen@gmx.de> (Oswald
        Buddenhagen's message of "Thu, 23 Mar 2023 17:22:34 +0100")
Message-ID: <xmqqcz4y5huz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> action_name() returns a N_()'d string (for good reasons), so we still
> need to _() it.
>
> In practice, this affects 'rebase'.
>
> Whether this is actually useful is debatable ...

Yes, it is debatable.  It may be much better to add a new "else if"
that covers the case we _know_ is not covered with the current code.

Having 'me' in _() would be consistent with its source marked with
N_() as you found out, but I agree with you that it is debatable if
this patch is moving things in the right direction.  It would belong
to the part that should never be exercised once we give action names
proper covering by adding missing "else if".

We could even replace the fallback else with a "else BUG()" to ensure
that the action names all callers pass have corresponding message
that can be translated without sentence lego.

Thanks.

> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> ---
>  advice.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/advice.c b/advice.c
> index d6232439c3..f75f3df582 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -192,7 +192,7 @@ int error_resolve_conflict(const char *me)
>  		error(_("Reverting is not possible because you have unmerged files."));
>  	else
>  		error(_("It is not possible to %s because you have unmerged files."),
> -			me);
> +			_(me));
>  
>  	if (advice_enabled(ADVICE_RESOLVE_CONFLICT))
>  		/*
