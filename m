Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9E0C433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 16:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376640AbiFVQyS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 12:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377151AbiFVQxc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 12:53:32 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D74540E78
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 09:51:18 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 59so3284930qvb.3
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 09:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rbVcXuz5bVQfNLja+V5JG28cSNeju0zm0/NpRQ9Zm0g=;
        b=QgZU6qaIKgMf1d0NAh8HhBwVCOpR7mTOpNmY5CukLpBQiBIwZNUfupfCnCmn88bvKW
         z1i3tqVPo1npWTZgoUySv3zYok2e6q/L2BY8Lk8A9TAs/07RW0obnpk9Qvgh0cIynb1X
         hFH1AVZYa07fe4chD1n050/DqnQMY8qXaHNRRHmjCbduNX67E5TmTzP+fxYgnjRz19fi
         i9Yh8bN7S7FEdpXu9p5eaiVET6JhiNHSVe3Xj2HEkrILqqCdJrvwL8ZnFiIyWXkQXFrv
         DYk8R0A6KXcKpFbOAz9JgzF4ZTWJyb6kAf8zSqpF2Dp9cxvxw77snxPD27YAxakRSbYP
         khxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rbVcXuz5bVQfNLja+V5JG28cSNeju0zm0/NpRQ9Zm0g=;
        b=wG8kzbc4igBnt4QRyHWyz3GccSFwy/v20+mzWwFGhRo6gdkbhvIuDbWvNMwYWzwKwW
         cK12R+DKgJnsGogWCn2DYq76LuW8AsSClmbPgBVL6sQtUTWb6EClaUIK0IpEa1uUQMsT
         zVjRjqjEGHZ7tzqNwviXMdZ7k1LbCA0qwp/nVZw6mzM0F51KOP2nt4ZgHVWbjgLNO4ks
         tNsFO03PdG1ha+/6WdzysZpHdg23/4Cw2ZEbGbrIv9DxL/BNNVLFy30Uqojfy/kZkLI2
         oiLIiJaelevRKf3dy00EekfdrPTWtdsiuH5qghRtJ1HOp8QsQAN6qgRkH9y414cYo7VK
         RUkg==
X-Gm-Message-State: AJIora8+cuCFwya90o0XrMoikFoWgbM41QNJK2UDdEG8z5bly1MPPI0k
        +UxIre2Qjyftwxr1Vuo0Pbx+Cw==
X-Google-Smtp-Source: AGRyM1uGPTWOD9uD/Jg/LDkL4ZdJtIxbQX6qBECYAsVRiolk2cE9ONmD5qlN0vRq5zC4Ui6v1ToLlg==
X-Received: by 2002:ac8:5d8f:0:b0:305:182:b659 with SMTP id d15-20020ac85d8f000000b003050182b659mr3871834qtx.603.1655916677632;
        Wed, 22 Jun 2022 09:51:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bs26-20020ac86f1a000000b00304fd1f6b4csm14377864qtb.77.2022.06.22.09.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 09:51:17 -0700 (PDT)
Date:   Wed, 22 Jun 2022 12:51:16 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 3/6] pack-bitmap-write.c: write lookup table extension
Message-ID: <YrNIhGt8mlKMO40D@nand.local>
References: <YrDxt1MkQKdNJL1F@nand.local>
 <20220621125054.23035-1-chakrabortyabhradeep79@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220621125054.23035-1-chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 21, 2022 at 06:20:54PM +0530, Abhradeep Chakraborty wrote:
> Taylor Blau <me@ttaylorr.com> wrote:
>
> > I'm not sure if I remember why `table[i] - selected->xor_offset` is
> > right and not `i - selected->xor_offset`.
>
> Even I myself got confused! Before sending the patch to the mailing
> list, I was clear about that. That's why I didn't catch the so called
> mistake I have been notifying till now. Thanks Taylor for asking
> the question!
>
> I should add a comment before the line so that people can understand it.
> Let us parse `table_inv[table[i] - selected->xor_offset]` -
>
> Suppose bitmap entries be like -
>
> Bitmap 0 (for commit 0)
> Bitmap 1 (for commit 1)
> Bitmap 2 (for commit 2)
> Bitmap 3 (for commit 3)
> .
> .
> .
> Bitmap 20 (for commit 20)
>
> These bitmaps are ordered by the date of their corresponding commit.
> `table` array maps commit's lexicographic order to its bitmap order.
> `table_inv` stores the reverse (i.e. it maps bitmap order to lexicographic
> order). Say for example, if commit 4 is lexicographically first among all the
> Commits then `table[0]` is 4. Similarly `table[1]`=2, table[2]=1 etc.
> `table_inv[4]` is 0, table_inv[2]=1 etc.
>
> Now suppose commit 4's bitmap has xor-relation with commit 2's bitmap.
> So, xor-offset for bitmap 4 is 2. And `table[0] - selected->xor_offset`
> is equal to 4-2 = 2. It is pointing to the commit 2. Now, 2 is in bitmap
> Order. We need to convert it into lexicographic order. So, table_inv[2]
> gives us the lexicographic order position of commit 2 I.e. 1.
>
> Long story short, there is no issue regarding xor_offset. This xor_offset
> is not relative to the current commit. It is absolute.
>
> Sorry for the initial claim :)

Ahhhhh. Makes perfect sense. Thanks!

Thanks,
Taylor
