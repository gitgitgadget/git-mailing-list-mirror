Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE972C7EE2E
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 21:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237685AbjFLVmi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 17:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjFLVmg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 17:42:36 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E35D2
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 14:42:34 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b3db8f3d07so7060325ad.2
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 14:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686606154; x=1689198154;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mW9DukPWszQ1Gaj0BGywXV8wbT1yH0qrMIrI2kQ/KPE=;
        b=f7QI4zhSfpZahk73EOVzCVjEhdFn2MaSUntWPhF/E2ruU4vMvw15GoJpsGkCuBHbiq
         g4hJ1lm3IY9jufoCggfdKJeAjgT5N1QCXeB4cJWPnxy9PCyyFGDrPqkW1TtulL3ENj5C
         Voxl1HBvq7JvOtEvdOSdX9KlTTU6rXtlwa+OxWh3nV0K+1ybxzgWb6ppIa6+dRmuhkqI
         BjlbtVj1LwWbLA1kEpyybKhqGJeINryxZJI12PM5WA44+9usFZf8fN489bP5F+7fZilg
         mxcDVqkIF90ctuKU5noGLlBXkFDKlySgj3nDGABX7F6gOfYj9it4tAZHMZd/k9tOJbuW
         mz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686606154; x=1689198154;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mW9DukPWszQ1Gaj0BGywXV8wbT1yH0qrMIrI2kQ/KPE=;
        b=fxe7yCQo0wLXcm7L/JQn35BPJWO4U4DdV/PJUg4NI1agwSMnxaW2Cl644IK5wilaRZ
         SJNL1hHYQA06gz/25vGTd59rBf7/odMK2E15cRhZcXNBXMkpHjRHaZiYWytNmMPD7Y9X
         908F6npunVOyXwNz2jzRSnjnBZJlHX2whBKO68YPwS4BOGB/x4yTGHrbqjlq5eUYUht6
         I8Fwih3tb4qCcb+iQtZMqkP601BLi3V0MtidZFhf5a9d1tCCAqfU+MHhDgdesB0wJeKq
         cDSHdZYI+0qGdqKyx3z2fnzEI5aqb8P0ssAYCP3mR1QGq1gVhW90+1hTslUppfxfcD/A
         izVA==
X-Gm-Message-State: AC+VfDxX1ihAFj/jiLkyBerSvhFYRR66UVZRqvlFYKflmxCtxIUqyWSq
        soIfMzTfGMJqkX/SqygfSbgU20SSZ6I=
X-Google-Smtp-Source: ACHHUZ4dzT7hbMpXfsSpsMQWN+Ea5+ott/7cbYbRoJXT7mSm2+N7yUdOX7MgymSj0I4oj7HhoO2Kjg==
X-Received: by 2002:a17:903:1247:b0:1b2:5070:c1d5 with SMTP id u7-20020a170903124700b001b25070c1d5mr8468866plh.13.1686606154306;
        Mon, 12 Jun 2023 14:42:34 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id ba9-20020a170902720900b001ae268978cfsm8657732plb.259.2023.06.12.14.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:42:33 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 19/25] completion: complete --patch-with-raw
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
        <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
        <807b8201d145a21c629797067cee21d1d1b9a0d4.1686574374.git.gitgitgadget@gmail.com>
Date:   Mon, 12 Jun 2023 14:42:33 -0700
In-Reply-To: <807b8201d145a21c629797067cee21d1d1b9a0d4.1686574374.git.gitgitgadget@gmail.com>
        (Philippe Blain via GitGitGadget's message of "Mon, 12 Jun 2023
        12:52:47 +0000")
Message-ID: <xmqq4jnc8iie.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Everything else in the series looked OK, but I am not sure if we
want to advertise this historical wart that has no practical
advantage over using "-p --raw".  The only reason why we kept it is
because we do not have to even think about how likely it will break
ancient scripts if we removed it.

Thanks.

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index a69421cd740..c0d2678d320 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1741,7 +1741,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
>  			--color-moved-ws= --no-color-moved-ws
>  			--full-index --binary --abbrev --diff-filter=
>  			--find-copies --find-object --find-renames
> -			--no-relative --relative
> +			--no-relative --relative --patch-with-raw
>  			--find-copies-harder --ignore-cr-at-eol
>  			--text --ignore-space-at-eol --ignore-space-change
>  			--ignore-all-space --ignore-blank-lines --exit-code
