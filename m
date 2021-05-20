Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41617C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 15:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E8A8611ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 15:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbhETPLP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 11:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbhETPLP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 11:11:15 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F8EC061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 08:09:53 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id t15so19809036edr.11
        for <git@vger.kernel.org>; Thu, 20 May 2021 08:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=dmACOQSI7taJnGOGfoxcZPC4u6wTh/nT07gS9JbYE7g=;
        b=M09VtFWHAKJ132YF6a+2IjIAiq350VYNwV9aTTInRvSQ/cDOTqypVbydiMjeON92cO
         X653+cGwV0Xksw8QWObtdAoZyEj8fwUn/SBhsGhr2OsvfFnhqfLw+qI+7TwgIyx7OQ8N
         6JtKKaJuiE0WRuNJJMewXe/UtqPdYyO6KZbiIkD95IqTVk46KTvBUij+CNo66WHL+C8j
         w4lVF0GxnGdl0QuiWCobpTnw0byKCYNi8Wrxk4P7F5bX6FsCrwq+Mv9DxLSgi7E6nJ+j
         hO2z+IExOtq0GmuJ2L2tNLqp6V8aGPbe5kgtzcp4XPkthT4NeHuZcZ8hP7S7yF0fFdiy
         9zaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=dmACOQSI7taJnGOGfoxcZPC4u6wTh/nT07gS9JbYE7g=;
        b=jk7mgfK497Xckw4QEEgb/RNcQ6Ln/vA4KBngnijgof8GNcRaxwOxFbVlxbV2vl8u30
         KQtkPXrWWzvd+hSgy1CwiyC52Q98X+qf8i9V8JY1MQ///z8hwtSXXxeL9wxU+El35qtQ
         4UZ6Ja3eK2c4LF7E5KPtn7xVoWkGRioO3ppJQyO9oKnFwKO6M3u1oyI9b927LMdElZv0
         zVlaCP95fEWWKF+w9zlb03du2KvHpNXsozgVTywxVSNFdtPwbzymDiSlsrVbU7r0OSLc
         4OvtLkGMxVFgJOMkrV9poPVKrzMPDHQEwN7I6eaF79G9YdAmX5ASrlQX67i8tl6p9q3f
         hhOA==
X-Gm-Message-State: AOAM532skqoRELKyzBzquP+dH7AnQ9R+8jH5zyfXCQmlxduBu+VxPtXV
        TePfyVGgXgHCo8LzMz6E2eb2C1JPYoSu3g==
X-Google-Smtp-Source: ABdhPJz3MGHwj1bTXeEOduxp+oHy5n1fxREqXHZX4+xlARezQExlZW/j1WWWkmZgk+N9KzCw/Wk0IQ==
X-Received: by 2002:a05:6402:2691:: with SMTP id w17mr5572820edd.140.1621523391739;
        Thu, 20 May 2021 08:09:51 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id s2sm1716033edu.89.2021.05.20.08.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 08:09:51 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 02/21] t/helper/ref-store: initialize oid in resolve-ref
Date:   Thu, 20 May 2021 17:06:59 +0200
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
 <e6222944a3eb441d44ab6c7d1e9b873f5546220a.1619519903.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <e6222944a3eb441d44ab6c7d1e9b873f5546220a.1619519903.git.gitgitgadget@gmail.com>
Message-ID: <877djtqw5d.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 27 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> This will print $ZERO_OID when asking for a non-existent ref from the
> test-helper.
>
> Since resolve-ref provides direct access to refs_resolve_ref_unsafe(), it
> provides a reliable mechanism for accessing REFNAME, while avoiding the implicit
> resolution to refs/heads/REFNAME.
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  t/helper/test-ref-store.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
> index bba5f841c6ab..01d8f3285dc8 100644
> --- a/t/helper/test-ref-store.c
> +++ b/t/helper/test-ref-store.c
> @@ -118,7 +118,7 @@ static int cmd_for_each_ref(struct ref_store *refs, const char **argv)
>  
>  static int cmd_resolve_ref(struct ref_store *refs, const char **argv)
>  {
> -	struct object_id oid;
> +	struct object_id oid = { 0 };
>  	const char *refname = notnull(*argv++, "refname");
>  	int resolve_flags = arg_flags(*argv++, "resolve-flags");
>  	int flags;

This feels a bit magical, later we have this:

        printf("%s %s 0x%x\n", oid_to_hex(&oid), ref ? ref : "(null)", flags);

Isn't ref always going to be NULL in that case too? Wouldn't it make
more sense to not zero this out and instead do:

    if (ref)
        /* current code, mostly */
    else
        use zero_oid()

That seems more straightforward to me than this implicit proxy for
zero_oid(). Also, isn't the point of zero_oid() to not make this
particular assumption, i.e. the recent discussion (haven't followed
where it went) of the "oid" having some sort of "hash type" member,
which surely would do the wrong thing here under either SHA-1 or
SHA-256, or maybe I mis(understood|remember) that discussion...
