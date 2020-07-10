Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF69C433E0
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FDE620725
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="JhmzrMVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgGJC0N (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgGJC0M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 22:26:12 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772D7C08C5CE
        for <git@vger.kernel.org>; Thu,  9 Jul 2020 19:26:12 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id m8so1925678qvk.7
        for <git@vger.kernel.org>; Thu, 09 Jul 2020 19:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mrTWqRTv0wTSX5c4Xs8XBBPu8UKPb35BpiFcgo2ruIw=;
        b=JhmzrMVjXxqXBgTB5ZBCyxIUATlBvQEfEyxjXAmFc9p8TDdt4HFs+8DdiS5yVD6aA4
         HDAcyy+mvfXQ15/he3pyJ6j2+d7Bszu9f4W7O8wtSKyeNx1fDf1a+Mgy5o9qEl0HyW1m
         xdxsA0He7VhyGHHPEwdvOK08q4jFWFkdzVnP+xMHLM4ueVz5DBbbUD/SEh2amlFkVPIL
         E8Xp/kICXZfm/Ezz6NDvPx4uceN44FtpfN2/XfR07TDLkNFXJK279eJs1QDUSKfZ6ym3
         dgJ7QZ7LaAloxAeUl6yoO7/B7WhPhlltBSahgCmd5pShPZYJoSMvmsP9StPNDUeoLpIv
         yKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mrTWqRTv0wTSX5c4Xs8XBBPu8UKPb35BpiFcgo2ruIw=;
        b=ZAzzlc7iabWFroFCaXRu2jfqXBj/riUBX7lcpMsek2XNDSBX7+BtnplNUv2Vj+9/o+
         Uri+ObSVz3Ve+3J9aiQPeyOdr02TGrjIU6DYOTslRNXCJvZ4T0FxefMnOGrgkP7SgI20
         mIm5hESJmtxBM+ltHw91q7R6uSfcZyVCkkBUxSQCpasEOqY+SfDpLGZNEktw8KPU2SWi
         UfLVfHsHMz//HUt40pvTIn5PQs/dqpUBm7SJOu+zzb8Ti1nSL6mYZFeuzccA4JTPHmN7
         2sH39qldwwjGQKC+nbOyPeB7p11S+UUoS3An3rB6G6nkKsMdFYnJD3P5k/iEquZxCPAF
         Kc8Q==
X-Gm-Message-State: AOAM532roRuKSrFhNtuKlhNCyfBJzD3gyzEneD0syGF1fyPkCWfRcdll
        42zxAxedTLRgii+lw5Vy9qBdjA==
X-Google-Smtp-Source: ABdhPJxTerRjZQAWrq5mu1uKd7LT0P6KS+ZIZMpo3C4hwROeGtLtCKFo3OWvrRYKUtGnGP5IJEKIdw==
X-Received: by 2002:a0c:f307:: with SMTP id j7mr41160310qvl.55.1594347971635;
        Thu, 09 Jul 2020 19:26:11 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:4c16:d6c9:a96a:4df9])
        by smtp.gmail.com with ESMTPSA id f22sm8011847qko.89.2020.07.09.19.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 19:26:10 -0700 (PDT)
Date:   Thu, 9 Jul 2020 22:26:09 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2020, #02; Thu, 9)
Message-ID: <20200710022609.GC39052@syl.lan>
References: <xmqqa708wen2.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa708wen2.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 09, 2020 at 02:40:49PM -0700, Junio C Hamano wrote:
> * tb/fix-persistent-shallow (2020-07-08) 1 commit
>   (merged to 'next' on 2020-07-08 at ef1709f4bb)
>  + commit.c: don't persist substituted parents when unshallowing
>
>  When "fetch.writeCommitGraph" configuration is set in a shallow
>  repository and a fetch moves the shallow boundary, we wrote out
>  broken commit-graph files that do not match the reality, which has
>  been corrected.

Thanks again for fast-tracking this down to -rc0. It had been on my list
to look at, but I was out of the "office" every other week of last
month, and so it kept getting pushed.

I'm glad that will hopefully end up in the release, and sorry again for
the rush.

> * tb/upload-pack-filters (2020-07-06) 4 commits
>  - upload-pack.c: introduce 'uploadpack.filter.tree.maxDepth'
>  - upload-pack.c: pass 'struct list_objects_filter_options *'
>  - upload-pack.c: allow banning certain object filter(s)
>  - list_objects_filter_options: introduce 'list_object_filter_config_name'
>
>  The component to respond to "git fetch" request is made more
>  configurable to selectively allow or reject object filtering
>  specification used for partial cloning.
>
>  Waiting for reviews.
>  cf. <cover.1593720075.git.me@ttaylorr.com>

Yup. I owe Peff a response on the 'uploadpack.filter' vs
'uploadpackfilter' decision, but otherwise I think that this series
should be relatively straightforward (not the least because we've been
running this at GitHub for months).

Another topic on my list is my series to send a reroll of [1], which is
a series to control whether Bloom data is read out of commit-graphs.
We've been using it during our roll-out of Bloom filters, and it has
been quite helpful for debugging.

...which reminds me, I have a backlog of topics that I need to send
upstream, including:

  - a fix for commit-graphs not using Bloom filters if the top-most
    incremental doesn't have them, but others do

  - a new '--max-new-filters' parameter, which allows the caller to
    specify the number of new filters they're willing to generate before
    stopping early (and writing what they have)

Oops. I didn't mean to ramble so much, but it is helpful for me to get a
list written down of things that I have been thinking about / wanting to
send upstream. Patches soon.

[1]: https://lore.kernel.org/git/cover.1593536481.git.me@ttaylorr.com/

Thanks,
Taylor
