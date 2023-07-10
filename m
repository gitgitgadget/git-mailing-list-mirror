Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CA6EB64D9
	for <git@archiver.kernel.org>; Mon, 10 Jul 2023 04:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjGJEpB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jul 2023 00:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjGJEpA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2023 00:45:00 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F298118
        for <git@vger.kernel.org>; Sun,  9 Jul 2023 21:44:59 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1b3ca17f2a6so3284147fac.0
        for <git@vger.kernel.org>; Sun, 09 Jul 2023 21:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688964299; x=1691556299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UT97KtsBhrtqhNaqQ7wsNdcJsXMgYGZOp9o2ewXwSa4=;
        b=cXuj51tQBfDq6iqzgc+oVvai2FKUxwD7s9sZdXmdbMHMqqUWoxdxhQWvmq3yWZGPCu
         2o+Ak9UVYwTZ+qaFP53gU8sfNqwabJpbUJEXbxsBv8UOiw2YPqrDGWunq7iIcg3mY2Lv
         M30KQhUXsBEPM+ThsM1Jomae+jC78i0i5/Kk60cyMqhyhFd8dJcBjL8s4+B+U55Q8wNS
         Np0VusN6Vavy4NSVoCBfqglzHgmpm9/7ri5U5bBHSISGDtaQT8vqKIf73lp340g84j3n
         FFkYE4S+V8jV0Ac7CcScOy/q4OD2XfP+wYWsBDqQULRz2vcIz1frCyqOWdgig6VN749v
         D2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688964299; x=1691556299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UT97KtsBhrtqhNaqQ7wsNdcJsXMgYGZOp9o2ewXwSa4=;
        b=Vk36a78PaibIPvPeSHeD5DfIcp4iQxEmI4iQtEPS906lgh39e9dqHR8ou630vaY81F
         G9bq8q0sSGwyx/Kuiw3+avpIL4CZyvoHnHzeZRcR5XnKqfbQHigW3z2nb5n/t5UjeVW5
         nYuDe9AnaJsKe7xrrfvnJQTACn3JxzlwECcaYgrD7OLbBS6AqBGGpltN0l3VKrxnL6JF
         UiQRXMR28KE9ymD9BIFW9qRG8MBhBpS/CzxG7KCZz2ok+Zc6jAjlKkt8BC+3WFtaWsG1
         Fzf2kID7sez1XagHgMawEuhElFZAsCC4UbJtiVrddZtaPt/d8cSN3oOdGf/66c+Vck2K
         OxPA==
X-Gm-Message-State: ABy/qLYIpUsb4wP0wBtdyJMs9z24PzSmBP1QXnsJ91eZtrgKPhBXGvU/
        qhxUsbrtp4QHBV2zVi21LO39IYfKPaJIHgPacG4=
X-Google-Smtp-Source: APBJJlFxAxvdk55FdSMGDNZlTIrL5JMiRBe5bY/2Vb9MNarbb2cOTYAztETH+5HwGemkAPnnR3g500b9n++u7wVNMfo=
X-Received: by 2002:a05:6870:c20e:b0:1b0:b13:c18 with SMTP id
 z14-20020a056870c20e00b001b00b130c18mr12877960oae.3.1688964298776; Sun, 09
 Jul 2023 21:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230704194756.166111-1-alexhenrie24@gmail.com>
 <20230706040111.81110-1-alexhenrie24@gmail.com> <20230706040111.81110-2-alexhenrie24@gmail.com>
 <xmqqttugbxds.fsf@gitster.g> <xmqqo7kobwpj.fsf@gitster.g> <CAMMLpeS9_P=XXMoOdTAM3jZbaxfLEJNwYArS6p9pMXisT3TRtw@mail.gmail.com>
 <xmqq8rbra9ti.fsf@gitster.g> <CAMMLpeQ2P+qQxo17dEdWhMHcmAfTiBoEifp2wUjWVrP+oGSzxQ@mail.gmail.com>
 <xmqqbkgl6f04.fsf@gitster.g>
In-Reply-To: <xmqqbkgl6f04.fsf@gitster.g>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Sun, 9 Jul 2023 22:44:21 -0600
Message-ID: <CAMMLpeSwadTcd+z0-J1t=vUgz0wFiVaE5KaT-Wy1cckT3=fFGQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] remote: advise about force-pushing as an
 alternative to reconciliation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git@matthieu-moy.fr, christiwald@gmail.com,
        john@keeping.me.uk, philipoakley@iee.email,
        phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 8, 2023 at 7:38=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
> > I agree, showing this message in the middle of `git commit` is not
> > ideal. However, that's a separate issue that can be fixed later; it's
> > not part of the problem I'm trying to solve in this series.
>
> That is debatable.  Even "by the way you can pull and reconcile
> early before you have fully finished working on the topic and are
> ready to push back" is irrelevant during `git commit`.  "Reconciling
> the differences is not the only way to deal with divergence; you may
> decide to simply discard what they have with push --force" is even
> less relevant at that time.  So it seems to be very much an integral
> part of the problem you are tackling, at least to me.

I thought we just agreed that we don't need to mention force-pushing
in this particular message? I guess you're saying that we'd still be
over-encouraging `git pull` if we don't remove this message from `git
commit` altogether?

-Alex
