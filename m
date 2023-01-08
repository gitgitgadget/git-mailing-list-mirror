Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F25C53210
	for <git@archiver.kernel.org>; Sun,  8 Jan 2023 07:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjAHH2w (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Jan 2023 02:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjAHH2u (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2023 02:28:50 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4448A1D0F6
        for <git@vger.kernel.org>; Sat,  7 Jan 2023 23:28:49 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id b9-20020a17090a7ac900b00226ef160dcaso4406246pjl.2
        for <git@vger.kernel.org>; Sat, 07 Jan 2023 23:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3nn4ZPPnPNxg6SU5s2TgpmGTHLSv8xlv6HDce7KC80=;
        b=iPLU6+lXO+fdcbRG0lYDPUD6qx+TjUIjMO4AfDMY8CN2UCQ65mlngBBs2RZ/67WS1Z
         paNPn8hOpHdrtB3XoMoFWb1/NVW0g8S/Ub0zf40iuv+I8Lh5DWVX26RUUpfoHIOyIuIC
         nCKtT6NGwxZNOZvHRwb7LijUUsPXOQrJcvNLlpztFn/JGEglFmJSeaqUCSpnMNdJ9flN
         Uba/k/66kEHPexMTsy0a2Vu0ICW8H9RJ/1ri8gmoiUKP9fYueR5n/EyIxV3uRlsTtMmD
         hd1b/DnpVodLB56a2OVXeyjulK9dJ3dSOcLRA2fHIauxLtASvRxe8gDNhYuAmTpzc9Dk
         HVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m3nn4ZPPnPNxg6SU5s2TgpmGTHLSv8xlv6HDce7KC80=;
        b=239PcmGyN7VwtT8LpJdXFWTVeZm5Zc2mhPwjKxqYkR8g/uwZVau3BGAs6WGfNqZLpu
         l5cUBTCnFgodY7/+9ff9Ybjf63W5N6n+ih+oSsnqytTwj2YjwgtmQezTu+FtufGFobFT
         sigmK5as69h1uZZKYEWFOtcJh3fWIop5CarvTSX1fhGAxmpJAGUT6fg+TcfNjsY5Iug7
         nC4nc1OnB7vS6n2TWIEK2q3rvvvCdv5msJX6Z9toTwXrTSEj329dlRZtYyOFkyO59/9Y
         QcJtkmHwv3pOq7CrDIGMyuOtArAb/rABupWdoRdOUzDbA08b0Uow94OnxJlnMkCZyxc8
         UOyQ==
X-Gm-Message-State: AFqh2ko2OjxXyGXpxthwDX9TYSJwgZZRQHGfw1Dl235Bn4R7wcLuWDoY
        KxUJzFn2GROUzXtgzvjjugk=
X-Google-Smtp-Source: AMrXdXtcuqDNhoQYGAxZn3M4iuJND+rYJL++ho9nA275w9nF+/MG30/j1lbbROQFkmOOsp2qqqDBBg==
X-Received: by 2002:a17:902:8484:b0:192:d631:be14 with SMTP id c4-20020a170902848400b00192d631be14mr19011438plo.13.1673162928595;
        Sat, 07 Jan 2023 23:28:48 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id o3-20020a170902d4c300b001886ff822ffsm3700377plg.186.2023.01.07.23.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 23:28:48 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] do full type check in BARF_UNLESS_COPYABLE
References: <efe7ec20-201e-a1c1-8e16-2f714a0aee8e@web.de>
        <9bc1bd74-f72c-1b43-df7c-950815babb03@web.de>
        <4f161041-b299-f79a-e01b-cc00e2880850@web.de>
Date:   Sun, 08 Jan 2023 16:28:48 +0900
In-Reply-To: <4f161041-b299-f79a-e01b-cc00e2880850@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 1 Jan 2023 22:11:20 +0100")
Message-ID: <xmqqy1qdxz67.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Use __builtin_types_compatible_p to perform a full type check if
> possible.  Otherwise fall back to the old size comparison, but add a
> non-evaluated assignment to catch more type mismatches.  It doesn't flag
> copies between arrays with different signedness, but that's as close to
> a full type check as it gets without the builtin, as far as I can see.

This seems to unfortunately break builds for compat/mingw.c

cf. https://github.com/git/git/actions/runs/3865788736/jobs/6589504628#step:4:374

   1848 |                 COPY_ARRAY(&argv2[1], &argv[1], argc);

where the two arrays are "char *const *argv" in the parameter list, and
a local variable

#ifndef _MSC_VER
		const
#endif
		char **argv2;

It seems that (const char **) and (char **) are compatible but the
pointers themselves being const breaks the type compatibility?
Perhaps the latter should be "(optionally const) char *const *argv2"?

