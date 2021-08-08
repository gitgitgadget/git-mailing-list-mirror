Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D423AC4338F
	for <git@archiver.kernel.org>; Sun,  8 Aug 2021 13:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B433560EE7
	for <git@archiver.kernel.org>; Sun,  8 Aug 2021 13:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhHHNpO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Aug 2021 09:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhHHNpO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Aug 2021 09:45:14 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807A8C061760
        for <git@vger.kernel.org>; Sun,  8 Aug 2021 06:44:54 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so30315203pjs.0
        for <git@vger.kernel.org>; Sun, 08 Aug 2021 06:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:user-agent:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=OiS0nm95mP644PZx6CM7BdtwZm8lpK5O6xQTwydcgDM=;
        b=lo26mJ+UOoEgtN7mwdDPrTqefXZdP42QW4foZz8BMO6hR4tEZKWfO+O8zsIWE9T2aK
         GIqLwwEXQK4DOqJ1cofFZ+QiXIbq/51SxfVBJyT/zYvV7GfWKL/g9JpI9UCPpKi355nY
         eIQ4lrFGzTmtaW01a6NatTHJdmRNcacgQaqx5MxLAaqlTMX0QphuI7zz7zo4aAezgH6a
         AQbhbOPAI/uAGelyFDMrJDkcDhUAL7vcjozfNHduq4zah+x0KcSBd+IkgNo606HcDu/K
         xp5rkczoZ2U2mXMjziti6HitE5ro2HLgTqMz3d1XOzH48mUPsYjIBqjYAbEvwv4cpV6O
         OSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:user-agent:message-id
         :mime-version:content-disposition:content-transfer-encoding;
        bh=OiS0nm95mP644PZx6CM7BdtwZm8lpK5O6xQTwydcgDM=;
        b=Y0KmJMi+Q/MOOuJJXGYr9JBdBroUe7QrbR+4xirmGzEGmlGgbOhY4v2fvxydAysXJw
         Ir3YsPvy7hEC6w2PKZ5W8lCjj/18tmiFv1k+z3D7bDM5j6NotUDUT3WHqvCEvQ/YRjX+
         7FlLwtiQp54pVzx1DJsh9iS0WbsCD6kfPh1+9UUh/BvY8c+uZnsoMzfE+w+rNEZzdRJC
         4DWUw5OHfGsH1hiWxGs5pC1+D+x0XwxOAPXx0LtxO5/f9tawxKhSCeKAHc7422bYhg2+
         uakcSmcqJZXslqFs8JaQqHSNMOoALvQsV8hzV1VgxH4c2Z62/0eQVBiVbO0D3Gym3tcA
         PSag==
X-Gm-Message-State: AOAM531PHPO17wCVB1TZ5Gs6TxRHEr+4eTXB0fAlm5qOW24pGjJaJDvn
        Qpk6vQhkzcAjRrLKm9lcAhzS0dvee3Azuw==
X-Google-Smtp-Source: ABdhPJxJ5TuZ2ChWjaoU42h1T31cOE2+Vs8TADJ75pMzgFEMZFJbljvNUULunroRWyUQcMLRR9vHTA==
X-Received: by 2002:a17:90a:1b2e:: with SMTP id q43mr20567606pjq.230.1628430293834;
        Sun, 08 Aug 2021 06:44:53 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id gz7sm4764113pjb.20.2021.08.08.06.44.52
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Aug 2021 06:44:53 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC] My Git Dev Blog =?utf-8?Q?=E2=80=93?= Week 11
Date:   Sun, 08 Aug 2021 19:13:19 +0530
User-agent: mu4e 1.4.15; emacs 27.2
Message-ID: <m2eeb4aw4u.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

You can find the web version of this post here:
<https://atharvaraykar.me/gitnotes/week12>

Here's the contents of the post:


1 Week 12: Nearing the finish line
`=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D'

1.1 Project Progress
`~~~~~~~~~~~~~~~~~~'

This week was more eventful than the last week. I sent a [patch] to finish =
the
conversion of whatever is left of submodule add. The response has been
favourable, and my first batch of conversions have already made their way to
master! While this is all fine, it would be nice if someone could give some
insight into [my question] on that series about the cache API. My use of th=
e API
in the series seems to give correct results, but I don't understand what it=
's
actually doing, which is a not a good sign.

The [update conversion series] needs more eyes on it. Shourya Shukla has le=
ft some
helpful comments, but other than that I don't quite feel confident about th=
e way
I structured the [run_update_command()] function. I wonder if I should hold=
 on to
the follow-up of the update series until this one gets more comments, or if=
 I
should just send the next series in the hopes of renewing interest in what's
already on the list. For now I am leaning on waiting a bit more.

I have also started some work on [making submodule a builtin]. That series =
is
still incomplete as of now, but should be in a reviewable state in a couple=
 of
days.

With all of that it does feel like I am inching closer to the finish line w=
ith
my project. So is this stint with the Summer of Code. I don't think my work=
 will
be merged before the Summer of Code ends, because it still needs a lot of
reviewing, but that's okay for me, since I plan to stick around for a bit e=
ven
after the program ends. That said, I'd appreciate more people volunteering =
for
reviews so we can wrap up the submodule conversion work faster :-)

It would be nice to see this work, which has spanned for [at least 6 years]
finally come to an end!


[patch] <https://lore.kernel.org/git/20210807071613.99610-1-raykar.ath@gmai=
l.com>

[my question] <https://lore.kernel.org/git/20210805071917.29500-1-raykar.at=
h@gmail.com/>

[update conversion series] <https://lore.kernel.org/git/20210802130627.3617=
0-1-raykar.ath@gmail.com/>

[run_update_command()] <https://github.com/tfidfwastaken/git/blob/6ce8fd2dc=
912f9073d6760b0aa77e0a5543ee26e/builtin/submodule--helper.c#L2340-L2436>

[making submodule a builtin] <https://github.com/tfidfwastaken/git/tree/sub=
module-make-builtin-2>

[at least 6 years] <https://github.com/git/git/commit/74703a1e4dfc5affcb894=
4e78b53f0817b492246>

1.1.1 Other Updates
------------------------------------------------------------------------

I will be busy from 15-19th August because of some family-related business,
which requires me to travel. It should not affect my work much, but I may be
slower to respond in that period.


---
Atharva Raykar
=E0=B2=85=E0=B2=A5=E0=B2=B0=E0=B3=8D=E0=B2=B5 =E0=B2=B0=E0=B2=BE=E0=B2=AF=
=E0=B3=8D=E0=B2=95=E0=B2=B0=E0=B3=8D
=E0=A4=85=E0=A4=A5=E0=A4=B0=E0=A5=8D=E0=A4=B5 =E0=A4=B0=E0=A4=BE=E0=A4=AF=
=E0=A4=95=E0=A4=B0
