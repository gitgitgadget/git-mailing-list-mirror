Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B34C433FE
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 06:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237710AbhLFGcR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 01:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236571AbhLFGcQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 01:32:16 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5A3C0613F8
        for <git@vger.kernel.org>; Sun,  5 Dec 2021 22:28:48 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso7487356pjb.2
        for <git@vger.kernel.org>; Sun, 05 Dec 2021 22:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=174x7EOPxVdRWIWja7ft/qV5YaR7mszqLTau95o6Zg4=;
        b=mhtKvMZvs0iNLORiM6BTE8Tqw7YUfMjYoQ2TO/IjCLPrlbZeBEe3SG4elLHRAj3wIr
         sgWM3nQ9AyS8gmZKZrqhBzwYjF0Mt1AOQdFUynijJSjdQdmzGlaBlnQ7Tuw65uvnUsOA
         9+rtN2HAeBBNdztgDEY8FEFBYqdoH3Rug3bllZ+dWGA29JQ6BRc97FneEz0o2pFNscQE
         /4YLfcjskKmyc8VJaPpw8kGtIGUkQLwdHNULBhQrgVbH9SO18ubq7JF9VMw7OQwpx+nO
         l9eUkqU2zm0+drdrL9wJTbhm3Ae98GTiD0/DeFXuU+Cqm7VzWtWWGfOcA7SKwXfnPafc
         ke/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=174x7EOPxVdRWIWja7ft/qV5YaR7mszqLTau95o6Zg4=;
        b=fuBqwYr9ZWS3kd0KCZB1DTPOBZ4uH0Oab4rk/57Z8bDaXmqhIfvrFewRykrAazmcHy
         GEW9+ABpriclzDe8yFpzK22+1YRxOdRwLYNGQqOSToyTuuYajUWsNicGLcxkIJP9BzOK
         xMgPkaGsdnCxWrogKZG3Sl3HCxo/WjA16OoVmve3dNE5HA35P3QW/uK1LKp9eip+KJl/
         19bzqijFkfedb8xqqzOzuwun45mvA1Dp2RLf4foSIQKvO30LJECK42qEgqailPsEQyjg
         zxzosK89UlZGBDmbIOt94pbNmU8OBzdrC3SlYfzlQr5hn0gIqigcwRF0jCTDIrVhzJaC
         YAVw==
X-Gm-Message-State: AOAM532pguvL5cde/QzbhReQ4gVCn63kFIa4DjfUDdH3d7shvvgopah1
        Y+yDnPAK657bZ1A03b/scVQ=
X-Google-Smtp-Source: ABdhPJxjV+Ju5WlRzuRXPeDqOgx+SI6Pw3OpkZRRkNEbpf7+2HGw5uJvAVGS9ctQu/3z49hWYIiBkA==
X-Received: by 2002:a17:90b:50c:: with SMTP id r12mr34865744pjz.71.1638772127835;
        Sun, 05 Dec 2021 22:28:47 -0800 (PST)
Received: from localhost ([2620:15c:289:200:33cd:af64:d2cc:36ad])
        by smtp.gmail.com with ESMTPSA id 95sm8610458pjo.2.2021.12.05.22.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 22:28:47 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Aleen =?utf-8?B?5b6Q5rKb5paH?= <pwxu@coremail.cn>
Cc:     "Elijah Newren" <newren@gmail.com>,
        "Git Mailing List" <git@vger.kernel.org>,
        =?utf-8?B?5b6Q5rKb5paHIChBbGVlbik=?= <aleen42@vip.qq.com>,
        "Aleen via GitGitGadget" <gitgitgadget@gmail.com>,
        "Johannes Schindelin" <johannes.schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2021, #07; Mon, 29)
References: <xmqqzgpm2xrd.fsf@gitster.g>
        <CABPp-BE4uYBFnb-AgVJhNo6iK4da5hiEFEBhd=7Ea3Ov=4K4zw@mail.gmail.com>
        <d95f092.3f.17d73a85761.Coremail.pwxu@coremail.cn>
        <CABPp-BG9jHaJYekDnvZT+8QW_fLGM_bmz-oOqzJswaotyVDFBA@mail.gmail.com>
        <211203.861r2tsfej.gmgdl@evledraar.gmail.com>
        <CABPp-BGE5Ff=adH3nREMDm38DGLEmtRTcPwuJowHw-ckwpbmqQ@mail.gmail.com>
        <211203.86wnklqx05.gmgdl@evledraar.gmail.com>
        <30b4169a.18.17d8d589b6d.Coremail.pwxu@coremail.cn>
Date:   Sun, 05 Dec 2021 22:28:46 -0800
In-Reply-To: <30b4169a.18.17d8d589b6d.Coremail.pwxu@coremail.cn> ("Aleen
 =?utf-8?B?5b6Q5rKbCeaWhyIncw==?= message of "Mon, 6 Dec 2021 09:25:34 +0800
 (CST)")
Message-ID: <xmqqilw2i6w1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aleen 徐沛文 <pwxu@coremail.cn> writes:

> Dears Hamano,
>
>     In my opinion, the '--empty' should act as a strategy option like the
>     'X' option to 'git-rebase'. Since that the default behaviour of not passing
>     the option is stopped in the middle of an am session, should the 'die' value
>     dies the whole process but not the middle state? It may also make it not
>     confusing.

Hmph, unlike "git rebase" or "git merge", "git am" does not employ
different strategy backends, so "-X<option>" would be out of place,
I would think.

Among what we already have, what kills the entire session is called
"git am --abort".  Since I do not find it unnatural to say "'git am'
dies" when it stops and gives control back to the user, so that the
user can decide what to do next, I am not sure where the aversion to
the word comes from (on the other hand, I find 'ask' highly
unnatural since we do not ask anything---we just throw the control
back the user).

