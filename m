Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FAC11F404
	for <e@80x24.org>; Wed, 15 Aug 2018 17:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbeHOUTw (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 16:19:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43991 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbeHOUTw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 16:19:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id b15-v6so1749129wrv.10
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 10:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=xotnKXfCj2SpXPjjFkc9f7s0QbcHWT7mwJLKWy4C0TI=;
        b=eL2q+OExOgRYcMrFIhppmGGbyuQ+vc1hnAWcEmALbw9kZ8OaWZy5LwWdP8Nl/N3lrd
         WBe0/LM3Ix/eLdMOzV9r1fnAr30Y/2ch0mVh5QAwv7O9KJQUBpj7bfoCyQYOXdEFDbSX
         SPptSZqLij95LmE/k4rEesMS1ss/ysllZYpTfxufgStzMijLasvlxRlB/Ll0apNta6AD
         TwAlVSxowUV6uus/ZIUgcWGxwMnPTsRir6nm37SuKpNuZSjxNrYbzgZwJBpsbxCfsJfW
         anWNU+lCLVhaAXKlrMEokKMRSynQeIj/FMEWiCh5KQgGQS8CA2fAvxBev1+gv7LKdo+c
         1N1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=xotnKXfCj2SpXPjjFkc9f7s0QbcHWT7mwJLKWy4C0TI=;
        b=OtvQ94yKThSTCrt5ub6prxXobzYOwb9lvr1WB6FepSW79k88Qj4D4V0yq7TG/JOFbP
         u+Dsv5tvb2A/9f0JZf3opgq869q7TFoDAtrUH+XAGJShQIxhl+uendg2rFKGJro7tcPu
         1SyLHyHcj5/U0/XxJxKS+bJZaDDraFhR/WGOf0xlB6GdFWgf7TM4R6HblFWlN9HrsTl9
         wlALnfH9hRx3yJcCevGXb4bmBQtV0dfkXnArg1psdHxKUEeutlfZCMVC42wSwh6i4enM
         1707C5+NlXC3WOi0Ff1gor2TYbMHgzDhEja+Yq87T6tAUA+gxP8LyW2zvcmjiwyhfSIC
         0SaA==
X-Gm-Message-State: AOUpUlGXOiwUzfTJFG4o7FJ3OvQFpnGEoP+j2lDm6kyiA6dZdjMeiyYV
        khdyAt8/sEMiO05/eRzENmU=
X-Google-Smtp-Source: AA+uWPybgJ1/gz4ZRftSnlUyoIoadvejca/vxdwug9ZOH+jrr0rzucPWrkR658iHRd8SlAPwB0SnQw==
X-Received: by 2002:adf:deca:: with SMTP id i10-v6mr16038657wrn.163.1534354007777;
        Wed, 15 Aug 2018 10:26:47 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m200-v6sm3354901wma.32.2018.08.15.10.26.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 10:26:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] cherry-pick: fix --quit not deleting CHERRY_PICK_HEAD
References: <20180815162308.17747-1-pclouds@gmail.com>
        <20180815162308.17747-2-pclouds@gmail.com>
Date:   Wed, 15 Aug 2018 10:26:46 -0700
In-Reply-To: <20180815162308.17747-2-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Wed, 15 Aug 2018 18:23:08 +0200")
Message-ID: <xmqqpnyjilrd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> --quit is supposed to be --abort but without restoring HEAD. Leaving
> CHERRY_PICK_HEAD behind could make other commands mistake that
> cherry-pick is still ongoing (e.g. "git commit --amend" will refuse to
> work). Clean it too.
>
> For abort, this job of deleting CHERRY_PICK_HEAD is on "git reset" so
> we don't need to do anything else.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---

Please do not hide this bugfix behind 1/2 that is likely to require
longer to cook than the fix itself.   And more importantly, it makes
it impossible to merge down the fix to the maintenance track, as I
do not think we'd want to merge 1/2 there.

Thanks.

>  builtin/revert.c                | 9 +++++++--
>  t/t3510-cherry-pick-sequence.sh | 3 ++-
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/revert.c b/builtin/revert.c
> index 76f0a35b07..e94a4ead2b 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -7,6 +7,7 @@
>  #include "rerere.h"
>  #include "dir.h"
>  #include "sequencer.h"
> +#include "branch.h"
>  
>  /*
>   * This implements the builtins revert and cherry-pick.
> @@ -191,8 +192,12 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
>  	opts->gpg_sign = xstrdup_or_null(opts->gpg_sign);
>  	opts->strategy = xstrdup_or_null(opts->strategy);
>  
> -	if (cmd == 'q')
> -		return sequencer_remove_state(opts);
> +	if (cmd == 'q') {
> +		int ret = sequencer_remove_state(opts);
> +		if (!ret)
> +			remove_branch_state(the_repository);
> +		return ret;
> +	}
>  	if (cmd == 'c')
>  		return sequencer_continue(opts);
>  	if (cmd == 'a')
> diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
> index 3505b6aa14..9d121f8ce6 100755
> --- a/t/t3510-cherry-pick-sequence.sh
> +++ b/t/t3510-cherry-pick-sequence.sh
> @@ -103,7 +103,8 @@ test_expect_success '--quit cleans up sequencer state' '
>  	pristine_detach initial &&
>  	test_expect_code 1 git cherry-pick base..picked &&
>  	git cherry-pick --quit &&
> -	test_path_is_missing .git/sequencer
> +	test_path_is_missing .git/sequencer &&
> +	test_path_is_missing .git/CHERRY_PICK_HEAD
>  '
>  
>  test_expect_success '--quit keeps HEAD and conflicted index intact' '
