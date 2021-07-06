Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6484C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 22:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B20BF61CB4
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 22:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhGFWQv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 18:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhGFWQu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 18:16:50 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B334AC061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 15:14:10 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id s24so1075391oiw.2
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 15:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=qx7uZ9ZoBOsQvPcQaKhR0Iwxgahq9SUZpRr4S9t/sy0=;
        b=W6SqPr3PwqpJwN87ScIvEp2Q1jWurPXbblUmQ1aQfmvSGOI8HVrx1MgYnpmALSjj1S
         bLvbld87srGA7CYioukkkXo4GxPcf6vmLoNesHc6LS+/WcKTU6sPDOd7YXeSD42UTVIg
         kXGOX9hVzBJZYmlNMzxmQ7O2FxmmJ53J6QCNZqHjs/35ge+8EXdxxm1JPIKxlEh+Vaah
         ivEn3GOjKiLdeIRJR6OCms7Ykl5LrBv3/XkpCpNN0KA7sFhEeBTsJCCs7n6dlGkvPI2n
         E2/Dn9/xWq9u6vmhthfq2Az887Y++8MYV3m4KeJGX3BXUIdbbkab7iHt5Ce/OQ8gJ6Tg
         w9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=qx7uZ9ZoBOsQvPcQaKhR0Iwxgahq9SUZpRr4S9t/sy0=;
        b=U+IXTc6e+P3ikYyugO5EF6nbXgJNR/Jwxa10bRfXJFA62wElANnzwpn7fB78ZcryZG
         u6wYYRYjXi4wVXgEiJXLuthJPJrPD9VcX6j/NHq89NY/7ayaTaGJIo5VHnPpV9LLqFjT
         1g7Mbo7blLK12d4bl+KgRYtjlvxQmlVGtoRGAKfNvnkyr44RY7M2TpGr8YVTIhjFhr1o
         VTRggOVtLJhVP4uQV28yRmhbsl6V/vYuACxHA0Nb8H0bQ7s7K4MbCY0FFxnb+1oia4iY
         eM5Pv3WtiDHPe3Z8FtNDhMCWPDlErisBEjOma/7Egta/kX2SrNbTtlic8GiE+33GYGmQ
         nmBw==
X-Gm-Message-State: AOAM532vkjnaRons02aANJH1jj5L6y6W2e1v7EsxWpOiUsY0hRCy2i1A
        BYipn41oHLJN0uZ2kKjSMWw=
X-Google-Smtp-Source: ABdhPJyn4lsYABvekuRgoKp+IWTk/48fHA1wDWRgxoi0HvaEySzKl71D0ediTJ37CW2PkGL65turvA==
X-Received: by 2002:aca:350a:: with SMTP id c10mr2283870oia.60.1625609649974;
        Tue, 06 Jul 2021 15:14:09 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id k14sm3088993oon.5.2021.07.06.15.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 15:14:09 -0700 (PDT)
Date:   Tue, 06 Jul 2021 17:14:08 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Felipe Contreras' <felipe.contreras@gmail.com>,
        =?UTF-8?B?J8OGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uJw==?= 
        <avarab@gmail.com>
Cc:     git@vger.kernel.org, 'Alex Henrie' <alexhenrie24@gmail.com>,
        'Richard Hansen' <rhansen@rhansen.org>,
        'Junio C Hamano' <gitster@pobox.com>
Message-ID: <60e4d5b03dbe8_1c4281208b1@natae.notmuch>
In-Reply-To: <04df01d772ad$c9ac7430$5d055c90$@nexbridge.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
 <20210705123209.1808663-2-felipe.contreras@gmail.com>
 <87bl7f5ho1.fsf@evledraar.gmail.com>
 <60e4bf9a6a628_1c4281208b@natae.notmuch>
 <04de01d772a8$540c6690$fc2533b0$@nexbridge.com>
 <60e4c71099ef_1c4281208ad@natae.notmuch>
 <04df01d772ad$c9ac7430$5d055c90$@nexbridge.com>
Subject: RE: [RFC PATCH 01/35] merge: improve fatal fast-forward message
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Randall S. Becker wrote:
> On July 6, 2021 5:12 PM, Felipe Contreras wrote:

> >But this is not a `git merge`, this is a `git merge --ff-only`; they
> >are different operations. There *never* is a need for `--abort` with
> >`git merge --ff-only`.
> 
> Well, you know that and I know that, but having to explain this to
> every new git user who will operationally use git merge --ff-only
> within hours or days of their first clone is a different matter.

New users don't do `git merge --ff-only`, they very likely don't do
`git merge` either, nor do they do `git pull --ff-only`. This is obvious
from the countless threads where users do `git pull` without knowing
that they will create a true merge by mistake.

Even less likely is that they will know about `git merge --abort`, and even
less that they will know both `git merge --ff-only` and
`git merge --abort`.

Even even less likely that they will mistakenly expect
`git merge --ff-only` to be left inside a temporary stated to be
resolved by `git merge --abort`.

But as Junio said, *if* such a hypothetical user exists, we don't want
to keep misleading them into thinking that a true merge was somehow
aborted, because it wasn't.

It's much better to simply let go the current error message.

Cheers.

-- 
Felipe Contreras
