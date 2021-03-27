Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED791C433DB
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 06:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA07A619B4
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 06:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhC0Gew (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 02:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhC0Gec (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 02:34:32 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C88DC0613AA
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 23:34:32 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso5269976pji.3
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 23:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LGCy75rs+vSteGyNU6haHWMFvRs8sl0fPwMJ9TH2WkQ=;
        b=TDsQDLAOL4jtjtQQPLxtx74gGUygkK9uTN0QZGShpiMNd2Aw5uMmpGZZQ/7OUbJnWT
         GvypnR2k+AfTn+3k6bMvRX7PYYnRzFV1LvSClVz8j9YdGEipNIci66Ob2ILzJqtdTQbS
         IrHYZuPiAC7K4S+XNuac2pe31kfUV1GCFX5ieasmeck7mzYXnDdJasQozr5XUjyXpvN3
         JiMJSbqXASlBP01HLN+q1hbTtoj9ceaJyA5yMqm2pODOwQbhdYgXMfB1QujOjzedHBZF
         NPZ2E9hu3hRe4zcp+lyX4MT+BE5XWERHpRmPTsT67cg9MMrDDm6BR3x/jC9T5Wwl//Pl
         AU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LGCy75rs+vSteGyNU6haHWMFvRs8sl0fPwMJ9TH2WkQ=;
        b=C6x8R++eZl521oAsvfe5+nu5ILLLoIIcsf4qzUz13jC9HQc2IsbtesTc/F5scXlXba
         dOLLqKcSgL+pMc/lTOhDotDScPZPcRbRVB460yvupNHHWmtu1tu2uxGrPrTK2+soiPS5
         7xtbOb1EimLdXIDkNB39d2CHj7NgNpD1tU2x5C806Wgg+X4T7AjOoCNkafBM9hQRbwBM
         rmfUyKRdwYWkVPMbBwXS8nUF1o71pLaOaxO8qtNGrcBs3Ui3uf1W1eRHdTacmiLY+S6w
         Lk+TAaXoqRWbhmivG91Q7kc3OgFEI0lbB1pPp4PDqouK1ueN8j5ifi9LpOQ/+z/axog7
         pt4g==
X-Gm-Message-State: AOAM533oy7RURF322TGCgjTVWOWdbgLwEXPrAeGudZbjnvrEb2yqr7Nc
        +aFGpAznOkSZFJ+N5WWYYUXm3Yh9jmPUFw==
X-Google-Smtp-Source: ABdhPJzJCJBUvz3LWk5gqN5w5c+97Z8fuNvTOTQHFFc3NpmOUhe6bjYyxkmd1jUZWwQXwoEiUjHzQA==
X-Received: by 2002:a17:90a:a613:: with SMTP id c19mr17390722pjq.141.1616826871352;
        Fri, 26 Mar 2021 23:34:31 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-35.three.co.id. [116.206.28.35])
        by smtp.gmail.com with ESMTPSA id l25sm11275507pgu.72.2021.03.26.23.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 23:34:31 -0700 (PDT)
Subject: Re: [PATCH 1/2] SECURITY: describe how to report vulnerabilities
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <pull.917.git.1616796767.gitgitgadget@gmail.com>
 <2c9f5725d96fe45aa5d1a6bbc522f9ed6161173c.1616796767.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <4f715120-3cd3-9f14-a291-0eb6e83a940e@gmail.com>
Date:   Sat, 27 Mar 2021 13:34:28 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2c9f5725d96fe45aa5d1a6bbc522f9ed6161173c.1616796767.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/03/21 05.12, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> In the same document, describe that Git does not have Long Term Support
> (LTS) release trains, although security fixes are always applied to a
> few of the most recent release trains.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   SECURITY.md | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 51 insertions(+)
>   create mode 100644 SECURITY.md
> 
> diff --git a/SECURITY.md b/SECURITY.md
> new file mode 100644
> index 000000000000..282790164e78
> --- /dev/null
> +++ b/SECURITY.md
> @@ -0,0 +1,51 @@
> +# Security Policy
> +
> +## Reporting a vulnerability
> +
> +Please send a detailed mail to git-security@googlegroups.com to
> +report vulnerabilities in Git.
> +
> +Even when unsure whether the bug in question is an exploitable
> +vulnerability, it is recommended to send the report to
> +git-security@googlegroups.com (and obviously not to discuss the
> +issue anywhere else).
What about using reference word (`... it is recommended to send the
report to that mailing list`)?
> +Vulnerabilities are expected to be discussed _only_ on that
> +list, and not in public, until the official announcement on the
> +Git mailing list on the release date.
> +
> +Examples for details to include:
> +
> +- Ideally a short description (or a script) to demonstrate an
> +  exploit.
> +- The affected platforms and scenarios (the vulnerability might
> +  only affect setups with case-sensitiv file systems, for
> +  example).
Oops, s/case-sensitiv/case-sensitive/
> +- The name and affiliation of the security researchers who are
> +  involved in the discovery, if any.
> +- Whether the vulnerability has already been disclosed.
> +- How long an embargo would be required to be safe.
> +
> +## Supported Versions
The header should be `Supported Versions and How Maintenance
Releases are Made`.
> +
> +There are no official "Long Term Support" versions in Git.
> +Instead, the maintenance track (i.e. the versions based on the
> +most recently published feature release, also known as ".0"
> +version) sees occasional updates with bug fixes.
> +
> +Fixes to vulnerabilities are made for the maintenance track for
> +the latest feature release and merged up to the in-development
> +branches. The Git project makes no formal guarantee for any
> +older maintenance tracks to receive updates. In practice,
> +though, critical vulnerability fixes are applied not only to the
> +most recent track, but to at least a couple more maintenance
> +tracks.
> +
> +This is typically done by making the fix on the oldest and still
> +relevant maintenance track, and merging it upwards to newer and
> +newer maintenance tracks.
AFAIK, maint branch are based on latest feature release (say v2.24),
and any bugfixes there are cherry-picked to relevant older releases,
but does it mean resetting maint branch to that older release, and
then resetting back to before that? Or how tagged maintenance release
are made without resetting maint?
> +For example, v2.24.1 was released to address a couple of
> +[CVEs](https://cve.mitre.org/), and at the same time v2.14.6,
> +v2.15.4, v2.16.6, v2.17.3, v2.18.2, v2.19.3, v2.20.2, v2.21.1,
> +v2.22.2 and v2.23.1 were released.
> 

-- 
An old man doll... just what I always wanted! - Clara
