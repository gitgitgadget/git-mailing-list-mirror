Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50193C433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 14:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C47B2072E
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 14:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uvSH7d1W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390483AbgFXO3r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389874AbgFXO3q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 10:29:46 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CD9C061573
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 07:29:46 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id x62so1816942qtd.3
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 07:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=0Q/7b9GbJnSfTeavjfKxYZdD7xvS24LqkAqfADEuh+A=;
        b=uvSH7d1WwlHpR0oMQtg06cmNhYM+bTLR3Dsa/heUtRn0QNe3C3i4BssQKcFFJ67YCL
         D9om7lp4xXgerxKmE73EpvEYib1ASWjD43SroO/Xo9lnVwb14BgWOh79AytXFgsL0GJm
         SH+WobTkVVE/YY8k+cNtu9IIX5hSRbiCbz0I+rbDeeQJ2u/M65ZGg/h576RqF+dMiX59
         I41EIWodn+B6wWg0Z4Yj5WTAltJgdhiyEtGmq1rcKyBDUw1FkHVN39zT216FK5Ezjzxi
         3UxNnLq0aWweUSQVxCICEExwwq04/2Sbh7gpFSwGpBj7ayUVchJ5A2kdteQHpgtdQ4bG
         b/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0Q/7b9GbJnSfTeavjfKxYZdD7xvS24LqkAqfADEuh+A=;
        b=EQwWy69yrwiei7rCi93yk4QTcPmBdfF6boG0XgTJlUlDNk3synlxcGkXUvG0NHyyqh
         QYKENPgFv3PUbWFuprXNOKjQYehD/jv1Iey0842ky+EXcqDB7hWPb1VKNYnlh4WazWLN
         jgC3/fUZzu7hTuwD7xK8sf/do1iU8sWVygXrx0O3ERjD36n/WGA9tkzWqbGwCZ7b6R6n
         SOLrndu4eYXcl/XRPEdeh/BpNcMJlDzHW03I3odtuObW5iIaVPVCfN7JyI8MHPV81S7Y
         uGhC6LGrNbn5HT4MIOoIgH1C4wk5VwJ20PfiGd0qrMe6cmznL3GVhBRGtSwrRkjhq57l
         oN8g==
X-Gm-Message-State: AOAM532P47tOz5Cn7prGZte5uTgkZE2PQbgMMnCT3fNQqPBSq9Uqm7to
        7BWlGpy7jNfL2h5JUWO54/gUJh9c10A=
X-Google-Smtp-Source: ABdhPJxnyOhZ35h28/bOkhhYZOuaLQ4rjD8omR9kKDbqeOsMnimoD40kdFYuq6WsC0htIb6fZApoxA==
X-Received: by 2002:aed:3e9b:: with SMTP id n27mr2693928qtf.352.1593008985295;
        Wed, 24 Jun 2020 07:29:45 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id p29sm3736262qtu.15.2020.06.24.07.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 07:29:41 -0700 (PDT)
Subject: Re: [PATCH 1/2] revision: use repository from rev_info when parsing
 commits
To:     Michael Forney <mforney@mforney.org>, git@vger.kernel.org
References: <20200623205659.14297-1-mforney@mforney.org>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <88d8b24c-a0ae-bbbf-dd1f-5adb7a36ee95@gmail.com>
Date:   Wed, 24 Jun 2020 10:29:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200623205659.14297-1-mforney@mforney.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/23/2020 4:56 PM, Michael Forney wrote:
> This is needed when repo_init_revisions() is called with a repository
> that is not the_repository to ensure appropriate repository is used
> in repo_parse_commit_internal(). If the wrong repository is used,
> a fatal error is the commit-graph machinery occurs:
> 
>   fatal: invalid commit position. commit-graph is likely corrupt
> 
> Since revision.c was the only user of the parse_commit_gently
> compatibility define, remove it from commit.h.

Is this demonstrable in a test case, to prevent regressions?

Notably, you are _not_ dropping parse_commit(), and it would be
easy for another call to that shim to slip into revision.c.

> Signed-off-by: Michael Forney <mforney@mforney.org>
> ---
>  commit.h   |  1 -
>  revision.c | 18 +++++++++---------
>  2 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/commit.h b/commit.h
> -#define parse_commit_gently(item, quiet) repo_parse_commit_gently(the_repository, item, quiet)

I'm happy we can drop this shim!

> diff --git a/revision.c b/revision.c
> index ebb4d2a0f2..2b6bf47c81 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -439,7 +439,7 @@ static struct commit *handle_commit(struct rev_info *revs,
>  	if (object->type == OBJ_COMMIT) {
>  		struct commit *commit = (struct commit *)object;
>  
> -		if (parse_commit(commit) < 0)
> +		if (repo_parse_commit(revs->repo, commit) < 0)

I counted 9 copies of parse_commit[_gently]() in my version
of revision.c, so it looks like you caught them all.

Thanks!
-Stolee

