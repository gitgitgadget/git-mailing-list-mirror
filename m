Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB074C77B71
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 20:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjDNUZ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 16:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjDNUZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 16:25:25 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2826C10B
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 13:25:25 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id la3so19326495plb.11
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 13:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681503924; x=1684095924;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XWvt8CfnSe52+b88YG0QAEBk4crq2+KbdyU6WhV1ppw=;
        b=c4fdvRHGvw8AdpPmpsAKe4hg+L5GLP29BpLpKHzg1co09G6Xfhe/sErOVSpxNCX3az
         Y2eBz5FCXNF2YiGVh++7Gjs0tCrzm9Qw47qY+69P6+UMV59O424q5C1r97Kj2XkBsbtJ
         IIMVTE8Z5pmGR7SCdTtlRkO7MK2ZA8ihxgMeL4Zy/l9UQxD6tCCCEV7var/HefD6NRfU
         WbDOepz3xa+J+fRIL9RWp1x8pOc+5p5l23RZhSu8XPyQ8eXlIeIvl+5lB0opSvvUteq1
         Rqv+HhTWvjByONlEfkFQWH3o0T7b+bSqxVfpDxf182uk3iHgcAMowlrj7PZ6nStFrIAC
         wNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681503924; x=1684095924;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XWvt8CfnSe52+b88YG0QAEBk4crq2+KbdyU6WhV1ppw=;
        b=elconQgvjrvufeAlVmSAYbfq8VEuo48NhPJSrf+EQsT4W5xGTOWpjNXWBv2JR1sAbi
         1iT7wOtj76RuSwDr5KpNudv3C8HFCEpxKNKJH+Su9+df1Y9hCCwKU0WS8CdWVQTbGjkO
         SROBK5nqNY7sgWnq1na6pOrHG/aick8Bs4DwXYn0DeAysitGYdc5SCmKFPhrbk/3mjo4
         ptwudhRh1w3SsZ/tdVd78Q2RaX2v6MbBltnjdIcFyM5mQ7o2p5jAiW90TUOxjx2+Wy8E
         UwOrKY2mOj+DpYLgagvQFbVp3Kr+nOrLrm2IPKumv/EI9OXF4jdn9sjtA1sH5y//Gcnw
         9WkA==
X-Gm-Message-State: AAQBX9cWgffgQUI3lIwy2m5uauzezxGXxF40GIjcvqQRh9XSes4PVN+P
        +qTayoFLleTPPsKNRz3he4U=
X-Google-Smtp-Source: AKy350bma9A6Dy/99UnHvBTdRj6smfqTWal2ZgUtfkZ77x0m0B2ksnNZm8GNPLtiybnUjdlOrCX+Gg==
X-Received: by 2002:a17:903:1cf:b0:1a5:eb:9d3f with SMTP id e15-20020a17090301cf00b001a500eb9d3fmr5296589plh.56.1681503924446;
        Fri, 14 Apr 2023 13:25:24 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id d17-20020a170902aa9100b001a50ae08284sm3382550plr.301.2023.04.14.13.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 13:25:23 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 2/5] completion: complete REVERT_HEAD and BISECT_HEAD
References: <pull.1515.git.1681495119.gitgitgadget@gmail.com>
        <f3a47758f9dce20c29ffb776bffaf73e238c20d1.1681495119.git.gitgitgadget@gmail.com>
Date:   Fri, 14 Apr 2023 13:25:23 -0700
In-Reply-To: <f3a47758f9dce20c29ffb776bffaf73e238c20d1.1681495119.git.gitgitgadget@gmail.com>
        (Philippe Blain via GitGitGadget's message of "Fri, 14 Apr 2023
        17:58:35 +0000")
Message-ID: <xmqq4jpiqki4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> The pseudorefs REVERT_HEAD and BISECT_HEAD are not suggested
> by the __git_refs function. Add them there.
>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index dc95c34cc85..bcda376735c 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -767,7 +767,7 @@ __git_refs ()
>  			track=""
>  			;;
>  		*)
> -			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD REBASE_HEAD CHERRY_PICK_HEAD; do
> +			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD REBASE_HEAD CHERRY_PICK_HEAD REVERT_HEAD BISECT_HEAD; do
>  				case "$i" in
>  				$match*|$umatch*)
>  					if [ -e "$dir/$i" ]; then

This does obvious change to add two completion possibilities reusing
exactly the same logic we have been using.

A tangent related to my earlier "didn't we plan to limit them to
*_HEAD at some point?" is that we could turn the loop around and do
something like

		for i in HEAD $(cd "$dir" && echo *_HEAD)
		do
			case "$i" in
			$match*|$umatch*)
				if test -f "$dir/$i"
				then
					...

which could be a lot more future-proof, once we have such a rule.

But that is a tangent that we should wait until the current series
settles.

Thanks.

