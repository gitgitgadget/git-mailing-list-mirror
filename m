Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3BEC433E0
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 03:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B509820672
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 03:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ud9VzHs8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgGODcU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 23:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgGODcU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 23:32:20 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37607C061755
        for <git@vger.kernel.org>; Tue, 14 Jul 2020 20:32:20 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id i3so607703qtq.13
        for <git@vger.kernel.org>; Tue, 14 Jul 2020 20:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gQLnHSHo4Q7a2QqEefiBmpHc9/KZxDgTMtbknfJAnxo=;
        b=Ud9VzHs8ksF4SQleyMNSMAIHhBngMVfk3F0AQSdGBuXULN6Ga91CdC6EZFSLKcS7gC
         L8HJUqYIjvrYgMvLhbcEL7DfLmnklOuArj0s9czcUNr2gw5jkp6wF4IVU7iTp/uNSVZq
         0aGbeHpbBJt/woydKMCWW8iOjeQkXJUV2n+zxZT0+FXcvvnhQYucMt97yOLwyTSn+85H
         bntCP9RNaxEbrKvW9OLYyH0vskGC5dGTIBUyHyLe0y7w0dZxRgiU98iTCXVoWU7yw4kI
         v5ZaGMr7sU7RDTR1bdhzPtdiZ2fQ7GgekpkQk6fUIFgKmqo6j25hwlY8jHmESd2+u2Hn
         QMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gQLnHSHo4Q7a2QqEefiBmpHc9/KZxDgTMtbknfJAnxo=;
        b=b9ew4jzpuvElCAf5uDS49BDVC83+iF9WIxz6u+On7v96AfdvmJVoKb79Uw2HNJp8ho
         pvpQqOq3CdbGjbujMMYlH9b/UKjEi53mfve1PsncQlnYkyj4rtMPTNtGyicYUohV2bQL
         WrtqypgHd7ywafz2vPYxmBx+CRgYUHxIZS/nsNkHXZwfdu6KBtKtU7+6EaFNSV0MeqQJ
         HQNXwJhf5k2Xi1w92YzL/YbC1StOmSssmQerIhhkY0NcehCCRUbNGcso+lSrlzjJdinZ
         /DuvYIkLB/JfxeWXdfR33RQaqgpA6dwWmDDRYKNpL28f3j04E5rwf4z2KdMhCt0Q0JC6
         AkJg==
X-Gm-Message-State: AOAM532Yg3W1zLb6e9Jma9sJDtwjADFe6tJT2PxCIEugMcj8/4BO4h/U
        x/EKNX+n9QgBhshDxM2Xd0k=
X-Google-Smtp-Source: ABdhPJzhCUxW0GYN+uv8OgG6tWj4ViH/NxjlVRRI3Co7JSMzm2o6t+ZSUg4ZnBHmZbHNsX/tfUmAyQ==
X-Received: by 2002:ac8:1991:: with SMTP id u17mr7746463qtj.93.1594783939323;
        Tue, 14 Jul 2020 20:32:19 -0700 (PDT)
Received: from generichostname (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id f65sm1322128qtd.61.2020.07.14.20.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 20:32:18 -0700 (PDT)
Date:   Tue, 14 Jul 2020 23:32:16 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     levraiphilippeblain@gmail.com, git@vger.kernel.org,
        sunshine@sunshineco.com, avarab@gmail.com,
        Johannes.Schindelin@gmx.de, newren@gmail.com
Subject: Re: [RFC] should `git rebase --keep-base` imply
 `--reapply-cherry-picks` ?
Message-ID: <20200715033216.GA11770@generichostname>
References: <20200714031017.GA15143@generichostname>
 <20200714035104.1465772-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714035104.1465772-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 13, 2020 at 08:51:04PM -0700, Jonathan Tan wrote:
> > > How would a change that made '--reapply-cherry-picks' be the default when using 'keep-base'
> > > be received ?
> > 
> > I'm somewhat surprised that --no-reapply-cherry-picks is the default. I
> > would argue that it _shouldn't_ be the default at all. It's an
> > optimisation for when no --onto or --keep-base are specified but it
> > definitely can cause problems otherwise, as we've seen.
> 
> When I encountered this feature, it was a surprise to me too, but this
> has been documented as a feature for a long time (e.g. see the man page
> for 2.1.4 from 2014 [2] - search for "RECOVERING FROM UPSTREAM REBASE").
> 
> [2] https://git-scm.com/docs/git-rebase/2.1.4

Ah, I was mistaken. Thanks for the correction.
