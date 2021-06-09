Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECCBC48BCF
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 17:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2155661040
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 17:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhFIRYR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 13:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbhFIRYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 13:24:16 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C83C061574
        for <git@vger.kernel.org>; Wed,  9 Jun 2021 10:22:21 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id v17-20020a4aa5110000b0290249d63900faso2674071ook.0
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 10:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=hMMsv4WR9ywt3tRDqcSArb578+BzdvkDlJjIUUUShoI=;
        b=KGYgsr6dYGTYQJm8LmlF9nn7Fj/otNmSODjXxeJSFRbJs+Oa1EA3EnoCaHrWP6T0RH
         yj0cFOoJc4GhGXMxWxMKwmIbUmox6Pj1g2uW//yKFStrB84ZLtzG0tG9mj8kzcmneH1+
         PKk3pPc37APzDYDLanRBoWvOuBI2nBYPDxAxW+j6aLDGGrU8ZPLt0B4G9bihTjitsNyE
         uIBByf5+hyUsPO2CPqZG+8KRm1EtJQ4Xiv5RMHXSJWq6KRjut7dxmBk9Ta5ru/PCGQIe
         IjKqS+4H3Zi1EeQxPse0Ofiy96H3V+P0DcqMH0um/P8opxLw3Umq95oE+m7rTp6ezEyQ
         sTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=hMMsv4WR9ywt3tRDqcSArb578+BzdvkDlJjIUUUShoI=;
        b=bG3C9mYEmQNcIGTzsDzstgcT33H9WTmqerX94ZjoEkRrMr8D/aQozN7kf1zeUtVl7/
         /nZBTthRmaK5sN4KAUH+bI5xeeDGtPRTzBurrX7tABwbRQJKu6ZXJO1xVM/lL3DSyS63
         FE/TkAjYJlLWADj1SLH63voppVp3OrJ8eCUXNYmVdosJnTUan4LAA856XNPBXCO69IJK
         iMh/gjnOvciM1EyY+PxgqJ+3RfcrlidjmY0K+GUTdOHdHV9YdqvSZNq3HGwF8aDj9EGk
         4fGIY2EftJPg4cd1kEcWSAaDkKU0KtQ66+2dAJpVBne+Lu6naLmi8oxIc0EWxWUT7n5e
         JDwg==
X-Gm-Message-State: AOAM531x3smzfw0NtpGP4AWE6zeJw+wNg2UwADVrHsyLPWqezDVEbazq
        q5b1JN+90f9AzZVet8Zqe4s=
X-Google-Smtp-Source: ABdhPJzQPNXSAmY2nRI6BmCJLHVGUCQYX2tClgojFAiklAJCqMNeTwxcXDRNiHHBeD4HG1N3sVeXDg==
X-Received: by 2002:a4a:97ed:: with SMTP id x42mr778673ooi.49.1623259339627;
        Wed, 09 Jun 2021 10:22:19 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id a7sm65649ooo.9.2021.06.09.10.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 10:22:19 -0700 (PDT)
Date:   Wed, 09 Jun 2021 12:22:17 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, stolee@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Derrick Stolee <derrickstolee@github.com>
Message-ID: <60c0f8c9d69c8_10749208d2@natae.notmuch>
In-Reply-To: <87a6nz2fda.fsf@evledraar.gmail.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
 <87a6nz2fda.fsf@evledraar.gmail.com>
Subject: Re: [PATCH v2 0/4] Use singular "they" when appropriate
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> The below for-show patch[2] shows an alternate approach that I think is=

> a better direction than this series.
> =

> It shows how some of the s/he|she/they/g search-replacements you did
> could IMO be better if we simply reduced the amount of prose, e.g. in
> strbuf.h changing:
> =

>     passes a context pointer, which can be used by the programmer of th=
e
>     callback as she sees fit.
> =

> To:
> =

>     passes a `void *context` to the callback `fn`
> =

> Is a better change than a mere s/she/they/g. Nobody needs all this
> verbosity to understand the common pattern of passing a user-controlled=

> 'void *` to a callback. It's implicitly understood by the technical
> level of the reader this documentation is targeted at.

!00% agreed.

> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -551,6 +551,31 @@ Writing Documentation:
>   documentation, please see the documentation-related advice in the
>   Documentation/SubmittingPatches file).
>  =

> + Prefer succinctness and matter-of-factly describing functionality in
> + the abstract. E.g.:
> +
> +     --short:: Emit output in the short-format.
> +
> + Not something like these overly verbose alternatives:
> +
> +     --short:: Use this to emit output in the short-format.
> +     --short:: You can use this to get output in the short-format.
> +     --short:: A user who prefers shorter output could....
> +     --short:: Should a person and/or program want shorter output, he
> +               she/they/it can...

I'm a big fan of this succinct approach.

> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -240,17 +240,17 @@ already exists on the remote side.
>  This option overrides this restriction if the current value of the
>  remote ref is the expected value.  "git push" fails otherwise.
>  +
> +When collaborating with others this is safer than using the `--force` =
option.
>  Imagine that you have to rebase what you have already published.
> -You will have to bypass the "must fast-forward" rule in order to
> -replace the history you originally published with the rebased history.=

> -If somebody else built on top of your original history while you are
> -rebasing, the tip of the branch at the remote may advance with her
> -commit, and blindly pushing with `--force` will lose her work.
> -+
> -This option allows you to say that you expect the history you are
> -updating is what you rebased and want to replace. If the remote ref
> -still points at the commit you specified, you can be sure that no
> -other people did anything to the ref. It is like taking a "lease" on
> +By using `--force` you might inadvertently clobber commits that
> +someone else pushed on top of branch.

* the branch?

> ++
> +
> +Unlike `--force`, `--force-with-lease` will transmit the expected
> +object ID to the remote server (similar to linkgit:git-update-ref[1]'s=

> +`<oldvalue>`, and thus provides a safeguard against inadvertently
> +clobbering remote refs which have changed since you retrieved them
> +with `git fetch`. Using this option has the effect of taking a "lease"=
 on

Clearer and more useful. I didn't even notice where the gender of the
reader was replaced, or where it supposedly came from.

Instead we focus on what's important: instructing the user.

>  the ref without explicitly locking it, and the remote ref is updated
>  only if the "lease" is still valid.
>  +
> diff --git a/config.h b/config.h
> index 9038538ffd..a2200f3111 100644
> --- a/config.h
> +++ b/config.h
> @@ -450,8 +450,8 @@ void git_configset_init(struct config_set *cs);
>  /**
>   * Parses the file and adds the variable-value pairs to the `config_se=
t`,
>   * dies if there is an error in parsing the file. Returns 0 on success=
, or
> - * -1 if the file does not exist or is inaccessible. The user has to d=
ecide
> - * if he wants to free the incomplete configset or continue using it w=
hen
> + * -1 if the file does not exist or is inaccessible. The caller decide=
s
> + * whether to free the incomplete configset or continue using it when

Gramatically correct and clear. This is a good change.

>   * the function returns -1.
>   */
>  int git_configset_add_file(struct config_set *cs, const char *filename=
);
> diff --git a/strbuf.h b/strbuf.h
> index 223ee2094a..c7c67cfe14 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -337,8 +337,8 @@ const char *strbuf_join_argv(struct strbuf *buf, in=
t argc,
>   * placeholder is unknown, then the percent sign is copied, too.
>   *
>   * In order to facilitate caching and to make it possible to give
> - * parameters to the callback, `strbuf_expand()` passes a context poin=
ter,
> - * which can be used by the programmer of the callback as she sees fit=
.
> + * parameters to the callback, `strbuf_expand()` passes a
> + * `void *context` to the callback `fn`

Simple and to the point. +1

Cheers.

-- =

Felipe Contreras=
