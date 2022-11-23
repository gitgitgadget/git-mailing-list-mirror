Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA14AC433FE
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 23:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiKWXyB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 18:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKWXx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 18:53:59 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220B4DAD01
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 15:53:59 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so3574075pjs.4
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 15:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N+yhghePNQRkRtkUpIAUVzuVNrqceWHyDCm6AxlfayQ=;
        b=VyZ8rrEcBn081yg8DGTbFsWDTR2JqZRcm76FpfaEpgBjM7vG5IXq1ByarolcDjXc3F
         9s0YJg6YE37JzUDTSjl3S7yXRT+RJD9lX3WZG/RVhwcwaRzGiOdUnPxrfk6SjvhXfVZP
         k00duFaWNCp7BhGD6qas30RLNNBV2ucKS9oa0RD+yOWch+i/Yh1Dtof0slQdatR+0V9U
         ASf1shpY70x0Zyv+2J5st9BNlltzt03uJWFbL8iw9bl4eDJ+tSCZ8Q+8N1jgnJ8VyJAX
         IBDLZ1HT1mtbeg1+upy5MvHRY0qmmaClebU4gOM3Lwb2Im64uHdfTSFwVaa99XoWF6yY
         x3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N+yhghePNQRkRtkUpIAUVzuVNrqceWHyDCm6AxlfayQ=;
        b=GxB4CBoMkhNxjzmZ4QTKny6JncrIBtJ+4W5T71mYtGzoHuKalB1xKH9d69gGC41L0d
         g12O+wMd0B57fFxVFgiYky/2bhZp6mUmMAxJhdSYC3OzhRB1+kCk5BD7qTFXq5QEY1ht
         whdgY6iij83xzPy3rYKwe4o5aId2/HBsXct5pdJcF0IARnTESd+uNGgGvHjfhu/nVbuI
         RB2FWvkas7hfviQIj6tpI/gjyeZCYMutQXKtYsld9BbDi/suZEwsk9e7W5QBXdryQAX5
         xUumcOcz284Zv+V5G6waerri3bh7L5KjzcuO3Krnv9M77gj3A0Mi1bAmXMLZf2SGd44n
         NQfw==
X-Gm-Message-State: ANoB5pnP1Yi2Patbsf2Bwkn001W1UsOY03FnWg/XiS/oCSOucdoYO89T
        L8ebBB3aaHzrH2+sTjrbJZQ=
X-Google-Smtp-Source: AA0mqf6kkJ0wcUcag1G06kLFSZMkYrWxsT8KaMgKXFmjmuWu9btn54bBo+QuZUJ7p/0r+nqnLiinOg==
X-Received: by 2002:a17:903:330e:b0:189:57e4:c470 with SMTP id jk14-20020a170903330e00b0018957e4c470mr1469061plb.66.1669247638523;
        Wed, 23 Nov 2022 15:53:58 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id r19-20020aa79633000000b0057293b17d64sm13673540pfg.177.2022.11.23.15.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 15:53:58 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Hasenack <andreas@canonical.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Andreas Hasenack via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] chainlint.pl: fix /proc/cpuinfo regexp
References: <pull.1385.git.git.1669148861635.gitgitgadget@gmail.com>
        <CAPig+cQ6_7wf6C280Rqi7mcTCiQp-n5GiLWTPazfcUcGFeZi0g@mail.gmail.com>
        <xmqqsfiao47q.fsf@gitster.g>
        <CANYNYEETCaaQGOXVLrRCC8wdS-uD66BHqr98Eetb+1GVk5WkTg@mail.gmail.com>
Date:   Thu, 24 Nov 2022 08:53:57 +0900
In-Reply-To: <CANYNYEETCaaQGOXVLrRCC8wdS-uD66BHqr98Eetb+1GVk5WkTg@mail.gmail.com>
        (Andreas Hasenack's message of "Wed, 23 Nov 2022 09:16:51 -0300")
Message-ID: <xmqqfse9mdm2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Hasenack <andreas@canonical.com> writes:

> Should I still change the commit message regarding where I mention the
> commit that introduced this, as explained by Eric? From the activity I
> saw overnight it looks like things were already picked up and it
> doesn't matter anymore.

Sorry, I should have said "will apply with tweaked log message" to
reduce the need for a round-trip.  Please double check what is
queued in 'seen' and send in replacements before it gets merged down
to 'next' if there are still things you may want to update.  If you
are happy with what is in 'seen', no further action is needed at
least for now.

Thanks.
