Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E926C61DA4
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 10:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjBIKaI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 05:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBIKaG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 05:30:06 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE1DF9
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 02:30:05 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id hx15so4882644ejc.11
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 02:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ih+H8Mq1Q+yDd+4jNM6sJKz1V6tYKadPjmKx7Lqi6qY=;
        b=cSP25w4slrZ4z0WZfoP0bBj5uOnN8Wtc4Qxsgf5masBpr5fIEYHPqbXKrsRGglHmWW
         FsCUh5cUrPoSyDe8uMzjWT+6nr5UYf6l7te1iS0WN4np4wfinQef+gCfkw31AirRQqfG
         orH9ThWdL8wiMg9wTQ22y/1ZDwoWYl03qk/K9Drpt1Jq8FNjhnAozixo1vjo3dxvpkEL
         EyCNRsoBB7j0smdSqGCKoAN8KSidz0mtdmz/7AV17xEqN/e80HB3mSGa8e5SHENA36rn
         8VQs1IwOIlB5DsTpFFl6NvfNnJY4Cf8F0mYQiXNQ4/jwGXFzYwNrzZVzuC84xSkNhmcU
         Zkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ih+H8Mq1Q+yDd+4jNM6sJKz1V6tYKadPjmKx7Lqi6qY=;
        b=5Q30UHt9/ZGBKriN4I/5ZMzv53PwFBYFe3+LIiq2jX5f0rtBLOHU1hhuscxUtkxkdF
         U0hfXEmiM7ifFuevve80m8kTfNruUb3+LxEswIZ1+Xsf14svgGwWbClfbh22dF26aX0f
         G78Kg/3fAo9BHmCQJ/60AezxDI+RXMgpWymtsHXUsPCkJwQA8hIc5wtUziJ2S2eAj27n
         e09phvyTe8EIet/POxlSZ3UDXh5rerLr4huWuGbiJfcRKxORq9gZL2wIKH/W1A5kf6er
         pL/vhYVeJW7DNaylDQ+Lyio6TMcwppVsCnPc6TssvSMwYimtKD+7arn30io9UI2HOd/D
         nXxw==
X-Gm-Message-State: AO0yUKUtxyN99Hm9SvgfM9ALsjPb1XbhHWD8EFP6246Zwyy4k/Dgd2CX
        /B1NAZRusbh+wmyJtbxSd9+HTWktmbm6DIGf
X-Google-Smtp-Source: AK7set8TK083ZlPvit+E8sAGVWASED/OvO2+sxn/uWaLbl9xLZmJhWmJnSPdsR7keZdtE2gCzMbT+g==
X-Received: by 2002:a17:907:60c7:b0:8ad:51e9:cd57 with SMTP id hv7-20020a17090760c700b008ad51e9cd57mr7048316ejc.49.1675938603657;
        Thu, 09 Feb 2023 02:30:03 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id f27-20020a50d55b000000b00494dcc5047asm570614edj.22.2023.02.09.02.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 02:30:03 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pQ4Bm-001hZk-1Z;
        Thu, 09 Feb 2023 11:30:02 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Vinayak Dev <vinayakdev.sci@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Doubt about skipped commits
Date:   Thu, 09 Feb 2023 11:21:37 +0100
References: <CADE8Narm5asbx_bdgT=Q_e1CiHUQqFSo3F2cWrataqq3O9YuKQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <CADE8Narm5asbx_bdgT=Q_e1CiHUQqFSo3F2cWrataqq3O9YuKQ@mail.gmail.com>
Message-ID: <230209.86cz6jxhat.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 09 2023, Vinayak Dev wrote:

> Hello everyone!
> I am a new git contributor, and was reading through the source code.
> I want to implement a small check that prevents an interactive rebase
> from proceeding with a fixup in case the last commit did not apply
> cleanly, in which case the fixup could amend the wrong commit.

Hi, and welcome!

> I am doubtful about how to check for missing/skipped commits in
> rebase-interactive.c .
> Could anyone provide guidance?

I think it's probably best for this sort of thing to start with a test
case you think is doing the wrong thing, i.e. can you skim the
t/*rebase*.sh tests we have, and see if you could amend one to produce a
test case that fails now, but which you expect to pass if you were to
implement this.

I'm asking because if you mean that you have e.g.:

	pick B
	pick A
	fixup D
	pick C

And we apply B, but then have a conflict with A, and drop you into the
shell, you need to fix that etc. (maybe extensively), and you then want
"D" to categorically fail to apply...

...then that's something that a lot of people definitely rely on working
the way it does now.

In general just because your commit failed to apply cleanly it doesn't
have anything per-se to do with whether you want to fix up a later
commit into that failed-to-apply commit.

E.g. consider a case where "D" is a typo fix for some documentation
presnet in "A", but the reason we failed to apply "A" is because of a
conflict in code that A and B both modify, but which is far removed from
the doc change.

And even *if* it's all to the same few lines of code it's not obvious
that we don't want the fix-up still, we just want to resolve the
conflict and move on.

E.g. I might add a param to a function, and typo the parm name, and "D"
is the fix-up for that typo, but "B" added another parameter, I still
want to churn ahead and apply this all in that order, conflicts and all.

Which is not to say that I don't think this *could* be useful,
e.g. could we be smart enough to say "hey, this would apply, but not
anymore because this other thing got re-arranged"?

Or maybe you're talking about something else entirely.

But in any case, coming up with some testcase or demo for what you think
is the wrong thing might save you some grief, in case someone annoying
like myself comes along and says "actually that's intentional, and a lot
of people rely on it" :)
