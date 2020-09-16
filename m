Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B4AC43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 05:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3603821D1B
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 05:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCuMsFYv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgIPFbw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 01:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgIPFbt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 01:31:49 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47ECC061788
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 22:31:48 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id r19so2569877pls.1
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 22:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HDc3C0LWXgxxteFZRDyZaeqBNbRTnJLyhVWmzmo90Vk=;
        b=DCuMsFYvpn+SDXuieGxReTwLbsJ9xiX0DU9aDS941WwdAoHmcOepEqXLb70tV2yGwR
         mc0e+WBCJ/HhDTymHeHy7fDvngEHhq/RDfUD7YfUEnJE/gXg/F4NufoFhPMgs+US372z
         cAqF8tVEEaE+oGHwXprqmmLTJIKyfH6ldxz5OPtNegzVPqny+xDM0hjd2Y/RkKIzknhR
         IRi5L6f25ChSwpG1JdBoFdFc+UCd8R31JsdzH7xTQAfrOuqwJKCQ+mIhQUSyKEHeE0Wo
         J9NW5WfF7Ixo2NnjzrOB0BgsyEb7OVrswJNBcb1tUyLu8FqpcamAi/xiuSip6NL/5K7x
         UmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HDc3C0LWXgxxteFZRDyZaeqBNbRTnJLyhVWmzmo90Vk=;
        b=rensLjYNSAiEJJ/FVOHL9+EHPiVZdPDJv2p3sdsjsuTkWinWssxajnTUX94SKpVWpj
         uRmKA1MPWfX595bAXRDb4f8fbij7WbgpWMPSxgmjJXUHC/y9Cz2tgqseh751fQlSEzq4
         jVwN3poJHUTyhiZVLgmLvLkqTVV2aOClRQJLwt/r14EFdJ9rh4LZLuZgwHZ79N5zcqMr
         Tui9CSZIxiiJspL7kTXJkKIYjwboi8gzWUswcEabcDlLXZZlseGEectwaWY1hvq6z+LP
         cS7Iet/Uc6XIoatznQ4Jp4GAjcyfmz9Mt8fl8CNN71MiOFEua7B2AH+IYpieyGXrm9yn
         JtQg==
X-Gm-Message-State: AOAM530I3mlbPMvAvbOrlfzgHIF74tDA7nkaXUspBVrO+OdyJsyysYOM
        1nmgqTjcQTEPtoknLS8K0Ro=
X-Google-Smtp-Source: ABdhPJyHugjxAzJr77f6vQ6on3QOHNJU5o5dCXvzP1qcUD76neifYbHi+s9jAR/GQK8OhU0BQ5tcyA==
X-Received: by 2002:a17:90a:db0f:: with SMTP id g15mr2486815pjv.145.1600234308222;
        Tue, 15 Sep 2020 22:31:48 -0700 (PDT)
Received: from mail.clickyotomy.dev ([2401:4900:33b5:8018:b140:be83:aa16:5dde])
        by smtp.gmail.com with ESMTPSA id v21sm1185163pjn.4.2020.09.15.22.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 22:31:47 -0700 (PDT)
Date:   Wed, 16 Sep 2020 11:01:41 +0530
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] push: make `--force-with-lease[=<ref>]` safer
Message-ID: <20200916053141.GA29901@mail.clickyotomy.dev>
References: <20200904185147.77439-1-shrinidhi.kaushik@gmail.com>
 <nycvar.QRO.7.76.6.2009072119350.56@tvgsbejvaqbjf.bet>
 <xmqqr1rcxdsu.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2009090542430.54@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.2009101220400.56@tvgsbejvaqbjf.bet>
 <20200910144456.GA25125@mail.clickyotomy.dev>
 <nycvar.QRO.7.76.6.2009120013070.56@tvgsbejvaqbjf.bet>
 <xmqqk0wwjf4p.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk0wwjf4p.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 09/14/2020 13:08, Junio C Hamano wrote:
>>> [...]
>>>
>>> Good catch. Would adding in_merge_bases() along with checking if OIDs
>>> are equal for each reflog entry in oid_in_reflog_ent() address the
>>> problem? That way, we would check if remote ref is reachable from
>>> one of the entries?
> 
> That sounds very expensive.  

Yes, you're right about that.
 
> If we switched to check the reflog of HEAD (and not any particular
> local branch's reflog), then "has this ever been checked out", tests
> would suffice, no?  We detach at the tip of the remote-tracking
> branch and then reapply our work one by one in such a case, so we
> should have the record of having their tip in the working tree at
> some point (i.e. at the beginning of the "rebase" phase of the "pull
> --rebase" operation).
 
Interesting, I think that might work! Since HEAD moves around and
records all the movements, if the remote was ever checked out there
should be an entry in the reflog. I guess we could stick to "oideq()"
for each entry if we're going this way. However, I think we should
keep that one "in_merge_bases()" call at the beginning to check if
we can can skip checking the reflog if the remote ref is an ancestor
of the local ref.

>>>> On 09/10/2020 12:22, Johannes Schindelin wrote:
>>>>
>>>> BTW I think the patch needs to cover a bit more, still: after I run `git
>>>> pull --rebase`, the local branch will never have been at the same revision
>>>> as the fetched one: `git rebase` moves to an unnamed branch before
>>>> replaying the patches. So I think we need to see whether the remote tip
>>>> was _reachable_ from (not necessarily identical to) any of the reflog's
>>>> revision

Also, there would be an entry for what Johannes describes above -- when
a `git pull --rebase` is run. Will change to this in the next series.

Thanks.
-- 
Srinidhi Kaushik
