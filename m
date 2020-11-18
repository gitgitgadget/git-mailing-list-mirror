Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26C1C6369E
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 15:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87FB821D46
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 15:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMvxUVmL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgKRP1T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 10:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgKRP1S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 10:27:18 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FC2C0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 07:27:18 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id x11so1182540vsx.12
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 07:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=nK8k2nwgsRvP4S52Wx3eyhsOcF6IsZXqybUpZu7Cje0=;
        b=JMvxUVmLsZMH9Ik7Fa7NDl12aOkeYhDGMec4EZmFiOLgi6+HSa4ReLoRoE5G9U7N8L
         u2Io2NxqDu37/SVAK45cQze0B7jE1yg20qzaHJh9iqKxmW85CQ5Id892pnXHsIkKcGUF
         EWUAH6nxBlI7ALkNeFPgfgWwKl5d57BaqcR+xcCu9A82e6cmLi3xuwX5xXeTCv05q5G2
         R/3Pte+V6mzFawBQlWFHvnBb2CFPEgngYw0hM+JOngXCulKtGi1YhvDXH9RM5ePocxfa
         6M1zXL1Erqadp7mDlsyEEuzReK8zymUJFxJLJKnFy9r5B/HilhSpXFApCKiIWFUeV28g
         MfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=nK8k2nwgsRvP4S52Wx3eyhsOcF6IsZXqybUpZu7Cje0=;
        b=FZERJGlfsiqG6jgiloRicOXbe0Yxr19I9uc7uI/q5EWkngImgXOhkCcXGPmzbCdZcc
         pUMMpDzvqwgI11PSYTB41sFGfFMB+e6DsEwJ+ABoIIReyk6kMrCO0uoIHU0eafFl8YCk
         yvcS9xhS/XAG3pPhfpFNwxC37nem0yYOYgOblTrStpa+MmT0YbXopHa7ujbE8JLqkNj2
         FzNjwOCyGSqEGoSwTzbApPww41KkPLIyHpCz4xu/AItT4jB7p0fmf11ps79kFLeVCMdh
         cH1N9hLpr7Z08i7jP1Shq7s5rYLgh9KZWnaRsA1g8O9Iwb5hvyKGM34CeunQvlhczstO
         Dlxg==
X-Gm-Message-State: AOAM532AtJhoBXQ12iFEATdGucmo10ZbnOJQ/QL688fUxBaev2IM3he6
        VP1HIN8BpnS3hBQIADv81UE+bn+YvUe7ZnQquJBZbSKSzl0=
X-Google-Smtp-Source: ABdhPJzJnr2TYJZPJ9UCO4sqtPdn6eHh/92i6653l1XB7trBm0yHzebU/v+ReoTJD9u2onhp51000kom51zAYfhQwPM=
X-Received: by 2002:a67:683:: with SMTP id 125mr3738637vsg.34.1605713237850;
 Wed, 18 Nov 2020 07:27:17 -0800 (PST)
MIME-Version: 1.0
References: <20201106184904.7196-1-dimitriy.ryazantcev@gmail.com>
 <CAPUT4mR75M6138MVUdb_=ag0aG9MdrLbj-PgwP7y7J+2fv4zLw@mail.gmail.com> <20201118122814.kvt2zjt4kp4rudgh@yadavpratyush.com>
In-Reply-To: <20201118122814.kvt2zjt4kp4rudgh@yadavpratyush.com>
From:   Dimitriy <dimitriy.ryazantcev@gmail.com>
Date:   Wed, 18 Nov 2020 17:27:06 +0200
Message-ID: <CAPUT4mTkcuY_mUv6Nf0ChPiay4C5c+imu_xo1br9ZhMFKTA40g@mail.gmail.com>
Subject: Re: [PATCH] git-gui: update Russian translation
To:     Pratyush Yadav <me@yadavpratyush.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,

> It must have slipped through the cracks because I don't remember seeing
> this at all.

Seems I forgot to add you as CC into the original email.

> Can you please explain in more detail what you "updated". I don't know
> Russian, and I don't know any Russian speakers willing to review this
> patch. So a brief description of what you change will make me a little
> more comfortable merging this patch.

Actually I don't know what to say regarding "whats updated" - I just
updated an outdated translation.

> Also, please don't redirect people to this website. If you _are_
> interested in maintaining the Russian translation long term, let's do it
> here on this list :-)

I am already maintaining Git Russian translation (po/TEAMS in git
repo) and doing actual editing online via that website - just added a
link so people could know where they can submit corrections.
If you want I can remove that from the commit message.

-- 
Sincerely,
Dimitriy Ryazantcev
