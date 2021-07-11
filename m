Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DBDC07E96
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 09:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4057661220
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 09:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhGKJkE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 05:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhGKJkE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 05:40:04 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5264BC0613DD
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 02:37:17 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id f13so34798820lfh.6
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 02:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oRX6tNSVTrLk0MJfqhL8651s6dhMJ7FfwxANMgIE/CY=;
        b=lP7DC4B6cuD4FE7lAK5Ntpo1zTz+XzzBqmFepWqGsqSf0ELEB1CwrWfcL3F0CkJyHC
         7fjdAmsywiqgh0KVseo+DjAoEzVvSYZhgBtzUnGJlnXeQVpWVTryPuEyvirveZDpCrG1
         FPX1vsgnGdlMmQ5uP9onFJeFLflgg2IYk2+A1ecKu3LOcMy8NhCI7y+FFVs1O0qFDPMn
         0/pV3Zb9tys+reci+zbcjYQMioT0TizvoNO4PWor/5wLccPMT9zi8uUiZV0N+VgaEDMT
         XhqXCLV5lzLNfe4osl0PGSrjRt9lB2vMiE8BpOuk5lezhmK3+LMqoMPFPyik9poJ+J2E
         fSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=oRX6tNSVTrLk0MJfqhL8651s6dhMJ7FfwxANMgIE/CY=;
        b=Mnayc1P4nloCOAqYIO+WG6p29opRSYs+j17uR9MOTDOAFK4fXAKhrMpJ00y32XSOoQ
         eZHdIT+VwQD7knuE2NabFal3VpzWpIPBXXQ36OTs7PdtaJtESR9+VROSvlvbVoL5Fln4
         o0blJtkpNytpHddfQyNFWdUkt9G+NQvCX/HefIVCQpRrp6iT5s8kPZtXqnqOcd0D2vwU
         IrQ266WL9heXzct1hjjKM8Z1oYsybX++lcWV2xC273RGnhrp7HuU+9WsFSmtO14zUQ0b
         zXg4vIVlKdIHHDcMdaZFifIRJ4v8NleaQt50eY95Yrxbt4moLT0bUM5e673u6ae1WCkS
         gT6g==
X-Gm-Message-State: AOAM532/iLTPDxf3/9lJMsCbxvU37MU5iczbLaichkNyLpC0TwyYk4fE
        HedXb11ygrgWBzOmx+rqS4ZXMELCrlk=
X-Google-Smtp-Source: ABdhPJyV5ENm2ElQzRJfbGKRKqIualEqeUG/JDDCOekUpwxCXcBeFUKy8QW6gx8D/FNfXrpCGm+brg==
X-Received: by 2002:a05:6512:3745:: with SMTP id a5mr35472715lfs.478.1625996235338;
        Sun, 11 Jul 2021 02:37:15 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id bq36sm907864lfb.96.2021.07.11.02.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 02:37:14 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Martin <git@mfriebe.de>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: PATCH: improve git switch documentation
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
        <877di13hhe.fsf@osv.gnss.ru>
        <c740a4f0-011f-762e-4f49-f85d1b3abc99@mfriebe.de>
        <60e67389a4adc_306ac1208fd@natae.notmuch>
        <4057b3ac-a77c-0d5f-d3f4-ad781754aae4@mfriebe.de>
        <60e736e72da68_30939020850@natae.notmuch>
        <155308af-42ad-b044-fb37-676251a9b7e1@mfriebe.de>
        <60e762243aab1_30a7b02089@natae.notmuch>
        <2b85a7eb-d0be-65e7-ecbb-1750abf53e53@mfriebe.de>
        <60e79c31aaa72_30b8a4208c1@natae.notmuch>
        <65362688-b65b-661c-20c1-94d7dc2118c7@mfriebe.de>
        <60e874e1c6845_215320861@natae.notmuch>
        <dbfa96f0-558e-ccaf-6e34-6d95c43848b5@mfriebe.de>
        <60e88a4b8592f_16bcb2082b@natae.notmuch>
        <ad58bd54-a9dd-59a9-4fce-f90be469cd60@mfriebe.de>
        <60e9f8d462bd9_7ef20898@natae.notmuch>
        <6f43b36b-abe1-41f2-6138-e820c974b1bd@mfriebe.de>
        <60ea07e3495e8_7ef2081d@natae.notmuch>
        <30e4c874-6b87-b03d-fa33-fde5b7e50b2a@mfriebe.de>
        <878s2dgu4d.fsf@osv.gnss.ru>
        <0d7190ae-e64e-d1fa-2367-29f302c2ff7e@mfriebe.de>
Date:   Sun, 11 Jul 2021 12:37:14 +0300
In-Reply-To: <0d7190ae-e64e-d1fa-2367-29f302c2ff7e@mfriebe.de> (Martin's
        message of "Sun, 11 Jul 2021 11:27:03 +0200")
Message-ID: <87sg0lfayd.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin <git@mfriebe.de> writes:

> On 11/07/2021 09:57, Sergey Organov wrote:
>> Martin <git@mfriebe.de> writes:
>> 
>> [...]
>> 
>>> Currently only the branch is mentioned.
>>> Currently nothing does explicitly say that *commits* can be affected.
>> Commits cannot be immediately affected. One of the most essential
>> features of Git is that commits could only be affected (deleted) by
>> garbage collection. That's what makes Git so nicely safe in operation.
>> It'd be unfortunate to have statements in the manual pages that
>> contradict this.
>> 
>
> Tell that a new user, who never heard of "dangling commits" or the reflog.
>
> For ages, I wondered what git fsck meant by "dangling commits" and why
> my repro always had "that problem".
> And what I might do with that hash it gave me.
>
> For a new user, a commit that is not in any branch listed by
> "git branch --all" or "git stash"
> is effectively not existent.
>
> For a new user, it is also "no help" (and the doc should help) to
> avoid saying it, and instead refer to something else from which it
> could be
> concluded.
> "reset the branch" talks about the branch, and not the commit.
> A new user, even if he read about it before, may very well not make
> the conclusion.
> So "reset the branch" does nothing for a new user. And an expert
> already knows it. So for whom should that be there?
>
> We can use the term unreachable. But it is no better than say "drop"
>
> Technically they are not "unreachable". If I have the hash, I (as
> expert) can reach them.
> If I do not, I can get it from "fsck". (And spend a good amount of
> time, going through a few dozen hashes. (That is, if the reflog was
> disabled)
>
> "Drop" does not mean "deleted". More like "dropped from view", "given up"
> But a new user reading "dropped" will take it as a hint to be careful.
>
> We can add "dropped commit" to the glossary. Then there is no
> ambiguity. (I don't think its needed, but...)
>
> We can say "may no longer have a reference" instead of "dropped"
> But it is long, and again obscure (to a new user).

As I just stated in anther answer, which see, I see what you mean. I'm
still against "dropped" though.

I did suggest a wording in that post:

"Allows to reuse <branch-name>. Commits from the former branch may
become unreferenced."

Another one could be:

"Allows to reuse <branch-name>. Commits from the former branch could be
lost."

Thanks,
-- 
Sergey Organov
