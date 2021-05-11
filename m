Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9398CC433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 14:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F7E86117A
	for <git@archiver.kernel.org>; Tue, 11 May 2021 14:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhEKOEQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 10:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhEKOEN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 10:04:13 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AA7C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 07:03:06 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id t11so28745832lfl.11
        for <git@vger.kernel.org>; Tue, 11 May 2021 07:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=eVsLBGOEttcOXSNbzEfXLWowCLd0G9TBjunMLwsK0rE=;
        b=NKtWP8XQdxppBzNksUc/Lw9kYMoCJj9p27KMUBhG3MuiZJ1WxHJlOI91AE/iwYCFW/
         Co+fOyPexHvBFU41KrudE+dVBswiaHYHpEUPjfrQWg1N/SAxg9fXjP04fIK+WQWQIEKa
         ZF/M5ddPpYeTyo2QS8KqdLm/wG3DP7r1FgrtoIiyjtHOVrC4YA1uyW0V5ypIUoPbuLF3
         wdxkBxJvtB+bPV/swjLJs4HlqO7E9Tjdt+XYMRm3yTuJo3A/l0y24jJfxXtHP8R5BSSY
         Aaec/VlZTWHpuQXXljm31pe1p3eXYo3r/M/so4Cv1Om3f4VaGRZ/tb23W8Mybr3OY9Ez
         e+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=eVsLBGOEttcOXSNbzEfXLWowCLd0G9TBjunMLwsK0rE=;
        b=L5jNeMYDGJ2nqV5qPRwobBrHu5kvEvg3XVCa1f4jWL2VbVvl5E0/PN1SyeFAsxd/O/
         lnXH0GghANd7LKTlJ9nWnndWSzFg9//n5BZZDM6/3B5yG9A2fKOvSV2i39Acwqqpo+yL
         5phqQA5ZHlFl36WGqZAFtUKCGhJQZTSnRv3SuzFSsc/ifjst0sX5iA9fIAuae4vj0jgY
         dYji7/L8vJjLL2HK/0Jpgn4IREHqYSl4FrWsqv/RM9yTgMTwW/IDhkK34CC/JOJ1wMNS
         OTmKjRXJr5si1geR8YiRkbSeHEKijMe7Kh5fGSjLcA3YWrTGhVBooJTx1qrHSQoKghB9
         0KgA==
X-Gm-Message-State: AOAM533y6qRVQZn7xVxuWz24ZMK1Hu3HZARQRYFa+GnkACanRAsOvjYP
        3ARl9/OzwQ6uu/oRU+3ADpuoXflhKds=
X-Google-Smtp-Source: ABdhPJyHmsD5FsGKT7h3RP4it5WWqsnUNbqYokYGZBkWF+gx4+iFVcMtB0b1eZM/0a98zVr8K76O9Q==
X-Received: by 2002:ac2:5f6c:: with SMTP id c12mr21224833lfc.292.1620741784316;
        Tue, 11 May 2021 07:03:04 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id f16sm3711533ljp.19.2021.05.11.07.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 07:03:03 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 6/6] diff-merges: let -m imply -p
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210510153451.15090-1-sorganov@gmail.com>
        <20210510153451.15090-7-sorganov@gmail.com>
        <xmqqsg2toqik.fsf@gitster.g> <xmqqo8dhool7.fsf@gitster.g>
Date:   Tue, 11 May 2021 17:03:02 +0300
In-Reply-To: <xmqqo8dhool7.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        11 May 2021 13:56:36 +0900")
Message-ID: <87v97pv04p.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:

[...]

> If we enable "some kind of diff" for "-m", I actually think that by
> default "git log -m" should be turned into "log --cc".  As you told
> Alex in your response, "log -m -p" is a quite unpleasant format to
> read---it is there only because it was the only thing we had before
> we invented "-c/--cc".

Please, no! --cc has unfortunate feature of outputting exactly nothing
for a lot of merge commits, causing even more confusion than historical
"-m -p" format.

The best default for -m output is --diff-merges=first-parent. Everybody
is familiar with it, and it's useful.

> But that might be outside the scope of this series.  I dunno, but if
> there is no other constraints (like backward compatibility issues),
> I have a moderately strong preference to use "--cc" over "-m -p"
> from the get go for unconfigured people, rather than forcing
> everybody to configure

I rather have strong preference for --diff-merges=first-parent. --cc is
only suitable for Git experts, and they know how to get what they want
anyway. Yep, by using --cc. Why spare yet another short option for that?

Overall, let's rather make -m give diff to the first parent by default.
Simple. Useful. Not confusing.

Thanks,
-- Sergey Organov
