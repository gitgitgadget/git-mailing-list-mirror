Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7B5C77B61
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 19:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346573AbjD1TBe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 15:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345577AbjD1TBc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 15:01:32 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA2B3AAC
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 12:01:04 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63b4e5fdb1eso420007b3a.1
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 12:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682708463; x=1685300463;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3+2FVFhe0PjGhBavNsfdU59SQaW+DJ3Z49OeAJCPyb8=;
        b=ru2ysM0+MiuPGhHVNvPOPd/2oZysw5wvJUzJlZvdXTXUW5h/xPDePXtnbIqJDM4u2J
         IfAJp5nICDLWNdhOiW5dOKXEh6WqvkwURiPrBImulkrRMViTP82O+DtPSYw3Mw5Xkb9R
         aMvpKMMgECzqowFDzxvvOrta4uK8shx4dDRP+vlH7+i1+RzYAis05Zqdd/jqi3yOuxPI
         5QSXY1M+oM2rocbP5zpwfbtSSduUadttrTJUBbY4gf9SxIQNw5bhheSFTtqUxk/jhaXo
         9uC6ZuRqm31bBe4o5OB+Z0wJcvJtjz/Vzn7soq35lIRyiFwNonvyxUr0prTiEUAdUnVw
         n79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682708463; x=1685300463;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3+2FVFhe0PjGhBavNsfdU59SQaW+DJ3Z49OeAJCPyb8=;
        b=VJNgO1e1yniNC4anryfhSkRcQw9bwwESbAOFwMNMcCpduZJhp4GcNEBWEdLH1gxg/7
         TBp8b98qGgiFBYKWm6CPFEROP5XNyLac8tn3aXJEuGD7wKCppbsDo+cAZiM0a8M0jcjr
         u5Joudt/UlzGAyiNYbWKgyZQJVr2stbu7z5Gi/4FM0nlHX3uwVQBayDMNdA9auFtT7HW
         y2FbIbgyQLJ7em1d9ZBRO2tsoZlUqhqNyZdzW0RduianaLxdw4766sGbD/rqKuMmrjS5
         vDdyK3gbANWAAdjuMoRzma9O9Mrcp5AazJF0UJU8+xGLL75TTXNi1ENj57Xm43t9/bU5
         flLA==
X-Gm-Message-State: AC+VfDzD1C1JJCeZiouDcCqbcLVmn2SQsQj+eg28uuqPizj6p2WFuxtb
        +h7f3YWOU8SxKnd14nA/qmQ=
X-Google-Smtp-Source: ACHHUZ5VACjLPnOndf/7ryS2Df1C99qQAFBBTdzeuzupugz9pceNq4DcktdB36elYcy3YHA1SVN+OA==
X-Received: by 2002:a05:6a00:2d87:b0:63d:254a:3901 with SMTP id fb7-20020a056a002d8700b0063d254a3901mr10123617pfb.25.1682708463489;
        Fri, 28 Apr 2023 12:01:03 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id h6-20020a056a001a4600b0062612b97cfdsm11847121pfv.123.2023.04.28.12.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 12:01:03 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] advice: handle "rebase" in error_resolve_conflict()
References: <20230323162234.995485-1-oswald.buddenhagen@gmx.de>
        <20230428125649.1719796-1-oswald.buddenhagen@gmx.de>
Date:   Fri, 28 Apr 2023 12:01:02 -0700
In-Reply-To: <20230428125649.1719796-1-oswald.buddenhagen@gmx.de> (Oswald
        Buddenhagen's message of "Fri, 28 Apr 2023 14:56:47 +0200")
Message-ID: <xmqqjzxvde6p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> This makes sure that we get a properly translated message rather than
> inserting the command (which we failed to translate) into a generic
> fallback message.

Hmph, can this be accompanied with a change to add a test to an
existing test script to demonstrate that the function can be called
with me set to "rebase" and results in a generic message?

> We now also BUG() out when encountering an unexpected command.

This needs to be reviewed by somebody who is more familiar with the
rebase/chrry-pick/revert/sequencer codepaths so that they can give a
definitive "good--I know that we never call this function with any
other value in 'me'" and that person would not be me.

> Arguably, it would be cleaner to pass the command as an enum in the
> first place ...

True, but that can be left to a different topic, I would think.

Thanks.

> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> Cc: Junio C Hamano <gitster@pobox.com>
> ---
>  advice.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/advice.c b/advice.c
> index d6232439c3..c35ae82e7d 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -190,9 +190,10 @@ int error_resolve_conflict(const char *me)
>  		error(_("Pulling is not possible because you have unmerged files."));
>  	else if (!strcmp(me, "revert"))
>  		error(_("Reverting is not possible because you have unmerged files."));
> +	else if (!strcmp(me, "rebase"))
> +		error(_("Rebasing is not possible because you have unmerged files."));
>  	else
> -		error(_("It is not possible to %s because you have unmerged files."),
> -			me);
> +		BUG("Unhandled conflict reason '%s'", me);
>  
>  	if (advice_enabled(ADVICE_RESOLVE_CONFLICT))
>  		/*
