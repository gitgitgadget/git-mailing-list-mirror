Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445D6C433E1
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 11:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01FB661A31
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 11:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhCYLEX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 07:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhCYLEQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 07:04:16 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94E2C06174A
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 04:04:14 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id c17so1674766pfn.6
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 04:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MXdgl4sGCtpeqkU0oFf+aQcnEqApRk5BPIOm1oT4Eys=;
        b=jfyKZFTljo+DOhdfXWw9ev8DfhL4YihLRvfmj/AvveogieeLe5c2lzhaYgzjLPaNTu
         n8L5z/3PD5qT4wpZC3m0NvRXGa9xalP7EZUWMBKBeTkvhKke4HeR8+ez23qvK+rXKEAs
         iFTbWbi5gpJz0mRrmVkyDAx4oTtE190w6Od85dtMzCOcERTREd/jxzvitMx1eikpoPzi
         S2mM7A4UynTpJRAVRte0P+wRecEWK3/SILd+4P6mnO5NlViX5SwCVKo461UAUZ8Dfryc
         Bj/cHycHBucV8yEq941F9/YQ9jar6kNlZfOvl6jgedzzzLWmFMiIhHeK9PXCg8/6/+3y
         2mlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MXdgl4sGCtpeqkU0oFf+aQcnEqApRk5BPIOm1oT4Eys=;
        b=SqZbgJ1utb2ZAjEB6a0IFJUNggPWUFydWxAzBmYl0H778qPIsqqD1+R5NzcwPrNIAQ
         ZNtOeIS2QbOb852s+Md6fcqGTI6xxn5+Nn9cJvLoVlbzK9qPOgFZbnxQiGB/188MgDKN
         JytTys/AdQ076HKWywiowP3eHvi2/WjAQUiQMfK7xnF4Qy45yMz+u36NEemwTwhymoyN
         yMus8Oq+gajCxU+Z8q6H8YoblxvoFXz9CtVh1Nwqv/esH3HfWG9rtKEwLcaylrWZxx7b
         YjuqE2svSD4kqbW7kt49PgUn1JzP5mbKu3CXIgxcUTmR1jaOyg8+R4DesVKbl0rnupCn
         uTdA==
X-Gm-Message-State: AOAM531gFAtyryPjMBfTqJcnXsrtpre+ewF4OGAgDVtCjsK91Xpl/fLZ
        rtBDveeEF6POoAIWdHlSbK8x+nFDeUa1NQ==
X-Google-Smtp-Source: ABdhPJwPcHCr0BXFY+JfFSmOekXT+EGmarECb9Xj6NooopUAmYQ8bYbQwrVl4xptVkti0sWpvLEeKA==
X-Received: by 2002:a17:903:230d:b029:e7:1052:a94d with SMTP id d13-20020a170903230db02900e71052a94dmr8156260plh.0.1616670254153;
        Thu, 25 Mar 2021 04:04:14 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-39.three.co.id. [116.206.28.39])
        by smtp.gmail.com with ESMTPSA id o9sm6142935pfh.47.2021.03.25.04.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 04:04:13 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] pathspec: warn for a no-glob entry that contains
 `**`
To:     =?UTF-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <xmqqft1iquka.fsf@gitster.g>
 <20210325102228.14901-1-stdedos@gmail.com>
 <20210325102228.14901-2-stdedos@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <af50b7e9-3594-ac46-ed1b-23f3143fe11e@gmail.com>
Date:   Thu, 25 Mar 2021 18:04:10 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210325102228.14901-2-stdedos@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/03/21 17.22, Σταύρος Ντέντος wrote:
> From: Stavros Ntentos <133706+stdedos@users.noreply.github.com>
> 
> If a pathspec is given that contains `**`, chances are that someone is
> naively expecting that it will do what the manual has told him that `**`
> will match (i.e. 0-or-more directories).
> 
> However, without an explicit `:(glob)` magic, that will fall out the sky:
> the two `**` will merge into one star, which surrounded by slashes, will
> match any directory name.
> 
> These changes attempt to bring awareness to this issue.
> 
> Signed-off-by: Stavros Ntentos <133706+stdedos@users.noreply.github.com>
> ---
>   pathspec.c                 | 13 +++++++++++++
>   pathspec.h                 |  1 +
>   t/t6130-pathspec-noglob.sh | 13 +++++++++++++
>   3 files changed, 27 insertions(+)
> 
> diff --git a/pathspec.c b/pathspec.c
> index 7a229d8d22..9b5066d9d9 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -1,3 +1,4 @@
> +#include <string.h>
>   #include "cache.h"
>   #include "config.h"
>   #include "dir.h"
> @@ -588,6 +589,8 @@ void parse_pathspec(struct pathspec *pathspec,
>   
>   		init_pathspec_item(item + i, flags, prefix, prefixlen, entry);
>   
> +		check_missing_glob(entry, item[i].magic);
> +
>   		if (item[i].magic & PATHSPEC_EXCLUDE)
>   			nr_exclude++;
>   		if (item[i].magic & magic_mask)
> @@ -739,3 +742,13 @@ int match_pathspec_attrs(const struct index_state *istate,
>   
>   	return 1;
>   }
> +
> +void check_missing_glob(const char *entry, int flags) {
> +	if (flags & (PATHSPEC_GLOB | PATHSPEC_LITERAL)) {
> +		return;
> +	}
> +
> +	if (strstr(entry, "**")) {
> +		warning(_("Pathspec provided contains `**`, but no :(glob) magic.\n\tIt will not match 0 or more directories!"));
> +	}
Why an extra \t? Unnecessary indentation?
> +}
> diff --git a/pathspec.h b/pathspec.h
> index 454ce364fa..913518ebd3 100644
> --- a/pathspec.h
> +++ b/pathspec.h
> @@ -157,5 +157,6 @@ char *find_pathspecs_matching_against_index(const struct pathspec *pathspec,
>   int match_pathspec_attrs(const struct index_state *istate,
>   			 const char *name, int namelen,
>   			 const struct pathspec_item *item);
> +void check_missing_glob(const char* pathspec_entry, int flags);
>   
>   #endif /* PATHSPEC_H */
> diff --git a/t/t6130-pathspec-noglob.sh b/t/t6130-pathspec-noglob.sh
> index ba7902c9cd..1cd5efef5a 100755
> --- a/t/t6130-pathspec-noglob.sh
> +++ b/t/t6130-pathspec-noglob.sh
> @@ -157,4 +157,17 @@ test_expect_success '**/ does not work with :(literal) and --glob-pathspecs' '
>   	test_must_be_empty actual
>   '
>   
> +cat > expected <<"EOF"
> +warning: Pathspec provided contains `**`, but no glob magic.
> +EOF
> +test_expect_success '** without :(glob) warns of lacking glob magic' '
> +	test_might_fail git stash -- "**/bar" 2>warns &&
> +	grep -Ff expected warns
> +'
> +
> +test_expect_success '** with    :(literal) does not warn of lacking glob magic' '
Padding with without test above?
> +	test_might_fail git stash -- ":(literal)**/bar" 2>warns &&
> +	! grep -Ff expected warns
> +'
> +
>   test_done
> 

-- 
An old man doll... just what I always wanted! - Clara
