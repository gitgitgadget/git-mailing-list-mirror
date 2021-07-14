Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AADC07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 08:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83F8E61361
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 08:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238522AbhGNIpc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 04:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238432AbhGNIp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 04:45:29 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEEAC06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 01:42:36 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id r9so340769ual.7
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 01:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1gML4HkA7vYySQaFwr/bgkA2g0DW2aGSHH0nT3ZEXoo=;
        b=K5XR2Jhs+vrx9mHyLSfktfaHyQP9OB5Hxhot87/It8oXaBx3AmAiOW9c6i2AvEbQzC
         UZil3grbEx4ngxXNQtN+ZVRpKOIFAK3+O/BcxAbfeQcuevLe2wQt0OCZI2mWfsJCf+SC
         uHCOE2tyH9XbiuHuWorqdGai/Caj01qVYHSkLoOazK0r/eZUCWvr+wRakppCu6aqc9vo
         siyxW+88gNWaPrf097GVbsw1mWMSfD2OLUNFsxAF83GzAsbZz1vIEB8Zjt+z7ZiYoP05
         ZRr2S1MTsbPYyvRHjLuBFqZ0bTPoUviLNIEirlkDeRxjmQiQ7ZXSkJD2K4unRluuy6Io
         v6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1gML4HkA7vYySQaFwr/bgkA2g0DW2aGSHH0nT3ZEXoo=;
        b=d8V0Mgg3puwJ1K26DngenD/ncVPUM28ILgc7MgjJWi5/4oUvcKwV4Zic5w8Le2uRIh
         lQci75GXr8KSIHtfSgJx9bv5uoRePHEAbNElfpKdtcKbFp6GIRo5zxZPujFWrd9jyag3
         PSAWM4VZevsesdDL33pKnLY9XI3MH1f4uCBzxmNnEU/nJnBdUKwP7gFL5+S6R8nkwIeb
         eyOvICslEi+k/VsVFH5t50s+Bo9mFNyQlR8pQbnB7OK7bWHPfz4WNREuDAg7BV9ndC9+
         JeBE4KqxWYtc2xDJOsiqxbOpVG/1rlz+oM88EMIRshamJ0u5ceg/JdGKRzRGV4g55zxj
         7NGQ==
X-Gm-Message-State: AOAM532slGxWmvju+VEN5zSljLpj7xI9WWfWDLQ4ZeWmt7vgH5DfTq4V
        FmtJ5CZ41TPD18SZYvbOEz6iHnBs0BO0r8Y5fR6t7w==
X-Google-Smtp-Source: ABdhPJzT61b92BE8BGas06oMY4whIbQt1QboIjzHc5i46CRfbTqLbe7DAea3roGhNeRyY3p8chUmlb2vA1Fo9Ral7pg=
X-Received: by 2002:ab0:7305:: with SMTP id v5mr12578541uao.47.1626252155706;
 Wed, 14 Jul 2021 01:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqmtqpzosf.fsf@gitster.g>
In-Reply-To: <xmqqmtqpzosf.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 14 Jul 2021 10:42:24 +0200
Message-ID: <CAFQ2z_P=9Suh0kO6E44hUOyNFOAKcmcUg_x6AQFP9jhHrBA6RQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2021, #03; Tue, 13)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 3:07 AM Junio C Hamano <gitster@pobox.com> wrote:
> [Stalled]
>
> * hn/reftable (2021-05-20) 27 commits

I have some updates for the series pending, but I'm waiting for the
preliminaries (test fixes, the errno stuff) to hit master.

How do other folks deal with dependencies between topics?

> * hn/refs-errno-cleanup (2021-07-07) 6 commits
>  - refs: make errno output explicit for refs_resolve_ref_unsafe
>  - refs: explicitly return failure_errno from parse_loose_ref_contents
>  - refs: add failure_errno to refs_read_raw_ref() signature
>  - refs: make errno output explicit for read_raw_ref_fn
>  - refs/files-backend: stop setting errno from lock_ref_oid_basic
>  - refs: remove EINVAL errno output from specification of read_raw_ref_fn
>
>  Futz with the way 'errno' is relied on in the refs API to carry the
>  failure modes up the callchain.
>
>  Expecting a (hopefully final) reroll.
>  cf. <CAFQ2z_NzykfcBSvtHQ10RZWxLP48+qArZk9HbDJQB4tNX-GtYA@mail.gmail.com>

AEvar posted the corrected patch as part of his follow-up series.
(https://public-inbox.org/git/patch-04.17-270cda29c3a-20210711T162803Z-avar=
ab@gmail.com/).
Would that work for you?

--
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
