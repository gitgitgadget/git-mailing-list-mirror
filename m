Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A0CC28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 19:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238039AbiHVTlj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 15:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237444AbiHVTlh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 15:41:37 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E4348E8F
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 12:41:36 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id cr9so8729227qtb.13
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 12:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=OipMwG/CC9MAIpySpGywJGUfuNhCYFRKcG5QHV4TWuQ=;
        b=qLRR95vGMmThHBf4qGKdeZcj+FnDdLkiel8qRNLm7AfFOcxakEc+JnvhBOx6VWInDE
         cO/3Fw1t9kn00EFto1CsfBmI8JFU3F8aPkJZ5z/6iMiNgUMc51hjSQkqADUxBWIMLfsO
         vPp4OX+z6o1ZFNGz0pfwDoJmDg+drzvic+OzFLvEQu++OkKeC29DB11CUilt/H8pXo9k
         EPqO+SRdDM+Th8GdMDlDwZ3b2RhEknRzbqAiSZLqV5DFCQbqXZaB9wh6iNAaPkkh74jK
         XlTzD0COn6QofZk8j2RV6ehpa/vIidTofiRgs7Wd3V3ch8XRF6G35WtPGCWcqu1SNx7Q
         +NyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=OipMwG/CC9MAIpySpGywJGUfuNhCYFRKcG5QHV4TWuQ=;
        b=Vvg0mVwCETtDVahz8/D+/DbDm4bPrU+UkHAIZxZfNOcbcC88TSGl6r3hgvk3D1uoy8
         kGNWSyBhHE4qsvPhSu1dACetZrZXnvZTn9eGIbB11yhFrrhKmFviIwLzc8LjVCbabTo7
         eB4Cr1WU3lbq6AuO41UQKCPbQoriBID+DKWngglKrgWaZUzZOi+DNs1yyAvyGf26HU6o
         pSF/I3Zvk9bdG6eGcZGI7qVokc6NdM7bf7irmwUKICalbb+ds6onWmdXdsukbk/ddgYK
         bKC5EArTM5034S0H2LvSFpGIsPNsFXe8YWndIghXEeX3d59mHNEy4sR5RkO+xrrBbAoN
         si5Q==
X-Gm-Message-State: ACgBeo3uMtXT5OrqyyYWubcuG4JmQhKtiWmah75bwAqr+uha7WdLdCWs
        Ihi7MOdFEc12ATzXyAS5vwLd2A==
X-Google-Smtp-Source: AA6agR6v3EUKlz2XwDt9D/aUdtKWZtukSY2Fn8J++fscKwExFQeQBkJjyUDzL52zTlF2US15gWY+cQ==
X-Received: by 2002:ac8:5950:0:b0:344:55c1:6888 with SMTP id 16-20020ac85950000000b0034455c16888mr16542435qtz.413.1661197295670;
        Mon, 22 Aug 2022 12:41:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v21-20020a05620a441500b006bb20e8ee70sm11369250qkp.89.2022.08.22.12.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 12:41:35 -0700 (PDT)
Date:   Mon, 22 Aug 2022 15:41:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        Johannes.Schindelin@gmx.de, chakrabortyabhradeep79@gmail.com,
        jonathantanmy@google.com, kaartic.sivaraam@gmail.com
Subject: Re: [PATCH 1/6] t5326: demonstrate potential bitmap corruption
Message-ID: <YwPb7qamZGpdRpai@nand.local>
References: <cover.1660944574.git.me@ttaylorr.com>
 <3e30ab1a19115107fc24a25118f2417319bd1b0d.1660944574.git.me@ttaylorr.com>
 <3525f8bd-31af-181d-b7a5-6e8a453bbba7@github.com>
 <YwPDkW8KemC5Hs/C@nand.local>
 <xmqqbksccbxb.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbksccbxb.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 22, 2022 at 12:31:44PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >> > +	git init repo &&
> >> > +	test_when_finished "rm -fr repo" &&
> >>
> >> nit: test_when_finished should be the first line of the test.
> >
> > The "rm-then-init-then-test_when_finished" is an (unfortunate) pattern
> > extended throughout t5326, mostly that some tests don't clean up "repo"
> > after deleting and recreating it.
>
> I do not think it is so bad to be defensive to "prepare it cleanly
> enough so that I would not be affected".  So "rm -fr repo && git
> init repo" I would fully support.  "init && test_when_finished" is
> totally indefensible.  It should be the other way around.

Agreed. We should fix those up, probably once Abhradeep's topic has
landed, since doing so now would create an avoidable amount of merge
conflicts.

> > But it's easy enough to just use a separate repository, and avoid
> > removing it altogether. Thanks for the suggestion!
>
> Those who run tests in a batch without "-i" would have more material
> to study and find breakages if you did so.  I agree that is probably
> something worth doing (unless in narrow corner cases where each test
> repository consumes unusual amount of storage or somethinglike that).

Agreed here, too. It's much handier to get a broken state immediately,
instead of realizing that a test was broken, commenting out the
"test_when_finished" bits, and rerunning it again (not to mention hoping
that the failure is deterministic).

Luckily these repositories are small in size, so it doesn't hurt to keep
them around.

Thanks,
Taylor
