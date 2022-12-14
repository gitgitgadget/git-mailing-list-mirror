Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7EFC4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 08:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237733AbiLNI3V (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 03:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237742AbiLNI3S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 03:29:18 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0C7167C9
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 00:29:17 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gt4so6169426pjb.1
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 00:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Fj6KRVhWW7CFTcX/xh+iAgQf5QxQzJPpf1yzlz01xoc=;
        b=P2FMmZ1iIOY+E1pbSvYvp+g3bTgK6oPoq8BqOISg06yu4x04lp4HAchFCWKRHS2Hh/
         nBwfLVw6HcV+3g8l3Avy096j/VYyH57BKeqSfaR/LqbTKkrUOV5W47Fme+8hrLqxvh0i
         V2vQ8P/YeSWlU/SIl/P82anodgPTeyp1BJzBaRF4UtDgHhSVSyuij+Ekhtu6CSbkclkZ
         ZzDB4aqX0fOI6V+zcFTZxPBJR5F6lOvY+m0uqftL6wkh7nw0PtqisypuBIyI7hFER9OK
         WWm+Fe97dMiAy4MOtp1MExuswgA5Vs7iZMXzhl5gBg0mkVyrtH4j+Tejy1MKB3+c4HnK
         69lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fj6KRVhWW7CFTcX/xh+iAgQf5QxQzJPpf1yzlz01xoc=;
        b=ZAxKI4/yEEU7OlRuzxfB1yVXYKN1DLN0pL9SqgqCUbBQQ8PgiuLqsgl2UzaR/gkOde
         sKhxu/PWiE/Asqb5c0qz0FZ3x1mruLSkatI+ZtsBGQDXqSXDBs3K9w6PEzXn26TlF+Hp
         vP1sCDmZhxHWLElilkemE9+DocsZ/jrbqL/qA/nZoPeEUCmNMmHU6aZDkE5VALxrDWR1
         +BFMeSQ799xsrYAr0iyzTgF9zL4aPxFYwfuHPCK9pVSWhUROJ/snMaOh3z2yFOsx6aVt
         cy0gYzqFkFFpsgAO9D7Xt+CwPfSFeq4BbMfG7OTYelDbWXRdY0z4TgjDCYjzrwOjtutH
         SPTA==
X-Gm-Message-State: ANoB5pm67NSgpG0ZrBvrKi/chNKtS09r8OCYP7TPdXvSAdhuT3mCYenO
        CV3ne9BDIe9zYR0SHiR/W2P9Et5iOmreXQ==
X-Google-Smtp-Source: AA0mqf6O8ZexMsudkwyRxiZ7OBYRhJt5vpEJ71ZkPJMLKOcM3FW+OBVzFFa2nbXa3+of80alCSw1IA==
X-Received: by 2002:a17:90a:b282:b0:219:e43b:7f03 with SMTP id c2-20020a17090ab28200b00219e43b7f03mr24604995pjr.23.1671006556577;
        Wed, 14 Dec 2022 00:29:16 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id j3-20020a17090a694300b002190eabb890sm830283pjm.25.2022.12.14.00.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 00:29:15 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Tao Klerks <tao@klerks.biz>,
        Luke Diamand <luke@diamand.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Subject: Re: [PATCH] git-p4: preserve utf8 BOM when importing from p4 to git
References: <CAKu1iLWvd+PVOK405Q+SNDyyYnhbi=LtovZvWw55y6eQqoRpaA@mail.gmail.com>
Date:   Wed, 14 Dec 2022 17:29:15 +0900
Message-ID: <xmqqv8mewfqc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com> writes:

> I propose rolling back the patch that introduced this behavior, and if
> that is not possible, I would like to submit a patch that adds a new
> setting in the "git-p4" section that will enable users to opt out of
> this new behavior (for example a boolean setting "git-p4.noUtf8Bom").

If a change in the most recent broke P4 users who have happily been
using "git p4", then we definitely should do both.  Immediately
revert in preparation for Git 2.39.1 or Git 2.39.2, while working to
reintroduce it as a separate option to allow the feature to add BOM
automatically to please users like Tao.

But for such a resolution, this report should have come while
fbe5f6b8 (git-p4: preserve utf8 BOM when importing from p4 to git,
2022-04-04) was still in flight, before it was merged for e4a4b315
(Git 2.37, 2022-06-27).  We had three months to do so, and now it is
way too late.



