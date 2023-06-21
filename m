Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A2CEB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 11:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjFULLy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 07:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjFULLx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 07:11:53 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26652122
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 04:11:52 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f9002a1a39so41237695e9.2
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 04:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687345910; x=1689937910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UY6phdzFJs+csbrhVkasG4hk8XmSVOEsH15gjU5cGP0=;
        b=F5vkSxg0vC/noNb7YLbhDUOptpuWgjL0LzLY5FKjqCYiLK0HhJsMRHgVyDMtI4G6e/
         CcsAifNwWkYSOx88Dd7szZ9QNryy0KIyNLF4jZhCY7hrhV7gTo7ZY1yshtgxv+DGvbJu
         Dw5qrBpay6Ket+InPpZKkhn4FJSnNX1IdTOy4ewYWGTOxJ66j/ziBK0dWiTbtWu04sJn
         3gB8Hqs2tP9ggqXiCtL3hwLkJY9BuIgvOL1QWUTvx3vb5VxVO8U/GSro9ky9AXipET3k
         KxnotfwwSIsEiPw6kUThxZNrfG+ZX2O3ZSvtwy6w8eNGnYGqfF8GC79mdVyY/jnV4/nX
         ZZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687345910; x=1689937910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UY6phdzFJs+csbrhVkasG4hk8XmSVOEsH15gjU5cGP0=;
        b=PV0jPOGJLhnCQR1gXAK5qlmcQXEBF9piNwd9y/lTcb0Uhkrvg3zqi4U5LUKsFSGHlU
         dEkKRpTsdgRBCGbHDUOudvL+Oc9wlIiLNlYBUgOB9Ifx2wL/gHovun5iW5eKX9iLqxqY
         E7TIGOjSyAaJs8ZL34kktjqDL/5BfXF1MGagqdvfjzePr3SDeGjEhGUTWS9dL+4BJZrr
         M64jiGwlOMZbFU8GVuIgpw85Oidajlpm+OkX2n4YrUjR5IQJ5L3BMvS8zC1KJWEsJPyC
         7MNGJPtF3Z1LS5KsQQfi6hlmA0rY+fC2KYxEjVTga7QEPMvavowYU/6GUEmLcx2Z9deZ
         SrZQ==
X-Gm-Message-State: AC+VfDzyXBxsLOZfoky6A8F4f3DBtlTCDGFuyiQi3XZl5jRe8Uy6RJtB
        vhcs5UZKiftEVU6OYh8YHMFYb1dC8SY0hfN2H0I=
X-Google-Smtp-Source: ACHHUZ5e/9d7RSiljLEPQ7s+xqIaSjysxylil95iWihf2KcPu1lg6xkUHgiZ8A/sGEAMHAhrVVz4MFs/hSGzqt370WU=
X-Received: by 2002:a7b:c40c:0:b0:3f6:11cb:4926 with SMTP id
 k12-20020a7bc40c000000b003f611cb4926mr10634531wmi.22.1687345910331; Wed, 21
 Jun 2023 04:11:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230614192541.1599256-1-christian.couder@gmail.com>
 <20230614192541.1599256-3-christian.couder@gmail.com> <xmqq7cs4uyqe.fsf@gitster.g>
 <ZJLWgfCNoqE6xNqq@nand.local>
In-Reply-To: <ZJLWgfCNoqE6xNqq@nand.local>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 21 Jun 2023 13:11:38 +0200
Message-ID: <CAP8UFD1cAMg-54YTmW6N9sbi3KKs2OmPRz7zshWDGkStgiZnUQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] pack-objects: add `--print-filtered` to print omitted objects
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2023 at 12:52=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrot=
e:
>
> On Thu, Jun 15, 2023 at 03:50:17PM -0700, Junio C Hamano wrote:

> > Makes sense.  It is a bit sad that we have to accumulate everything
> > until the end at which time we have to dump the accumulated in bulk,
> > but that is a current limitation of list-objects-filter API and not
> > within the scope of this change.  We may in the longer term want to
> > see if we can make the collection of filtered-out objects streamable
> > by replacing the .omits object array with a callback function, or do
> > something along that line.
>
> Hmm. I think it is possible to use something like `git pack-objects`'s
> `--stdin-packs` mode to accomplish this without needing to keep track of
> the set of discarded objects (i.e. those which don't match the filter).
>
> IIUC, the set of objects which don't match the filter is the same as the
> set of all objects in packs beforehand, differenced with the set of
> objects that shows up in the pack containing objects which *do* match
> the filter.
>
> If you mark all of the "before" packs with `-` in the input to
> `--stdin-packs`, and then pass along the pack containing the filtered
> set without `-` (to indicate that the resulting pack should not contain
> any objects which appear in that pack), I think you would end up with
> the set of non-matching objects.

I agree that it can be done like this, but I am not sure it's very
efficient to do it like this. When we create the pack with filtered
out objects, we know the set of objects we filtered out, so it doesn't
seem efficient to make `git pack-objects --stdin-packs` read more
packfiles or their indexes than necessary and compute that set of
objects again.

Now I haven't checked if there is a real performance difference for
large packfiles, and perhaps `git pack-objects --stdin-packs` is very
efficient. But I hope that going the way I implemented it and perhaps
using some optimization ideas that Junio suggested above, will make it
easier to improve performance in the future.
