Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31947C433E0
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03EB464ECF
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448740AbhCCGff (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 01:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2360742AbhCBWYz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Mar 2021 17:24:55 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFE3C061788
        for <git@vger.kernel.org>; Tue,  2 Mar 2021 14:24:15 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id v8so15875196ilh.12
        for <git@vger.kernel.org>; Tue, 02 Mar 2021 14:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8hLzHMKoDXr1owq7Y/V4ayaBqQPZsk2o8WeKxVT6LJs=;
        b=Pz6Kd3xPskFLBr+LEl8Ijs/6mmtvzEBpIHaYsbNQcVSxaWCGh91JidbLK0fmdcspP4
         BYiG2V8Pi0K2r5gUem0gbM3/8+yGY854FgvFY6cXy3i0kIZybG0J0iAVT5dgMmqk+Nnl
         LdgYyAkBPjBfv0DMiVwBua8Dn+AJN83pQQY4AqqWs5lf+F4XpBxCgoUMuo1L3kWE/mZb
         1wbW+xzVl34TXa8EN/Ko6kuEi3aLay4ntmdMOKHxe5un6inJjj3Xj8Mf7u8KUQNDzly4
         imSO3JQPHrA0NhQWdp2GAPr7gPSK2UCHEzdZcbKbcbaRaNb6KBX0fUsgW9Q+v4FSI70Z
         dtGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8hLzHMKoDXr1owq7Y/V4ayaBqQPZsk2o8WeKxVT6LJs=;
        b=BJjD2IiY2iZpwbSTqRbUEjVr7L8gZ1NuzmuFn/cbpptc6voBANQ625Z73H3FGWwviJ
         kjINZtscIMgAyZPi6VPbWJKNWlpmPwRiFKbfQ2lIiDFMpzJcKSN39L4Oez/wxfh6M48G
         Evtx90l11yEV1MQ8s4VXPADVuSscIQhdUsiyABzWg6B0KZR7HQ0w9bbl+hkztUztrW8z
         6QaIBaYJOiV6VdeSwhxyTgZA8orVT5jKfb4FgXuwc8mV74zkbnfyZO89vIB3eLJXSfAD
         1ZDrh6WO+CxKcgJy16ZUlk51TU4dZfz3Fk20qXZ5q5MBSzG+RWwD62XAagqMR+zMiTjB
         8GoA==
X-Gm-Message-State: AOAM530AAlOknqQrULekdUP/vqIjqzlaDC+8lrJSMavCNesD39vhf2wU
        Uzefp1pj88ey8jhDs6cFQl8wTq+j25h/ZnwmTUmOdshnuMtNlw==
X-Google-Smtp-Source: ABdhPJyr3Sg0gC99csDhlzVZQtDhmKqRbcOiu6EyvFyob7F//z7bdDP+HDQWDRvpx5fwI0lX7UVkWsg+fyOqpUWXjFk=
X-Received: by 2002:a92:b003:: with SMTP id x3mr20767065ilh.15.1614723855280;
 Tue, 02 Mar 2021 14:24:15 -0800 (PST)
MIME-Version: 1.0
References: <CAPkN8xK7JnhatkdurEb16bC0wb+=Khd=xJ51YQUXmf2H23YCGw@mail.gmail.com>
 <CABPp-BGDB6jj+Et44D6D22KXprB89dNpyS_AAu3E8vOCtVaW1A@mail.gmail.com>
 <CAPkN8xK9__74a3aEFsevfdW_hQ-vzWE+c=QypRacTktuZOfdSw@mail.gmail.com>
 <87mtvolbuj.fsf@evledraar.gmail.com> <CAPkN8xLE68d5Ngpy+LOQ8SALNgfB-+q4F3mFK-QBD=+EOKZSVg@mail.gmail.com>
 <87im6ak5hd.fsf@evledraar.gmail.com>
In-Reply-To: <87im6ak5hd.fsf@evledraar.gmail.com>
From:   anatoly techtonik <techtonik@gmail.com>
Date:   Wed, 3 Mar 2021 01:23:59 +0300
Message-ID: <CAPkN8xLtVS4Xx86UMrRXD09P72NQc+DwQVG40gEXaEDRD53mBA@mail.gmail.com>
Subject: Re: Round-tripping fast-export/import changes commit hashes
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 1, 2021 at 11:02 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Aside from other things mentioned & any issues in fast export/import in
> this thread, if you want round-trip correctness you're not going to want
> JSON-anything. It's not capable of representing arbitrary binary data.

Yes, binary data needs to be explicitly represented in base64 or similar
encoding. Just the same way as ordinary strings will need escape
symbols.
--=20
anatoly t.
