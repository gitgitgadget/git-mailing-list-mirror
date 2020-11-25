Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5566EC63798
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 01:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08FF020BED
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 01:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qsxc/ZLw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgKYBA1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 20:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgKYBA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 20:00:26 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E230C0613D4
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 17:00:25 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id x3so532062plr.23
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 17:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=zWBqjodVFhpVcAAOjn8/0etH6nGAIPd8Vc6RsdUzy0s=;
        b=qsxc/ZLw+LE8NbgPclzNkddd0eH9b7UT3/240BFychoi8ZESvzshNlJR5IHRelI99K
         5feknOFfdLLIjUHTq/l4ctlsVXXP6XNy/wMoEmF8pIumU4YMwjtbwH1d0+mdDcNLSEBc
         ejxctOpsyjCwbnVPD3brnDI7/UsJM9/2hBIjZPqN2cE+qhNOqTTZcgmswBOppjjMA189
         T/6eDRQMkxalPBt8OA5YUY3kbEsxca4xAv4J6Erl1l9V5w1RGqWefeMmMTQqtcLipoWq
         CfK22z7DFQhzjZLYzPnzactVuSyrj0DFapN9w+xciaY1FkrmVwQXUtUyYTViYvLGGO66
         i/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zWBqjodVFhpVcAAOjn8/0etH6nGAIPd8Vc6RsdUzy0s=;
        b=U13YQ7dCTHS5h7yPzVO2qeCWqIxkaY8hyllZf97Bd+LtDKg8HIRpKP//CbUlz9aOHM
         /oO/BZCdE7xIHoFFhMUsshGf+3fJMrskLd8WOZIkGLrlq3unKiADadxCTxqaHUdThArb
         SpFEgMs1x2L3sansUpE+B8l9moTwqS90mixSQdDInJMgiyw3m5J4w2bxXkikGH7Qn0sF
         wKme+0jjXj39L0JRhXkW4VN9f23/awWcQKeZY2GS5/hnEWT6L7VxvD0J4UvF7orCQNI5
         nU8RN3oOBdXEkP7I3tWQpqdmc2cL1KnPZ4NHZZFq6XYTKQbZGwng7cdnLefCDIa8SIPP
         w90Q==
X-Gm-Message-State: AOAM5337fPKl289Dh8V/IN4krr7FVfyeijZY5+3aFMjSmhcfGrggrtYf
        JjHSsfUsUSKABUWezrMwdH9q04LLBZg96cTv2R+Q
X-Google-Smtp-Source: ABdhPJwrOLoD9zcO2OLZomAaUqO1g9pJ03XlYlP7N1ezH7iE1aRvvhNypk45aS39X/RegVnNa5k9N0m+mi924yfahlZ+
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:eaca:b029:d6:807e:95b8 with
 SMTP id p10-20020a170902eacab02900d6807e95b8mr889830pld.33.1606266024353;
 Tue, 24 Nov 2020 17:00:24 -0800 (PST)
Date:   Tue, 24 Nov 2020 17:00:22 -0800
In-Reply-To: <466dd3036a8ca7dc9718a53f17cf87e0eb22c066.1605649533.git.me@ttaylorr.com>
Message-Id: <20201125010022.938266-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <466dd3036a8ca7dc9718a53f17cf87e0eb22c066.1605649533.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: Re: [PATCH v2 11/24] pack-bitmap-write: pass ownership of
 intermediate bitmaps
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        peff@peff.net, martin.agren@gmail.com, szeder.dev@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
> index f2f0b6b2c2..d2d46ff5f4 100644
> --- a/pack-bitmap-write.c
> +++ b/pack-bitmap-write.c
> @@ -333,6 +333,7 @@ void bitmap_writer_build(struct packing_data *to_pack)
>  		struct commit *commit = bb.commits[i-1];
>  		struct bb_commit *ent = bb_data_at(&bb.data, commit);
>  		struct commit *child;
> +		int reused = 0;
>  
>  		fill_bitmap_commit(ent, commit);
>  

Before the following chunk is the start of a loop:

"while ((child = pop_commit(&ent->children))) {"

> @@ -348,10 +349,15 @@ void bitmap_writer_build(struct packing_data *to_pack)
>  
>  			if (child_ent->bitmap)
>  				bitmap_or(child_ent->bitmap, ent->bitmap);
> -			else
> +			else if (reused)
>  				child_ent->bitmap = bitmap_dup(ent->bitmap);
> +			else {
> +				child_ent->bitmap = ent->bitmap;
> +				reused = 1;
> +			}
>  		}
> -		bitmap_free(ent->bitmap);
> +		if (!reused)
> +			bitmap_free(ent->bitmap);
>  		ent->bitmap = NULL;
>  	}
>  	bitmap_builder_clear(&bb);
> -- 
> 2.29.2.312.gabc4d358d8

So this is clearly correct.

I asked myself if this optimization is worth it when we're going to
drastically reduce the number of steps in patch 18, but I think that the
answer is still yes.
