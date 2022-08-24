Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8594C3F6B0
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 22:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiHXW1I (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 18:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiHXW1H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 18:27:07 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26116E898
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 15:27:06 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-334d894afd8so314599327b3.19
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 15:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:in-reply-to:date:from:to
         :cc;
        bh=6zZ1VEohubX/SbkHmlyI4DURH31vzmGAWjt16VuihGY=;
        b=opQON6ZoACxcAqleZSHE3LbkMFiu744ojR9jKhDd2kr0L4sqAkpbAIqhXaAZxPpalJ
         xa9GkQh9iOF8G/O+WaCL7ZJ//KO/aVRSspDwzHogKvZkxZnERLGpHLFmxbFZ8olfMww/
         +Ty9aM6pmo6oy2xlmUy4Ul5+aWidDMn/zcqyQUssvHg/KyU1gV8AjsFmixu+MIXYmOMt
         MXosF5uaNDTmkggACvFwCzcqxOL1kzTZ8UdAjOUZjT4OsHxqMZPkGxOfyaGrdRu9TXx4
         3v8eIAfxT6IOJZ2eYHU1+jkmDdq2/W7vL3mCIpqDJVnNkOFJhg+c2hoJ9gLd+NLYs1cx
         LfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc;
        bh=6zZ1VEohubX/SbkHmlyI4DURH31vzmGAWjt16VuihGY=;
        b=Oyg9o4esqerHfi2lsSFTmZXOn1qk8yJegLAddp98LQ/VDiyCh5I/0gp44IxqUJKhxY
         cBzPPqkOzMG3I8PZ2HUILaWMbg3rrCAiG5E+K2NRceOl3NqFNJh2w+U7UCr7xqyGEdJ3
         zojmyPtx5YCHw+OOCXZOLLvO5lrswPu+mDFqttD6kU2OoK07j+1SfftfSeeVAX+hWedP
         ceOzknsHmaPCRXWku2ni3bF5VgS2anZpPb7CQ5MjgyX/sUn+PkpkDgKwSP2y0vpX06hs
         pgZaB10i0GiLw2OVFBD0DbkNcCl6Td0KLU01J2PWUezS5UHKaA7ORVMj9489IhQAOcCq
         GmXw==
X-Gm-Message-State: ACgBeo0IX9VdnQnVEO4h/JrYW+R77VVstYpbXGykb/YiKvILKtZ58xfH
        B0JGxLX9P6qdweMem1z4lrCqScAyckjmTBa9rRVS
X-Google-Smtp-Source: AA6agR4qXiiv1UI0fYmoWm2eWXbH81jpNcQ3F1Z61/iEqb9KMeJb5laxXTqcNaPlp3DiRHsDtXl7oU4Iyc006kU4SmwL
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:2d5a:0:b0:695:9023:d0d7 with
 SMTP id s26-20020a252d5a000000b006959023d0d7mr1105244ybe.529.1661380026175;
 Wed, 24 Aug 2022 15:27:06 -0700 (PDT)
Date:   Wed, 24 Aug 2022 15:27:03 -0700
In-Reply-To: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
Message-Id: <20220824222703.1685763-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: Re: [PATCH 0/5] rebase --keep-base: imply --reapply-cherry-picks and --no-fork-point
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> A while a go Philippe reported [1] that he was surprised 'git rebase
> --keep-base' removed commits that had been cherry-picked upstream even
> though to branch was not being rebased.
[...]
> [1]
> https://lore.kernel.org/git/0EA8C067-5805-40A7-857A-55C2633B8570@gmail.com/

In the thread at [1] I said that (in [2]) I expected that
--reapply-cherry-picks would be the default, but this implicit
--no-reapply-cherry-picks (in order to automatically exclude certain
commits) is a long-available and long-advertised feature. So I
symphatize with making certain modes of rebase automatically imply
--reapply-cherry-picks, but I think that either all modes (as much as
possible) should imply it, or no mode should imply it.

Having said that, I already looked at the code so I have included my
review comments anyway (in case we do decide to have implied
--reapply-cherry-picks for --keep-base but not for other cases).

As for the --fork-point part, I made a comment in my reply to patch 5.

[2] https://lore.kernel.org/git/20200714035104.1465772-1-jonathantanmy@google.com/
