Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE46C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 22:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiKHWxK convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 8 Nov 2022 17:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiKHWxI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 17:53:08 -0500
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5395463CF5
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 14:53:07 -0800 (PST)
Received: by mail-il1-f178.google.com with SMTP id o13so8229000ilq.6
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 14:53:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ziVbU1MLShCRbglIiTJHmVh3WG96m12DCp6hIVAPYMs=;
        b=McqQlW3YottjnusSVfr6nqH1CEftzP34DPqv/4osBcibWvdBJTEL8SGVmIevDDHNIb
         dZfFkHc5zx/DJQD3fgNDvctf560bEUXB5otxC1aRx7fs2TWhLvGOy8oJEka5ocdUWtYS
         Af+pbFy50cZtcu4YcslIVaPKyBua/LXZ4HJsnVQp4g7+PVwtG8rn7rHTikCcs1nLgt9L
         97lOs1ECHYD0wGwn+BhQA9wSPLLbLUfPg0f65QMEdb47L40leoa0P1gxO2mvs/jLHS7Y
         a1q8MbzGLssb9oOCaojt+Bh/Akv7NAxnsudFbLhdDirbLKyxjvQosh25ZzOyab+J/XX6
         HLTg==
X-Gm-Message-State: ACrzQf2Z1b0JTyz/EMtQp1figaYYD7WMseyhp27ZXT/QghkYqWoiFoln
        80n+fRSB9lhbt/6b3MixMZiOR122sWZMHmWu7BNoEP54
X-Google-Smtp-Source: AMsMyM5YrMGpJxu3SGTqSV1+dmHR4r2M6XtV+ZIinJsFoEL3Sy4Hm9rJoHX4I6u+s+EKr7U9wy9BHDcCbWSYCj+zXUM=
X-Received: by 2002:a05:6e02:ee9:b0:300:ef0e:9381 with SMTP id
 j9-20020a056e020ee900b00300ef0e9381mr12415858ilk.252.1667947986521; Tue, 08
 Nov 2022 14:53:06 -0800 (PST)
MIME-Version: 1.0
References: <pull.1375.git.git.1667934510.gitgitgadget@gmail.com>
 <221108.86iljpqdvj.gmgdl@evledraar.gmail.com> <CAPig+cSWXYhp95kcRn1EHrPW15o_z7uL+TcHO-hf6owP5FQnNw@mail.gmail.com>
In-Reply-To: <CAPig+cSWXYhp95kcRn1EHrPW15o_z7uL+TcHO-hf6owP5FQnNw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 8 Nov 2022 17:52:55 -0500
Message-ID: <CAPig+cTLoyyzU3+qo8UA7iGCh9o9UbowOz_Z_debN3NXoN8=_w@mail.gmail.com>
Subject: Re: [PATCH 0/4] chainlint: improve annotated output
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 8, 2022 at 5:43 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Nov 8, 2022 at 5:29 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> > On Tue, Nov 08 2022, Eric Sunshine via GitGitGadget wrote:
> > > (Note to self: Add Ævar to nerd-snipe blacklist alongside Peff.)
> >
> > Also, and I guess this is an attempt to evade your blacklist. I *did*
> > notice when playing around with this that if I now expand the "1 while"
> > loop here:
> >    [...]
> > To something that "follows along" with the parser it shouldn't be too
> > hard in the future to add line number annotations now. E.g. for
> > "#!/bin/sh\n" you'll emit a token like "\n", but the positions will be
> > 0, 10.
> >
> > But that's all for some hypothetical future, this is already much better
>
> My nerd-snipe blacklist hasn't fully solidified yet, unfortunately (for me).

I forgot to add that if you do manage to penetrate my nerd-snipe
blacklist, such a feature would be built atop the current series (i.e.
no reason to hold up this series for the "hypothetical future", as you
say).
