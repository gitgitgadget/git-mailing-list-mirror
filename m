Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3835EC433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 22:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiJLWad (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 18:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJLWac (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 18:30:32 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857B87C1DF
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 15:30:30 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id sc25so174242ejc.12
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 15:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BsB74C+6ZAiLQ3o41bIAf3rYknUgqQq9oHefA4kZVeU=;
        b=O7jsGhPxv+Fe9UeB/u2R4HO8LlkiAv4hXOaYNs1Y76VFyWnyL1cuaMYNwaCtYOAXEx
         LrW1I3mUh4ZfZd7uM5kDnLW1kZUn1+H0T3mVC35gk3HyFIjNbs7vmfcnZizzqeukLM3t
         PmRxJrpsYYw8xuxv0IeLSlx9gqfy0bMit/YFSPU3aVHAjvwCsPhK2UCzknhkU+H1hu2b
         mc8kIPn0+TbrITaggBCdYHkEuN0l5zIq+JSHLBWH56S/4g+QO7E/ZLV5cD2TiJHVfQtO
         90ueJQNpJDQXTIcvyN8M+O/Y3AnARat1Aju6kPfLFUBEzwHeDQxuKCxz4hwfmqjCm38T
         3HbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsB74C+6ZAiLQ3o41bIAf3rYknUgqQq9oHefA4kZVeU=;
        b=UHxk8iF7qegEFWYcZngL9AeeE8/+55DVjety4A1ZklgxKIAr2Ri3EtOF1040jbiXD4
         NJaoaUdcWFQNWhybFLjm7NCDwqKQ7qHiC63h8qw9LjyoOgz7KMeg8x5p09bRtve/Lupo
         epGKqEas31B0rumOVtQpE4OsABxmPNsmG7AYT0Jup8tMgwD6SKABzi5oN21x+NT0JfAB
         JyxyLfZxhia7NpVDmVTM4XbDGyGgsozdfsmx2qFSCbjBvLBBBEvfQKChA82flpNT7rxn
         GaI4WOWPcaCT0lu5f77qE5Q2w3XDy7TsUVTifL9T6iCXd0Y8N5Yy471WzDHrLfKygRvY
         zSTg==
X-Gm-Message-State: ACrzQf3EOkF8b5EBmlSslbnESsB5Z9TEvn0ko8ZFXYpdX/8brzSWO6lZ
        hMf0D8XhPKC1smkD654eSvw=
X-Google-Smtp-Source: AMsMyM5oiV40RfM334yBfuL90E6DB4l3t7gI0KUyAqZob541PlHNuhCMSqyG7B4uEyemXdP2+EGXqA==
X-Received: by 2002:a17:907:7204:b0:783:ce92:d75e with SMTP id dr4-20020a170907720400b00783ce92d75emr23202841ejc.682.1665613828949;
        Wed, 12 Oct 2022 15:30:28 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id h27-20020a170906719b00b0078ca30ee18bsm1944640ejk.95.2022.10.12.15.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 15:30:28 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oikF9-004MsO-1L;
        Thu, 13 Oct 2022 00:30:27 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>
Subject: Re: [PATCH 1/2] t0033, t0035: test for included config
Date:   Thu, 13 Oct 2022 00:28:09 +0200
References: <pull.1360.git.git.1665603814.gitgitgadget@gmail.com>
 <8c0f40aed7e7f7044b9233053ce3ab258f9b634f.1665603814.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <8c0f40aed7e7f7044b9233053ce3ab258f9b634f.1665603814.git.gitgitgadget@gmail.com>
Message-ID: <221013.86a660n08s.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 12 2022, Glen Choo via GitGitGadget wrote:

> From: Glen Choo <chooglen@google.com>
>
> Protected config should consider [include]-s. Add failing tests that
> describe the behavior we want; they will pass in the next commit.
>
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>  t/t0033-safe-directory.sh       | 9 +++++++++
>  t/t0035-safe-bare-repository.sh | 9 +++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/t/t0033-safe-directory.sh b/t/t0033-safe-directory.sh
> index aecb308cf66..720d6cdd60b 100755
> --- a/t/t0033-safe-directory.sh
> +++ b/t/t0033-safe-directory.sh
> @@ -71,4 +71,13 @@ test_expect_success 'safe.directory=*, but is reset' '
>  	expect_rejected_dir
>  '
>  
> +test_expect_failure 'safe.directory in included file' '
> +	cat >gitconfig-include <<-EOF &&
> +	[safe]
> +		directory = "$(pwd)"

Here you use $, so <<-EOF, not <<-\EOF, Okey.

> +test_expect_failure 'safe.bareRepository in included file' '
> +	cat >gitconfig-include <<-EOF &&
> +	[safe]
> +		bareRepository = explicit

But this one should use <<-\EOF
