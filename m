Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B65C38142
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 08:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjBAIJD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 03:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjBAIJC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 03:09:02 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED00C22A22
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 00:09:01 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id s67so11899552pgs.3
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 00:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yh0Vn4R5Lr9Bb0vkmZWqDXQCMIvXTvcq5LFWm7Cd9q4=;
        b=Uiea8sNciGCshBPAJNnNHqGdfZQXksOJZ/ZXzOLeNl9RjUyNsqsNDlWCz4VzPozxX0
         CY8Zw28nMg2axlU9FSV2d3hKccznY8alEQIFavUP8uvfWIi2RrjhNxZ0dNgJ9YL0Mift
         pOJ0lDA7CaUFjv4bWtG2vqPu6c+YqVdKcia6+p39qIgjOegKc7LiNG4BxwssrSqYGAvc
         YMOXKv0X++vT1XOkCw3z5rbIiWMPQV4pub9AIQkQF+6URAWflS4Q26Oo8+ADLKElE72Q
         Jze+dK41gyD2pt/xyClNY4o0JogbnfEii7RZf5Ar6jTPMqXqW0MNBtsP54oM3kj9RSY/
         YHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yh0Vn4R5Lr9Bb0vkmZWqDXQCMIvXTvcq5LFWm7Cd9q4=;
        b=MPiUEINudcoeMpBqyO6sZuygEW1Uiuvm8zx44GtXbI6+0+Ytsl/Pe4thtpNEw0U4iS
         4gX93BkY8rgyHBedVGhXe0WgURbmdre4hT1HQX0DYksbIcnv4/GOeMTjbUW2BWOuCUJ+
         zi9HWRxj9wwxtQsAkarGs+JwP0nhF0mOKzozbL10FBC5ACM5fDHiqc7D0uXjYfKcANGM
         Y+fZLZsiGS/CUGN1nPmyg3MOMWOknIn/e7orsDPcY8t9dDTAMH2s+NJLI3fLzsPFasS7
         QD0rpi24+uKDof6XGhG2MqL0bBwwmP8brQUEQp4lJuSxfB7Zr60KhkUqUnC1Cse4x3Dd
         JLgA==
X-Gm-Message-State: AO0yUKV90CfLSZ/JXEtF5vmrf/UlwFftI/TXHcxanMTYn/rUQVTji4rY
        lscnE9yGyXcQ8bQIko4Bzm8=
X-Google-Smtp-Source: AK7set/ix2vHVyaPoHrE/3txsdkqa0PH4HTHQW8ROFH4bSBpX0sz4/FNsQoJoFL6dgLCuBdvydUgsw==
X-Received: by 2002:a05:6a00:299a:b0:590:732b:f1b2 with SMTP id cj26-20020a056a00299a00b00590732bf1b2mr1322160pfb.15.1675238940884;
        Wed, 01 Feb 2023 00:09:00 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.55])
        by smtp.gmail.com with ESMTPSA id c11-20020a62f84b000000b005828071bf7asm5928544pfm.22.2023.02.01.00.08.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Feb 2023 00:08:59 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     sunshine@sunshineco.com
Cc:     avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v4 3/5] notes.c: drop unreachable code in 'append_edit()'
Date:   Wed,  1 Feb 2023 16:08:54 +0800
Message-Id: <20230201080854.28231-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.39.1.368.g2363c1bacec.dirty
In-Reply-To: <CAPig+cTVMGcRQqntPuwtV9x=WxUh-37Uy5V95A3F4ekeQgFq2g@mail.gmail.com>
References: <CAPig+cTVMGcRQqntPuwtV9x=WxUh-37Uy5V95A3F4ekeQgFq2g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 30 Jan 2023 00:38:02 -0500 Eric Sunshine <sunshine@sunshineco.com>
wrote:

> It's unfortunate, perhaps, that the git-notes command-set is not
> orthogonal, but it's another case of historic accretion. According to
> the history, as originally implemented, git-notes only supported two
> commands, "edit" and "show", and "edit" was responsible for _all_
> mutation operations, including deletion. git-notes only grew a more
> complete set of commands a couple years later.
>
> At any rate, even though the original behaviors may not make as much
> sense these days now that git-notes has a more complete set of
> commands, we still need to be careful not to break existing workflows
> and scripts (tooling). That's why it would be nice to beef up the
> tests so that the existing behaviors don't get broken by changes such
> as this patch wants to make. But, as mentioned earlier, the additional
> tests probably shouldn't be part of this series, but rather can be
> done as a separate series (by someone; it doesn't have to be you).

Make sense by your detailed explanation.

Thanks.
