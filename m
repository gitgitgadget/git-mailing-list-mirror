Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B07FC433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 13:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AFAF611CA
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 13:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353500AbhIINhm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 09:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357655AbhIINeT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 09:34:19 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C97C0D9419
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 04:55:16 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id v24so2272105edi.10
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 04:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=7DMYZtEjEsSGEXzF1rA9pGe6AZ3x9pJJyn1T6VBRHf8=;
        b=O7rBajOYy6ia6hdQpgkMon1dG5dU2lSQLHxn9FWtSIKSUsARL5OYjNYm4HcxLD+aE3
         noXVixV4v0fHooYj6cD91SYaM7MnbG4UZn/YJFiHOvtarfc0YTeKK17xUxCMEpfxm+nk
         0JCI/UmR823VM9rOUVCJPDPn7aidXnsam7/UczqgeCMx+LfFsvgomgJjsPxjRTvyWyPb
         cp5jxbFTQauGJp12YXJQKgunXBtnJOpSXCWViUz1wfcrkg+0tu4XBaIxHZS+t+Ybu8xC
         5Ezu0u8y9KVprR5xjJbNJmvzESY2rohyPaLxq6sXGYB5qpVvM7pbTUVAIVRNo/WUnGX0
         Awsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=7DMYZtEjEsSGEXzF1rA9pGe6AZ3x9pJJyn1T6VBRHf8=;
        b=n2eeVDvpI9GxV0QArcLzOHhTNzc0dVM7klIDL1+DK4JcOBhLSnf2oRWynTDpVpyhyi
         bTGDpz9n8gkrVGqRCE0Gm3pMRRLM0OHOdsmL1vJLPb1rZkvg/94cW3vn5Ry84ewAzzF5
         XJfa0BlKx22DNJdGojwNJmgA6lEsr3+9e7lZFW48FioaiBlBP8AloZKlaaOFGSWNrCot
         Kz2ZiHwRSOf5l8qUYi6J4JHJyhyBZcWfvIZ7KcquZlG7sok8PEGn9IjvcBZ6vnQHl17E
         jfVNQCjRjpjPFSh0nFWIwdYU3xEBchHYg4ZgoxzxLBp58HFTjGOoDeSRAmHo6seo+FhJ
         gJvg==
X-Gm-Message-State: AOAM530mat56AqzYCMG5tcJ0d29HIUiXZ8d5MiFp8VkXV5tklQyx9CMz
        xSE/JWyp5Iniu5lAiDAUNl4=
X-Google-Smtp-Source: ABdhPJzPGBSW/OiqqxbA3fW4Y7yV7G9ogxKZMV00oZjPWJuLqZi4DJN1e1czVMpUoSJNDztrOBKOIg==
X-Received: by 2002:aa7:c9cd:: with SMTP id i13mr2827555edt.178.1631188515252;
        Thu, 09 Sep 2021 04:55:15 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h8sm885240ejj.22.2021.09.09.04.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 04:55:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] gc: remove unused launchctl_get_uid() call
Date:   Thu, 09 Sep 2021 13:53:58 +0200
References: <b0d6bb0b07f29e68f5bcdf4c69d3d726d77882c0.1629819840.git.gitgitgadget@gmail.com>
 <patch-1.1-93adb856b0c-20210909T012244Z-avarab@gmail.com>
 <nycvar.QRO.7.76.6.2109091222260.59@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <nycvar.QRO.7.76.6.2109091222260.59@tvgsbejvaqbjf.bet>
Message-ID: <87bl52dkv1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 09 2021, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Thu, 9 Sep 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> When the launchctl_boot_plist() function was added in
>> a16eb6b1ff3 (maintenance: skip bootout/bootstrap when plist is
>> registered, 2021-08-24), an unused call to launchctl_get_uid() was
>> added along with it. That call appears to have been copy/pasted from
>> launchctl_boot_plist().
>>
>> Since we can remove that, we can also get rid of the "result"
>> variable, whose only purpose was allow for the free() between its
>> assignment and the return. That pattern also appears to have been
>> copy/pasted from launchctl_boot_plist().
>
> I don't find the most crucial information in that commit message: what is
> the fall-out of the removal of this call?
>
> Such an analysis (_with_ a summary of it in the commit message) is
> definitely required. And it should not be left as an exercise for the
> reader.

Do you mean an assurance to the reader that the removed code doesn't
have any side-effects? E.g. an addition of

    As the patch shows the returned value wasn't used at all in this
    function, the launchctl_get_uid() function itself just calls
    xstrfmt() and getuid(), neither of which have any subtle global
    side-effects, so this removal is safe.

?
