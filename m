Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977A1C433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 18:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C80360295
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 18:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241178AbhIQSm7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 14:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235206AbhIQSmx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 14:42:53 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83661C061574
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 11:41:29 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id x27so36713644lfu.5
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 11:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tBC6VlMy5aAP1yzhjryneCT62+NrFkEBHjQrDytQAcE=;
        b=UhlWYxF5x3r7/iZZRV8J4BcqEka+39DEYD5ajaSsMWs4RiXXLrlOEWQ1hhpOVbTDY7
         OeEEaQFoDqm+GJ0c33FBr5C+2InM477YYdrIqWWshhgWTF3wkPyDqQ6MHv87DoaHOEaK
         5oiQQEz9bm2gyLr806jBMXDZ+t8IhxE7wqe9sykNxHF2nz2x6hrFr4WxI/Zlzc1VUEtm
         DJOlheJ9D8cGEVbJXMeXo4pKw5sL20MDm9fBCQhbmjOyV9iC3AGvYeSvz8E7fquCqh5a
         cWACO4Vw92ElvbgRLBZCsOO8yy1DWq2iCq4t301TF14OUfj7i0T2O75pZmmEib7B2a7e
         PX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=tBC6VlMy5aAP1yzhjryneCT62+NrFkEBHjQrDytQAcE=;
        b=EXOWCccsqMls/8PA/pzae0F156nyAFvx9hCkDte/8DPz5h89Os0513JkxuCNy2Z6MT
         IjWjFg12ljfNyISIrdUS5bCeolaTPurPmj0ZbIIVSQ8EHQ1CsSfdoHCrW9vh0lwJr36m
         MV39RojVKYmkecAAiD4+9hof4seXxZPnedKgrxlZeD7M8spamw+WTkxkRjIoQuP8mdr1
         1Konv7/wnqIo3pwinuFHl60aSXThuaqXYHcmJW0y1IrbEY2pVPA7k7eIpoDpkma292ty
         xpRPIrRcA2KEcb8CYS4OT49JJacCyNiGAZmld73dZwGyT7G+wPqygXt7EPXo25XTxw7d
         ZXmg==
X-Gm-Message-State: AOAM533U59KOHJrcEi5C6u5JR0RZ4oxxFBNxN2FZb8EsaYS1Act48fBF
        mUI5VMt0I+fen6wlszRg32ePMGB74r0=
X-Google-Smtp-Source: ABdhPJwY1fAHWX3sHgpUP8Y7Mj/gPkg70wce9KYYzDWIre4EmeLuMZINP7imke90mMldpP/qxklQRA==
X-Received: by 2002:a05:6512:10d0:: with SMTP id k16mr9321813lfg.530.1631904087462;
        Fri, 17 Sep 2021 11:41:27 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id h7sm584950lfv.95.2021.09.17.11.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 11:41:27 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Paul Mackerras <paulus@ozlabs.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: diff-index --cc no longer permitted, gitk is now broken (slightly)
References: <e6bd4cf7-ec8b-5d22-70f6-07089794df0c@kdbg.org>
        <87h7f4tf0b.fsf@osv.gnss.ru> <xmqqy288b64q.fsf@gitster.g>
        <87pmtjkwsj.fsf@osv.gnss.ru> <87sfy497ed.fsf@osv.gnss.ru>
        <xmqqy27wrzmj.fsf@gitster.g> <874kaki1nb.fsf@osv.gnss.ru>
        <xmqqzgscqgmv.fsf@gitster.g> <87bl4rk7bh.fsf@osv.gnss.ru>
        <xmqqbl4ri2mq.fsf@gitster.g>
Date:   Fri, 17 Sep 2021 21:41:26 +0300
In-Reply-To: <xmqqbl4ri2mq.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        17 Sep 2021 09:32:45 -0700")
Message-ID: <878rzv59k9.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Ah, now I see, but it's exactly lack of documentation (and tests) that I
>> was referring to as the "problem of the historical status quo" on the
>> Git side, so I was somewhat confused by your original response.
>
> Well, you said the fixup "restores" the status quo, but in fact,
> with or without the fixup, before or after it, the lack of
> documentation was there.

No, what problematic patch did, it changed behavior of diff-index
exactly in accordance with its *current* documentation that doesn't
mention --cc as accepted command-line option for diff-index. So, with
that patch applied, there were no this problem with documentation
anymore. Implementation now actually matched the docs.

Unfortunately, that brought worse problem: it unexpectedly broke gitk,
that, as it appeared, depends on undocumented diff-index behavior.

So, I re-enabled --cc in diff-index, lesser of two evils, that brought
back the problem of lack of documentation and test cases for "diff-index
--cc". This way, the status quo has been restored indeed.

> So I thought you were talking about something else.
>
>>> I wanted to give you some credit for having worked on "--diff-merges",
>>> an effort to generalize things in a related area.
>>
>> Thanks for that! More to follow )
>
> I somehow expect there was need for no further work in this area,
> but there are also many other areas in Git where your talent is
> applicable and appreciated, I am sure ;-)

I'm afraid we still didn't reach one of the ultimate goals of all this:
letting -m be useful again, specifically, as suitable *user* option.

Also, current --diff-merges options are incapable of providing current
-m behavior, as has been noticed by Jonathan Nieder in another thread on
reverting "-m implies -p" commit:

  "When I try it locally, -m shows no diff by default,
   whereas --diff-merges=separate shows a diff for merges."

and I'm going to fix this by adding yet another feature for
--diff-merges. This is to be pure addition, thus causing no backward
compatibility problems.

Thanks,
-- Sergey Organov
