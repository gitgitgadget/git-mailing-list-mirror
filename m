Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FD0C43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 22:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbiGOWKn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 18:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbiGOWKV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 18:10:21 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA78698209
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 15:05:16 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id f14so4678875qkm.0
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 15:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e8Ocg+C5AAQ5ddXgvtPFqb8s6SNYuRy64Fz7hGKDHqU=;
        b=gc4852ktOFrCLUymiQ7s4jktirDsfRJUO7mEhzWoEQaTf+0X1H36XUv/617kK4+81C
         G99uxaUp4GbMTSNGH8FLUiZmldbVO8ual4iG6PY/hKf405wVxso5XzS017chAQ6hov0h
         jTNrvCKPi76YTm76Y+AWuq0FWRuYhLIDf5g1kV9ipxg8XWk7K4KLqVpWjLAkBXlYa5pv
         0hynYNiB1ervVK+7wu1GZGTzFzgURP9bmToxSGTlKfQdyKxQv8r7EQExDDAoMAfZcIoN
         FfZWF2MWhsDrqfFd56XBxMsfa2/U6SSE5fW8sz2k38B3ifh9aLsRMDavpbrUZojbbMTq
         DS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e8Ocg+C5AAQ5ddXgvtPFqb8s6SNYuRy64Fz7hGKDHqU=;
        b=y7oAMbISBfMzFe2u6R537btv8Zkx/sN3DF+jiGJOA3FlsOpo0d5PtMPqzaVQrxln2m
         oc0gaxHUiqPw2YUQ1JQP501vF2UbAY/o8KMOR/fD95TGOnVcS5VTLHEATG2ZOYKdfMTM
         IwnzHMQwMRPvJQvcEdSsFKtvwRHPx5eBuIhnwbgGQqR9ie9mrAzRAGDvxYN4uFfrdZf7
         u3Fj9vRelysRWBdPS3diQlkIgGibw/uzj2zJA21CU9H43PfZAzxTYV45yLm1x7uvkbXw
         87MN/rnqJ7+hAvoZHGFXkEBnG8L5Dk/i/5P0eiNEofECDR6CMxBHb3RPvgBhzV9vuZCP
         ostA==
X-Gm-Message-State: AJIora8I/SIGim+/szy0bk0sdTPZwHhYHDfWIS0bBGPJ9iHjDNY4dP/E
        47X7uTUlUHPBThFd4xZlaJzetQ==
X-Google-Smtp-Source: AGRyM1uOFPn6pgqhDiNR5mfuHTfM8USQ1phqrLYsPuwc4xQYpmcjfBNKfO07aWPv4yqCQSyNthispA==
X-Received: by 2002:a05:620a:4048:b0:6b5:7c09:938f with SMTP id i8-20020a05620a404800b006b57c09938fmr11380507qko.498.1657922715398;
        Fri, 15 Jul 2022 15:05:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id de41-20020a05620a372900b006aefa015c05sm4859545qkb.25.2022.07.15.15.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 15:05:14 -0700 (PDT)
Date:   Fri, 15 Jul 2022 18:05:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net, ps@pks.im,
        wfc@wfchandler.org
Subject: Re: [PATCH 1/3] t5318: demonstrate commit-graph generation v2
 corruption
Message-ID: <YtHkmb4Qwvo9n00A@nand.local>
References: <cover.1657667404.git.me@ttaylorr.com>
 <0a49c86037bac200bb23e1abf9f67363e99c4b7c.1657667404.git.me@ttaylorr.com>
 <10d12d6f-6d86-743f-518b-eb45871509a7@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <10d12d6f-6d86-743f-518b-eb45871509a7@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 14, 2022 at 11:15:42PM -0400, Derrick Stolee wrote:
> > +		# This commit will have a date at two seconds past the Epoch,
> > +		# and a (v1) generation number of 1, since it is a root commit.
> > +		#
> > +		# The offset will then be computed as 2-1, which will underflow
>
> I have verified that your test works, but this explanation is confusing me.
> "2 - 1" is 1, which does not underflow. There must be something else going
> on.
>
> Looking ahead, you describe the situation correctly in Patch 3 to show that
> we take "generation - date", so you really just need s/2-1/1-2/ here.

Yes, absolutely. Thanks for catching it.

Junio: you may want to s/2-1/1-2 in this patch's message, or I can send
you a replacement or reroll, whatever is easier.

Thanks,
Taylor
