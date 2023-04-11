Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC448C7619A
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 21:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjDKVOg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 17:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjDKVOe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 17:14:34 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C9A30D0
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 14:14:33 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id y69so16591765ybe.2
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 14:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1681247673; x=1683839673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OPCBHVxCbjeycGniRs3hVzGDW2WGOebYMirbZyBj7xk=;
        b=xHRuvMptlYaBQqoHvmiEyB72CUjZi+ChbHCha5RLj20DD1or21JG2wIBRDyQC1AhJa
         QEsNWM3jT8+1iUk11l8w52ejBcOnm3bwTspupsHepCdYCf7FogOuOOW7IWb37zG4i57l
         Njr3a8CpMCfVbKFalwNqSkLOHyY6G0gl0pZy0lZseRES0d2+Yt4xqnAR7c6LkLZDS4lb
         7nFu3D4BzvdDwvkF2nzZm+tGZX2Zt64pYUOmVnZFBGHWPToDqZFME51PKTxMB3pzsVTX
         wCs8evry6WRLM03s6qv52U0GzUd+b/btmd2E7+S3k8ti9Zxs/1pwS4YYslaWdmKKOTH6
         gXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681247673; x=1683839673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPCBHVxCbjeycGniRs3hVzGDW2WGOebYMirbZyBj7xk=;
        b=jYNcOhfBzzJkVCKvorl0i/s93H6YShJEsjk2kPVMWlZ+8ZN2glLlmmTLMjoR2VRWCT
         zHS5UWUBGnkEfk40Rt1MW/S0ZkNa/o3fYCU6h0DOeJbgPGPfVj57OfnNM5bdXNJwgbVj
         c+oFr664d+sNcf9AqqBdAUNyllde3Q0uaBM7v8B81bZBOxz8uVZBYl3x3dF+JrHIMrWg
         9Z62YYcRgm82cvFchZEFxoOcGktydWNz8OxXL8HdyKNzUHW7+DClCJvWHqDgveDDoe/H
         EaJhHpJizRa4t2gBjou3gdtnp9aGsfLXtBjELUsF+Md5omnHFuhz8puch3dEWCN3kfXZ
         5cVQ==
X-Gm-Message-State: AAQBX9dQFUr6FCQzGdbdUDovmRVU5W1bQVD3kHpCzTm6FNlaBwoO56ZA
        jcsUJQ/SqslG5/uY8fVWTzNGsw==
X-Google-Smtp-Source: AKy350Z9gYtmmZP4viX+EeOlOIl8V2NcwMFOfvpicCv4cCCWhUI4ssGyEqBczHkfappxobaxQR2qkw==
X-Received: by 2002:a25:2008:0:b0:b8d:2846:3f8a with SMTP id g8-20020a252008000000b00b8d28463f8amr8717145ybg.2.1681247673070;
        Tue, 11 Apr 2023 14:14:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r125-20020a254483000000b00b7767ca749dsm3889130yba.58.2023.04.11.14.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 14:14:32 -0700 (PDT)
Date:   Tue, 11 Apr 2023 17:14:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        peff@peff.net, dstolee@microsoft.com
Subject: Re: [PATCH] repack: fix geometric repacking with gitalternates
Message-ID: <ZDXNtygNkdSbohTe@nand.local>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <ZCxytq1esQWvjIz/@nand.local>
 <ZC0eY8q6ushpfkrQ@ncase>
 <4c7b95e1-9d3c-e253-98ca-ac6c201babb3@github.com>
 <ZDWTp2RfFTbiE9I9@ncase>
 <ZDWYLPw4Hk0-12Fe@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZDWYLPw4Hk0-12Fe@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2023 at 07:26:04PM +0200, Patrick Steinhardt wrote:
> > The problems are quite multi-faceted, but taken on their own most of the
> > problems actually seem quite easy to fix. I've got a local patch series
> > that addresses almost all of the pain points I have found until now:
> >
> > - A segfault in git-multi-pack-index(1) when passed no packfiles and a
> >   preferred packfile that it cannot find.
> >
> > - The issue that git-repack(1) asks git-multi-pack-index(1) to write an
> >   MIDX with packs that it cannot actually track because they are not
> >   local.
> >
> > - An issue with git-pack-objects(1) that keeps it from packing objects
> >   that are non-local due to the way `--stdin-packs` is only referring to
> >   the packfile basenames.
> >
> > - The fact that we don't honor `-l` when doing geometric repacking.
>
> Ah, one more thing I forgot: add a safety mechanism that disables
> writing bitmaps when we see non-local packs.

Thank you very much for working on this.

For what it's worth, I think that this whole thing is pretty cool.
Having a couple of different forges use this feature in subtly different
ways is proving to be an extremely effective way to shake out subtle
bugs in the implementation.

Thanks,
Taylor
