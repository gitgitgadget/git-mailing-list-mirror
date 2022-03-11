Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EFCC433F5
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 13:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348957AbiCKNo0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 08:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348950AbiCKNoY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 08:44:24 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522821C4B20
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 05:43:20 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a8so19193921ejc.8
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 05:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=6TZJ/Tcr+4y3RkgbhlcPWXSkc7cfjgY0HkgI9HNXNgg=;
        b=G3VgKQMasgDHqt0gUbcAf6+7Ia2rGiUUv9ZUEe5lIKrDvSuHztgPNQdGWD4vlyiRvg
         FCKjJjnWj+nCCaUX+mf/T6GHjUNswVx/Y5IeMXWnMy3siMxSQU4lV9YOnz6o22t8useN
         mmdmE3eCmU+wAvpNjB4uLsEoT6vFAe8yue+WJc2Vw0eqmr5Ub5sB8uJ5sPcNLeStH+Uo
         SaY1yg1V8D5P8lGjff5DNMmJ7E7hm4k2OsJhJi68rOXuKGjFFubmefrZMIXFJby0eIQQ
         xDajotLBSjZl2+IFuI3s3wLa/NtM98x3YdoTGdF1WfmarVrHwk4yTpklLX4a0YwPNqri
         lRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=6TZJ/Tcr+4y3RkgbhlcPWXSkc7cfjgY0HkgI9HNXNgg=;
        b=cwTyUNNaETVAdtSJQg+PgsQeRwTU4cBlN4jJBodaTyCLkNMGj5Hks55+KVZJsbzi+5
         +Cx4CpQt90E0jfNOo0afwDGxj4oOOAqXa10HNr1OIdJk9uYq07V8s9olNAY0Yu589o9m
         shTh1zbr55O/omHbPVbxoklW1z61odDf6v0TnJxiks1b+6h4lztAnub4thYrwhMRONE4
         9fN8KFYYx2Cv/vIplYKriBz/GDNrdD/KBZftWa8PHHE6572E1LLtwiKDzltMFPug06IY
         QWcmGwEiYQHVMlwCgRxqhxy+wCcqfLkX4Wm7cu7moFoa3XPYVvM+QjseZjAP/AtJj0S8
         iN8Q==
X-Gm-Message-State: AOAM53118JNQW5JJUcZR7k0u7tkW4JJ3+2tluEOaHk1zA/HIKvJO8F/E
        NA2S7t+BjynDrKfBsUZdcOIHTjANVaW5Rg==
X-Google-Smtp-Source: ABdhPJwOU68N/e9L52X+h+XUjPU6q+QA/ZbUuQ+e5DXKBusqokbWCgyfU8UdCaSj3L4YHRiJY7IV+Q==
X-Received: by 2002:a17:906:fc5:b0:6db:30df:df23 with SMTP id c5-20020a1709060fc500b006db30dfdf23mr8639186ejk.396.1647006198550;
        Fri, 11 Mar 2022 05:43:18 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id o2-20020a50d802000000b00410d7f0c52csm3345155edj.8.2022.03.11.05.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 05:43:18 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nSfY5-0012mo-EP;
        Fri, 11 Mar 2022 14:43:17 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        aevar@gmail.com, newren@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 11/25] bundle: allow relative URLs in table of contents
Date:   Fri, 11 Mar 2022 14:42:53 +0100
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
 <bdd5c664cde070a93d7e698aff2ab11ce7557ee2.1645641063.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <bdd5c664cde070a93d7e698aff2ab11ce7557ee2.1645641063.git.gitgitgadget@gmail.com>
Message-ID: <220311.86lexghafe.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 23 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
> [...]
> @@ -460,6 +463,10 @@ static int cmd_bundle_fetch(int argc, const char **argv, const char *prefix)
>  			    (!info->filter_str || strcasecmp(filter, info->filter_str)))
>  				continue;
>  
> +			old_uri = info->uri;
> +			info->uri = relative_url(bundle_uri, info->uri, NULL);
> +			free(old_uri);
> +

I had it on my TODO to look into how to do this, and hadn't dug yet,
it's really pleasing that we have an API to make it this simple.
