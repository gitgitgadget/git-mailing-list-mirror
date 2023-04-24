Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9171BC7618E
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 20:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbjDXURi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 16:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjDXURf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 16:17:35 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC7C4EDE
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 13:17:33 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-18ecdb1f2aaso573532fac.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 13:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682367452; x=1684959452;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tf3SS+fpg+okqQP+M6pfZo9xuJY1EoeA9LEUj5cX2FQ=;
        b=Rm+QCBRqU30TpdCX0+AerkICoik66jV+J3y3ZxOLrtH493VjdKDcNsnvxIhZQDWhrF
         PA3UmhyFvgjzfeWAKtx0tkkot20Ma9jAKbzPcJB5492mXfFMxqPW4Iqs1Q1TVYKh5xA0
         xpZMkPPjWn/J/DYUytu5Y/OkuFrfgtDPfnTjKD+fpXfQp4I1U65CvmIhzKffTLYlijvX
         HfF8/fPKfPE2sf2dAXahcOVJYUYxLI43zBTKJcpNsAvgd6ElRDZLA5bAbFGdXiZrsJm6
         bp22q7UcRm7Wcz4WRfJr71fMrA7t4nJGsPRcHxMOCB4L5Pj8Xl54yYdUe9Xph4y+Fjy9
         sfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682367452; x=1684959452;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tf3SS+fpg+okqQP+M6pfZo9xuJY1EoeA9LEUj5cX2FQ=;
        b=Hq7K3SNZLJItI9b5GeXitnKUegXfVPQrbvIbGJSon+/zxDSYXN+YvrUcKs5eEkDc+L
         Stex51IgJPP6XkZaxPuQPrbqbGOsHraS3lVPvjb2S1qP3VDPGGUK6P8C3tAIqwvMzvaW
         EUgPNulf7hFofBRStcUz5MMtLbqq9eNjdxZ5iJcPMQAr3JjahBfRyRZgU/8mCpIppXx0
         pYPp9stNDr9T7zwPK54Ie1j9UAaJr9l6FB/c0rC0BNQcQZTW1p+YywBxAvMAIVHhVjv4
         OoyYXhzMWjnDcD80sGYXOA4h58pptLHnNzuXlIs0GpqaVlM6IpZBnurGFYFEbpAgmBCV
         nqtg==
X-Gm-Message-State: AAQBX9ed8r8eG2z8Mhk/t41pLzHSSRxh45oFTKORu0+vsb34ybVw7ysk
        qIOUG6IBuLBuDsr67Ge0RUY=
X-Google-Smtp-Source: AKy350an8pkGgtucH4BPmrz8v9MFcZHnJ58ttbKU0iMCNui5c6uqMQXGppOfYnCxEGRlspRtu0Mb+A==
X-Received: by 2002:a05:6870:ac23:b0:187:a154:eede with SMTP id kw35-20020a056870ac2300b00187a154eedemr9611246oab.4.1682367452392;
        Mon, 24 Apr 2023 13:17:32 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id v6-20020a056870e28600b0017e0c13b29asm4864664oad.36.2023.04.24.13.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 13:17:31 -0700 (PDT)
Date:   Mon, 24 Apr 2023 14:17:31 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Message-ID: <6446e3db4702d_cd6129452@chronos.notmuch>
In-Reply-To: <cover.1681906948.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
Subject: Re: [PATCH 0/8] fetch: introduce machine-parseable output
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt wrote:
> Parsing the output of fetches is mostly impossible. It prettifies
> reference names that are about to be updated, doesn't print the old and
> new object IDs the refs are being updated from and to, and prints all of
> that information in nice columns. In short, it is designed to be read by
> humans rather than machines.
> 
> This makes it hard to use in a script way though, e.g. to learn about
> which references actually have been updated or which have not been
> updated. This patch series intends to fix that by introducing a new
> machine-parseable interface:
> 
> ```
> $ git fetch --output-format=porcelain --no-progress
>   fff5a5e7f528b2ed2c335991399a766c2cf01103 af67688dca57999fd848f051eeea1d375ba546b2 refs/remotes/origin/master
> * 0000000000000000000000000000000000000000 e046fe5a36a970bc14fbfbcb2074a48776f6b671 refs/remotes/origin/x86-rep-insns
> * 0000000000000000000000000000000000000000 bb81ed6862b864c9eb99447f04d49a84ecb647e5 refs/tags/v6.3-rc4
> * 0000000000000000000000000000000000000000 83af7b1468c0dca86b4dc9e43e73bfa4f38d9637 refs/tags/v6.3-rc5
> * 0000000000000000000000000000000000000000 ab3affb8ed84f68638162fe7e6fd4055e15bff5b refs/tags/v6.3-rc6
> * 0000000000000000000000000000000000000000 1c8c28415e8743368a2b800520a6dd0b22ee6ec2 refs/tags/v6.3-rc7
> ```

Makes sense, my only question is what other format could `git fetch` have? I
think `--format=porcelain` is clear enough.

-- 
Felipe Contreras
