Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA72C4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 12:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B583C613B4
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 12:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhFBMPV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 08:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhFBMPK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 08:15:10 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F020C061763
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 05:13:21 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id m3so2258491lji.12
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 05:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3kSP8xMjsoRnaxZHBWbger1HDPVk0bKvSS+NPahJNEQ=;
        b=Rt9VIlN7JKJQgj06J2eRYw4OpjeqzRb50pAJOOOVM1RYH/it70t7SvwCTUeqcLvGzS
         DWc4TBqEObXcPVMCzQhzJoBQf7RPPzlxtJx35Wok3/6rziYj66STpF2RPd478UYLf/fe
         u4fCyyMtL/RVryxY1lffcG6XRwg2bntPjFW5IuApE/ffrFfoEEOkLLMjVbIazAWn5BNT
         6lkrkMg6s/rekve51gyfQakUwMBMmHZj44ATvOTbVEnW9lb1yNKwU8Ey5cpdtjFGcDyq
         kic1mNFdZqGY+IwzN8WHvdVrbR7JO9L9hl6fWEjxFB2kJv5LgbkGnTztNRJDFtulDGBC
         N+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=3kSP8xMjsoRnaxZHBWbger1HDPVk0bKvSS+NPahJNEQ=;
        b=fTK1OQ29no/pE44Mqal0h8pDy+EO8v0XyqzkKWGNkDbGbZ2VYYxgF7Ww6esULokV4q
         koNe1avo74jW2c0dx5w0leqS98b3VwDpgxG2BnQ71Sf+wf5QMXI5AY0rTnqdGUi6KDfU
         ShfaRbFYWddL2VoBNsbzDqUcNV21QL3AOMTahMgdTXk8sG1keARLv91BQO0eskSrYKgH
         7Ns6B2ee2pvZT+aFUzio/BOmhJWUaJ8QhK58D7njH5zCPdw0DTg73n9NDy6FhDodvPJd
         zM/Y1LJ98cdMGgJi/IMb0GI2/Qy6HpRKPulWLiLuWnCFtWE3UQ6mHnfeUmL1LW9N+/He
         oqzw==
X-Gm-Message-State: AOAM530QK9+Od+0j2C/M1/INpJbtV/yDqLgKf2xqRZWWmzZ5mILuHABR
        Xw/ayd8OdlBDS0sHJ9IOVEAZeX1EwwU=
X-Google-Smtp-Source: ABdhPJzKAwuGZ2Hlfr9yEmeD9zz7bTO3CEncbPIl/33RGrl1UqXcOyQ5RVXpiDu7GOOWv7exan9IhA==
X-Received: by 2002:a2e:7214:: with SMTP id n20mr13561199ljc.356.1622635999111;
        Wed, 02 Jun 2021 05:13:19 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id t13sm2317342lji.19.2021.06.02.05.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 05:13:18 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: The git spring cleanup challenge
References: <60b5d281552d6_e359f20828@natae.notmuch>
        <CAJDDKr7AG_qs2ZmNCuS9zS0oqCT9cWU=CSCfxALEkGuLHBH=OQ@mail.gmail.com>
        <xmqqzgw9qky5.fsf@gitster.g> <60b6bef41791a_404420881@natae.notmuch>
Date:   Wed, 02 Jun 2021 15:13:17 +0300
In-Reply-To: <60b6bef41791a_404420881@natae.notmuch> (Felipe Contreras's
        message of "Tue, 01 Jun 2021 18:12:52 -0500")
Message-ID: <87im2wtqg2.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> David Aguilar <davvid@gmail.com> writes:
>> 
>> > +1 for merge.conflictstyle = diff3, rerere.enabled = true, and
>> > log.decorate = short from me. I noticed others already mentioned
>> > these.
>> 
>> As the inventor of rerere, I agree on rerere.enabled.  It was made
>> opt-in only because I thought it was somewhat risky when the feature
>> was introduced, but it has been stable and useful, and it is long
>> overdue to be enabled by default.
>
> Agreed.
>
> I personally would like some interface to see what's going on behind the
> scenes because sometimes I've made a wrong resolution that gets carried
> around and I don't know of a way to clear them (other than manually
> hunting down the cached files).

I'm second here. Wanted to get rid of some recorded resolutions, but
didn't find a suitable way to.

Thanks,
-- Sergey Organov.
