Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16E4C61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 05:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbjBWFf5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 00:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbjBWFfx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 00:35:53 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F0116AD2
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 21:35:51 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id o12so3693987oik.6
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 21:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6SrEgXuXdRBOaJDWGOrhyvbed5sioVN7MJm6ro2SHTI=;
        b=AKzKrQnkgjYFJ9OjbpKWSC0AEX0R77jCYrwfQSSqBwWmG+JHgdFtUUA1seR3YxSNjL
         75BtBUWsZj3nmHXkW/W8Z+vbo7gZG++VxhjfRGEBpg7kDTPtj6QC+aB0Pcq+D0NpcsKO
         3DRJxPr27F3QLLl5+D2wAw6X+PjgqFSecz3noYSclH5bffPJm2U7k+XiIr+V6HamT70V
         /EZq08IpRH3GVQ3hORtst/lbBwaKEvTV6W2gSKn7yRecDW/F8I8osaYpQ3f/pBxm37kk
         m1IHaNxECJ0s53a4DWg9IIQLlujktcePp9UOh4e9uUikDt399J5+OC1X7reB9RN0XlDm
         Qyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6SrEgXuXdRBOaJDWGOrhyvbed5sioVN7MJm6ro2SHTI=;
        b=2Hvmw2Uwq3aEn6n2XvIJgu4iPWZBP8cdPd3LzihHITsp71ls1yJx10YQjH75wHFjCl
         LGXR2Up4uV1X2/9awczBrRng9CbwPOJjp7AP68f8ATMNLVkxoxpfqZFOCHTdchmSVzVg
         Tb4UBor55HghlulHe+KkHPXu7C/N0+HS1HZCrsrTd02nthJ8WyEa+Eid9/WXFTw8KsXb
         8xCH1GBltwL2g7S06tT5lHB6e6OXP5NrxuK78kPnOaAqd+NItuiqlc/lp8SqP7wwrEuN
         kD5AhkuswXGQe/cduvNaSQBtF8v+gjd+AyzYtL+Hm350wDgD0ybCvUmjuDyGEaFFiLV3
         h1sw==
X-Gm-Message-State: AO0yUKUMvdFclWizMBLvGRctWw8JxXy+Dg5FCFh4SC6XyYopXwqGRIaR
        mAtMyPHqqcj40W9d2k1YfRv9gV69//pNZOAv6IdEfVRN
X-Google-Smtp-Source: AK7set/TBMSRzTDgAbIHL+MLL5H2eAFTn3OzWSA5lnTnzATSkVRLNpGlMV4Jn9dHrJ3PDG+IRkWTsJR+qOrDZwSTHPY=
X-Received: by 2002:a05:6808:1795:b0:37d:8c44:93bf with SMTP id
 bg21-20020a056808179500b0037d8c4493bfmr1054733oib.141.1677130550780; Wed, 22
 Feb 2023 21:35:50 -0800 (PST)
MIME-Version: 1.0
References: <20230222051709.464275-1-alexhenrie24@gmail.com>
 <20230222051709.464275-2-alexhenrie24@gmail.com> <xmqqlekpb6f3.fsf@gitster.g>
In-Reply-To: <xmqqlekpb6f3.fsf@gitster.g>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Wed, 22 Feb 2023 22:35:39 -0700
Message-ID: <CAMMLpeTsg6kRxun84YS_PwBkdUHPV=6St1KCavz-zcw+kZWzUQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] rebase: stop accepting --rebase-merges=""
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, tao@klerks.biz, newren@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 22, 2023 at 4:56 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
> > +test_expect_success '--rebase-merges="" is invalid syntax' '
> > +     echo "fatal: Unknown mode: " >expect &&
> > +     ! git rebase --rebase-merges="" HEAD^ 2>actual &&
>
> "!" takes any non-zero exit, even a segfaulting "git".  Let's use
> test_must_fail to make sure it dies in a controlled way, i.e.
>
>         test_must_fail git rebase --rebase-merges="" HEAD^ 2>actual &&

Done in v4. Thanks for the feedback.

-Alex
