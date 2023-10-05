Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7481E9271B
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 17:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjJERio (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 13:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjJERi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 13:38:26 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C78D42
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 10:38:24 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-65af75a0209so6291606d6.3
        for <git@vger.kernel.org>; Thu, 05 Oct 2023 10:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696527504; x=1697132304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rc9kRZFdsN/uXsSUnOj8TgRnQT+wSgOC5VSBuwOJwAQ=;
        b=Xd2JhwLuYB+SUQ3EfZ45Ua8TU7wPrC1C/Xynqn6OpNajJBQ0DoHNbgG5VsIDDTwUAO
         yX5WMqZsETfMuMVb4+KxcVATscSJAZgNR9P4+1a+SaPxpS3ckIfoMvufS4evjD/ixna9
         7bnZXcJVC0zxTJK0Tjqx/973gbtsu2Kh/ANp7qygc8NdeTsODEKgc01P0y5fLRL8IoSO
         NZSN/SIaWugkfHfzcDakvyIinAjwflsvel1Pt2ERngNpcJD2KXFY4AA/ritpY8E5sSRG
         hMdPX3UeRelNHTvKr6gen3RUBGPCJ4vWfRZo7OPlesHN4p9TaoP0kZTOfDqqHpqUMo8+
         Jqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696527504; x=1697132304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rc9kRZFdsN/uXsSUnOj8TgRnQT+wSgOC5VSBuwOJwAQ=;
        b=ec/DQ4jtquPNJHAdLwpQ4gcwomQaaoBjzpyjSjRN5Un6WvhaEZHKwVR/9kMG+d1LWb
         OSKswUCODIvs8XhnIPZ+Hfp9bhvRtZggo0N0sNRmllY1qJOssGCn+yOmLB+RK0e55uFu
         5/eHGrETwx1sxZ9vyGy2obqOu/g6SQZXB3Knfa96KTrr/dCGQfRdYHFbbIA3Qb7fdygX
         kBPUIVRPLeRnLPe46p1iYSy671c1cCMImw2y9koLtXf3+ss3OdFXtF+4RI9Qly97R1KC
         5RkWSXAE6K0h1H9xP+NvkVqYDzGmhIYaKSjJWj7BPLheD9XEi8QIBo5iUep58LkrX2NT
         2WYg==
X-Gm-Message-State: AOJu0YycD5K0lKvzkGZfHwD0taoA0SZbnLE+7BWAlD2X/fHAe5V608yN
        NnRXM5AfTDZ9ARFTEiRUvEIejA==
X-Google-Smtp-Source: AGHT+IFoNlqzdOYMhAmD9FyzdXZQpOrtJqijBshMhjI6AAJgZFKiU/wNeM7U/+lMgiTlKFdzlDZPSA==
X-Received: by 2002:a0c:f5c7:0:b0:658:9cd9:ec63 with SMTP id q7-20020a0cf5c7000000b006589cd9ec63mr5624988qvm.52.1696527503773;
        Thu, 05 Oct 2023 10:38:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w25-20020a0cb559000000b0065af366bdc1sm659522qvd.103.2023.10.05.10.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 10:38:23 -0700 (PDT)
Date:   Thu, 5 Oct 2023 13:38:22 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 0/6] some "commit-graph verify" fixes for chains
Message-ID: <ZR70jsa4TTl3k940@nand.local>
References: <20230926055452.GA1341109@coredump.intra.peff.net>
 <20230928043746.GB57926@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230928043746.GB57926@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 28, 2023 at 12:37:46AM -0400, Jeff King wrote:
> On Tue, Sep 26, 2023 at 01:54:52AM -0400, Jeff King wrote:
>
> >   [1/6]: commit-graph: factor out chain opening function
> >   [2/6]: commit-graph: check mixed generation validation when loading chain file
> >   [3/6]: t5324: harmonize sha1/sha256 graph chain corruption
> >   [4/6]: commit-graph: detect read errors when verifying graph chain
> >   [5/6]: commit-graph: tighten chain size check
> >   [6/6]: commit-graph: report incomplete chains during verification
>
> Here's a re-roll that fixes a missed case in patch 6 (I sent more
> details elsewhere in the thread).

Thanks, and apologies for taking a little longer than I would have liked
to review both of these rounds. This round looks great to me (and it's
already in 'next').

Thanks,
Taylor
