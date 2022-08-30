Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2D2ECAAD4
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 21:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiH3VaL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 17:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbiH3VaD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 17:30:03 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B2717040
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 14:30:01 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o4so12340244pjp.4
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 14:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=1Pf/DKFdjAyA9yfZJITjIzyQjzNRNZG8l2blrAcIQUs=;
        b=Fh8Ysrrj+NKKPYNl6CWnhocIYwd+SBDEc7AoWK1Ty6y//6X86welVI42Z+3YGkTAQG
         POlaWb2W2aOKSJyA3YPg+borlZU+zJxunf5cnv79xO5uUJDtFcNH1oOQSiZi1Ehb0jBZ
         fcnpZlhK1q1u1aAlU8k/8pA/U+vY25KBzOLoCuWxrPYXKrHXr+7JSRvNV+FSBtHwOETg
         NFtokTiy3geEgDOKwUkgTv7H0gH4d9XAXQ3GDW7htZ6dfq+zHjVirGb0awPpd7gXjSHD
         8Ys20OVbKwRykDhaeYtA0TjNm3Ta6p8TfgPHkcp6efbH1MS7OveBk1Seu6EMnzJZ262i
         1w1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=1Pf/DKFdjAyA9yfZJITjIzyQjzNRNZG8l2blrAcIQUs=;
        b=DsbJR+m8lVEbLpv/uX+l90quGHd+2qGAUVQetZtNhCT43KAqY/kB1CO6XjJIntovJ1
         M0AojKGlXzCarDK5H1K77kkmy6EARSdT72yHA0zvkxYig8q4AAZ+514WBcvqNctNmmhw
         5cd2axb+o3JsstZzoorI5dBgOuouRjWosBHvnLknsWHGRuLvW8bDftivI4uIC2tBnwnQ
         2dOnnA+DtLQnm1Llgjuwk5FioZCvViC19GLrzC0TUC2nmdcAfIY607DFa3CxmWbP9nGB
         DqoeT6tDvzOdq4PYqmGGL2q0uz540U2TwPvIkdRP3fE99N0Xz9rTIlxaXYZm5ITwrtah
         wTaA==
X-Gm-Message-State: ACgBeo1N4sF9hxVjILvV4L8ZK0W7qMi5cqlo+9PAC3yT2Z6rvD6iBMnH
        zgbBRO4vFMICRz3WJDVgbTQ=
X-Google-Smtp-Source: AA6agR4qLToopy8xnxaXcjSHelIw2TFOVZf9KWnCuO1tjga1bRZYQyZVFEw055jFDHk7agR5XhEU3g==
X-Received: by 2002:a17:902:bd49:b0:172:df88:8981 with SMTP id b9-20020a170902bd4900b00172df888981mr22870647plx.120.1661895001281;
        Tue, 30 Aug 2022 14:30:01 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id e15-20020a170902784f00b00172f4835f65sm8184110pln.271.2022.08.30.14.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 14:30:00 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     phillip.wood@dunelm.org.uk,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: validating signed/unsigned comparisons with Coccinelle, was Re:
 [PATCH 0/3] A couple of CI fixes regarding the built-in add --patch
References: <pull.1340.git.1661867664.gitgitgadget@gmail.com>
        <p9p431r8-nq64-02sq-3049-n10rrn1o89o7@tzk.qr>
        <dc48ce59-530e-da74-93ad-9eb4a17e391c@gmail.com>
        <73spp934-1q41-1123-41no-q2337954op92@tzk.qr>
Date:   Tue, 30 Aug 2022 14:29:59 -0700
In-Reply-To: <73spp934-1q41-1123-41no-q2337954op92@tzk.qr> (Johannes
        Schindelin's message of "Tue, 30 Aug 2022 23:12:24 +0200 (CEST)")
Message-ID: <xmqqbks1ifmw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Phillip,
>
> On Tue, 30 Aug 2022, Phillip Wood wrote:
>
>> I wonder if they would be interested in fixing the parsing bug we found
>> with Peff's UNUSED() series.
>
> Could you point me to the relevant mail? I am sure that I can come up with
> an MCVE that will help them pinpoint the bug and fix it as quickly as they
> did with this here bug.
>
> Still amazed at the turn-around time,
> Dscho

https://lore.kernel.org/git/xmqqwnax438x.fsf@gitster.g

