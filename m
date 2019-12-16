Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785D7C43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 12:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B522072D
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 12:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akuxgYoY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfLPMCk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 07:02:40 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41045 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbfLPMCj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 07:02:39 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so6910473wrw.8
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 04:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZH9hfuMDerobcSoTSV5KCleEZmGts2Z1T8NAPa0gm/8=;
        b=akuxgYoYfzxgW2F1hJxMvDHo1cIlUO/iQNiUUA2NuEkQU8c7W4C3qIQY9FWxab0EFC
         0Rk8Ld5y9sEHDLnw1giTAv5ANXwWnk29HBAny/UVtsA/w4w7TE0XdRjDijAW2Mm3Wnop
         Y7eIaZn/mqpe/fcxbr2FuEbhEJ9Z9tprsf07f0vQjnPXflNqJTiJsDlAneExOSXh0nUw
         FjhCqDhBdIj7eOg8e+hj52FvHhYUvRGx8SR2RjxckljY6y4h4+cgssJBSsgeUVogzX+M
         BA3pnUHHNozbFgnEJ5zB/gubhrOJRJ3erQW1+qLFo2CjoAv5f+0BoxL1z350Trq70Ls9
         rLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZH9hfuMDerobcSoTSV5KCleEZmGts2Z1T8NAPa0gm/8=;
        b=N/TmRsAcPukFjO19XMQRlekK4yHmR+VWaabR2MNiQvFexvuLudTUlyriH8MuI6nwb/
         LevDEyfUXSGHy01mqcC+XB8jy/lNIzax0+4bp2BXNU/HXTUY50x0y0O8aPp1X1Wgj78C
         V99mKLk2vNIOrQHN5+Modi1PoSpurSTJUcNCHximzZf39sxmYuUYdPV55Uj/FywK7ev+
         7hnBd41QIT+65dNEFpb/oYDHBATGwzzYE6BpmEzo+p5t7cppswAto5EUrXWDFajOSplh
         skLSjko3rhriMTdkClZPkeZDICO13aQv57VbSLQ+V8gnAET3yoMT1SaQmIcsiDPiioND
         57NA==
X-Gm-Message-State: APjAAAWEgulMj/v34ZJUDHvrJR0hdBpeZWyf+qcbYo54G9DGsWLi2RC/
        QS5Z9I/qvZfbSLpKbVaYrys=
X-Google-Smtp-Source: APXvYqwt86/30bZoyDg0oT60AA298xa5+Q1UXeeq84q4Yrm1ngJShEQhanOwoXihAY8KU0Z86vIuZg==
X-Received: by 2002:a5d:5283:: with SMTP id c3mr31209964wrv.148.1576497757398;
        Mon, 16 Dec 2019 04:02:37 -0800 (PST)
Received: from [192.168.2.201] (host-92-22-0-192.as13285.net. [92.22.0.192])
        by smtp.googlemail.com with ESMTPSA id x11sm20894199wmg.46.2019.12.16.04.02.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2019 04:02:36 -0800 (PST)
Subject: Re: [PATCH 02/16] commit: forbid --pathspec-from-file --all
To:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
 <c0980519ed319295c273d358b0547340cc511a6b.1576161385.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <5928a257-a1f4-dad3-052e-7a0dbf1df8e3@gmail.com>
Date:   Mon, 16 Dec 2019 12:02:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <c0980519ed319295c273d358b0547340cc511a6b.1576161385.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alexandr

On 12/12/2019 14:36, Alexandr Miloslavskiy via GitGitGadget wrote:
> From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
> 
> I forgot this in my previous patch `--pathspec-from-file` for
> `git commit` [1]. When both `--pathspec-from-file` and `--all` were
> specified, `--all` took precedence and `--pathspec-from-file` was
> ignored. Before `--pathspec-from-file` was implemented, this case was
> prevented by this check in `parse_and_validate_options()` :
> 
>     die(_("paths '%s ...' with -a does not make sense"), argv[0]);
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
> Co-authored-by: Phillip Wood <phillip.wood123@gmail.com>

Thanks for fixing this. If you want to credit me then I think
Reported-by: would be more appropriate as I didn't write this patch.
Also I tend to use phillip.wood@dunelm.org.uk for footers as it's a
portable email address (I should add a mailmap entry...). It would be
nice to have tests for the various error conditions at some point.

Best Wishes

Phillip

> Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
> ---
>  builtin/commit.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 2db2ad0de4..893a9f29b2 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -347,6 +347,9 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
>  		if (interactive)
>  			die(_("--pathspec-from-file is incompatible with --interactive/--patch"));
>  
> +		if (all)
> +			die(_("--pathspec-from-file with -a does not make sense"));
> +
>  		if (pathspec.nr)
>  			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
>  
> 

