Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1658C433F5
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 18:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B804361501
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 18:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345591AbhI2S1B (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 14:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244341AbhI2S06 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 14:26:58 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB68C06161C
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 11:25:17 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id i62so4327162ioa.6
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 11:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yzcDpHKfKWADzCK1erMGPo8MDmj8TCR1uasBfUeZuNw=;
        b=eHboSRCTBNcLnVXaiL58Rd+orW/pr5V5r2wI/04kWLfOq01GBTb3FidRhSTXaAfwCC
         iCyJ4xMXQz+PsP63Zi9c2la3fbOkcLvRGf/7IhIuZ/ReWYa7c6h8aqsWpdRx1bpCp0aR
         7FNzbmIN/AgxtbDQopJ06CJY7gjVFXo8/H9XWuySGekwlKJ0/3l2W8KmUE6y/8fzSFmJ
         zkeb6azHDZTBlPp6couwn5ksiuMRo7EKN5lkwzDiZEok7WyWYuNe51q3LcHTIXofl5oT
         7jQgtg/8LRlWaAlzNLBB97Es0KTCNEQS69VwhEHKwf8qgD8kcvkW/c6/3XubaZ18M7iT
         cHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yzcDpHKfKWADzCK1erMGPo8MDmj8TCR1uasBfUeZuNw=;
        b=ftffO58lPfWPdNrPMLUK8Men8gXAwBot7eV47ZYj/mU2j81CWLbQ+W7aopddUTeYdb
         xvpFELqJZlsBfMPxpQ90RLvu1qIk0+CW089aVGgsG6RXFlS8LZfoQWG4Dj3S18wMZrMI
         tT5T9t4AKEo3EVCiRigGt02AsFrWVcoIL1QboxVw1xAWzueB1E+s1meQrILolYm9VY+I
         bHFBwBC+crF6nAEGUyFaZsRc7w8QxUzbf2vVkCHgK2tJC7jG4I9tRTyvpqWqxQ0a2fcf
         2xBst6oBxBG2dhsmedjcWYHP+uOe4MRfvaQjW4YXiKURWGlKK9AAfmwYh2Z0WaZtRV8l
         BtBw==
X-Gm-Message-State: AOAM530TOKpr/aFWfMWX46L57SYDxP84XjmD8uzuOKwzU4bA/Op0RG6J
        dob3s3NvgkQGYVeVPDrnnGkgn09BDusFXQ==
X-Google-Smtp-Source: ABdhPJx4viFCNu7ub9kgSBhw8gwLrZ2Rq9LRxtj5zk6UteBqycxsWyt8qgcyw5qkNjACDmBMOyBTUg==
X-Received: by 2002:a05:6638:204c:: with SMTP id t12mr1082177jaj.9.1632939916791;
        Wed, 29 Sep 2021 11:25:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p16sm340369ilg.73.2021.09.29.11.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 11:25:16 -0700 (PDT)
Date:   Wed, 29 Sep 2021 14:25:15 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] config.c: remove unused git_config_key_is_valid()
Message-ID: <YVSvix9mY/jOz5K9@nand.local>
References: <patch-1.1-ba40601a511-20210928T125516Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-ba40601a511-20210928T125516Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 28, 2021 at 02:56:03PM +0200, Ævar Arnfjörð Bjarmason wrote:
> The git_config_key_is_valid() function got left behind in a
> refactoring in a9bcf6586d1 (alias: use the early config machinery to
> expand aliases, 2017-06-14),
>
> It previously had two users when it was added in 9e9de18f1ad (config:
> silence warnings for command names with invalid keys, 2015-08-24), and
> after 6a1e1bc0a15 (pager: use callbacks instead of configset,
> 2016-09-12) only one remained.
>
> By removing it we can get rid of the "quiet" branches in this
> function, as well as cases where "store_key" is NULL, for which there
> are no other users.

This was the part that I paid most attention to. The only caller which
passed "quiet == 1" was git_config_key_is_valid(), which is gone. So all
of those "if (!quiet)" conditionals can go away. And the remaining
callers all pass a non-null pointer to store_key, so those guard can go
away too.

> Out of the 5 callers of git_config_parse_key() only one needs to pass
> a non-NULL "size_t *baselen_", so we could remove the third parameter
> from the public interface. I did not find that potential
> simplification to be worthwhile.

But the guard for baselen being NULL needs to stay, and it does. I agree
with you (and Peff) that stopping here is fine.

Thanks,
Taylor
