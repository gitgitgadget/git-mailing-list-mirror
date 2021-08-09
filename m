Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB554C432BE
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 16:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C765760F56
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 16:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbhHIQON (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 12:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbhHIQMu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 12:12:50 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB61EC0613D3
        for <git@vger.kernel.org>; Mon,  9 Aug 2021 09:12:29 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id y3so2037721ilm.6
        for <git@vger.kernel.org>; Mon, 09 Aug 2021 09:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=A+XiF54HvJvAgP8jXZ4ZCWPI8Stj0FJJzcJok9b+VF0=;
        b=D+F7jFbqiqSAAC7ImSnQVimFSgRbVhRG+xx7CDjDZVqlneMnzpXu/+ERi9L0bJO2RO
         4Y5wNrs34FMf7aSSbJfXF9DFnAWyyvoDVZfz4TWzvXwNej6+f3TEc9khr1Wjqnao+wtB
         f6kotxBnKkm9siOJUswJ4oBPVM0NVCoP9F5C+ZVVAXRnjje0q1TttieakuV42Z/61/Xs
         TN2mwJofV8PP5JozpwP+Oz5R356sRvCMomPOm8nEVlja2jqE1CZYboH4nkobkGUla1pZ
         w7JhkZkTFJNdCfFe3E67aj26YpI5AZQqoUxc4+CZH/8vQKzssODIl3RxfKj+yem3GvML
         xtjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=A+XiF54HvJvAgP8jXZ4ZCWPI8Stj0FJJzcJok9b+VF0=;
        b=CSfhmmVPPlyG+r57ajVuVXppPGDXZSXSBh9sYXzIStOIl0DHlwrXI3BNNtWyNFjwez
         ymqI6cCU22xsg/AvBMeYiIV/jokyUawla+D0e8h/KR/x1wpQxC7b5MPQOeDzLvm+CeWU
         dncDB/5oir9HG+ZSQl4k7T6D3bYSigQovbQ0tvYKuG0MuuDPk8Ho9FeWehosaWnq8ibV
         qjfz6m51bwixv3oxfgTLscCId8Z39kxme5Yd7s7fWGsXDAUpIig2WjHyLx9UjuzAsLbx
         ds9FfSpdvxpjrboMipGttyID4o0SnjkOwm9EXn4FkY+RLlScfyW+Q+96GzduYmyF7Swu
         L4Qw==
X-Gm-Message-State: AOAM532dpTNxkd2rllNdp+9KCAJJp1J3/c5Kj1hifB2w/PvIKaToUIF6
        i9kL3w9RaZZhTmwUw2bcmU7e5roK8tqwDfDy9igeekWn2jA=
X-Google-Smtp-Source: ABdhPJzvTn/ga0ExaB/8wKnZg/5nyzho1OuGZ+9beFjpxVt2o2Q2RTCa3Xh+rUI3E8+0UT7a1NFCJSaL5E6CMvfLDr0=
X-Received: by 2002:a92:360e:: with SMTP id d14mr80690ila.171.1628525548991;
 Mon, 09 Aug 2021 09:12:28 -0700 (PDT)
MIME-Version: 1.0
From:   anatoly techtonik <techtonik@gmail.com>
Date:   Mon, 9 Aug 2021 19:12:13 +0300
Message-ID: <CAPkN8xJqqnJfdUM5fEEMA00JoKsFcqnQo--_qbCLAx1qXSrgdQ@mail.gmail.com>
Subject: Working with git binary stream
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

In https://lore.kernel.org/git/CAPkN8xK7JnhatkdurEb16bC0wb+=Khd=xJ51YQUXmf2H23YCGw@mail.gmail.com/T/#u
it became clear that it is impossible to make fast-export followed
by fast-import to get identical commit hashes for the resulting
repository (try https://github.com/simons-public/protonfixes).
It is also impossible to detect which commits would be altered
as a result of this operation. Because fast-export/import does
some implicit commit normalization, fixing that probably requires
too much effort.

As an alternative it appeared that that theres is also a
"git binary stream" log that is produced by

git cat-file --batch --batch-all-objects

Is there a way to reconstruct the repository given that stream?
Is there documentation on how to read it?
-- 
anatoly t.
