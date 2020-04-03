Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8803AC43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 13:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FBC62078C
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 13:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1MCDhnK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390883AbgDCNnL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:43:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35517 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgDCNnL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 09:43:11 -0400
Received: by mail-wm1-f66.google.com with SMTP id i19so7789221wmb.0
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 06:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b1FWCd+AydH/r5d1Kta/IInZm0jAL1kzlQFCuCH6gSs=;
        b=I1MCDhnKnI8I+BtmzW9Y8khhtxG+cUjHSjgZtgI9oNS7N95ZXUPVqHQRMnlJe5qfPn
         bo/lAjr/UW0v9rboV4zvxL7eC7nbJYytGxWqzsG+P2JLUgmDWrhf3kaYjm0gebbJb3mb
         Awdw9b4vRmRv8AItejom3rhdKTFg94YjWmUf8uq2UQ1kckGrtVTqaCW5lCntedU9OkZ0
         q8IfnfAeqoOY3o5iFJu8Qwc3KrpFse0QaQ7wJARZz4yjcvcL71VzQrmYV/GWgkENJrQE
         KWNxc5vt/F3llsRO/0MdbBTBms+dYTsQZnAJ+zDR+izrLfIKZn6qFOWyskzsyHL9sfHn
         ksOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b1FWCd+AydH/r5d1Kta/IInZm0jAL1kzlQFCuCH6gSs=;
        b=SSpVnFVq83M2mgKQgyZjboos4e7x0HMQ73pu61t5OJaproBf7ilwHjthvL16D6WC5F
         JthpO/kPXWLr7w/XVJ8Bw0aEVieXXixEvSyrAuH7HoMWvaUsIeYL/FPTAp+vn9oH+Jyl
         szNRNmpf8WAmniW2/Y/FC/QorbHiB52qgb6RWbKE2Mv028dHs++ol8LENeljsfqlYSxe
         UxpJlpdpeROegNSqGLnlVP9s/403Ifeh/EQop80kzHg41U+LwTEhODFTpwKTpfA9ZcCt
         ryo05wt+3vOwHXhddYBIzPGt73c/MG3iLazBt2HunzC+ymJbkTaBwWr46gD5pSJalBR8
         5CZQ==
X-Gm-Message-State: AGi0PubvQyQ4igEJ1b3O2+JLfvddxR8wDLskGrYm9QkfuHOagWWbDKBJ
        ZVn/qpyaMY67qdCbz/DUIDJWDgHN
X-Google-Smtp-Source: APiQypJF7pxuRkS8mVTHGs0j0e9z7yuJ9TDP3Dt49/8F6OqUjGcovDLVHGIk7piO8//sjd6A6RhU5g==
X-Received: by 2002:a1c:a145:: with SMTP id k66mr8617186wme.26.1585921386535;
        Fri, 03 Apr 2020 06:43:06 -0700 (PDT)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id c4sm11731273wmb.5.2020.04.03.06.43.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 06:43:06 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/6] cherry-pick/revert: honour --no-gpg-sign in all
 case
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        git@vger.kernel.org
References: <20200331064456.GA15850@danh.dev>
 <cover.1585909453.git.congdanhqx@gmail.com>
 <28ebbfe72a04b787fb92702199efea663a6b7ee5.1585909453.git.congdanhqx@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <180436a8-5b50-88b8-f3f1-1ec6aff41c9e@gmail.com>
Date:   Fri, 3 Apr 2020 14:43:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <28ebbfe72a04b787fb92702199efea663a6b7ee5.1585909453.git.congdanhqx@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Đoàn

On 03/04/2020 11:28, Đoàn Trần Công Danh wrote:
> {cherry-pick,revert} --edit hasn't honoured --no-gpg-sign yet.
> 
> Pass this option down to git-commit to honour it.

I did wonder if try_to_commit() needed any changes as we do not fork 
'git commit' unless the message is being edited but the tests seem to 
cover that case. It might be worth checking the code just to be sure if 
you haven't done so already.

Best Wishes

Phillip

> Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> ---
>   Documentation/git-cherry-pick.txt |  5 +-
>   Documentation/git-revert.txt      |  5 +-
>   sequencer.c                       |  2 +
>   t/t3514-cherry-pick-revert-gpg.sh | 86 +++++++++++++++++++++++++++++++
>   4 files changed, 96 insertions(+), 2 deletions(-)
>   create mode 100755 t/t3514-cherry-pick-revert-gpg.sh
> 
> diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
> index 83ce51aedf..75feeef08a 100644
> --- a/Documentation/git-cherry-pick.txt
> +++ b/Documentation/git-cherry-pick.txt
> @@ -109,9 +109,12 @@ effect to your index in a row.
>   
>   -S[<keyid>]::
>   --gpg-sign[=<keyid>]::
> +--no-gpg-sign::
>   	GPG-sign commits. The `keyid` argument is optional and
>   	defaults to the committer identity; if specified, it must be
> -	stuck to the option without a space.
> +	stuck to the option without a space. `--no-gpg-sign` is useful to
> +	countermand both `commit.gpgSign` configuration variable, and
> +	earlier `--gpg-sign`.
>   
>   --ff::
>   	If the current HEAD is the same as the parent of the
> diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
> index 9d22270757..044276e9da 100644
> --- a/Documentation/git-revert.txt
> +++ b/Documentation/git-revert.txt
> @@ -90,9 +90,12 @@ effect to your index in a row.
>   
>   -S[<keyid>]::
>   --gpg-sign[=<keyid>]::
> +--no-gpg-sign::
>   	GPG-sign commits. The `keyid` argument is optional and
>   	defaults to the committer identity; if specified, it must be
> -	stuck to the option without a space.
> +	stuck to the option without a space. `--no-gpg-sign` is useful to
> +	countermand both `commit.gpgSign` configuration variable, and
> +	earlier `--gpg-sign`.
>   
>   -s::
>   --signoff::
> diff --git a/sequencer.c b/sequencer.c
> index 6fd2674632..9969355de7 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -946,6 +946,8 @@ static int run_git_commit(struct repository *r,
>   		argv_array_push(&cmd.args, "--amend");
>   	if (opts->gpg_sign)
>   		argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
> +	else
> +		argv_array_push(&cmd.args, "--no-gpg-sign");
>   	if (defmsg)
>   		argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
>   	else if (!(flags & EDIT_MSG))
> diff --git a/t/t3514-cherry-pick-revert-gpg.sh b/t/t3514-cherry-pick-revert-gpg.sh
> new file mode 100755
> index 0000000000..5b2e250eaa
> --- /dev/null
> +++ b/t/t3514-cherry-pick-revert-gpg.sh
> @@ -0,0 +1,86 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2020 Doan Tran Cong Danh
> +#
> +
> +test_description='test {cherry-pick,revert} --[no-]gpg-sign'
> +
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY/lib-gpg.sh"
> +
> +if ! test_have_prereq GPG
> +then
> +	skip_all='skip all test {cherry-pick,revert} --[no-]gpg-sign, gpg not available'
> +	test_done
> +fi
> +
> +test_gpg_sign () {
> +	local must_fail= will=will fake_editor=
> +	if test "x$1" = "x!"
> +	then
> +		must_fail=test_must_fail
> +		will="won't"
> +		shift
> +	fi
> +	conf=$1
> +	cmd=$2
> +	cmit=$3
> +	shift 3
> +	test_expect_success "$cmd $* $cmit with commit.gpgsign=$conf $will sign commit" "
> +		git reset --hard tip &&
> +		git config commit.gpgsign $conf &&
> +		git $cmd $* $cmit &&
> +		git rev-list tip.. >rev-list &&
> +		$must_fail git verify-commit \$(cat rev-list)
> +	"
> +}
> +
> +test_expect_success 'setup' '
> +	test_commit one &&
> +	git switch -c side &&
> +	test_commit side1 &&
> +	test_commit side2 &&
> +	git switch - &&
> +	test_commit two &&
> +	test_commit three &&
> +	test_commit tip
> +'
> +
> +test_gpg_sign ! false cherry-pick   side
> +test_gpg_sign ! false cherry-pick ..side
> +test_gpg_sign   true  cherry-pick   side
> +test_gpg_sign   true  cherry-pick ..side
> +test_gpg_sign ! true  cherry-pick   side --no-gpg-sign
> +test_gpg_sign ! true  cherry-pick ..side --no-gpg-sign
> +test_gpg_sign ! true  cherry-pick   side --gpg-sign --no-gpg-sign
> +test_gpg_sign ! true  cherry-pick ..side --gpg-sign --no-gpg-sign
> +test_gpg_sign   false cherry-pick   side --no-gpg-sign --gpg-sign
> +test_gpg_sign   false cherry-pick ..side --no-gpg-sign --gpg-sign
> +test_gpg_sign   true  cherry-pick   side --edit
> +test_gpg_sign   true  cherry-pick ..side --edit
> +test_gpg_sign ! true  cherry-pick   side --edit --no-gpg-sign
> +test_gpg_sign ! true  cherry-pick ..side --edit --no-gpg-sign
> +test_gpg_sign ! true  cherry-pick   side --edit --gpg-sign --no-gpg-sign
> +test_gpg_sign ! true  cherry-pick ..side --edit --gpg-sign --no-gpg-sign
> +test_gpg_sign   false cherry-pick   side --edit --no-gpg-sign --gpg-sign
> +test_gpg_sign   false cherry-pick ..side --edit --no-gpg-sign --gpg-sign
> +
> +test_gpg_sign ! false revert HEAD  --edit
> +test_gpg_sign ! false revert two.. --edit
> +test_gpg_sign   true  revert HEAD  --edit
> +test_gpg_sign   true  revert two.. --edit
> +test_gpg_sign ! true  revert HEAD  --edit --no-gpg-sign
> +test_gpg_sign ! true  revert two.. --edit --no-gpg-sign
> +test_gpg_sign ! true  revert HEAD  --edit --gpg-sign --no-gpg-sign
> +test_gpg_sign ! true  revert two.. --edit --gpg-sign --no-gpg-sign
> +test_gpg_sign   false revert HEAD  --edit --no-gpg-sign --gpg-sign
> +test_gpg_sign   false revert two.. --edit --no-gpg-sign --gpg-sign
> +test_gpg_sign   true  revert HEAD  --no-edit
> +test_gpg_sign   true  revert two.. --no-edit
> +test_gpg_sign ! true  revert HEAD  --no-edit --no-gpg-sign
> +test_gpg_sign ! true  revert two.. --no-edit --no-gpg-sign
> +test_gpg_sign ! true  revert HEAD  --no-edit --gpg-sign --no-gpg-sign
> +test_gpg_sign ! true  revert two.. --no-edit --gpg-sign --no-gpg-sign
> +test_gpg_sign   false revert HEAD  --no-edit --no-gpg-sign --gpg-sign
> +
> +test_done
> 
