Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8461ECAAD3
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 17:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiIIRYg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 13:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiIIRYd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 13:24:33 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACD238A3
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 10:24:30 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o2-20020a17090a9f8200b0020025a22208so5982277pjp.2
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 10:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=BxDWYfL0+gG5uPVV0gXsUFdxtXNVoPQ14iq4KsIg7ng=;
        b=CnW7usC62KXcf3HSVrjI/ho/lYiiSfinuzsOlYAo+Tjc4LP5az69RO6aFiQmf+pr1/
         srQh+0vxGxPUgE+tr7/1JE8kJzZP9NT2ornf9BcUo597MUlLPNyQtkaj1N2x8hkSTQ5c
         zl58f2TM8Hf9u/ls2YXfTYdZ2bObmOBMJ+TVkgq3oP7W3gbqqnkR7ZiEOThNJzk9X2VL
         y5Zyv13X8QhipG7RvK0H2deFEoteYwoMoF2wYV/UTL5ykc23GIRxmolHTPRNfAVTqRed
         d8rT8cIgy/1POBrvO5hiIuFQpNHneyjOeWN4WGOp0IQtJy+/q3gi3LUcTngeJIA/jCsq
         JDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=BxDWYfL0+gG5uPVV0gXsUFdxtXNVoPQ14iq4KsIg7ng=;
        b=tK3fJ5/WjfJ9NPPx2+z85fn2M/kan1UFiwwcXLVgNcwov/UfitrbbDxw4+pUCkH1E2
         Aord/F5Fro3waSck+YW5YlZgZqn9d/SAtezQN1jYJQvQAHt+BZDEMGA9QLn0rxe9Amy0
         fngiA06DiAWvGvdlAB/jMpQMs/bOoHlj1ACPdbEh1zlMBYStKqBPnu+7qUgk/3fQHi4i
         z34UmnaqhFrlGvWw48GtznUOmDppfLDPVMLqweoyNSG3twAES2Cj6eks3h3SBuWl0EmD
         h4bitwzQvIDFYjg4hVrX5m5esokTxtNeDrzIqoFJlTHF2UJWOCGEMSTJjr1Aes1qw0xZ
         l+tw==
X-Gm-Message-State: ACgBeo3tyf5yuNs18RDgvvu0U4wolRMUAeLDkeTkEM0yYJo35Xz1Gu3a
        2m0ieMETciPGrgdw8zhdEL8POriwZyM=
X-Google-Smtp-Source: AA6agR4CI0EzI6CHHNZnHdk9vPKw7aH0JZ1BcABI9PvIxOnvV0rg8giJzSxa2tGZSDSVXWbabsF26Q==
X-Received: by 2002:a17:90b:4a4f:b0:202:8d29:c188 with SMTP id lb15-20020a17090b4a4f00b002028d29c188mr3762503pjb.199.1662744269740;
        Fri, 09 Sep 2022 10:24:29 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id g8-20020a635208000000b0040caab35e5bsm723777pgb.89.2022.09.09.10.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 10:24:29 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Teng Long <dyroneteng@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 1/9] bundle-uri: short-circuit capability parsing
References: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
        <pull.1333.v2.git.1662734015.gitgitgadget@gmail.com>
        <2ca431e6c377f42d70ea9ce0ac74058fc983ea2c.1662734015.git.gitgitgadget@gmail.com>
Date:   Fri, 09 Sep 2022 10:24:29 -0700
In-Reply-To: <2ca431e6c377f42d70ea9ce0ac74058fc983ea2c.1662734015.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Fri, 09 Sep 2022
        14:33:27 +0000")
Message-ID: <xmqqleqslauq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> When parsing the capability lines from the 'git remote-https' process,
> we can stop reading the lines once we notice the 'get' capability.
>
> Reported-by: Teng Long <dyroneteng@gmail.com>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  bundle-uri.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/bundle-uri.c b/bundle-uri.c
> index 4a8cc74ed05..7173ed065e9 100644
> --- a/bundle-uri.c
> +++ b/bundle-uri.c
> @@ -56,8 +56,10 @@ static int download_https_uri_to_file(const char *file, const char *uri)
>  	while (!strbuf_getline(&line, child_out)) {
>  		if (!line.len)
>  			break;
> -		if (!strcmp(line.buf, "get"))
> +		if (!strcmp(line.buf, "get")) {
>  			found_get = 1;
> +			break;
> +		}
>  	}

Hmph, is this safe to do?  Who is feeding child_out?  Aren't they
get upset if we do not slurp what they write to us?  Are we
expecting to read more from them after this part?  Aren't we get
upset if we leave some other stuff when we read from child_out after
we saw "get"?  If we respond to child_in without reading all from
them, do we not get into a deadlock?

Perhaps these are all silly questions, but the description above
does not quite answer them.

>  	strbuf_release(&line);
