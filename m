Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4448EC433DB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 23:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7E0664E02
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 23:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbhA2XxF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 18:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbhA2XxB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 18:53:01 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F54C06174A
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 15:52:19 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id kx7so6600161pjb.2
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 15:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+0h+66sz6LoUa8mO8IFF4cBeT/qYeZaYCBT+Cbz5egM=;
        b=Cx4AK2yjpQZqXh8YIL4PpIgJ+lq05pSjrsmtxWu9BzQmaS7c/KcVvq4H0gNpKz3b1N
         cFpx4GWXYzGydDew0hnuyRxZ0Y+l5lseoaRAomjxDNPY7hZc493dBPlgf8Dmj33G7SY9
         DiQEXrvWvZaKvy23IFhtEA6Y8ewS4Z2E2WVMsWlr+S8XnTtjmSWAGhOJOcIr/krVMph7
         doPPjKroNXOtwjoJWaNOzNM9/DpkcPB1+HeUt66OlkdCWvKqT3ycGD0FoeNOwv+t0We8
         Xj26ITKz7OdeA2hsQx4JGeO9idtQLbf9YoUtXgDr8tf9fW68EsooKaOZTqlizlINpOMW
         Ecag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+0h+66sz6LoUa8mO8IFF4cBeT/qYeZaYCBT+Cbz5egM=;
        b=mg3xGwgLfS2RqV7LwnORpwELnAjqUa64yMHa/1iG11iPZaYE68X5QT/sjY2t/OIcHj
         KDX/OLQ+7xh74trjct/wj/q5HA8XdRFOcterCZgHJ9J1+OCLoCXn4wiXoRTwqMUqsOEo
         mdKSlGOQzmrmBgscgnw1QiqxfjBm7kqw+IJePTIxCEesRSdhl30zpsYHSgUWH9S8oPke
         il6Ml7Xea3n5WEuUL3w7cAYw1XGyaiQgzTSPZbM8uhJ/5tik5ZRtpupVFC56xaTRjySJ
         pwKRcEcPZ0OSRl804MxUbZNgu8ERUE7xjAb595QUUzP5NuCu/a6b8BeIe6gCrv8e2EhZ
         DpQw==
X-Gm-Message-State: AOAM530qQOBIupq5T4XraDQVU2G1b/zDSiDzRaQXp6XBL0Puz2xhVBG7
        UlB60Z0Qo6kiEXJrvWBGk3+JSA==
X-Google-Smtp-Source: ABdhPJwQamBCsLi/e6kikVvNC2U4frHsm4sZiXIBzvBIpyfMwOmn4CD+ubu0z+JbOrbaqY6jYHbJ5g==
X-Received: by 2002:a17:90a:7e84:: with SMTP id j4mr6515089pjl.167.1611964338777;
        Fri, 29 Jan 2021 15:52:18 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:3547:8f35:27a2:2e7e])
        by smtp.gmail.com with ESMTPSA id k6sm11047454pgk.36.2021.01.29.15.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 15:52:17 -0800 (PST)
Date:   Fri, 29 Jan 2021 15:52:12 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 01/17] doc: propose hooks managed by the config
Message-ID: <YBSfrAfNCvk5LJb1@google.com>
References: <20201222000220.1491091-1-emilyshaffer@google.com>
 <20201222000220.1491091-2-emilyshaffer@google.com>
 <87mtwz7jew.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mtwz7jew.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 23, 2021 at 04:38:31PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Tue, Dec 22 2020, Emily Shaffer wrote:
> 
> >     Since v4, addressed comments from Jonathan Tan about wording. However, I have
> >     not addressed AEvar's comments or done a full re-review of this document.
> >     I wanted to get the rest of the series out for initial review first.
> 
> As you note here and in a couple of other patch notes a lot of the
> current state was based on my v4 commentary. I see we have parallel hook
> execution by default now, woohoo!
> 
> I've been keeping an eye on this series, but have been kicking the can
> down the road on reviewing it.
> 
> Skimming it now I think the state of it looks mostly good now when
> viewing the end result, I think it's mainly got one big problem, but the
> good news is that it's relatively easy to solve :)
> 
> Which is that I think it's really hard to follow along with it because
> 01/17 starts with a big design doc that's partially outdated, and
> partially saying things that aren't in or should be in either a
> user-facing doc or commit message.

Sure.

> 
> And then individual patches (e.g. 12/17) either don't have tests
> associated with them to test the feature they add, don't update/add
> docs, or the docs are at the very beginning.

Thanks, sure.

> 
> I think we should aim to mostly or entirely get rid of
> Documentation/technical/config-based-hooks.txt, it was more of a "what
> about this design?" document in the beginning.

I'm not 100% sure that I agree - there are a couple other design docs in
Documentation/technical which I still refer to from time to time, e.g.
for sparse checkout. But I *do* agree that there's a lot of info there
that needs to be in end-user docs.

> 
> In a series we'd apply most or all of it should really be in end-user
> doc (and stuff like "Future work" can just be noted in commit messages
> as we go along).
> 
> So long story short, I started trying to review this, but found myself
> trying to reply to one patch and then grabbing docs from 01/17, or
> (e.g. for the parallel stuff) not having tests and starting to come up
> with them myself.

Yeah. A related issue I could imagine, although not what you mentioned
here, is needing to do the same thing between part I and part II of the
series, as I often added some functionality late in part I and then used
it first late in part II. I don't think this is worth reordering for,
but probably better notes would be handy.

> 
> So I thought I'd send this E-Mail instead as prodding to maybe convince
> you to re-roll it again to make it easier to follow along in a piecemeal
> fashion.
> 
> As noted before I'm happy to help with this series if needed. I just
> thought I'd send this first given that it's been a month since the last
> submission, perhaps you've got some more local WIP changes by now...

The biggest help for me would be review focused on nits, code style,
missed free(), etc. - I still haven't gotten that kind of review yet,
and I feel the series as it is now is pretty much "feature complete".

In fact, and I'll mention this in reply to the cover letter in a moment,
we picked this series up as-is from Junio's branch in 'gitster/git' and
have been using it at Google for a couple of weeks now - primarily with
users running their legacy hooks living in hookdir, but also with a
subset of users encouraged to try out the config functionality.

Thanks for the bump.
 - Emily

