Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB25C77B61
	for <git@archiver.kernel.org>; Mon,  1 May 2023 15:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjEAPGo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 11:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbjEAPGl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 11:06:41 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672C51715
        for <git@vger.kernel.org>; Mon,  1 May 2023 08:06:40 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63b733fd00bso1877541b3a.0
        for <git@vger.kernel.org>; Mon, 01 May 2023 08:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682953600; x=1685545600;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPaebQGSSDhVS7evasyZ9tKosK41o3iERUf+LPHCEM8=;
        b=M6brLaMuccYzGNji84iOb4u4R3RHOr2upaj2NXDmFV5+aNviep0t/CikrEQ1wVBJkS
         Eanigc1Ou2BgJwOpkyljF/v7aQNzyDoz2W6oTzIJow4GRgEirzEDcZn9zRgvcwdlUrxr
         iqfRffNUcig83Ib9h8bj7ymGEyDHVH655DuBB9sE9M7T5TNFFg4WhpckcgHagPzMBDFa
         WGMopimeeFQnCq9ohKMdWtl25yHziWk1YFb7gpGCBrSjAIVj+N8AB9mliboEMvx7t+Du
         d5Lx3JfLZJPzvD4fx5+1w43AzsQMmSFiWLezDn1u3m39ibKwKoX9AimKGI1jnLhKxKVg
         TzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682953600; x=1685545600;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cPaebQGSSDhVS7evasyZ9tKosK41o3iERUf+LPHCEM8=;
        b=hhSNUu8MBpQ7a6SlmUJuVxY+JImGcWhwfCwCNSNgnvme91ViztCCNeLK2xd+eT35/C
         Jxv71Tyjt9eo5cJHgndnZjKc3lIEg8djlx9/KBcwSwdqPGkIY5GRvXzMadumsJhroVp1
         xBY3rNIGBh4Fqs/3c+6oGI+zS4KPmYV2gi/VuUGUJWlsezoSv8szchj/vov2kqrN+3Hw
         XYb+kMelZKXyP9sFNtLryC55sTkkYeIvs1zVFS45sBnDlzqRFlOtF0Bf1X74wbrwbrVh
         5KnLXCJVuf45Tl5SgC0SIlCjcGNtWAlN/5b8kWHejHW0i8Gd3ROnRXfb/jMfpj3zz6AM
         kcIw==
X-Gm-Message-State: AC+VfDxv74KIqGp+oKHmapU7QH2+PkNpylb/KxaumANfW7biy9CvHLol
        A+sMCWS8ereI5E7x0uhKtuXftTF5/fo=
X-Google-Smtp-Source: ACHHUZ5qUQgeH+Xb3C8jQ8N+lpPN4pVNArqjI574Fy8DA0JtuAmlCKWHSPmD4o/p6rWsmopeYlr6hg==
X-Received: by 2002:a05:6a20:3944:b0:f2:4d44:3553 with SMTP id r4-20020a056a20394400b000f24d443553mr18122749pzg.54.1682953599566;
        Mon, 01 May 2023 08:06:39 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id z2-20020a63d002000000b0050bcf117643sm17218959pgf.17.2023.05.01.08.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 08:06:38 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v2 1/2] cocci: add headings to and reword README
References: <pull.1495.git.git.1681329955.gitgitgadget@gmail.com>
        <pull.1495.v2.git.git.1682634143.gitgitgadget@gmail.com>
        <4a8b8a2a6745e791e35296e34f530b5f40f51c27.1682634143.git.gitgitgadget@gmail.com>
        <230501.86h6swjp3r.gmgdl@evledraar.gmail.com>
Date:   Mon, 01 May 2023 08:06:38 -0700
In-Reply-To: <230501.86h6swjp3r.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 01 May 2023 12:53:19 +0200")
Message-ID: <xmqqjzxs851d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Thu, Apr 27 2023, Glen Choo via GitGitGadget wrote:
>
> Re subject: I don't per-se mind the "add headings" formatting change,
> but doesn't it have headings already? I.e.:
>
>> -Git-specific tips & things to know about how we run "spatch":
>> +== Git-specific tips & things to know about how we run "spatch":
>>  
>>   * The "make coccicheck" will piggy-back on
>>     "COMPUTE_HEADER_DEPENDENCIES". If you've built a given object file

I think "add headings" mostly refers to what the first hunk, that
is, the hunk before that one, did.  Giving the entire document the
title (while removing references to "examples").  As a side effect,
the existing two sections ("-Git-specific tips..." we see above is
the second one among them) are moved down in the section hierarchy;
in other words, I do not think the highlighted part of the patch in
your message is the primary change intended.
