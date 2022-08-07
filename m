Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AE7C19F2A
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 22:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241888AbiHGWgr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Aug 2022 18:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237003AbiHGWg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Aug 2022 18:36:26 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662006263
        for <git@vger.kernel.org>; Sun,  7 Aug 2022 15:27:49 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z22so9323293edd.6
        for <git@vger.kernel.org>; Sun, 07 Aug 2022 15:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=MmGzont8aRED5Q5eA65JNveI2uocqiaDF/bLiOxFS7c=;
        b=q07Z4OG/mHG0LgQJvaxwENPeCnbjdva//azvJvtexvKTOTPRHahapoDWY6xChIoiZe
         VDP0U58DlQfcxtkqbQjrTK0F7QGrQ2EL2VmHPQOYjiGSWNd0sIXMZ+mz9L9kKBbZcZP/
         3AvT60uQheGlHUL01UrZHwnMwPz1rzgwKiqWCgEKQoPARYzr2ku+/q8i3PsD7IMEHUXK
         UkGFT9vF1ljgQySL1PPC82H5xpBJTX9mQonQOhLhn4/bfrOxpm+F+SkzQK+QbmPhxit0
         /YVjsxMXaGOhi2o4TV/pw5La8HQITuLR8DRaJSItBMdNKXWD4zHvi4AOONCwsIDRMtRc
         aONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=MmGzont8aRED5Q5eA65JNveI2uocqiaDF/bLiOxFS7c=;
        b=O1IYWK9S7+8T+N5oPtQzhk+cEiiOriZJNWbM4W/j8X7H+asey4WOedZkKqB+xM1N7x
         RNISnaUrNFMmYe7VnTQoQWK1T5En7wDWQPjKc8/eiksCpH3vJd2BNlxaHYJ+6AtuCNoF
         hyU4Wzic9W0n6hfD09lwDwMQhliAmjj4mF5xVIyJUrDw07xfYhMFPHOK9AzOM3XdqGoU
         pFyQgp84F/P1gCUxThf+IwBSF7YwU2168JjkiJxtuD06J6gb3Wo7ywY8ajECv1bF22vU
         KF3Ia07TOBtQ8GtTmEG81NSxwZ6HYNnjSK1UayQgZyQ9t6FeE8cWoACsJV3wg3xpwRtq
         sdkg==
X-Gm-Message-State: ACgBeo3YctwRsEv610CXUOgE7f3xd0z30F8WllRF3p+repwmtYy5cVC1
        lmdudlCp2cZ9sOkz8fivR9wvcQdMxAiDJmTPkH9BTHxYJdY=
X-Google-Smtp-Source: AA6agR6lm3MnlFOTo9uj70NuZtD+DLKM7f/xUnD6B7+x+iGCNE23uU54NrYGf5GmSAr29vUpjbeoIbRww9mSO8msOis=
X-Received: by 2002:a05:6402:1cc4:b0:440:5af8:41c9 with SMTP id
 ds4-20020a0564021cc400b004405af841c9mr7657306edb.339.1659911267871; Sun, 07
 Aug 2022 15:27:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220807024941.222018-1-felipe.contreras@gmail.com>
 <Yu9vvAKJzOpoQ5AS@zacax395.localdomain> <CAMP44s2s7QV9+Pgkchfk9=X-6Vwz_QZP0Vd145-euT-SR9Xw6Q@mail.gmail.com>
 <YvAGycJR8Yq3hxOh@zacax395.localdomain>
In-Reply-To: <YvAGycJR8Yq3hxOh@zacax395.localdomain>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sun, 7 Aug 2022 17:27:37 -0500
Message-ID: <CAMP44s1QrksABPqfsduJTTNx6H+Keb-6Qg3PEmJJChHZFofvAA@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] mergetools: vimdiff: regression fix and reorg
To:     Fernando Ramos <greenfoo@u92.eu>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 7, 2022 at 1:39 PM Fernando Ramos <greenfoo@u92.eu> wrote:
> On 22/08/07 10:39AM, Felipe Contreras wrote:

> > To me if I configure "BASE,MERGED" and I close the first window, I
> > should end up with the same view as "MERGED", but I don't, which is
> > why I fundamentally don't like this layout approach.
>
> This won't work. Not even after the fix. If you want to modify the layout (ex:
> by closing a window) vim won't automatically update the list of buffers to
> consider for the diff.

Of course it works:

    vim -d -c 'set hidden diffopt=internal' BASE MERGED

Close the first window and the diff colors remain.

vim doesn't need to update the list of buffers.

-- 
Felipe Contreras
