Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B33CCA47F
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 00:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiFHA16 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 20:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392520AbiFGW54 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 18:57:56 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A62132388E
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 13:02:36 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id z186-20020a6233c3000000b00510a6bc2864so9821654pfz.10
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 13:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=m69hN7dtOrF6ALMGXR8F8uMbRGfHV0RjD03m9TDUiKY=;
        b=IzTn1isSj2A9wX2qsxKEtDburYSQ6XtMXkCOPdW8r8z/0z3CADEjsOso1yQcBhbfZ4
         CmDfsghvlvGL+/uUgiwe9U03H9mt480JRjeAcX59zqH3nlj4wiG3G8zV1M8Ww46/gTyV
         eWvJ10Sr4Tc6fG99FDeTUze/7ffedL6BrbHIvBt6Fq4IVvKI2NUWB+wHyWybQd5IS/pL
         N5jXIH9nEYsTRFcM2Vg4KxFHB3TXZzUEVrbOGnZDigs87HOa0Hnd1cgiN8H0gTIQZ2k9
         Jy1oCGdwPD6paD5IVFOaBOkvNHoTOuxEF1VhuOIX9xNUIf7P1fa2ibWW+wVrMt4ywEQL
         uh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=m69hN7dtOrF6ALMGXR8F8uMbRGfHV0RjD03m9TDUiKY=;
        b=ETM1kl4FAUoiHEFvyh78eorq8y1A88b8U708Zqsj0HtoBnT1sYLknXMib58w58TsVv
         X0AjuKJQNHr6hK5e9zVyRM5fGutve5CICHhB4nIPVbk8Sq+Dfp8B3oIX2muk+MYmkQPU
         OpdRsfk6CmTWHWyevnnnTq7eCUQ5KmmO6itgl9FBncEAWtEoNmhN3seo3skOQDEcNy1N
         e3mjbXqked0B9qNY9ti+hyd4WVpJBjIxQ7RTzVvBqH7lydqbaCiwdjoDH1GtlaVE4mvy
         OZI+UyQr/rsMYNiCFNn8JJkrcKnBagovn4rN17wK2Zc3A27ZCWhgEfTBCoBss5EJbptf
         J7+w==
X-Gm-Message-State: AOAM5317dtjnJ6GfzzJIaU9kxMF9d0/pgjr5H5PfvunNwX7TBwV791eZ
        bcCxjYy8p69DmuviZwZW0k/IznK3JlwrW0lom9m+
X-Google-Smtp-Source: ABdhPJw3XmSqxXtMh4jzL5Ks26q915KjLzQolpxxK/uGYWI4pVc19vGiXa7K6EuSOJAE2JqJe3vMtd6JLtYGwTsgorkP
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:d2cb:b0:164:11ff:e55b with
 SMTP id n11-20020a170902d2cb00b0016411ffe55bmr30379269plc.111.1654632155295;
 Tue, 07 Jun 2022 13:02:35 -0700 (PDT)
Date:   Tue,  7 Jun 2022 13:02:31 -0700
In-Reply-To: <2c2bfc7b43c92dc7c0a4c47a2c88dadeb39c763b.1649486398.git.steadmon@google.com>
Message-Id: <20220607200231.1958109-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: Re: [RFC PATCH v2] commit-graph: refactor to avoid prepare_repo_settings
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        me@ttaylorr.com, derrickstolee@github.com,
        lessleydennington@gmail.com, gitster@pobox.com, vdye@github.com,
        avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:
> diff --git a/fuzz-commit-graph.c b/fuzz-commit-graph.c
> index e7cf6d5b0f..e53a2635f6 100644
> --- a/fuzz-commit-graph.c
> +++ b/fuzz-commit-graph.c
> @@ -11,7 +11,13 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
>  	struct commit_graph *g;
>  
>  	initialize_the_repository();
> -	g = parse_commit_graph(the_repository, (void *)data, size);
> +	/*
> +	 * Manually initialize commit-graph settings, to avoid the need to run
> +	 * in an actual repository.
> +	 */
> +	the_repository->settings.commit_graph_generation_version = 2;
> +	the_repository->settings.commit_graph_read_changed_paths = 1;
> +	g = parse_commit_graph_settings(&the_repository->settings, (void *)data, size);
>  	repo_clear(the_repository);
>  	free_commit_graph(g);

The comment doesn't explain why we need to avoid an actual repository. Maybe
better: Initialize the commit-graph settings that would normally be read from
the repository's gitdir.

Other than that, this patch looks good to me. Isolating a part of the
commit graph mechanism that can be fuzzed without access to the disk is,
I think, a good idea, and this patch is a good way to do it.
