Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA85BC352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 01:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiLGBAr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 20:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLGBAq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 20:00:46 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3524745EFB
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 17:00:46 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id h17so7263627ila.6
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 17:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b+S1hjAuFDAdbI+A5sGqRtlYoiwEEwcSOnDHv409rvU=;
        b=zBcnSHS4mx+maZJh/abmFPC3k2BT47GH7rgu/yB/WcfWs7GLbosdDIDtihaz8c3XI/
         R6bkJKMYnQ6bvbwCSsbH95xm/l3wvk5dhsRjRkpQ09wNRpdm+hO/34rQ/MrhXnRUbm/Q
         7kJ76hfg6uvDnf9D+Hq0rsf1AAYBrqad9RdIQmWmF9buYg2puBR5JPwJx2gty5lXcXDU
         RH2u4qCB34QNQEelQ3N+PNbtjoT99XCqCfh+n1Uv9q1u8/yLJ/6YUhri6dFPoUjj/xLM
         okFMePi1YGgtiRxGYIhGmMVFU/jw5aM97jCi4/JCJuQQyQPsNoR2dwhYn+lXz99Pt4EB
         6lBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b+S1hjAuFDAdbI+A5sGqRtlYoiwEEwcSOnDHv409rvU=;
        b=5KqOLIavTUvHiltN/7jl8OfeKtq5v8brFw/FULk96oTB+nBZyu4SLLxMMFrb25vik6
         Y2fWDTr3u+ZnvrXrQlq16/YQSqMV3Fkzi7sxjXnADQCr8UDmRWn1zTSjeqAVn0FsJpYj
         tL9Roi/8tXSXo6YL6i31Y3VdWQcBYx795up8s/wqJahEVM2Q+3O/cO2VcOb2XVnGKBWF
         5pkJcdaaZcV9ukl2jz+tMF2kqKnal1f1dsg+cPnD/sbz32n6LBhUU1bl383yR2J67h8y
         38QMhSXKA6q3tI+6brmloLiFQDyRWTar219DiDTFtFdtFDUXD4bmlHH3NeglCIfw7sVQ
         2qMA==
X-Gm-Message-State: ANoB5pn6v3YhtBF4QSW18ZnZZ61yAaU4+vryL6wXydFYaveC43ueccM4
        kl6ceWrNqGu7/gpFCvXpty/OwQ==
X-Google-Smtp-Source: AA0mqf5JSSmrvFovDiODMheb1XiHR949gYwqOs7c2NQdNP5nyqtJ04HqwJrZiqqjctiiWxx4riLdIQ==
X-Received: by 2002:a92:d790:0:b0:303:1035:9d87 with SMTP id d16-20020a92d790000000b0030310359d87mr21185466iln.97.1670374845511;
        Tue, 06 Dec 2022 17:00:45 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t8-20020a02b188000000b003762327da9bsm7146603jah.89.2022.12.06.17.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 17:00:45 -0800 (PST)
Date:   Tue, 6 Dec 2022 20:00:43 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] test-lib.sh: discover "git" in subdirs of
 "contrib/buildsystems/out"
Message-ID: <Y4/lu8Ekt/DP6imJ@nand.local>
References: <patch-1.1-f27d8bd4491-20221201T162451Z-avarab@gmail.com>
 <xmqq5yeuspam.fsf@gitster.g>
 <87f22a55-ee84-2f76-7b9b-924a97f44f89@dunelm.org.uk>
 <221202.86sfhxg2ng.gmgdl@evledraar.gmail.com>
 <Y4qF3iHW2s+I0yNe@coredump.intra.peff.net>
 <221203.86pmd1dyqn.gmgdl@evledraar.gmail.com>
 <Y45/8WnuUnP9gOMo@nand.local>
 <Y46clyoKk9KzFiqj@coredump.intra.peff.net>
 <221206.86zgc1cnc3.gmgdl@evledraar.gmail.com>
 <Y46jT0i/7DhxHzfS@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y46jT0i/7DhxHzfS@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 05, 2022 at 09:05:03PM -0500, Jeff King wrote:
> On Tue, Dec 06, 2022 at 02:43:17AM +0100, Ævar Arnfjörð Bjarmason wrote:
>
> > > I don't mind having it in-tree if I can ignore it (assuming the project
> > > attitude is the "it's a side thing" from above). It's the CI failures
> > > that make it hard to ignore.
> >
> > ...but on this thread-at-large, I'd much rather see us focus on just
> > reviewing the patches I have here than raising the burden of proof to
> > whether we should get rid of it entirely.
>
> Fair. In case it is not obvious, I have no interest in reviewing cmake
> patches. ;) But I will at least stop making noise in the thread.

Same, and same.

Sorry for semi-derailing this thread. I don't feel strongly enough about
the CMake stuff to start a new thread about it on the list, but while
others are discussing it, I figured that I might as well chime in.

Thanks
Taylor
