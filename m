Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50795C433B4
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 23:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C61F61179
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 23:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhDNXvA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 19:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhDNXu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 19:50:59 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA62C061574
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 16:50:31 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id z17-20020a0cf0110000b029019a84330150so653075qvk.13
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 16:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hyqZvEHpFztPyjegthWInZObES70WZcF2RUCQA3NNgw=;
        b=QGe5/wO/tSmAhNf+Ojr9AtMlP6VflOdZggp1Pqce86f7qT8ipHQhpBNaOUz0TNYQF4
         l7Mo5lAb6DAgqMF2pVOltYzBfvG1FtXQwhzx7pzL9cNbCtn6rNORz5AWZyOx9NXnsifz
         ZltPTwzkCiUfZ9qsGTTZXQTiuvCDoZsfggME3OWJf2FrQ56mw9pJF/e0DCea/xWnsMx3
         F6A8oi/8IpkAJI19OQAat7CG9qm2b0iAzLdABEVzsM4DlZ2cNYuiyf2Bp9tof8mrYbh1
         63XGYal1x+BS21BO/I16IvkB+hPHoxUWUFGmhqmBD3ocifwEckJODVW/doNXF2B6r63t
         nQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hyqZvEHpFztPyjegthWInZObES70WZcF2RUCQA3NNgw=;
        b=LsF2mxPnyt7NtYBAnPEz+joKjbMWbtvyPn7lEjclmVdCtu+2qRRVZNinDhAprqoTIC
         8k8QXXKw+6iXpGRqcov2LrWr202r0uqDfXJ/eQsvPQ8Jm6rdRcKRhQlHbVZKibzQElBp
         tqW7Kgh9P4BGt0Ef41uApOhECyZBF6twYDwiyu/VVFaKpqelu/dvUkiFJshwDyZnb2UW
         fHGZu1Ex2V87xWaXTiCIHhPDZX3E9r6mnpQdmJwitBEbQBmnT5lH5hXS3A6/BcDPLZW+
         DhF0nyd80K4IQiP6BLKf2iJ9zoKmfKRDVVnYNBIUZhaFzbhouQVCORgtHBBdbBPHvu7Q
         I3pg==
X-Gm-Message-State: AOAM532uZAoE6YQtz986wIOfgWOf9qZrjmBZyeNneeRxy0Rn8kAMNeKv
        RNpkRg4d3V09Qxb7jondHLX8tifp6VQB2jtsaWuE
X-Google-Smtp-Source: ABdhPJxGEE0Z6hlvLmYpTLnukmiCJSQhRHnRuxEQJgi3koAg0/u6wmKgmjis837vmT9FsfZYPYpxS6yMjHFtZAP3O1+i
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:1844:: with SMTP id
 d4mr524127qvy.56.1618444230416; Wed, 14 Apr 2021 16:50:30 -0700 (PDT)
Date:   Wed, 14 Apr 2021 16:50:27 -0700
In-Reply-To: <20210414191403.4387-2-rafaeloliveira.cs@gmail.com>
Message-Id: <20210414235027.4064035-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20210414191403.4387-2-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: Re: [PATCH 1/2] repack: teach --no-prune-packed to skip `git prune-packed`
From:   Jonathan Tan <jonathantanmy@google.com>
To:     rafaeloliveira.cs@gmail.com
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, peff@peff.net,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The `git repack -d` command will remove any packfile that becomes
> redundant after repacking, and then call  `git pruned-packed` for
> pruning any unpacked objects.

s/pruned-packed/prune-packed/ (note that there is no "d" after "prune")
throughout this commit message.

Also, if there are any objects pruned, they are packed objects, not
unpacked objects. Maybe better to say "...for pruning any objects
already in packs".

> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> index 25b235c063..728a16ad97 100755
> --- a/t/t7700-repack.sh
> +++ b/t/t7700-repack.sh
> @@ -127,12 +127,7 @@ test_expect_success 'packed unreachable obs in alternate ODB are not loosened' '
>  	git reset --hard HEAD^ &&
>  	test_tick &&
>  	git reflog expire --expire=$test_tick --expire-unreachable=$test_tick --all &&
> -	# The pack-objects call on the next line is equivalent to
> -	# git repack -A -d without the call to prune-packed
> -	git pack-objects --honor-pack-keep --non-empty --all --reflog \
> -	    --unpack-unreachable </dev/null pack &&
> -	rm -f .git/objects/pack/* &&
> -	mv pack-* .git/objects/pack/ &&
> +	git repack -A -d --no-prune-packed &&

This is great!

> +test_expect_success '-A -d and --no-prune-packed do not remove loose objects' '
> +	test_create_repo repo &&
> +	test_when_finished "rm -rf repo" &&
> +	test_commit -C repo commit &&
> +	git -C repo repack -A -d --no-prune-packed &&
> +	git -C repo count-objects -v >out &&
> +	grep "^prune-packable: 3" out
> +'

As for the test description, I would prefer "...do not remove loose
objects already in packs".
