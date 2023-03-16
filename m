Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5A5C74A5B
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 21:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjCPVbZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Mar 2023 17:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjCPVbX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2023 17:31:23 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F9019A8
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 14:31:23 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id le6so3207232plb.12
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 14:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679002282;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k/pIkdhHzHkqHnydgXAdYCOAdN3pJvuZDIyHyOurCcU=;
        b=bu+JMdG6RxjAnOgETUa7lZnGnVRcc0Cv8l98uai8P87hoh1pVhUxjT3w9p6TGHDetQ
         nMysAGD9UG+I/8pc6aTIxresQkn1P38XjyNjkl4sr+4U0D/c6csegtn8kOYzeRBajRYe
         9J4zgLLbOEhqyt82kTK8T4r1KkDFHYMY0LrV58ed/wYT8wBhBsP0A5Qkh02v17ppRsnC
         aSas2w3xM/cSwk5DBCnzwB5CakXoc76LSDQ/Fuv1UUoQxSGyQ+UWhM91UXNTrlvyilZK
         6V3I4qpqXV0lsBcLqcrLlsb3xIfwiUcaI4HpSYg7/z8Z2TjGgABW+VlE3XnrRorAwuZV
         y/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679002282;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k/pIkdhHzHkqHnydgXAdYCOAdN3pJvuZDIyHyOurCcU=;
        b=7Z9G4D6gq0iRo9vsWE+CN49Y2OfkqQHZJP0YBHdT/dvdhbgHwfbe1jCcIlchNhWwZV
         tOReccNbkquyPJ/bAMQMFnHlVbDwLy9jTFz77NQgDO+pIzpCPgCxKD7EF4r5vMpcI/6T
         K4nsO+K5Z8PspP2GIa6Wfe8txg+t5aBMLW9irh3fZqdjeYAhaT5uuDCtQ9FUPwg+OnOr
         5n8VODgc9IGWVeyIPHjvsc9cUT9V+c0OrO2ZXr6fRH3aIBTjzfdxpYYKORkiA+W8af/9
         UHCG3g3y445eqGM6GACSIQS7FfvJxrkU5k7ee9Y45Uj8PwjYBGcAYolpG6GEhlS3TAi2
         KQTw==
X-Gm-Message-State: AO0yUKVaCHm3AywgPVvVePqT22kP3goV899WKgD2GrPHzQYXHPAVwH8O
        uF0VlVYoEg4PLqlWjQZ/9zw=
X-Google-Smtp-Source: AK7set8ZgPC3DLeXhteA52kR8wS8StU9yxi99SVaHM3QJxNkmQskdGqk3Gh9gLg8L6gCSJdJCW+/QQ==
X-Received: by 2002:a17:903:2450:b0:19c:e405:4446 with SMTP id l16-20020a170903245000b0019ce4054446mr5916548pls.30.1679002282483;
        Thu, 16 Mar 2023 14:31:22 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id p17-20020a170902a41100b0019f232619d7sm149209plq.173.2023.03.16.14.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 14:31:21 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Calvin Wan <calvinwan@google.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v2 2/8] config.c: don't assign to "cf_global" directly
References: <20230316211821.313426-1-jonathantanmy@google.com>
Date:   Thu, 16 Mar 2023 14:31:21 -0700
In-Reply-To: <20230316211821.313426-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Thu, 16 Mar 2023 14:18:21 -0700")
Message-ID: <xmqq4jqkjsd2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> +static inline void config_reader_push_source(struct config_source *top)
>> +{
>> +	if (cf_global)
>> +		top->prev = cf_global;
>
> Don't we want to set prev unconditionally here (i.e. set it to NULL if
> cf_global was NULL)?

Good eyes.  You are absolutely right.
Thanks.

>
>> +	cf_global = top;
>> +}
>> +
>> +static inline struct config_source *config_reader_pop_source()
>> +{
>> +	struct config_source *ret;
>> +	if (!cf_global)
>> +		BUG("tried to pop config source, but we weren't reading config");
>> +	ret = cf_global;
>> +	cf_global = cf_global->prev;
>> +	return ret;
>> +}
>
> ...since we use it unconditionally here.
>
> The rest looks good.
