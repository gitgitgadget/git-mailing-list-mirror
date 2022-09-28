Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379C7C04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 23:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbiI1XE3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 19:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbiI1XE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 19:04:27 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014F51191A6
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 16:04:24 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r7so21965994wrm.2
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 16:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date;
        bh=107snoycC7BohFGY9nym+2RPy3jFoxu6hAj0qYjesgE=;
        b=L193FhfQ/P8GKe05wcFu5X22LsP5xgEe1jV4ue8bnVABnrN4GGUOpvnzchiRO03+fE
         h3D4tHslRTHjt2/1FSJH4BRnfIxtm/y/8MwPmKQ/FnJXuMDfVsOnrq6BOSgpnWjHDEfG
         3V2NSEUkYcbZTQB08uScOh/4aajFWj7nzT7sU3cDTLa5jYo1jnYfBUMTwSdTtZ4Z77Ki
         cJ6InN0fRtYKmjgSoEMPvnhi2Zuh6lHjEV9dmQgEAhBQO7pvdtK5nl6UwOzIliC6/IrY
         XsSA1X68M+k1sECxo/X8/Y4k/mW9M7MmGBpToFHQaZAd4rdWDvE4BDDqIl1dbLDkvv6+
         tRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date;
        bh=107snoycC7BohFGY9nym+2RPy3jFoxu6hAj0qYjesgE=;
        b=pWIH1rlWFBWykMdwGBaBnsx8I9PYgBeKgf0sdphx0h9bzifwWvb+ErhU4jNeRUuilS
         CnwH/vIkn4qZ8YqoT9Fz3+OaUSTOLF2674+ZcgcZpbRZ4DxaYZMo6A5UROKS9hYnhdSG
         KVyoDm+mNlzS4QMBChVNpa8/wFs5Escur9B0D5gXn0Rq9LHHthCjGLcWqZxQQu0vf9bd
         P8gneBzyFLxbl3YYW1jTjeQevhUBdqaM+z9ARO3THbB3jNiCL9CxNQG7eTdjyNukzVLi
         CzxQpxClxZ1DBCYws7nZsGkW7d1oreEVqWE8t8xKDIERKVV9StR2b8/5BnK8FDGqUy8q
         dDtg==
X-Gm-Message-State: ACrzQf17gbMqflJ5tMlve6IRN16iWQFzmF1tG3Q/iIQ2RAWw0KfFjpD0
        W/t5aM1SyHPXZLpV+uO+GqBWc4NgXqo=
X-Google-Smtp-Source: AMsMyM6P1N3mMrKBxnT0qO/GVOZryUXGHNksjtuXZnz5lesrg55EdiwMl/0tGF+E66ExkS42+r+HGg==
X-Received: by 2002:a5d:64e4:0:b0:22a:4997:c13c with SMTP id g4-20020a5d64e4000000b0022a4997c13cmr86977wri.621.1664406263325;
        Wed, 28 Sep 2022 16:04:23 -0700 (PDT)
Received: from [192.168.2.52] (5.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.5])
        by smtp.gmail.com with ESMTPSA id e16-20020a05600c2dd000b003b47e8a5d22sm2998280wmh.23.2022.09.28.16.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 16:04:22 -0700 (PDT)
Subject: Re: [PATCH] branch: do not fail a no-op --edit-desc
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqczbftina.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <1faa5c44-1a59-7a60-d29b-c4d4e8d0bf92@gmail.com>
Date:   Thu, 29 Sep 2022 01:04:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqczbftina.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/9/22 21:15, Junio C Hamano wrote:
> In a repository on a branch without branch description, try running

On a branch without description, ..

> The simpler solution of course introduces TOCTOU, but you are

Nice to introduce a term that can generate curiosity.

> fooling yourself in your own repository.  Not overwriting the branch
> description on the same branch you added in another window, while
> you had this other editor open, may even be a feature ;-)

Not overwriting if there was no description in the first place, otherwise
will clear.. ¿?

> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/branch.c  | 6 ++++--
>  t/t3200-branch.sh | 3 +++
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git c/builtin/branch.c w/builtin/branch.c
> index 5d00d0b8d3..dcd847158a 100644
> --- c/builtin/branch.c
> +++ w/builtin/branch.c
> @@ -604,10 +604,11 @@ static GIT_PATH_FUNC(edit_description, "EDIT_DESCRIPTION")
>  
>  static int edit_branch_description(const char *branch_name)
>  {
> +	int exists;
>  	struct strbuf buf = STRBUF_INIT;
>  	struct strbuf name = STRBUF_INIT;
>  
> -	read_branch_desc(&buf, branch_name);
> +	exists = !read_branch_desc(&buf, branch_name);
>  	if (!buf.len || buf.buf[buf.len-1] != '\n')
>  		strbuf_addch(&buf, '\n');
>  	strbuf_commented_addf(&buf,
> @@ -624,7 +625,8 @@ static int edit_branch_description(const char *branch_name)
>  	strbuf_stripspace(&buf, 1);
>  
>  	strbuf_addf(&name, "branch.%s.description", branch_name);
> -	git_config_set(name.buf, buf.len ? buf.buf : NULL);
> +	if (buf.len || exists)
> +		git_config_set(name.buf, buf.len ? buf.buf : NULL);
>  	strbuf_release(&name);
>  	strbuf_release(&buf);
>  
> diff --git c/t/t3200-branch.sh w/t/t3200-branch.sh
> index 9723c2827c..5f72fd7453 100755
> --- c/t/t3200-branch.sh
> +++ w/t/t3200-branch.sh
> @@ -1381,6 +1381,9 @@ test_expect_success 'branch --delete --force removes dangling branch' '
>  '
>  
>  test_expect_success 'use --edit-description' '
> +	EDITOR=: git branch --edit-description &&
> +	test_must_fail git config branch.main.description &&
> +
>  	write_script editor <<-\EOF &&
>  		echo "New contents" >"$1"
>  	EOF
> 

The change looks fine and removes a confusing error. Good.

Thanks.
