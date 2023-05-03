Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB95C77B7F
	for <git@archiver.kernel.org>; Wed,  3 May 2023 18:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjECSHY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 14:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjECSHW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 14:07:22 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFA63C3E
        for <git@vger.kernel.org>; Wed,  3 May 2023 11:07:21 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-518d325b8a2so4791815a12.0
        for <git@vger.kernel.org>; Wed, 03 May 2023 11:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683137241; x=1685729241;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5LzBky+jdx7H8dHIJrh2kem8SHJB87XbiCmcvufHfyI=;
        b=igRx/m7WmJClOUtb+unApoQDWT8xfFTDmaIIywaoHPqDtKtLnWxDPYB2ZcSi3KCl3e
         Jk4I73N+rred3rblZwIjoixZZyXnHnMbPOSHxaNjBi0+H4C/AcdaMGm1QYrMI+tolb6Q
         duvJ0dQ+Xr7od0P121Cmy2ZH63X5T1VNqwFQexsoFAhyys/Lib91UpK+s42L8PyrQ2m1
         ywYKP30uzwH5uxnr+8Eru4LLRvRnvYiMC4/qSIa66CTGnkf6lf5prKrFbOKrDX4orcSZ
         diDOdWv0D/VxVm7xM/IQ6Ekph5EVRd3p93b9bxjqISaFJSfU4uU2z5MvKW7Ou6Fg8m8A
         SAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683137241; x=1685729241;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5LzBky+jdx7H8dHIJrh2kem8SHJB87XbiCmcvufHfyI=;
        b=T9nnh/0CYuCZtw287SkOgpyHaIz2IQkQcVU5AI2X1H+wBi/5XpUCmeVO9zjCNNNgdN
         EO4uc/BJdo6DiH5uHIUb+aUfxTt1kQUK1xgeNiNJ2wuGayCxiMkiwycCBVIE6cjPgtRI
         /5fzvN83MMFJRSCWOxPooIkFNA6P2mROIvac3ffqo+xKvYsbnQFsXxK6gzOgbk5xgkmb
         PFSKDK4URUsOrdPF00kmQirb4i3sVFLSJgUFk3nsceHO7exp21NfDQ6T6ZOyolt2Cv73
         49yVyC0vp3ED9ywO1SbWa79YDmsgSBLck2nie0APngt5ZT3ocuWNT8/RtUZEtchCy6dD
         xCdg==
X-Gm-Message-State: AC+VfDxgoBBCRyjAgJ9YEg+t0NRYg9P3QG/QS8y3rTvIQ4uMxiCqcnZE
        W68iwmwnnSb5efKn8dgJJYA=
X-Google-Smtp-Source: ACHHUZ6o+0uuUExQPplpZW+gkDLn+ViFUHWFx8qRDZCZWToRo7N9N/n0SVj86gK56+4fNP11t+HvPw==
X-Received: by 2002:a17:902:f542:b0:1aa:ea90:8c8d with SMTP id h2-20020a170902f54200b001aaea908c8dmr1069883plf.16.1683137241140;
        Wed, 03 May 2023 11:07:21 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id d7-20020a170902854700b001aaf5dcd762sm1616683plo.214.2023.05.03.11.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 11:07:20 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t4013: add expected failure for "log --patch --no-patch"
References: <20230503134118.73504-1-sorganov@gmail.com>
        <xmqqsfcdtkt0.fsf@gitster.g> <874jote2zl.fsf@osv.gnss.ru>
Date:   Wed, 03 May 2023 11:07:20 -0700
In-Reply-To: <874jote2zl.fsf@osv.gnss.ru> (Sergey Organov's message of "Wed,
        03 May 2023 20:31:10 +0300")
Message-ID: <xmqqmt2lqofb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> No problem from my side, but are you sure?

Absolutely.

I've seen people just say "we document a failed one" and leave it at
that, without attempting to fix.  I am trying to see if pushing back
at first would serve as a good way to encourage these known failure
to be fixed, without accumulating too many expect_failure in our
test suite, which will waste cycles at CI runs (which do not need to
be reminded something is known to be broken).  I will try not to do
this when I do not positively know the author of such a patch is
capable enough to provide a fix, though, and you are unlucky enough
to have shown your abilities in the past ;-)

Thanks.


