Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E144C433B4
	for <git@archiver.kernel.org>; Mon, 17 May 2021 16:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFC0D61004
	for <git@archiver.kernel.org>; Mon, 17 May 2021 16:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238865AbhEQQQ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 12:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347219AbhEQQPX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 12:15:23 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95042C03543D
        for <git@vger.kernel.org>; Mon, 17 May 2021 07:48:37 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id z4so1075316plg.8
        for <git@vger.kernel.org>; Mon, 17 May 2021 07:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4AKCO1L3I7Kzvtw1cuapjUC8hVjO6rs40Z+Ml+u4wu8=;
        b=rjNsrBOxvMt7ntcOcNRpeiJb9hdIEn3FREhgpOmHQL3H5sOjnALyE+5aZgnii49oUv
         45HZwX40xVcwUCmibD9kd3zgOfxTzbNWXyadTS2vIc0BN2ETcGa4tf/G2SFUoKpFrEEZ
         nYBMeHQvNzWKabrFkoiF9XYQlf4NjYD1wEE6YSyqV7pVlDsbQQFZlZHV8xmXKmM7UV5E
         AgUDO9haJzB+m9P7KfeZz5KuGD+8hXFtUNnetHd+Aj3qityKmr9EYO3LM2qCWQB4S/Lo
         6iLUSR6HiVGA4X3vIVx7m6bCf31kxOwCAWaJO2KmtZgzWjmRZ2Iy+rqczQxOP5IeHTZI
         Qn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4AKCO1L3I7Kzvtw1cuapjUC8hVjO6rs40Z+Ml+u4wu8=;
        b=Qk6bMEvPvN3FsvCzk5bHCw9oncfIfNZ0iRnw/W/sKx0BVi1NseEoMWMW/+P/yLhSWc
         qiDUP18zHWro8VUVkUEPT38rXn06d6sK4VwCbVAwhpzQ+XIZyHHmNM3qD8BjpzndWAdM
         fGhQEY1aQttZ9OKRFT82S0emhFXMJ06hI9wvdpdBlrHjB3PelW8Q8PXb82fxnjpa5D+L
         82jgxvrWV1ADaQiMtCFsEuNJOyMsmL3S58bnNByMiSpxMB1JLCpMNWBUEpUt547qmI5F
         A3SuQEqd7t4Bw0t3c7usN2n54OG34MGMtCrR0L0XwAOKuuqGMeq/WLZJQdos9nCAwaSp
         C/uA==
X-Gm-Message-State: AOAM530VQjYelIWOu4UPVhXjFajQM1T3ZtLAzo+4CkDPI4XsO6i9bRvH
        QR8/p+VGWqdTysC0uu1oMEOZsR4Fbp8A6g==
X-Google-Smtp-Source: ABdhPJwtEZlvIE3eHTppU7Z3ZxuoRW1DmmDST6raRY3yveIL1Js3hsS94y5MhdejGrPd89UHvTL3NQ==
X-Received: by 2002:a17:90a:7f81:: with SMTP id m1mr287810pjl.23.1621262917185;
        Mon, 17 May 2021 07:48:37 -0700 (PDT)
Received: from localhost ([2402:800:63b8:92ac:abeb:6648:927:6523])
        by smtp.gmail.com with ESMTPSA id z25sm11453071pgu.89.2021.05.17.07.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 07:48:36 -0700 (PDT)
Date:   Mon, 17 May 2021 21:48:34 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Rebase options via git pull
Message-ID: <YKKCQmaEHMR5WATP@danh.dev>
References: <87r1iakbyn.fsf@osv.gnss.ru>
 <CAMMLpeQ8_isyDtP34p+_tEK3JAasfro7dJbVrTVPZ7C4q0kT6w@mail.gmail.com>
 <YJ3LJ++lsAuSkCUJ@danh.dev>
 <875yzlu8gt.fsf@osv.gnss.ru>
 <87zgwtr7i4.fsf@evledraar.gmail.com>
 <87k0nxv8tt.fsf@osv.gnss.ru>
 <YKJkmws18M6oJZXy@danh.dev>
 <87a6otv7lm.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a6otv7lm.fsf@osv.gnss.ru>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-05-17 15:59:49+0300, Sergey Organov <sorganov@gmail.com> wrote:
> Đoàn Trần Công Danh <congdanhqx@gmail.com> writes:
> 
>> On 2021-05-17 15:33:18+0300, Sergey Organov <sorganov@gmail.com> wrote:
>>> >> Probably add generic cmd.<cmd>.opts config support, so that I can say:
>>> >>
>>> >>   git -c cmd.rebase.opts="--no-fork-point --empty=keep" pull --rebase
>>> >>
>>> >> Thoughts?
>>> >
>>> > It's been discussed before (but I did not dig up the discussions,
>>> > sorry). It's been considered a bad idea, because our commands are a
>>> > mixture of plumbing/porcelain commands and switches, so we want to be
>>> > able to reliably invoke say ls-tree with some switches internally,
>>> > without config tripping us up.
>>> >
>>> > Of course we could make this sort of thing work by selectively ignoring
>>> > the config, but such a thing would be equal in complexity to the effort
>>> > of assering that it's safe to introduce new rebase.* config in the
>>> > codebase for every switch it has now, but with a less friendly interface
>>> > both for git itself and users.
>>> 
>>> I don't see much complexity here. We'd then just need to effectively
>>> invoke ls-tree internally like this:
>>> 
>>>    git -c 'cmd.ls-tree.opts=' ls-tree
>>> 
>>> Not a big deal.
>>
>> It's a big deal.
>>
>> Scripts was written with plumbing command and expect stable output.
>> If such change can be accepted, a lot of scripts will begin to fail.
> 
> Makes sense. Then simply don't do it for plumbing?

Then, we will get back to the state Ævar pointed out.

Quoted again:

>>> > Of course we could make this sort of thing work by selectively ignoring
>>> > the config, but such a thing would be equal in complexity to the effort
>>> > of assering that it's safe to introduce new rebase.* config in the
>>> > codebase for every switch it has now, but with a less friendly interface
>>> > both for git itself and users.

Anyway, it's not only plumbing command, it's also semi-plumbing
commands (the ones accept --porcelain option) like:

	git status --porcelain[=<version>]

-- 
Danh
