Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9339BC433E9
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 12:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4678D64FEE
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 12:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhCJMEu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 07:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbhCJMEl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 07:04:41 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D95C061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 04:04:40 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ci14so38086393ejc.7
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 04:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=jrL/OFTpL3AhxSx2DXlCT5OmyDr/R9l6rtYtHLFYpF8=;
        b=b2buurC3SUpGXpN0dMcuPyHS4P6bh6kXW0Ezrt5b92N9cl7edSUIrO0j3xoCN0xGMj
         i8Dz0Bm0C2n/sUOH8yJ95mFyAc9Mw9PUIDpNctDl3lDrQHupdP5+1lvcqkPMnyLZYu2X
         SvvDu+hzANmygmdCWXRG7OB7eOdOru58YDYqYNH4nCZf/XciRiMCpbJiOaeTUd1ao6aw
         zQuZMa25Dz4SGilYBV6FjUdqy1ABICutOqT8kGykiG+6y8Db+qKFhthzltE0pkrWZ/Y2
         hfCfSURd8ygiz7ESlcW60CBRNwBTmftXVdmjaJMNjannRSutvJ8U0J3y38ZJlveW8Sr5
         ScKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=jrL/OFTpL3AhxSx2DXlCT5OmyDr/R9l6rtYtHLFYpF8=;
        b=dD/PxcHe+lQLXeIBIAim2jkfB2V4im4TNBCMqXh58o3AbdXrUF/JIZVO2c8PAZTZJs
         eJRUBuvsohLtrFCapXbzgVBxupl2JJE9XP4RcKJMdlNIz1VfbQXtrr953do/NCRK5EZg
         3vzIj0PktgzhqsGD6tDkrZPtn+hGD2zaRkZ5S/Wl6VxrK3QFYPf9Q1HmIQqZjH/VGb/2
         z0cQz5rs5Tj9MJG6DzsDj6Uey60y6qq/5KwIPvlxi6qXmLFeQtPwS/cEPcrpmHiScUoU
         WFroVa1d62owpKH9l7Z/kLJuOFKcGH3c3jnh34R3WUN/KU5sHJ4XXonDvmlBmoXjNgF4
         ABnA==
X-Gm-Message-State: AOAM530KaKlStL05xPAWJgsvBAqEPDeXbqFM5NnC0dvh8vOXJ1garb7q
        4bJLXTarXclPfVliLZntG5Q=
X-Google-Smtp-Source: ABdhPJywxvybmpFJN6hK/NIDT26ki9nwC7JTVHZqZ5jlX7ZLbs0ncrUGLiUVWxj17NTsUTy3ozzioA==
X-Received: by 2002:a17:906:fa04:: with SMTP id lo4mr3288380ejb.44.1615377878819;
        Wed, 10 Mar 2021 04:04:38 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id z17sm9902419eju.27.2021.03.10.04.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 04:04:38 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v6 00/39] SHA-256, part 3/3
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
 <20200729231428.3658647-1-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20200729231428.3658647-1-sandals@crustytoothpaste.net>
Date:   Wed, 10 Mar 2021 13:04:37 +0100
Message-ID: <8735x3i59m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


[I couldn't find a more relevant thing to reply to]

On Thu, Jul 30 2020, brian m. carlson wrote:

> [...]

B.t.w. thanks again for all your work on SHA-1 -> SHA-256.

I found a missing spot that wasn't trivial to fix, so sending an E-Mail:

In git-filter-branch.sh we have:

_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"

Then later we have a case condition based on matching a SHA-1:

        $_x40)
                echo "Ref '$ref' was rewritten"
                if ! git update-ref -m "filter-branch: rewrite" \

Just deleting that case arm has filter-branch tests passing, so whatever
it's meant to do it has zero coverage, which explains why it hasn't
broken with our tests.

I didn't have time to dig, so sending off this E-Mail instead.
