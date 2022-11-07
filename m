Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973CBC433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 19:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbiKGT4S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 14:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiKGT4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 14:56:16 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9423E20BEC
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 11:56:15 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id s10so7938044ioa.5
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 11:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZUUrefOqP72yLUOi0nzFnSlZ6F6Q9wm8MhjQRizihaA=;
        b=vXXu8QEaXLIky6gC/TRh9Jbxj5PoxW28YULmykldNA2A7udRr45bYYCUK+l5KgWaWd
         TcPKKMc9fZAt0cLWeJWU6NNP3Mnze7wOkO2wRUxhC8bMPHbdB9r6tphDq1gcGrg7uICK
         j5EvqrxCc1R9rxjyWq9MbHzr1+IuwMMc8IfUMM6zfFTRH+1knxTNou6Zf1VjcYt3/JSV
         G3W/otne0EqxYEIurOpCM8PLBa5VWhx6JRAiIH54OT83zG46/VjAMz0L4rHyXGHiFCFB
         witaUJhlsbwu+0bnph+raF0PgVSnJDgnLfNfxSl9QEzYfgrduK0Ux/I1NG5jqvIJ4uOl
         ZjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUUrefOqP72yLUOi0nzFnSlZ6F6Q9wm8MhjQRizihaA=;
        b=L0YU/AZjvvMst2ivxDRoCzHx7IOukliLtuc9wsA8XInp/6Hw6KAPCMWdqYAaWwcFxb
         6/1Ia/uLVGhQ4focdfeqwVjnA2eWYSaU5vAwxDm1SVmGYnNKcSaXnTWM+Qr6W/VE8+Ox
         CtYITPW1f4+xn1JKcdcDBxYSEAnat4wwNuTcVnNWP/hBcnLjX/W5IXmXp+eKgdvkRKT0
         UP8SqZE6th8hDqGwnyJY0X/FvhfXm0ckrP3KdZTwySIKXfJzmKB2MtXhVageHM4RKNXA
         tUy+fsqoKi5CBkT9/xaodOtU8ZQ8l6hx4LlRMpSMV5q0LvpzIr4k+oQ+wDroKf7HP9ze
         ZLnA==
X-Gm-Message-State: ACrzQf1yA1plNt6iXyeSOnQsuup7DdzthEaPYWc7qXBOAqHlkuw4eKod
        XtSKW3dO+64f89iIaHlD69aUJQ==
X-Google-Smtp-Source: AMsMyM6E93tI6HGsPtQoMvau5B7cx2dBCqaHu3e3GVHzszVBOwfOHczhAmHDT9dQL2yx4idlXTOhew==
X-Received: by 2002:a02:240c:0:b0:375:686d:7e63 with SMTP id f12-20020a02240c000000b00375686d7e63mr22951688jaa.205.1667850974953;
        Mon, 07 Nov 2022 11:56:14 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g26-20020a05663810fa00b00374f84d3f4dsm3105979jae.120.2022.11.07.11.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 11:56:14 -0800 (PST)
Date:   Mon, 7 Nov 2022 14:56:13 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        y@nand.local, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 0/2] rebase: stop setting GIT_REFLOG_ACTION
Message-ID: <Y2li3Xg5vVTEInUB@nand.local>
References: <pull.1405.git.1667575142.gitgitgadget@gmail.com>
 <Y2WIz5qvjQMfXPgP@nand.local>
 <221107.86mt92vjul.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221107.86mt92vjul.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 07, 2022 at 04:51:38PM +0100, Ævar Arnfjörð Bjarmason wrote:
>
> On Fri, Nov 04 2022, Taylor Blau wrote:
>
> > On Fri, Nov 04, 2022 at 03:19:00PM +0000, Phillip Wood via GitGitGadget wrote:
> >> This is a follow up to pw/rebase-reflog-fixes that moves away from using
> >> GIT_REFLOG_ACTION internally. This conflicts with patches 12 & 14 in [1]. As
> >> this series replaces the code being changed in those patches I think the
> >> best solution would be to just drop them.
> >
> > Thanks, I appreciate the updated round.
> >
> > The conflict you noted in [1] is a perfect example of why I dislike
> > queuing sweeping leak cleanups like in that series. Those two patches
> > need to get dropped in order to queue this series. OK, except what
> > happens if a different part of [1] marks a test as leak-free when that
> > is no longer the case because of something in this series?
>
> I'm about to rebase my v2 on this topic, which I think is the best way
> forward, so this is about to become a moot point.
>
> But I think this is a good example of why it's better to solve the merge
> conflict rather than dropping patches from one topic:
>
> In this case the merge conflict is trivial to solve: Keep the side of
> this topic over mine, and after remove the one function call the
> compiler was alerting about.

I agree that it is better to solve the merge conflict. But doing so is
time consuming, especially in a series which is unfamiliar to me. I
appreciate you sending a debased version.

Thanks,
Taylor
