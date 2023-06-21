Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A29EEB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 12:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjFUMTg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 08:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbjFUMTf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 08:19:35 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33ECA1FCB
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 05:19:33 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-bfe97b3752bso758988276.1
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 05:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687349972; x=1689941972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iBDaBkOGYfSChC73b3wgmS+AK9REvwqnuz5ukCaW77I=;
        b=yykSYF249KtWizSDoxh1ZkN8n37Xtusf/V+edtEOKcvZIRhh2aIxddUyL+VRICdT/i
         VDjIxxrQw+Ysz/xdAd4J7XLz0048YT2162i/wVizmKPruZA5+XviU95RFvIKghJ5nVPt
         Eu/hogQ0aK9QnRlKzsBYnYbftjy7UPiOhcWBynYEc/zfrwg/BHd90ahJ0P/rN8tyUPXY
         T4qw63QzWuy9C6qAGkl4M3hWAfYDbAcnIEmIS4PaE0aBGxc7e3sKHT7lPBxBUSIcYsKs
         4tTnRORiIPMZqOZLb0k8v3Vn/uzn5yFf2E2VcTcNrHJki91EkAOCp1H09HYRX+KLrmsk
         YdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687349972; x=1689941972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBDaBkOGYfSChC73b3wgmS+AK9REvwqnuz5ukCaW77I=;
        b=dULgP39MS2JWmM2IRcFVZgUGg+TCbs+e5PxK25BDP2+scvGYP8NSNVpFc4I+zfgQgH
         PyeefsdIF5DD+bj37GoycZ9+mgU8mI5MBcjppmSyf+YAfl6eUyv/l1IsA9/lNIIfYcB3
         yg8qrEUlA2FfXaGHqBq5crobEu4NGPjsgbeyefYK4e6QlMTL8DHJb9CrBXyvYtS6BnnV
         BPqrEtG9hOwom2rMviu5tUMExN3umy8LIDkFVAAbSxuwM/kjPSRVrhSnlOi9HAQ6gf6r
         h2ZAxK9Du/iZD2XETT1CP3eVCkPlgACb+wkbl3Xamv0lTMovKu47VYk7RltHT/JQA1GX
         vUGg==
X-Gm-Message-State: AC+VfDzkkoab+rwmAaj0VqrH1BZV/vbWTjZ5YLZ0IVIztPxJ74ygh9OT
        asOlOb76ENKS0a4QgZeIDlXo6g==
X-Google-Smtp-Source: ACHHUZ42bLFPgvg9ODEi1uOO33J4Z7TrngLCEFYIxOqbVlzpkeigA3L/oauxpqsJ3lZhMxMFUObjFQ==
X-Received: by 2002:a25:db85:0:b0:bb3:ab9a:46e2 with SMTP id g127-20020a25db85000000b00bb3ab9a46e2mr11036971ybf.63.1687349972582;
        Wed, 21 Jun 2023 05:19:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d18-20020a5b0c52000000b00bc501a1b062sm876013ybr.42.2023.06.21.05.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 05:19:32 -0700 (PDT)
Date:   Wed, 21 Jun 2023 08:19:29 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 0/4] Changed path filter hash fix and version bump
Message-ID: <ZJLq0XE3lSVzQ28k@nand.local>
References: <cover.1684790529.git.jonathantanmy@google.com>
 <cover.1686677910.git.jonathantanmy@google.com>
 <xmqq5y7r5fsx.fsf@gitster.g>
 <c7b66d2c-cdc3-1f0f-60a0-a2ee21c277bf@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c7b66d2c-cdc3-1f0f-60a0-a2ee21c277bf@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 20, 2023 at 09:43:46AM -0400, Derrick Stolee wrote:
> This version is not ready. The backwards compatibility story is
> incomplete.

I'm also late to the party, but I agree with Stolee here, having come to
the same conclusion about needing to support reading older (corrupt) Bloom
filters when possible (i.e. when paths contain no bytes which have their
high-order bits set), and assuming the filter contains all paths
otherwise.

>  commitGraph.changedPathsVersion: Which version should we _write_
>  when writing a new commit-graph? Defaults to '1' but will default
>  to '2' in the next major verion, then '1' will no longer be an
>  accepted value in the version after that.

I am not sure if there's a situation where we'd ever want to not write
the newer versions when starting a new commit-graph (or chain) from
scratch.

I think that follows from what you and I are both suggesting w.r.t
backwards compatibility. If that's the case, I think that we could in
theory drop this configuration setting altogether.

Or, at the very least, we should be able to change it change only what
version we *write*, not read. I think this is what you are suggesting
above, but I am not 100% sure, so apologies if I'm just repeating what
you've already suggested.

> The tricky part is that during the commit-graph write, you will
> need to check the existing filter value to see if it matches. If
> not, the filters will need to be recomputed from scratch. This
> will change patch 4 a bit, but it's the right thing to do.

Yup, good suggestion.

Thanks,
Taylor
