Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71910C6FD1D
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 05:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjDGFt4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 01:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjDGFtz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 01:49:55 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BC69768
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 22:49:53 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id x20so42646219ljq.9
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 22:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680846591; x=1683438591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvGHj9z1qeBgnLOQoUtZ9TAzXHVK2YMhvGjn6ZOh2y4=;
        b=E5OxUVXcUkjhKHGUT9uYcUgoXGNtNbEYynqPZT1Yx77lzRF+68+TrH4wypY1NzvuXE
         A+3Cy6wWmT6ohAVM5TMrzDNswuC1D43/PX5ba7zuyd93i3o2mUbPxj1o8UvmmoOXhbR+
         l0eVTXnIZ0i1uja5/JcP2ZW4XH+8n9NMdNXdYF3a2n4GM68bpWsuQzi8CX5zj1WMh5Ng
         +XvWruoVLHyiZkyGeMyQowxqbtnt0N84cDZYXLD7MAnW6qVXM96ykQ3lp+qs9cjTtVXl
         E8aBL6fVd78LwmPjdfmgDAHqXdZTR+yFD77rv0xYH0kMGQCS11sIIXZVw/032FV8ubce
         7btg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680846591; x=1683438591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvGHj9z1qeBgnLOQoUtZ9TAzXHVK2YMhvGjn6ZOh2y4=;
        b=Sgzh7HKXFVDvmBTur8M7sgtQNwIgFm3NUmQCs/4SiaAWdZCbf5xzLEa1iYNjHm/F5/
         ddurRc+mjDR4tr76WPISJYijIJQVPaIOA5gxJ6Vx3Wm+Tyomag5mxmvRUSVGx/mjbAxf
         suCAYYiTL+6c9iBX3BfHiNW/+3MbPFoBl8L315SAMNS+MVQz6nNDQOQaXubAdOyX9nGO
         JaukC4L8tWB5X68bAITfZtao5HYYE2r/N4hekBRRdrwpKZC8PTVh7WjGFEUcXIua92f2
         Fm25ut3ks0sea0HmWDGM+yGJyrKGLzjSQrrWwkITQ1LTC115WWdHtgWGBiLcIaAKvP1Z
         Tmzw==
X-Gm-Message-State: AAQBX9cQU0oL/QwaOqZ0VwOTM7yKl00zqs68pzHEKIt4a+WtHV3BHiW4
        wUq3p9HeaVRvbwPAr1JvV1xEEU97QraaW9PsEcbwcljw
X-Google-Smtp-Source: AKy350ZkC9MHadoWFWMbkWq/P8I3OiXq8ukaiZd0Tcs14J1K2OtHBgJQpAmU2Mri8HXYZ8Z3xhI/7gt+GCFx2KPIhBU=
X-Received: by 2002:a2e:93c3:0:b0:29b:ebfa:765d with SMTP id
 p3-20020a2e93c3000000b0029bebfa765dmr273488ljh.1.1680846590853; Thu, 06 Apr
 2023 22:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1678893298.git.phillip.wood@dunelm.org.uk> <cover.1680708043.git.phillip.wood@dunelm.org.uk>
In-Reply-To: <cover.1680708043.git.phillip.wood@dunelm.org.uk>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 6 Apr 2023 22:49:38 -0700
Message-ID: <CABPp-BFMiU8cYzUr1-m6P8w-YAtqPRyMfah8UAqdO_N4cdxUKg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] rebase: cleanup merge strategy option handling
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 5, 2023 at 8:22=E2=80=AFAM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Cleanup the handling of --strategy-option now that we no longer need to
> support "--preserve-merges" and properly quote the argument when saving
> it to disc.
>
> Thanks to Elijah for his comments on V1.
>
> Changes since V1:
>
> I've rebased these patches onto 'master' to avoid conflicts with
> 'sg/parse-options-h-initializers' in the new patch 2 (this series
> depends on 'ab/fix-strategy-opts-parsing' but that has now been merged
> to master).
>
> Patch 1 - Unchanged.
>
> Patch 2 - New patch to store the merge strategy options in an "struct
>           strvec". This patch also introduces a new macro OPT_STRVEC()
>           to collect options into an "struct strvec".
>
> Patch 3 - Small simplification due to the changes in patch 2.
>
> Patch 4 - Moved the code to quote a list so it can split by
>           split_cmdline() into a new function quote_cmdline() as
>           suggested by Elijah.
>
> Patch 5 - Reworded the commit message as suggested by Elijah.

I noticed a small typo/grammo in the commit message of Patch 4 that I
missed in V1, but otherwise this series looks good.  I'm not sure
fixing the tiny grammo is even all that important; I'll leave it up to
you for whether you want to bother re-rolling to fix it.  Either way:

Reviewed-by: Elijah Newren <newren@gmail.com>
