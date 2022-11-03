Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFCCC4332F
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 13:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiKCNEt convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 3 Nov 2022 09:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiKCNEb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 09:04:31 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A842140F2
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 06:03:10 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id 13so5049526ejn.3
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 06:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ngJUEzwgff6r7vrdvMSc9pGIVYOZ+jdvx1LpHNvI0cA=;
        b=kTJgpeuGTUaeRRWy5m/axJ6IWYR/47Eq1S6iX2Fk4otrpbvxUwlrYS5uZzMVRiyd+d
         vs+l0JmuKMSV2RBb7riIPxQvhh7o/Gvxy2q7g1erCE6lYNnUIVW6cp/Kva3TWh/sxJTo
         HqCM3Vo0ymtkOLBD8b1Ox3Rbn1smRUJ5bsHg2F7tdBce9MOvjGUFiZN5WdyqAuLNJ6pc
         s3jANReOmenNWW3YxcjKOFOehfEPFTvhu+voYrM24FIcgAwgjH95DfX/ps2qI6utkXAc
         /Pfkp96YnPa3LEQLMEvneM4VIqFGRhPqaSbLKVyJk0aqen4+4I4H4wly9SKRrfTZs+Eg
         YqXw==
X-Gm-Message-State: ACrzQf2S/TtlZ+STcNJEn/8jG7ARU8CC9ymwYPdlMilifDJwQXyUsK2c
        yOkGKUWbaWCT9jas9FoFDE7zXBlwu4kuifyh4Vo=
X-Google-Smtp-Source: AMsMyM7bE1x2RuncQIzf1/LFS9TTeQUW0U8j4wu1tYz4DUrnpybVGRwEgt2rLU0uSSKWhmfFN/ftc+xycV0n+Wdz6F0=
X-Received: by 2002:a17:906:6791:b0:78d:4051:fcf0 with SMTP id
 q17-20020a170906679100b0078d4051fcf0mr28715373ejp.591.1667480586494; Thu, 03
 Nov 2022 06:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <2210311614160.25661@stax.localdomain> <CA+JQ7M81t0Lby=sB5GpUzJWakPgbi-ZNiQUL4va0wjDuk4v++Q@mail.gmail.com>
 <221101.86fsf24qnu.gmgdl@evledraar.gmail.com>
In-Reply-To: <221101.86fsf24qnu.gmgdl@evledraar.gmail.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Thu, 3 Nov 2022 14:02:28 +0100
Message-ID: <CA+JQ7M8g+e2y4tJ6k64ZQheS=x+HiZuB720M5bR8Y9yPFv0jZg@mail.gmail.com>
Subject: Re: Consist timestamps within a checkout/clone
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Mark Hills <mark@xwax.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 1, 2022 at 4:53 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>
> I believe you might be trying to re-invent "make -B" :)

True, in the simple case, but if you
  git diff HEAD --name-only --diff-filter=AM | xargs touch
that should consolidate the modified times on disk of the files of that commit

It needs a bit more work, something like
  pre_checkout=$(git rev-parse HEAD)
  git checkout XYX &&
  git diff pre_checkout...XYZ --name-only --diff-filter=AM | xargs touch
but something like that can work around the inconsistent ordered
modified times after a checkout
