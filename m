Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040C4C00145
	for <git@archiver.kernel.org>; Tue, 13 Dec 2022 01:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbiLMBic (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 20:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbiLMBiA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 20:38:00 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934171DDC3
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 17:37:54 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id g1so1204225pfk.2
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 17:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=il4tdrpV3qPDlyWeYG+Lt3oP3o8htLUAurkGp+yr58I=;
        b=Sj2t1ZeDpGM9bSDScVdkVOZpX28TZojz5UcjIy13jg93EXBGfLXP6UwIKiRlQUHA9N
         LcQvuD9AVB6LiSyQNimRKukLK4GJiPTpFFobhZH2JgB9F+67SaXZlNMKfB7Ss2kbM98i
         gNB/RQI6U7f09MWroBSt4whTTdmc2+b38+u2ZB6gRWfVSlKICIp9LS2hXocfWCrkwPFE
         HGrSVspm/GEj3T5utW/O21/+UDGunFbENCyLndVaLkRIc3IW76QlHCSkpp4KrHleWE4K
         UbrMZtqCD7kXFudKb8nDBEeXCwdJzbgVE3LNXrZtJUyyULCV0Glk5zo447HuSVQlMlMG
         7jOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=il4tdrpV3qPDlyWeYG+Lt3oP3o8htLUAurkGp+yr58I=;
        b=XyMgNNPhthZr4I8F3b+hEB+IZ6iPc83fR3nNmRvmG5spGM46SExrPC45lnyeaZX0Gp
         u7bHB5zu9fsoEgYUWxfMqFFp2Gjg4+sP5rHaBR8VfEjxEDuAsxCQjaGQGWewlDoL6p6Z
         Kg/EHNfQIJ7sfUdc6988twmfUsDBIjobZuhFt8ioPV26bK2Fkxw6eR9ROUyhvboZiUNt
         0gePVtsGmyIQq/UlMa4tIAzxQH0wF0hLHfEy+ENN5RJBEoRSy7t13NaNhGnNlOuHnlj9
         DnosVPtGA5pkFswlYTSQVOpfBInwDzYYrXulCvMV1B6++LYg5RitAsxMQPJvG0rqkh7h
         GziQ==
X-Gm-Message-State: ANoB5pky1l+X1tp3yag6ULUfRibGZZfvFwMjXh7BnkG8H6XClLDwJOn4
        PkYHf82hTWUAzG3hhMD2pdk=
X-Google-Smtp-Source: AA0mqf5bxokma/Qvogl1bnff5QMC3oz0TVNYilajYXL9cMRk+IJdKdUBO6PvPW41GQRD13KBsXfdgg==
X-Received: by 2002:a05:6a00:4510:b0:578:2e3b:4728 with SMTP id cw16-20020a056a00451000b005782e3b4728mr11071824pfb.33.1670895473816;
        Mon, 12 Dec 2022 17:37:53 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id f27-20020aa79d9b000000b00576670cc16dsm6403500pfq.197.2022.12.12.17.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 17:37:53 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Simon Gerber via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Simon Gerber <gesimu@gmail.com>
Subject: Re: [PATCH v2] help.c: fix autocorrect in work tree for bare
 repository
References: <pull.1373.git.git.1666970645.gitgitgadget@gmail.com>
        <pull.1373.v2.git.git.1667073374852.gitgitgadget@gmail.com>
Date:   Tue, 13 Dec 2022 10:37:52 +0900
In-Reply-To: <pull.1373.v2.git.git.1667073374852.gitgitgadget@gmail.com>
        (Simon Gerber via GitGitGadget's message of "Sat, 29 Oct 2022 19:56:14
        +0000")
Message-ID: <xmqqa63sqe1b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Simon Gerber via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Calling `git_default_config()` in this callback to `read_early_config()`
> seems like a bad idea since those calls will initialize a bunch of state
> in `environment.c` (among other things `is_bare_repository_cfg`) before
> we've properly detected that we're running in a work tree.
>
> All other callbacks provided to `read_early_config()` appear to only
> extract their configurations while simply returning `0` for all other
> config keys.

Very good observation and justification for this change.

>  help.c                      | 2 +-
>  t/t9003-help-autocorrect.sh | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/help.c b/help.c
> index d04542d8261..ae534ff0bae 100644
> --- a/help.c
> +++ b/help.c
> @@ -563,7 +563,7 @@ static int git_unknown_cmd_config(const char *var, const char *value, void *cb)
>  	if (skip_prefix(var, "alias.", &p))
>  		add_cmdname(&aliases, p, strlen(p));
>  
> -	return git_default_config(var, value, cb);
> +	return 0;
>  }

And this is exactly what the proposed log message promises to do.

>  static int levenshtein_compare(const void *p1, const void *p2)
> diff --git a/t/t9003-help-autocorrect.sh b/t/t9003-help-autocorrect.sh
> index f00deaf3815..f5b6b4f746b 100755
> --- a/t/t9003-help-autocorrect.sh
> +++ b/t/t9003-help-autocorrect.sh
> @@ -60,4 +60,10 @@ test_expect_success 'autocorrect can be declined altogether' '
>  	test_line_count = 1 actual
>  '
>  
> +test_expect_success 'autocorrect works in work tree created from bare repo' '
> +	git clone --bare . bare.git &&
> +	git -C bare.git worktree add ../worktree &&
> +	git -C worktree -c help.autocorrect=immediate stauts

The reason why this third line is a sufficient test is...?

If "status" is invoked successfully, it would not exit with non-zero
status as long as it correctly notices that it was invoked in a
worktree (as opposed to the current code without your fix, which
would say "nah, where you are running there is no worktree", that is
incorrect), but one scenario I am a bit worried about is what if the
tester has an entry on $PATH that has "git-static" or whatever that
is similar enough to "status", to cause autocorrect work differently
from the case where "git status" would be the only plausible case.

But then we can tell such a tester "don't do that, then" ;-)

Let's queue the patch as-is and see what others think.

Thanks.

> +'
> +
>  test_done

