Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62A7C432BE
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 12:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CCCD60231
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 12:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239978AbhHMM6b (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239791AbhHMM6a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 08:58:30 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D988C061756
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 05:58:03 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id e19so11835989pla.10
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 05:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:user-agent:cc:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=n8pdZajgc5D1eC+OJA4jztyb9yQqbpn/DWqLTTjBj00=;
        b=EmfqA0DeOfYkXf7Oq1nwXwW4khtdqEJltsVsZoKvStotHfxRD4z8VhDe/oZtD3pYRa
         QDfkHXDLkStgrwI5zJ2KZKCujcufrfixokBWwzieJPDyOzSH/0aas7CfbKIblHIcZJD6
         OfaSMeXdQ8U4XpEK+U3kPnRg7VB+thLyndzrLdq1NjDbuDWo5bH2S8klQzBRMWKREnQk
         0V8oOv14ofVPJdJlmMhSRu9iLSjRN9yYveJXk/4DL73dyA49Ppasq6mmY666zW4v/mdM
         V7xempO6ANwjA2P9thkJ0GZ0kC0GAtDVTzq/eSo8kv4QpLPi7utYImtPea6K9x/iO2vi
         65LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:user-agent:cc:message-id
         :mime-version:content-disposition:content-transfer-encoding;
        bh=n8pdZajgc5D1eC+OJA4jztyb9yQqbpn/DWqLTTjBj00=;
        b=ieET+IT/hJZhNLVvQpGQxoQABY+DN6IwbTaDRGz4DnYJicqbqMtBBIGu1H2cCM2ktS
         Jc2QgVDlk6B8Npp9XmG+dADKvc6ZlAB/l6+4OwvqLecfU2pCve7c6wf5zlCXHKTLUI4v
         YQelWh/fm00NVAuzvMqfjm2dqf9H6yj7g3KgyubJvpS+NHmxwu+bwQOBCOHCz2CPyf3Q
         MYl+p0Uthok/JDjyolUKqY0BpvTynFzHJ+IfgQBfHhpuWdprAagIqSz8xxEiB51f9LKs
         1gIzDeVf8YpJxtieKyGV9px3al9miUbpkRpj+zEnjblHAymIYahmW8QFyDB6qfoqrv6m
         0JwA==
X-Gm-Message-State: AOAM530P2ZAzb27WzPL8QanCoCXObTr7XlrCzzLJxffJOs4fI3W4zMFU
        AhR2SRXWKKfuDM7YsP0jfaQ=
X-Google-Smtp-Source: ABdhPJw2mNX5BDKyuztjMNtaR6YvFCrKaU9RiP08XWHPp/Pz3iIuIdtc7LydaL7vh/++YtyQTcHLlQ==
X-Received: by 2002:a65:6553:: with SMTP id a19mr2289017pgw.8.1628859482871;
        Fri, 13 Aug 2021 05:58:02 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id l185sm2319954pfd.62.2021.08.13.05.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 05:58:02 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC] My Git Dev Blog - Week 13
Date:   Fri, 13 Aug 2021 18:18:03 +0530
User-agent: mu4e 1.4.15; emacs 27.2
CC:     Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <m2im09a4dl.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's the link to the blog: <https://atharvaraykar.me/gitnotes/week13>

Since it's a short one, I'll share the text here as well:


1 Week 13: Preparing for the wrap up
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


2 Project Progress
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This week's update will be relatively short, partly because I will be out of
town and juggling multiple things this week, and also because I am saving u=
p for
the larger final report ;-)

This week I re-rolled my [run-update-procedure] patch. I was tempted to als=
o send
out my series that [converts the rest of submodule update] to C, but it is =
quite a
big series, and it doesn't help that we are already at the release week for=
 Git.
I felt I should be a little more patient, and wait for `run-update-procedur=
e` to
get picked up first rather than send a storm of all these related series at
once, at a time of release rush.

In other news, my attempt to making `submodule` a fully C builtin is shapin=
g up
well. Here's a brief of how the transition will work:

- We have a switch called `submodule.useBuiltin` (as well as
  `GIT_TEST_SUBMODULE_USE_BUILTIN` as an environment variable for the test
  suite) which defaults to false. When set to true, we use the builtins tha=
t are
  purely in C.

- If the switch is set to true, but the user requests a command that has no=
t been
  converted yet, it falls back to using the old shell starting point. This
  allows us to test the newly ported builtins with the switch set to true, =
while
  still passing the test suite as a whole.

I expect this transition to be rather brief, because the commands are alrea=
dy
implemented, all we need to do is manage the flag parsing. As of now [I have
already ported the `submodule status` command] to a pure C builtin. I am op=
en to
taking comments on this approach, feel free to leave them on the GitHub web
interface, or on the list.

------------------------------------------------------------------------

Have a great weekend!

---
Atharva Raykar
=E0=B2=85=E0=B2=A5=E0=B2=B0=E0=B3=8D=E0=B2=B5 =E0=B2=B0=E0=B2=BE=E0=B2=AF=
=E0=B3=8D=E0=B2=95=E0=B2=B0=E0=B3=8D
=E0=A4=85=E0=A4=A5=E0=A4=B0=E0=A5=8D=E0=A4=B5 =E0=A4=B0=E0=A4=BE=E0=A4=AF=
=E0=A4=95=E0=A4=B0


[run-update-procedure] <https://lore.kernel.org/git/20210813075653.56817-1-=
raykar.ath@gmail.com/>

[converts the rest of submodule update] <https://github.com/tfidfwastaken/g=
it/tree/submodule-update-list-1>

[I have
already ported the `submodule status` command] <https://github.com/tfidfwas=
taken/git/commits/submodule-make-builtin-2>
