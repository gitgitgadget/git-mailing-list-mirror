Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19353C433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 06:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D70E522B40
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 06:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4k/+rv5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgHEGL1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 02:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgHEGL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 02:11:27 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D799FC06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 23:11:26 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id o23so17626886ejr.1
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 23:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e68z74QuJSGrdWF3ysunpC762wR6YCLNw+ii2Q7mO/0=;
        b=J4k/+rv5HcEWU5/xQ6X9nfMYIE8V7IM/18+kHKtsRWijxIkdD6fCqIlMfo2RswebS7
         yCiCefPMzztAgEKHIEc0pycyPBDkPFIwSdyaa03uDRoFcXRuJ1eeyI9AiI8eZP7keQPl
         h3kipL+wnpXNTDDJ86TJR/7x9QN0bTC4r4/nf+7tQ9nTYJfYCCh9vZEAVF4xS20MZgMA
         NnNaiP04Rq1OfNeZsyPZ9GQ6n7rCS7pj/ggudAc6HNL5ntOJPbOBovd92tMZJgc/gkNv
         v7GcSwbjpWWmQisug5LMo5PVc7gSudEzRYOpEf54+oJliWG9QxUlDGc6iIVUcBlMjYPF
         kuww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e68z74QuJSGrdWF3ysunpC762wR6YCLNw+ii2Q7mO/0=;
        b=qD/uwmyXlLllvBnZ3Z40kJyMntXcrapVR83eF7rXE1NOft1p5fuo/09iCmnZBGkVBe
         LWvrLuXYEh0fG+NGjbRPaIFNp3goVDG6PlDB3tSjMU06vKnO3zWUohafuh9BTIWk4A7g
         wYRYa6pCJjHhNBccBWZ7hR5EHDwul9duBcjflxUVEFxjFcRIacIm5EEZjncYPkkHDwi3
         9x5Pi5+DuQ1ZXHsEfFZwp650T3SnhzgqJ9ViuyULUNmppxMPQ2ohnSpGnTJmTcNb6Z3m
         tHziKAOMVE2yrJeRvFlB5K3NOLXeid7+udY+bNdhUVCqNlltiVRs0l8RjBr1B/H/obmG
         mDjw==
X-Gm-Message-State: AOAM530zp/xB4fs8G9H6/b6OboxZO10je6fn5O3iNkpfLuOF+pZ1OR1J
        Q+fw2fk5eBXSlaGYz7FLDjK74l/RBs1NRP9g2Z4=
X-Google-Smtp-Source: ABdhPJzX17sii2cOq8G29C/F5t5xmgybdf+3CXBLSWAm6YD9mCH2ZmFnmlxxZKUYNK/uZ90KBKTkr7PU0TrL4CNeFns=
X-Received: by 2002:a17:906:743:: with SMTP id z3mr1658183ejb.216.1596607885110;
 Tue, 04 Aug 2020 23:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200801175840.1877-1-alipman88@gmail.com> <20200804220113.5909-1-alipman88@gmail.com>
 <20200804220113.5909-2-alipman88@gmail.com>
In-Reply-To: <20200804220113.5909-2-alipman88@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 5 Aug 2020 08:11:14 +0200
Message-ID: <CAP8UFD1YAu8pCm4u0KscmJSV0bgd=hQg9F1LaLb=Wj_NHNshHg@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] t6030: modernize "git bisect run" tests
To:     Aaron Lipman <alipman88@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 5, 2020 at 12:03 AM Aaron Lipman <alipman88@gmail.com> wrote:
>
> Enforce consistent styling for tests on "git bisect run":
> - Use "write_script" to abstract away platform-specific details.
> - Favor current whitespace conventions.
> - While at it, change "introduced" to "added" in the comments to make
>   them read better.
>
> Thanks-to: Martin =C3=85gren <martin.agren@gmail.com>

'Helped-by:' and 'Suggested-by:' are much more often used than
'Thanks-to:'. There are approximately 1182, 247 and 69 occurrences of
them respectively.

> Signed-off-by: Aaron Lipman <alipman88@gmail.com>

Anyway the patch looks good to me.

Thanks,
Christian.
