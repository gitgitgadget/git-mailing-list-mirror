Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BA0C25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 17:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237914AbiHQRiN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 13:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237097AbiHQRiL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 13:38:11 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E2BE04
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 10:38:09 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id m17so1468660qvv.7
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 10:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Qa/9NBoH5HQt5QfBt9bzQlG2DWTSDELVJF/2AS+69Gw=;
        b=Z5U+K7gwQXobTRXtXUKg3a0Sgw3ONsCJ61fxyfynBRG1xA63V/9s8W8Q73V549XGCe
         HXhkICoPmaDYJvSnX36mxM3qKYgaQCIctKJfa3Dlf4QKhUyeaRbWLVWh0OArp/3X1Jz5
         FAuOd0+c3Nz31dB/Nv8DLvmkJ0CVPkqhAuH8I24SlR5Rm4FTN2MYIqE6lYBf8Xly9lyW
         J8JqaK68ECHPDBOCIDURkahjbchKCNs1YfI4v+dWnxh8+fvvIRszh6EkxQK8PH2CWKOl
         IyO//Eet2oVlHy4hKLvYg07avNZ39wLgKf2+KHcNtgruWaeAhHl2wXNT3QjskOzC8Ttd
         gWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Qa/9NBoH5HQt5QfBt9bzQlG2DWTSDELVJF/2AS+69Gw=;
        b=q42pG2gaedQ1zWgXDj6hklH+5UfkftoP5bX7MnRyePbvSzfF0ZCoPKIoKeJddMw492
         T+2c0F9pYce0ZDJOayedbFubhHH2ZQY0rxSdvbi+uQavIomWVA0oM+h+J/XMLTl3P/4a
         9WNIp9qgEcoQ4JBn5ZT8h/yL4pmvTFCY8ivsCz7tAiGhX3231V2Z9kHmN6H/PkEaFR+G
         9/SccFjNuAvyCaxXExKgO5DpMoSo2oDYrX3GY/ed4/D+cE/We+7kIqkvzdT+Fa6UTOl6
         y7cxrVuye0MBIuluffuhekV032ReA0Pxq+J5gC/QK2+CXIvRUatc4Y+DAV7ksOqpLvn0
         j5Pg==
X-Gm-Message-State: ACgBeo3yX91/todl+odAGpMRNYUs1P2l04tWCECR5Lx7ZrCOYNB7ujHd
        DW6s0ShhP9DGduBWRm5CU2w4J8YbEYOEvAPD1as=
X-Google-Smtp-Source: AA6agR53vWcpVFXiUiHHK+uaoyM79KR6CDdIwPcmEnw05bkAzaK0nL34Uk/HIWsPhNOWoOJc8hnFnGIckGZNs3vF0+c=
X-Received: by 2002:a05:6214:20e7:b0:479:6ed5:e5ff with SMTP id
 7-20020a05621420e700b004796ed5e5ffmr23102640qvk.69.1660757888800; Wed, 17 Aug
 2022 10:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
 <20220817075633.217934-2-shaoxuan.yuan02@gmail.com> <80f24382-1188-d450-d1e2-42f68c08e60b@github.com>
In-Reply-To: <80f24382-1188-d450-d1e2-42f68c08e60b@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 17 Aug 2022 10:37:58 -0700
Message-ID: <CABPp-BGvihOqmz14CBudQ=7_=QXc-3NN3o3Tmy=MY3ykkqwPiA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] builtin/grep.c: add --sparse option
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 17, 2022 at 7:25 AM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 8/17/2022 3:56 AM, Shaoxuan Yuan wrote:
> > Add a --sparse option to `git-grep`. This option is mainly used to:
> >
> > If searching in the index (using --cached):
> >
> > With --sparse, proceed the action when the current cache_entry is
>
> This phrasing is awkward. It might be better to reframe to describe the
> _why_ before the _what_
>
>   When the '--cached' option is used with the 'git grep' command, the
>   search is limited to the blobs found in the index, not in the worktree.
>   If the user has enabled sparse-checkout, this might present more results
>   than they would like, since the files outside of the sparse-checkout are
>   unlikely to be important to them.
>
>   Change the default behavior of 'git grep' to focus on the files within
>   the sparse-checkout definition. To enable the previous behavior, add a
>   '--sparse' option to 'git grep' that triggers the old behavior that
>   inspects paths outside of the sparse-checkout definition when paired
>   with the '--cached' option.
>
> Or something like that. The documentation updates will also help clarify
> what happens when '--cached' is not included. I assume '--sparse' is
> ignored, but perhaps it _could_ allow looking at the cached files outside
> the sparse-checkout definition, this could make the simpler invocation of
> 'git grep --sparse <pattern>' be the way that users can search after their
> attempt to search the worktree failed.

In addition to Stolee's comments, isn't this command line confusing?

  $ git grep --cached --sparse   # Do a *dense* search
  $ git grep --cached            # Do a *sparse* search

?
