Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F80C7618E
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 17:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjDURWk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 13:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjDURWi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 13:22:38 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4585B13C16
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 10:22:35 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-63b62d2f729so2092711b3a.1
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 10:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682097754; x=1684689754;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BODf0JJqkmjlSRb5W17H2FXHnmV1xpFlEPW+jDD4030=;
        b=puUfdHwSTaBndMrd6GSZNp+FOAf/D5zfYwD1rOaNx8Dr9n1S2tU3Zw6d1abFo7pC7p
         7R/9PncXZpWbV+qF51cPo7A0Ba+cmIvbHnlAMTfWKSUFPRTdscHk88ehxl7x+R4vpY4A
         byavptvjSnbP8t7ka1D8RDFiXp3YmR1uLYtcfK4zNwa+vGbTB9znuG6T6fFAeDXz505E
         IuY/pB9fBxHWtKKbMv0kWGn8wTTHCH7Ftkltoqvlrntw769Bh31utCdNnyo8q2Vz5FJI
         98MNCtDgaPF4UWj9bXFIot1tcaTpGDNC+DyJMvGC7UCOYbOLSpx5mjf0OUTK9/7Vh7Sa
         WFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682097754; x=1684689754;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BODf0JJqkmjlSRb5W17H2FXHnmV1xpFlEPW+jDD4030=;
        b=ccYIhmkH47OuQ9Zpf+uvXizglYuHGOPFc+v4r3C7n9bQHXd5+VSpcsrPAlqH9WPW+a
         TrqPeWfyxHoVg3Uj0rlyuHU3FiKZ4+lepUWcoMWKKGiKGHIszFAE0f+j7DKHdL1nvlE/
         tEUt3najdxQ/y0/HU/2gvAoxzZF+8jlra6rCiPw3twAQziqNilN6EW1Gjhte7+7U3rzW
         cy0RRImA2fKZM+7RlzNslurkCWo41YZTSUYz/z0+4P0lUD8wox37nJfBbkO/583A/AO6
         WFBadLRxACaiL6i7Cv347u/45B99S0SEdvAL8SpZyQfFfCENL4u7FK39rc2zt6ysqs45
         sn1w==
X-Gm-Message-State: AAQBX9ePVGrJtnTFSMyleep7r9BopZeWs7bG68uoxrQ2WNcf0Wny1UJl
        dVCradQfK29D/3y3uv0ie2QQFqUXDoA=
X-Google-Smtp-Source: AKy350YG7BfylE/4lAmj19LEHioWnfv925AJ0ywtmc/BoyZ8i+iX52u/D9eLEhhe36IuCrAdRgbsOQ==
X-Received: by 2002:a05:6a00:1882:b0:63b:59a7:eafa with SMTP id x2-20020a056a00188200b0063b59a7eafamr7713337pfh.25.1682097754521;
        Fri, 21 Apr 2023 10:22:34 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id k16-20020aa788d0000000b00625616f59a1sm2823810pff.73.2023.04.21.10.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 10:22:34 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 1/6] rebase -i: move unlink() calls
References: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
        <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
        <3dfb2c6903bcc61258c72ba5c8e4201c9db2665b.1682089074.git.gitgitgadget@gmail.com>
Date:   Fri, 21 Apr 2023 10:22:33 -0700
In-Reply-To: <3dfb2c6903bcc61258c72ba5c8e4201c9db2665b.1682089074.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Fri, 21 Apr 2023 14:57:49
        +0000")
Message-ID: <xmqq8relkv52.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> At the start of each iteration the loop that picks commits removes
> state files from the previous pick. However some of these are only
> written if there are conflicts so only need to be removed before
> starting the loop, not in each iteration.

I do not doubt your reasoning is correct, but could you explain this
a bit better?

I think the reason why others, e.g. author-script, need to be
removed on every iteration is because the previous iteration that
called do_pick_commit() can come back successfully after calling
write_author_script(), and we would want to clear the deck before
going into the next iteration, so I can guess that you meant by "if
there are conflicts" that the loop will not iterate to the next step
after conflicts happened (and these files like "amend" and
"stopped-sha" may have been written)?  The latter, i.e. the loop
will not iterate any further, is the more direct reason to justify
this change, I think, and it would help readers of "git log" to say
so, instead of forcing them to infer "are conflicts" imply "hence
loop will stop".

Is this a pure clean-up, or will there be behaviour change?  I do
not think there is with this patch alone, but does this change make
future steps easier to understand or something?

IOW, the proposed log message may explain why this is not a wrong
change to make, but it is unclear why this is a good change we want
to have in this part of the series.

Thanks.

> diff --git a/sequencer.c b/sequencer.c
> index d2c7698c48c..5073ec5902b 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4639,6 +4639,10 @@ static int pick_commits(struct repository *r,
>  	if (read_and_refresh_cache(r, opts))
>  		return -1;
>  
> +	unlink(rebase_path_message());
> +	unlink(rebase_path_stopped_sha());
> +	unlink(rebase_path_amend());
> +
>  	while (todo_list->current < todo_list->nr) {
>  		struct todo_item *item = todo_list->items + todo_list->current;
>  		const char *arg = todo_item_get_arg(todo_list, item);
> @@ -4662,10 +4666,7 @@ static int pick_commits(struct repository *r,
>  						todo_list->total_nr,
>  						opts->verbose ? "\n" : "\r");
>  			}
> -			unlink(rebase_path_message());
>  			unlink(rebase_path_author_script());
> -			unlink(rebase_path_stopped_sha());
> -			unlink(rebase_path_amend());
>  			unlink(git_path_merge_head(r));
>  			unlink(git_path_auto_merge(r));
>  			delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
