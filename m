Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BDAC433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 15:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238995AbiCGPiF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 10:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235983AbiCGPiD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 10:38:03 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C4C5D5E6
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 07:37:08 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id r13so32842426ejd.5
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 07:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=6/4cRvY8uH/iWcCm9GY4dBQwF52QNgPu5D9Z/ZGNIxY=;
        b=CtkCNi+B/HGuGiu4oXFB5/l6jmb4CPi1tjlQ6rdem2LHCnUvj5sdXDgi9rmKkG8Pfi
         c3aA9DxMLcLerY5k6cxL5JBPyGLM3HLZoR5bvZGnBro02djyYwnCb5ZwOi5DPrEBevoX
         RpumrgYNdLAClw1GPHJb2l2ESAG9wUqBTrYCmH3LJZaQdCtIGrGGYWTHbn00+xuipZMp
         BBaDPEQqDkqzfuHt7cfSNeHwxiXNSB9DpAdlASZ1JgJNRmertCRy6zPFHelg2KCQsq25
         lkf+METdIrM3tnV2lOaUyOvwizJwLwf/ebWmdC7uBCm4FYPEA79SN0s6BszDW2LZZshj
         v2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=6/4cRvY8uH/iWcCm9GY4dBQwF52QNgPu5D9Z/ZGNIxY=;
        b=VhdMjVPrjTmnSQnP8xYRSSMb4JQVVdmn4pTRPe441YBqLa4Q8GDdO7hqC4AF0DP9zr
         h7b9dW8VDGVhxsBiR4VPwS0c0KJEz5cyj1B2Z+o4wx97itUac/DvVEH0LJxZGLqStxgZ
         xs6leyDM6hiwJ3223pQnKwUGbW/nEtoF/ggwscyhy5J5mjyETWgKvhCduohR3X5BRiIQ
         Qpv33ex+iGmRJgMnDTyTdvKwdpktIZ67gbm/Fsg6L/jrQzzl1XMwLfwuOGMeRO0ZysRA
         DYEuVsOvuyt553q+Rn4d0NOUA1/7Ef9CUtWX/iVquzTXzA4S4dyBd6MXnJdpHJDAobr5
         aUhA==
X-Gm-Message-State: AOAM531dVJpm2oRtOJseegB+oTu0glqP9BPHJs3a1tvM4nZZ69TLhvVd
        hIijVKkpka5pFwABRx1ksFug2OnBk/XYMQ==
X-Google-Smtp-Source: ABdhPJzukC64tdTbJfKbVm3lu/fwoYQR2lBI6z0JLzU6J/EfcscsIXrfQgsa0L9NXh9jYbdqmurI2A==
X-Received: by 2002:a17:907:1c98:b0:6db:b42:7f81 with SMTP id nb24-20020a1709071c9800b006db0b427f81mr7176019ejc.258.1646667426534;
        Mon, 07 Mar 2022 07:37:06 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id kw5-20020a170907770500b006db075e5358sm2416031ejc.66.2022.03.07.07.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 07:37:06 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nRFQ1-001Zgu-Fs;
        Mon, 07 Mar 2022 16:37:05 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 07/11] bundle: safely handle --objects option
Date:   Mon, 07 Mar 2022 16:35:25 +0100
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
 <1476a9495c53a165e6971afe75205889524fe7ca.1645638911.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <1476a9495c53a165e6971afe75205889524fe7ca.1645638911.git.gitgitgadget@gmail.com>
Message-ID: <220307.86fsntzsda.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 23 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
>
> Since 'git bundle' uses setup_revisions() to specify the object walk,
> some options do not make sense to include during the pack-objects child
> process. Further, these options are used for a call to
> traverse_commit_list() which would then require a callback which is
> currently NULL.
>
> By populating the callback we prevent a segfault in the case of adding
> the --objects flag. This is really a redundant statement because the
> bundles are constructing a pack-file containing all objects in the
> discovered commit range.
>
> Adding --objects to a 'git bundle' command might cause a slower command,
> but at least it will not have a hard failure when the user supplies this
> option. We can also disable walking trees and blobs in advance of this
> walk.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  bundle.c               | 10 +++++++++-
>  t/t6020-bundle-misc.sh | 12 ++++++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/bundle.c b/bundle.c
> index a0bb687b0f4..dc56db9a50a 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -451,6 +451,12 @@ struct bundle_prerequisites_info {
>  	int fd;
>  };
>  
> +
> +static void ignore_object(struct object *obj, const char *v, void *data)
> +{
> +	/* Do nothing. */
> +}
> +
>  static void write_bundle_prerequisites(struct commit *commit, void *data)
>  {
>  	struct bundle_prerequisites_info *bpi = data;
> @@ -544,7 +550,9 @@ int create_bundle(struct repository *r, const char *path,
>  		die("revision walk setup failed");
>  	bpi.fd = bundle_fd;
>  	bpi.pending = &revs_copy.pending;
> -	traverse_commit_list(&revs, write_bundle_prerequisites, NULL, &bpi);
> +
> +	revs.blob_objects = revs.tree_objects = 0;
> +	traverse_commit_list(&revs, write_bundle_prerequisites, ignore_object, &bpi);
>  	object_array_remove_duplicates(&revs_copy.pending);

The callback dummy callback part of it seems like something we'd be
better off doing by just teaching traverse_commit_list() to pay
attention to our "NULL" in this case.

But maybe I'd don't quite get why it either can't say "oh it's, NULL,
don't need to call that", or alternatively die earlier as it notices it
needs to call it, but it wasn't provided.

The same presumably goes for show_commit_fn.
