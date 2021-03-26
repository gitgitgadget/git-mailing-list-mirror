Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0ED4C433C1
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 15:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 923A261A24
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 15:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhCZPoE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 11:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhCZPnz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 11:43:55 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0B8C0613AA
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 08:43:55 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id z2so6088162wrl.5
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 08:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jJrygbEd0kZx9Mt2aX2sLb97oRhrBz9KEl7OzMbEacM=;
        b=GXv0rhJNnGgHzm0MPvr4K5pnr/pROAIYK3qveu+CTmt1q3ptJXrB0OhY8fuv5sLC4I
         K1FchSSdk+rcfwfGQT7A+cm7/xRKan3i+bn8oKW/RgtUaHifiP8/44Y9C7ab/qCWv7JH
         rb1beaAZWyqpkMUYR5HMf1u3FU8xViqaMP/uCb0A2Sm7rTjNMX2Diw0TiYlh/5vDjATl
         kwX5c4vLf17NJfjktoUQmnc7B8+yM+efPVY3b/8W37VmM8D4OugLqSwul8Z12N53SS7f
         FSaq88VtaVDLRsrX6HeuYXGxvPdcGjCeTo02OMIdleI8lN+xy/QfcpRMsRcrR/C7h06T
         9/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jJrygbEd0kZx9Mt2aX2sLb97oRhrBz9KEl7OzMbEacM=;
        b=Zsgn8Jeqq6hCMwh2beKBAOKZwAril0AuBDMlHnHqQC/ACRkDoN7ZN7WE/wzxbUZnXh
         JZ8CDmEaVSDolikU/FiTCMAPbiy57M1U2Ib0DXS6NRgMnqeIka02D5gnHWVjUDr4xdDO
         HvAoCIRscJ1fSDkJHMOWh67TdL89zhepuUEVzKrCiLOkhbcukCTwP52Wf4e+qZFo6nMb
         2Bm89T5hbqkAdmJtZt1l93f8LsBg/l9ICJ1JWWY2TGIkiAHIQbvCXRM5/1qTxN3yGdmd
         b4MLNqgkwan+5M0O//lPWo6veQGSeEjtrzqtdB/dgoGgC+gWBo6B4NtlUSyeGgRltxnM
         5f8Q==
X-Gm-Message-State: AOAM532+6Gf21Ef1ZHf8aKv3bdZr/gXtGrkRj1tdzDu4VnVrW8Ag/r0V
        O5dYAOIov000dLzUt5zO2jQ=
X-Google-Smtp-Source: ABdhPJyJpGAbhsi6LB1mgtPvWW3CNu05KEyCJSG7xuucTboxb5rmcwvUHQYULAMCvdObyY5r9QsNgQ==
X-Received: by 2002:adf:f843:: with SMTP id d3mr14914559wrq.55.1616773433891;
        Fri, 26 Mar 2021 08:43:53 -0700 (PDT)
Received: from localhost.localdomain ([2a02:85f:2a0a:9300:501f:ca6d:3b18:1e72])
        by smtp.googlemail.com with ESMTPSA id p17sm10349071wmq.47.2021.03.26.08.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 08:43:53 -0700 (PDT)
From:   Stavros Ntentos <stdedos@gmail.com>
X-Google-Original-From: Stavros Ntentos <133706+stdedos@users.noreply.github.com>
To:     peff@peff.net
Cc:     bagasdotme@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        pclouds@gmail.com, stdedos+git@gmail.com, stdedos@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [PATCH v2 1/1] pathspec: warn for a no-glob entry that contains `**`
Date:   Fri, 26 Mar 2021 17:43:50 +0200
Message-Id: <20210326154350.17524-1-133706+stdedos@users.noreply.github.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <YF1tjaATILcSNuMa@coredump.intra.peff.net>
References: <YF1tjaATILcSNuMa@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think I have managed to address everyone's questions in this thread.
Hopefully everything will be addressed by this, and the patch that will soon follow:

> You may notice that I would call both of those latter two "globbing",
> but only one of them is triggered by the ":(glob)" magic. :)

And that's why I argued a DWIM was warranted here
(https://lore.kernel.org/git/xmqqft1iquka.fsf@gitster.g/; it's more clear
in Junio's quote, but you could of course read the original).

I would want to be considered as an above-average git user, and I still was
oblivious to the fact that `**` required a `:(glob)` from the command line.
Especially since `.gitignore` files are treated differently
(i.e. don't require `:(glob)`)

I cannot / don't want to argue to "do it" or not, as I think my experience
is not substantial enough to navigate such argument, and go from concept
to materialization.

That being said, if there was a cli.pathspec.wildmatch flag,
I would've had it set to true in my global gitconfig.
Ofc I could set `GIT_GLOB_PATHSPECS=1`, but I am not that happy to
force it by setting it in a shell rc, instead of where it belongs.

> I am not sure everything after the "the sky:" you wrote is what you
> meant to write.  Without being marked with a "glob" magic, a
> wildcard character in a pattern matches even a slash, so these two
>
> 	git ls-files 'Documentation**v2.txt'
> 	git ls-files 'Documentation*v2.txt'
>
> give the identical result and there is nothing about "surrounded by
> slashes" involved in it.

It seems you are right - in `fnmatch` mode, `:!*.gitignore` would've
served me right (and avoided the whole thread).

If you think that it's just my (i.e. few people's) lacking of understanding
`fnmatch` glob, then we can drop this.
However, given the disparity between `.gitignore` syntax and pathspec given
from the command line (from my limited POV meaningless/confusing), and your
(plural) arguments of backwards compatibility, I think we can draw the line
at an advice been acceptable.

Unless I see other points (like the warn vs advice), or pure C code-review
points, I am getting the impression that this thread will not move forward.
As I don't know how reviews usually happen here, and lacking some other medium
of discussion, I would appreciate (at some point) an explicit go/no-go
decision - to save everyone's time.

Being unfamiliar to the project, and being who I am, I prefer explicit vs implicit points.
Navigating an unknown process from top to bottom is pressure enough to me :-D

> seems to tell me that the "zero-or-more directories" magic happens
> only when /**/ form is used, not when two asterisks are placed next
> to each other in a random context.

Not exactly: ** needs to either start or end with a slash (or both) for its
wildmatch behavior. I can try to make the code more explicit, but of course
the code (and tests) will increase - and then maybe disproportionately to
the otherwise intended-to-be small change (since DWIM is not wanted).
