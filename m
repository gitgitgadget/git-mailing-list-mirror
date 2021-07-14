Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C07C07E95
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FA506136E
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237123AbhGNAZw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 20:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237022AbhGNAZv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 20:25:51 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7C8C0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 17:23:00 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id l26so616217eda.10
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 17:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=1kbsCOmaIoQJpmyXuN+nZAO8fc4vwToPrNeoqRJ2+j4=;
        b=pdv1jSHQbtWSi+hlG7zjWtfIKlaFvGFTWsIg6Y2PH3L70AWNf7cTxFKdYE96RxJDo1
         5kDLY5YEVGtHhtKPb3/mCAS/K18u2Ymy/m0tYjICjwgyMW289JMSrI6io39iwXafSr1o
         5ByMJjQRRtR905GI4iIo5Ny0VMn1UbKh1MjjHLqDqQZ8K/i+KCSepvNXd6rFRP+e3Jpv
         aRkhQUbV8d+X8mRa6IkabY1T0SpCkoZyq9IM/JMjJZxRuBIkQAFYlm0PPyboBNJPqsKP
         P75qdc9pkdgeSsq0xrlPphsCEJIN6vgYzwEMj13SXe8k2upLQ2OYZvBXoNddv64X1tiK
         70ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=1kbsCOmaIoQJpmyXuN+nZAO8fc4vwToPrNeoqRJ2+j4=;
        b=U/qnbi+Mlh9qMpGZDLnILiTs+3Wk2VC0rpHH80IX6FbOfGFYTweKwGRLNtFMVjfjwD
         gZkGh0rt3NTHRiJidhEWB6l3C8S7J0Ky0Xh7DmujT8LGCaANQsfEU5lDstxcg6hKjQJK
         /ECNVfx1bja1y+r6WUfWT2DH1f1/stCTvZEPaSs+F3aQZRgZJa3hgHmovaB9szGS7Dvg
         DjlCfIuK4etvYgyiVObA8fp3a4PXD39IPyOJAepEqinnIRxR+sw8UJeVL0z5VBwHvqtT
         jgB3Gh9Uy0DM2Ba+r6cxAgDWuXhsDuK121U3n479LEBqsSlFhPiV4OK5rv8ii7YLMsKZ
         ZdMg==
X-Gm-Message-State: AOAM530ETi+qZbMQxl9eVlik8OLxErbVIBJt3PeC3nUMrGIC6hVAkRiS
        qP2FQXhvIHzCoFlskSPMPZg=
X-Google-Smtp-Source: ABdhPJxCcu9AwXJF6acXBDVynLuNZOJiwRNUPHeGILcjFTgDzfEob5Jg0e6x5RXcbHWCM1P1+17ecQ==
X-Received: by 2002:a05:6402:10d7:: with SMTP id p23mr9500725edu.74.1626222178616;
        Tue, 13 Jul 2021 17:22:58 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id ec38sm222217edb.15.2021.07.13.17.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 17:22:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jordi Mas via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jordi Mas <jmas@softcatala.org>
Subject: Re: [PATCH] l10n: allows to translate diff messages
Date:   Wed, 14 Jul 2021 02:18:42 +0200
References: <pull.1045.git.git.1626177676801.gitgitgadget@gmail.com>
 <xmqq4kcx24j7.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <xmqq4kcx24j7.fsf@gitster.g>
Message-ID: <87zgup217d.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 13 2021, Junio C Hamano wrote:

> "Jordi Mas via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> Subject: Re: [PATCH] l10n: allows to translate diff messages
>
> "allow to translate" would be the right phrasing, but it is too
> vague to say "diff messages".  You are only marking 3 messages for
> translation when there are probably a handful more.  
>
> You need to explain which ones, not just vague "diff messages".
>
> I think you are focusing on the words on the "git diff --stat" and
> "git diff --shortstat" summary line, so
>
>     i18n: mark "git diff --[short]stat" summary for translation
>
> perhaps?  And remember, i18n is the act of making the code capable
> of being translated, while l10n is the act of actually translating
> what i18n prepared into a particular language.  Here, i18n is more
> appropriate.

What i18n v.s. l10n means is quite the side-discussion, I have not heard
it used like this before, but rather as e.g. defined at :
https://www.w3.org/International/questions/qa-i18n

I.e. in git.git's case that all our gettext-ization would fall under
i18n, but l10n are generally a step beyond that, e.g. if "git status"
output entries were sorted by locale, fsck and other progress.c users
used localized numeric formatting etc.

IOW I agree that i18n is more appropriate here, I just hadn't heard
i18n/l10n used in the way that you describe.
