Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DEEFA3740
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 19:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbiJ0TmJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 15:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbiJ0TmH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 15:42:07 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7F37EFCA
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 12:42:05 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9so2643075pll.7
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 12:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VM/jWu0GWHNugR2ffz3HrjTskLvlnCgSl2g/2rwMb70=;
        b=Rjqw6CiP5xZ1WYF5NDJcaQF/Fw4DoKY026GIsEFAggf2fTY8rdE6FSzmSvz6WJgvx/
         wzk1PGJkwxBq0mmR7sVw9wW/kj+9+1aULVq/FEC4k13z2XVFMXQYGc1WY5pVxxikEUuV
         VfoR98rO/NbSFzpbWMQGsFTb5ERqBWYO7W/4a8VsErN2pBTlr3cr5SeGGthf6dW3TKEy
         Kd/aVODwYtW3aVCyOa9ixMw0y1J0NraGGljeGMSAI3AXoevRXwlaZ3IWyzgbg7Z9CAjZ
         R1ZevwLFHsiNj8qW9w5KsisRLH6IB8a7Mkj4ycpQ3f0Wy4v7LoxuRzLWKXKrQwTej9DH
         OTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VM/jWu0GWHNugR2ffz3HrjTskLvlnCgSl2g/2rwMb70=;
        b=MN9c3tip+KPUKuTEgNWmUOH3YoqnwBM7bLAMHU8WoiYWdFML6/h28Rc+/5xyXlFmch
         sp7puKM6jL9nwLzOtS5lINDZ541KvKPqvaLLcX6s1YKDkdQrCMF2evY0RLH2Pw0jg07w
         KEAPCQVyVc0gQ+HCOWYxlMYL5FxSJiMRlhtASmlEX/Wj5YlFmwPcfHg2NJ9BOE2UGJef
         Oyg0bE7P39Uq95g3MWFhdgHPTUYCVKKm7ANlTN4jsocfmA/p7u7+QJJF2ZEPdMtK7mkB
         aG7NvHUcvpjr9DMsb8r5Rw5K0ADmJE9CFCFY/eIPuU5E96JDeeYDomtefipNZ5dSjuEJ
         bvOg==
X-Gm-Message-State: ACrzQf2PR5QqyxF23lzYWKkyNlvQi8Buod3OEcaIVY0ryukJyOJ0Q3iT
        Yp7spXDcCkBVEheU4iA5EoI=
X-Google-Smtp-Source: AMsMyM7oQndl8Nsm2hbOeIJCqhxNZJzVCAYPNH4HPBsk/b/SVtiQvxtGCImbnbIQ0G/UfI1DDf4pgA==
X-Received: by 2002:a17:903:41c5:b0:186:ceff:f805 with SMTP id u5-20020a17090341c500b00186cefff805mr13414880ple.31.1666899724981;
        Thu, 27 Oct 2022 12:42:04 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id v9-20020a1709029a0900b00186616b8fbasm1567177plp.10.2022.10.27.12.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 12:42:04 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>
Subject: Re: [PATCH 07/10] config API: add and use "lookup_value" functions
References: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com>
        <patch-07.10-c01f7d85c94-20221026T151328Z-avarab@gmail.com>
Date:   Thu, 27 Oct 2022 12:42:04 -0700
In-Reply-To: <patch-07.10-c01f7d85c94-20221026T151328Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 26 Oct
 2022 17:35:20
        +0200")
Message-ID: <xmqqczadkq9f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Change various users of the config API who only wanted to ask if a
> configuration key existed to use a new *_config*_lookup_value() family
> of functions. Unlike the existing API functions in the API this one
> doesn't take a "dest" argument.

When I hear "lookup-value", the first thing I would expect was
"look-up by value" (i.e. the reverse look-up to find key).  That is
not what is going on.

What is presented here is "does the key have corresponding value
defined in the configuration system, yes/no?", isn't it?

I would expect such a function to be named *_config_key_exists().

> diff --git a/config.h b/config.h
> index a5710c5856e..cf1ae7862a8 100644
> --- a/config.h
> +++ b/config.h
> @@ -502,6 +502,8 @@ void git_configset_clear(struct config_set *cs);
>   * is owned by the cache.
>   */
>  int git_configset_get_value(struct config_set *cs, const char *key, const char **dest);
> +RESULT_MUST_BE_USED
> +int git_configset_lookup_value(struct config_set *cs, const char *key);

This must be documented, especially if we give it such a bad name ;-).
