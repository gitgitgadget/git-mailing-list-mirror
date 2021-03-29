Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF16C433C1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 20:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00EB461990
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 20:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhC2Ulj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 16:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbhC2UlW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 16:41:22 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B237C061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 13:41:21 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id d2so12325912ilm.10
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 13:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DxFwa00NekH79iIr8oCNL7gww0CSanpJJijmyO6vsUk=;
        b=qdn8d9+cnDstgs46BBwI6NHA6pubDyRgy9nyeSHU0U8s+H2CfDCtCZh/+W0XucBmwV
         bJ4sjLWOAyRe3MX9S3Bfvzuup2XV+4hdYdGv63Lz+hVUwB2GX6a/OHsroy2wOQ62iJUB
         jjqNxZM6SimNFkF/oGT49lXb1yX+GNscg4o2iZc9L664aEwBJaywi3d1HzPzIMWTrPza
         v5a98hu84vtkl/6LGFyF4bUtYJGzdkLpSuOjAyLJss8h8XYTTyfs8eTtuBUkkcujB6m+
         mx1oiWR21+IBJq9C52PWYs9Q9nk9828bxwr/fMCd9JOMEKLPr88zhZEHdiWiz15ySQo9
         OS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DxFwa00NekH79iIr8oCNL7gww0CSanpJJijmyO6vsUk=;
        b=KqOLw8sdORd2gwruWdAdl4CA2c9xgVJg9gTYx2EFPeyp9IFnNHs9nFUl6FQwCkVyIy
         unHsQbhmi75MKeElCMHhfaHm/cLRHAyziQFUdw1eEYUfxIwGqtkQh5znzrG0PbPlh9/7
         MW2VXQjynPQNRc7RL9Z5FeAeWAlxWklS5ny/hSXlh4/tE57LpqzA7/UpHJe1Xn+Yodb+
         8Jpxh30e6CwwRd8itmxRNGSExDrxjixYEe29Iq5xCwWrUcoQB7pAeZn2kWj/is1an57A
         +++TagChLcegvvBpg9gQnY9tvriS/ZxgWqergGV6LWFKb9SoIjCyDdD64jREshOXlAHf
         7Rgg==
X-Gm-Message-State: AOAM53207q1CYvvstSioYIUrvlwr2xotTNoZpJgh6kPliwqMTgd1ehOQ
        ctErrHduDhxOQEGn0Pt3F5Yx7A==
X-Google-Smtp-Source: ABdhPJysnHQr7FB6a9CKkaJChQ7gBAoYYrEqYNikii2nUlKmDI3tVz7AITqyUQykvNBpbncqwViv6w==
X-Received: by 2002:a05:6e02:1348:: with SMTP id k8mr23553905ilr.277.1617050480920;
        Mon, 29 Mar 2021 13:41:20 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:7b00:4f79:8763:6261])
        by smtp.gmail.com with ESMTPSA id a12sm10376693ilt.53.2021.03.29.13.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 13:41:20 -0700 (PDT)
Date:   Mon, 29 Mar 2021 16:41:19 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, avarab@gmail.com, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v3 06/16] builtin/multi-pack-index.c: display usage on
 unrecognized command
Message-ID: <YGI7b1xTYOQeyEy3@nand.local>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1615482270.git.me@ttaylorr.com>
 <f117e442c3460661dc88beba6f1853d6c388b0fd.1615482270.git.me@ttaylorr.com>
 <YGG9GogdjlijGxSF@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YGG9GogdjlijGxSF@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 29, 2021 at 07:42:18AM -0400, Jeff King wrote:
> I.e., I'd suggest changing this:
>
> >  	else
> > -		die(_("unrecognized subcommand: %s"), argv[0]);
> > +usage:
> > +		usage_with_options(builtin_multi_pack_index_usage,
> > +				   builtin_multi_pack_index_options);
>
> to:
>
>   error(_("unrecognized subcommand: %s"), argv[0]);
>   usage_with_options(...);

Thanks, that's a helpful suggestion (and pretty easy to change, too).

Thanks,
Taylor
