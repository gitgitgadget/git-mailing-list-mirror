Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D92EC433F5
	for <git@archiver.kernel.org>; Sat, 16 Apr 2022 00:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbiDPAK6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 20:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiDPAKz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 20:10:55 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73365C867
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 17:08:25 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id m203so697366vke.13
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 17:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sLOidLt7NkVGdud5vxFMt9NpuAHOrjhBsWaKKAWmvwc=;
        b=kbH9gVcvUwSkySHaaCEsrhcRPy+gMVhcWc/hNPaFg//1ZmhrMNo+WfbG2Glpw015Vv
         o2RYX9TO0sWpYPtPVQ/2mpmz63RHCFZmwW894xLcZqYtbMThGGqIRfTh4BgCf2bgHbM4
         aHoxfNLe6wUlMwOR3Q1cm0YoQNJQZHWAZFy4iibElmdeIqiLDzjXYYRyz4VhsOHEMIIk
         GAmSa9teBxfvHudbKXbtSSDHcxZR88A5nWhBBSk1Lrqi+4iK1bS/j02YTtRTlG3NNome
         6T9cadGpLK4FHE1B3QI0hK1o7eHc0x5UZQqRKxvoiq2fPt2LIPQU+8XQ26umupu6rIMt
         FZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sLOidLt7NkVGdud5vxFMt9NpuAHOrjhBsWaKKAWmvwc=;
        b=RdCMussJt3BNc0S1U9y+V9guEyY4Dzd+d6RMYCmaps09rLfEOutHTDggbGsUlKV+jw
         NYIxUPR8sGjDuKspqIbOdZjgXAZpZ1i+YQLh9Qkc0qDquBhc8S6ZfzM4FxHafQbz8qsz
         Jd7Y8dFOfrayf1RgQV9KEiKEnzHq/5Cpf2zl0V6GkM3yWlxFxoMBKXGHx+935wobtBea
         z3r1OENCtgqJ9ceGXSO4BJyw7cDZ2ausXXZPDOL7M6mgJbwZM+Ksq9DxD5GDaEnnfMis
         AJvWFJ6websz6F2xO5Ck24uhEC1qfv42z4hbf65YPMoFQC+HDc8w8pv7XsvJkx3e1Zo2
         wBJg==
X-Gm-Message-State: AOAM5315nHx4P7Unax0bRpl8wekxKcldTMerfAsgtNtCvuCjf/HtixJs
        2BdbDqWMRVoHBmzH59Se/jDiUYMBnEsR1kN4TlQ=
X-Google-Smtp-Source: ABdhPJxS3adBFGWsG+zQN8VUfLEAHnQ9wJuWQr0cLwwuIxLP7c0a5x2lJrjhJc8E8+eXC8rxjlUpE7s/2uK9bzMDrms=
X-Received: by 2002:a1f:a50b:0:b0:348:d595:2262 with SMTP id
 o11-20020a1fa50b000000b00348d5952262mr309534vke.16.1650067705030; Fri, 15 Apr
 2022 17:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220415123922.30926-1-carenas@gmail.com> <20220415231342.35980-1-carenas@gmail.com>
 <20220415231342.35980-2-carenas@gmail.com> <220416.8635idc3mk.gmgdl@evledraar.gmail.com>
In-Reply-To: <220416.8635idc3mk.gmgdl@evledraar.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 15 Apr 2022 17:08:14 -0700
Message-ID: <CAPUEspgYU_797VSsdLWVqLXjSYsKfJhUb7M=jdouF01kHcKQyA@mail.gmail.com>
Subject: Re: [PATCH 1/2] config.mak.dev: workaround gcc 12 bug affecting
 "pedantic" CI job
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, phillip.wood@talktalk.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 15, 2022 at 4:45 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Fri, Apr 15 2022, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> > diff --git a/config.mak.dev b/config.mak.dev
> > index 3deb076d5e3..335efd46203 100644
> > --- a/config.mak.dev
> > +++ b/config.mak.dev
> > @@ -65,4 +65,9 @@ DEVELOPER_CFLAGS +=3D -Wno-uninitialized
> >  endif
> >  endif
> >
> > +# https://bugzilla.redhat.com/show_bug.cgi?id=3D2075786
> > +ifneq ($(filter gcc12,$(COMPILER_FEATURES)),)
> > +DEVELOPER_CFLAGS +=3D -Wno-error=3Dstringop-overread
> > +endif
>
> What I meant with "just set -Wno-error=3Dstringop-overread on gcc12 for
> dir.(o|s|sp)?" was that you can set this per-file:

of course, but that change goes in the Makefile and therefore affects
ALL builds, this one only affects DEVELOPER=3D1 and is therefore more
narrow.

that is what I meant with "has been punted" in my commit message.

>         dir.sp dir.s dir.o: EXTRA_CPPFLAGS +=3D -Wno-error=3Dstringop-ove=
rread

I know at least one developer that will then rightfully complain that
the git build doesn't work in AIX with xl after this.

Carlo
