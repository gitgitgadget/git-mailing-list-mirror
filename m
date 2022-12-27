Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64CEC4167B
	for <git@archiver.kernel.org>; Tue, 27 Dec 2022 04:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiL0E0U (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Dec 2022 23:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiL0E0S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2022 23:26:18 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C84DF3
        for <git@vger.kernel.org>; Mon, 26 Dec 2022 20:26:17 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id fy4so12242048pjb.0
        for <git@vger.kernel.org>; Mon, 26 Dec 2022 20:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HltYtweuU8p+YubG/KehyNfYHOmYBKuGlzlEIoJqHbE=;
        b=WtiRsSQJo78TA8hUf4e0YzfzURp4T7YUhxDsMFVv9vQxjIdxIZlkknJ9f1KkvqXF6o
         bcAQzeG8U+Ud4iQel+/SXZp4RtAJiBjkwRVlKZmYvqB36s6MnzlFcaLDgZxyyDhr7W8u
         6YM6QO8+uKxVKKpRw20m9leDqCbSMp7H78iaVfdmJSTj5VJ3Jc1F///kYV5OgrksiUKl
         nJGIyueM3AJ/yMzQVDLNI03k5c6X6IxX2KS63BTjPxjQURAf1MF1Q/xZDdAiV0J1RR1C
         7x5I6Md3uIju21iusXSl5YRQKBhF+qm5UqLUQb/dQSZuPKt1NyRP1RVozq+kLgm4zVfG
         eCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HltYtweuU8p+YubG/KehyNfYHOmYBKuGlzlEIoJqHbE=;
        b=d9DV+2VRZlTLOeGm71kS3ccdF7509l8CC2kFrrXP5MZqYc9Sq23/GQIGBRexFuTD6R
         cdWuBKLZ2aR743e76n/acpKxdEZD0LyrkAXLvISaHW/2bNh2iXlnPX2Pw22BPnggEer+
         y643LbSzmxuE/oWmT7pmnDDChwM4/l1HjdzZn/FxLCH8Tb3HF+lTvTqYzgFrpi5ZhgKi
         ClNxh+Bl6iEtOCBJPq1FPCx7R00aqsD15O6rw/40CZgmJHigFPTXlo4Yamo0DgHkxu5u
         dpnGz9AyKlrgB3BXvEHnzz4c+XSX+rLrC0NGOFtfkk6r9vlfenVRZ0akxa2P8o7o2EzP
         yEWQ==
X-Gm-Message-State: AFqh2kpt0WNOUv4fXLZE5VKTrAbHfKrsWP1aStVxg6j2OmjY+DDYLRIG
        /dSXGHx1iP3cBnwdr6wsVRw=
X-Google-Smtp-Source: AMrXdXsDKZvcPPdzv6pM9j6tEohcf+FJJSMSo+r1Zf4tKZal8ekAAyUosPMFm87eXPQKK0neu+rdmg==
X-Received: by 2002:a17:90a:950e:b0:223:2edf:857e with SMTP id t14-20020a17090a950e00b002232edf857emr22905145pjo.8.1672115176178;
        Mon, 26 Dec 2022 20:26:16 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id e12-20020a17090ac20c00b00219dab2d7a0sm7045450pjt.9.2022.12.26.20.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 20:26:15 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: cmake topics & js/ci-disable-cmake-by-default
References: <xmqqcz86n8bn.fsf@gitster.g>
        <221226.86y1quv1gw.gmgdl@evledraar.gmail.com>
Date:   Tue, 27 Dec 2022 13:26:15 +0900
Message-ID: <xmqqilhxv5eg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> I split up the previously merged to "next" ab/cmake-nix-and-ci and
> submitted the uncontroversial parts of it as:

Not gathering any interest by folks who will be affected is
different from being uncontroversial, though.  It may not have seen
any controversy so far, but once it reappears in my tree and
sufficiently advances to cause trouble to other people, it would.

In other words, I am saving time and energy of people by waiting for
positive support on these changes.

> I think whatever happens with js/ci-disable-cmake-by-default that it
> makes sense to pick up & integrate those.

I do not think so at all, at least judging by what little has been
said so far on the list.  Comments on two among these three are
negative ones, and the other one had no traction.

>> * js/ci-disable-cmake-by-default (2022-12-20) 1 commit
>>  - ci: only run win+VS build & tests in Git for Windows' fork
>>
>>  Stop running win+VS build by default.
>>
>>  Will merge to 'next'?
>>  source: <pull.1445.git.1671461414191.gitgitgadget@gmail.com>
>
> Per my feedback there, I still think it would make sense to at least
> split up the "should we build with MSVC?" from the "do we use cmake, and
> run the re-run tests we already ran with GCC with MSVC too?".

Do you mean that in our primary CI jobs, you would, using Makefile,
want to keep building the win+VS artifacts with MSVC and running the
tests, even though Windows folks want to drive the same build
process via CMake, and their release binaries will come from the
latter?  

I am not sure which extra corners, which matter to us, are covered
by doing so.  What's the upside?

> But now we won't even run that in CI, and "git-for-windows" will have
> ownership of it.
>
> Does that mean that for such Makefile changes we should simply leave out
> the cmake changes, and rely on git-for-windows to "catch up" with its
> cmake contrib component?

That is the natural conclusion of what has been said on the list so
far.  We do not even "rely on"---it is up to them who chose to use
CMake to keep it up to date or lag behind.  Among those who have
made significant contributions and works outside Windows, we found
nobody whowants to touch CMake.

> Ultimately I don't mind such an arrangement, but I think that
> js/ci-disable-cmake-by-default brings us to a weird in-between
> state. Just removing it from the tree and having git-for-windows carry
> it would make sense.

That's fine by me personally, but somebody has to help coordinating
such a move between two projects.
