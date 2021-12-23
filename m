Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CED4C433EF
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 15:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349029AbhLWP7B (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 10:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbhLWP7B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 10:59:01 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB09C061401
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 07:59:00 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id u1so3403607vkn.10
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 07:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qFhtdDynuol7RFtfkuVMH93dUDdwx80KzQucBnvd+xA=;
        b=jYRLx9ccNHYuYafc7SHk1seSYgY1CDBIJl2hz1i5Z+H4c7AGJpXTzdjk7/Ypplir8o
         qdI8oQMZHAkKb/JiDQdJNk4bqwnQnsvlkncmorNErDfQ9Sb7rVcWswtv5y9XsGi38oiO
         R+1QLDVHPurxXJrofJPL9u3rEkNRNdd/zDNTwMc40PdrBjtd0P6Rtrht/c4QDnUNZ1fY
         ed7EvOeYLTGo9vG8HY2f3EmgOIeBkf1iKZe4CDVdRIloZIRM3eys5IetOHOfZ0PnGAt5
         4MQgbk1Z06RB9DGK1PpeymN1/b4T1S7Wf/YFbidUWrHQLtoF/W9IMSUK3jw/ZsAkuFQm
         lVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qFhtdDynuol7RFtfkuVMH93dUDdwx80KzQucBnvd+xA=;
        b=RT35eHzQkT1bK1EQVO2L5IS0Y0giTfT3A4/PxRvmdCnb/QSEBE1+m18Mvgcz6JmP6u
         OOSbFkXga7Tb0tRLpEYquqdTAk5nGxTxYMiqdIEq9we121vVnnIR1sd87prST/Bnj1Vr
         7oDaIC9I+Fcui1Qm6bu0vmnWbW2q5dljnD9JJ1wT/ASHF/L1MwJUxVPtTuwBWvcVzSnf
         PHNNCD9Ogjzgw224sEXyeSvA37cPkOjxCWELuVD13fzn8oz88zki0b84Hr2wSKHmxFNF
         yLNRaTMDww2ArqYPpP7ABIsNbsBFpZ/ZWyIo6o/g8b6NQW5D7iwzaI89cdEHDN3cUvLs
         vIFA==
X-Gm-Message-State: AOAM533RdDiGOrEj0RiIJkaFWs9CATzHr3BHWul3nCnSkF1XfVy7pfBe
        NAZ2yNkWVfMd1lIULgbiZ6PoAOVjD/3ihPGfLFojbA==
X-Google-Smtp-Source: ABdhPJz917GCdRxlIa8qaiJzbZDaFqJREEtqry/BE5f30aGzxuS0gSsZTvidvnPRHc4hoejyTVLHmXoVe9SFzo14VSI=
X-Received: by 2002:a05:6122:1821:: with SMTP id ay33mr1012448vkb.37.1640275139965;
 Thu, 23 Dec 2021 07:58:59 -0800 (PST)
MIME-Version: 1.0
References: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
 <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com> <e7f1be7bbec0427d5c10453631c3486936ed2bf0.1640199396.git.gitgitgadget@gmail.com>
 <xmqq8rwcfe36.fsf@gitster.g>
In-Reply-To: <xmqq8rwcfe36.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 23 Dec 2021 16:58:48 +0100
Message-ID: <CAFQ2z_MsQjrucS5XiR7sDWb=sZKu0KFYVBspL_dvyq2DoDufKw@mail.gmail.com>
Subject: Re: [PATCH v5 01/16] reftable: fix OOB stack write in print functions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 22, 2021 at 11:51 PM Junio C Hamano <gitster@pobox.com> wrote:>
> Wow.  The first one is future-proofing in case we learn to use even
> larger hash, but the latter is an outright bug that makes reviewers
> feel embarrassed, isn't it?
>
> Thanks for noticing and fixing it.

You should thank Coverity :-)

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
