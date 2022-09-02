Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC37AECAAA1
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 23:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiIBXwG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 19:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiIBXwE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 19:52:04 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D47109526
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 16:52:03 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id h13-20020a17090a648d00b001fdb9003787so3507480pjj.4
        for <git@vger.kernel.org>; Fri, 02 Sep 2022 16:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date;
        bh=5h1GcJQ4x3PXpuEo6KZkx4wJ6d2NRtLD2MyNPXlypKI=;
        b=jGvMWTL7mfBWPKTq6ltyqNJBBxoaEjM47LDoyV1zyRIvNY7FoS7zpgAfEl8my/1kmD
         hQ5OCKoejyshNWgwcx2W8Uu7xhN+z7IaC4FgyRlwp7/Ysex8ffIOhCbmKhvTTM+FOc79
         FdYG5bylHw5WbFhrQU5tiYwGXaqT2uCfm5XI2v4q5iI/FodoBqTrOLAzoJjvYQnQNLyU
         9SuRid2W0OO9+y/KRhGxpTcALc2ch0+xpyaHR9W2T9St3bJmWia70fp7CBvJIIHFdT5f
         h0S4EQOUrCHSJ48E5hbPIePXAcvUz7Y+OFDDW1uGto/0Eu4p0GNvGKk4+z/eThO0Vfw/
         YH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=5h1GcJQ4x3PXpuEo6KZkx4wJ6d2NRtLD2MyNPXlypKI=;
        b=NIzCitfcsAboHfm9rW2SV1sgVRI14pEpSD6ZL8LIGY22P8Ss3MfcROgckmVlIVOjSW
         TIzuZgQHuAOqbfsrFyiwDAqg9tZ7i/vXWKLQfDLDe+3BZJqohzKCLDovj4EJ17KuGVCQ
         RCDkyd79uwV4RErVPZmxMaqZcLejY0wlXrcVXqdCufZ1BAcD5DhyD0QywJqpN6BiComP
         V7CEvmLkEN0Xh7AYmjJvJgRFWPLY/Nu8YV2moSo+I2OC05z5kqyCDgdBFBx5izReAiig
         cjag/l+VCIrbcwvzdzMzqzw18dCKEz3fHEy6cz78aOMM/vFkmhxliSF8LyKlt0+BAHpv
         ivdg==
X-Gm-Message-State: ACgBeo04hH+m3mOeJAGNzIMeeLInAJCrCQq5HYCfxvbMf3FBKZKVorOy
        5pP0DHHN9J+ONb+pdkFenyKX4Q==
X-Google-Smtp-Source: AA6agR7fNsaDj52yBvYXr49JtYa+TKPF5ycNSq9/cmRGZRjO5ehQm1QnVvNh31FGMch8+UeDYVlyXA==
X-Received: by 2002:a17:902:cec7:b0:172:5b09:161c with SMTP id d7-20020a170902cec700b001725b09161cmr36541422plg.60.1662162723225;
        Fri, 02 Sep 2022 16:52:03 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:74f1:8209:5955:91e3])
        by smtp.gmail.com with ESMTPSA id e8-20020a630f08000000b0042c012adf30sm1989551pgl.2.2022.09.02.16.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 16:52:02 -0700 (PDT)
Date:   Fri, 2 Sep 2022 16:51:56 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, avarab@gmail.com, mjcheetham@outlook.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 7/7] bundle-uri: fetch a list of bundles
Message-ID: <YxKXHKUe05C3m6ZZ@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, avarab@gmail.com, mjcheetham@outlook.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
 <7b45c06cc9e0294311d9f00d40eb1fa4f8f146f9.1661181174.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b45c06cc9e0294311d9f00d40eb1fa4f8f146f9.1661181174.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.08.22 15:12, Derrick Stolee via GitGitGadget wrote:
[snip]
> +static int download_bundle_to_file(struct remote_bundle_info *bundle, void *data)
> +{
> +	struct bundle_list_context *ctx = data;
> +
> +	if (ctx->mode == BUNDLE_MODE_ANY && ctx->count)
> +		return 0;
> +
> +	ctx->count++;
> +	return fetch_bundle_uri_internal(ctx->r, bundle, ctx->depth + 1, ctx->list);
> +}

We should check whether fetch_bundle_uri_internal() actually succeeds
before we increment ctx->count here. Otherwise, if we're in
BUNDLE_MODE_ANY and the client gets unlucky that one of the servers
hosting a bundle file is offline, it won't retry any of the other
servers.
