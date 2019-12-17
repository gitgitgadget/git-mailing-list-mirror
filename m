Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F446C2D0BF
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 20:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E178320716
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 20:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lchHVAKt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfLQUAs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:00:48 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39657 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfLQUAr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 15:00:47 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so12662158wrt.6
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 12:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h9PL8E5qvQUX6gtm0NMBoJUvM5c9xccPjjWDfop1hdQ=;
        b=lchHVAKtSrbkWWG5/G2DO4Akg90s1BxV89DSvmDb4/8y1QSPrE4qcdjPPpKc8YlSAJ
         39R9BFDQoTg37U9LZOxzAtkjGFicinN7kkIRUCDVsEGOLSRj/AtUGA1wsFSGPVxRGaYF
         XcXMQYFmtE9TwBqF121S5qCjq9oztsnKInpyZAqKnclt2tuB01w7DlDSG5vI5w/q4zfU
         DsguIEzrySTnt+E2QfhOOSjqQepekyrqlLOrwZqcKNNAPHexKIAfk1l9tYrBzr59SK4f
         2pVXIevztPc8vTYZLmT0kN/x10CHeJUy+5wsrXoE5ZzHtvASgUo/fFGvJz4Xlqd7IKbm
         v38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=h9PL8E5qvQUX6gtm0NMBoJUvM5c9xccPjjWDfop1hdQ=;
        b=YnD/DLMFbNTGE9rq7ReiTisQRGCaj9YNWpo1GyPxDhTQYrYPX5f4AhKMEj5YTTbzec
         g3+UQ8lwl772FFdjiDY1hG6OgorL3o/lX4KBLKbyBexvKANLLbxnthz5LQBXnUwtM1Iv
         GFSbs7T/97LQY3dBV0mnKvZ8XeaG4Jw5WwggtalwDtZH1kyE62UJPBoyBsVQ/h3j6YX2
         zXMymWfC4fKXwNFOyAjo2zZge2FzClI+bz6FZ+BOca5daYZyQFkaDl22S27iBdQOUxDv
         plPDWTnML4k33ExnL82pQjeL/nycn/KnK3g978L/ohDdOXAugKZcg2eH91NrbHeY7TJt
         2WsA==
X-Gm-Message-State: APjAAAXee/nPT/XEEXOYvvRDbLJAJrs6feZB85oZE/4QOFdaLnUlO8gl
        C8RD+GR/VzjWQy8OukyuOpc=
X-Google-Smtp-Source: APXvYqy5OkSyFSErVDm+kDzw9yPZZKlhAs5j55T/cEO5ZiBH6/s6YY9lj5FWDsv+AdshN5yaV/dvlw==
X-Received: by 2002:adf:f1cb:: with SMTP id z11mr37909109wro.375.1576612845961;
        Tue, 17 Dec 2019 12:00:45 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-0-192.as13285.net. [92.22.0.192])
        by smtp.gmail.com with ESMTPSA id b10sm27001374wrt.90.2019.12.17.12.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 12:00:45 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 04/18] commit: forbid --pathspec-from-file --all
To:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
 <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
 <deeb860a85d25e0645a5d2e1c82654653ab1e2d5.1576511287.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <195a5b2a-994a-5984-8cc7-280a698df2a0@gmail.com>
Date:   Tue, 17 Dec 2019 20:00:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <deeb860a85d25e0645a5d2e1c82654653ab1e2d5.1576511287.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alexandr

This looks good, thanks for the test

Best Wishes

Phillip

On 16/12/2019 15:47, Alexandr Miloslavskiy via GitGitGadget wrote:
> From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
> 
> I forgot this in my previous patch `--pathspec-from-file` for
> `git commit` [1]. When both `--pathspec-from-file` and `--all` were
> specified, `--all` took precedence and `--pathspec-from-file` was
> ignored. Before `--pathspec-from-file` was implemented, this case was
> prevented by this check in `parse_and_validate_options()` :
> 
>      die(_("paths '%s ...' with -a does not make sense"), argv[0]);
> 
> It is unfortunate that these two cases are disconnected. This came as
> result of how the code was laid out before my patches, where `pathspec`
> is parsed outside of `parse_and_validate_options()`. This branch is
> already full of refactoring patches and I did not dare to go for another
> one.
> 
> Fix by mirroring `die()` for `--pathspec-from-file` as well.
> 
> [1] Commit e440fc58 ("commit: support the --pathspec-from-file option" 2019-11-19)
> 
> Reported-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
> ---
>   builtin/commit.c                | 3 +++
>   t/t7526-commit-pathspec-file.sh | 3 +++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 2db2ad0de4..893a9f29b2 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -347,6 +347,9 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
>   		if (interactive)
>   			die(_("--pathspec-from-file is incompatible with --interactive/--patch"));
>   
> +		if (all)
> +			die(_("--pathspec-from-file with -a does not make sense"));
> +
>   		if (pathspec.nr)
>   			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
>   
> diff --git a/t/t7526-commit-pathspec-file.sh b/t/t7526-commit-pathspec-file.sh
> index 68920e8ff9..ba769e0e5d 100755
> --- a/t/t7526-commit-pathspec-file.sh
> +++ b/t/t7526-commit-pathspec-file.sh
> @@ -72,6 +72,9 @@ test_expect_success 'error conditions' '
>   	test_must_fail git commit --pathspec-from-file=- --patch -m "Commit" <list 2>err &&
>   	test_i18ngrep "\-\-pathspec-from-file is incompatible with \-\-interactive/\-\-patch" err &&
>   
> +	test_must_fail git commit --pathspec-from-file=- --all -m "Commit" <list 2>err &&
> +	test_i18ngrep "\-\-pathspec-from-file with \-a does not make sense" err &&
> +
>   	test_must_fail git commit --pathspec-from-file=- -m "Commit" -- fileA.t <list 2>err &&
>   	test_i18ngrep "\-\-pathspec-from-file is incompatible with pathspec arguments" err &&
>   
> 
