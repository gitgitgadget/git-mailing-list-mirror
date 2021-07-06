Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4134C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 14:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D15F61376
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 14:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbhGFOme (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 10:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbhGFOmd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 10:42:33 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE32C08EC37
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 07:39:53 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id l24so28314582edr.11
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 07:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=OjmoS72f1J92VO9UnS3acXT3d7onYJidhm8VDyNKFs4=;
        b=JE6p6bQOW3rUkf6Z0Q2Jcta+Sc/31lOEv27eRiB6uIjVPZYPWFIBVUmdfWHCFBPbcU
         1e2JBvJdywYzMxqgo9XWMFRe2IBs/jcc6TSjlepcrGSke3sMQHUfxP/s20fH/A+P2rrn
         /D825n+oCTD9cJzhL7uDxKyRE6zrMfGip7AXIe3/CBDTcp5jVdJoUTNkrtS4FSmZW7HS
         +AffNQijw70WM5NUDqajkXb36g3XAoNIkQ4Hi1ozogTICM4oqGulTCdq43y84+nMSzhn
         yzpem3rV3pbIKNZlXhXCHuQ09w6GZPXFrOGWBpwmYIB+N6G6KsYCC3oVxUX09h+fpEHK
         aEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=OjmoS72f1J92VO9UnS3acXT3d7onYJidhm8VDyNKFs4=;
        b=N/AIl9Nn6qBsTt359GV8Ppxx7DcthFtb0f85L5HusRoUqFlofHzrnFamRTdsnuWZNQ
         LWBcxHajjmqfrRrNszogJ5NrwDNebKnTqHwsM1yM2QjLoK4djjEB1EqYKoe9Gw6gRci9
         Wn30b+WoZ9J3CD5EG7s6ntZhDY4mVzvWLW7h7BUEA0VurzRtprEVbP8XYRQ5ON+3Zh9U
         DkW//J0NiL3ZdJQIyAXNwdhoq93URqPLQ4wCTYFIJZl8iRRhw2H6RP7EyBtit0ztPlcH
         UcljDEae86h2/JppvDeWQH832otY37RL+EQaJrc6k//9eKccgLr0QTd/w3OLLfnXF6ku
         VtLg==
X-Gm-Message-State: AOAM530NA78/nbf4qv1JXwC9hBFnaXcyd82Ch842CAIaGooM+x4ujXPa
        1VTYUSufQ40A6v3+Yy0vSyQ=
X-Google-Smtp-Source: ABdhPJxTbJ6Sfu3rulREY1b5vCiJB3Vxo0s0SJehwEvbfoQsLMjrNA9QOSuVprGztRxEW+NK2Cd6RA==
X-Received: by 2002:a05:6402:90b:: with SMTP id g11mr23767032edz.336.1625582392452;
        Tue, 06 Jul 2021 07:39:52 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id d9sm1132614eje.34.2021.07.06.07.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 07:39:51 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Subject: Re: Applying a patch with a diff header in its commit message
Date:   Tue, 06 Jul 2021 16:37:49 +0200
References: <20210628183004.flxirucfv2celll3@yadavpratyush.com>
 <60da5ed21ec8c_1f78f2082a@natae.notmuch>
 <20210706081738.5th24lypiicnbckv@yadavpratyush.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210706081738.5th24lypiicnbckv@yadavpratyush.com>
Message-ID: <87pmvv5ww8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 06 2021, Pratyush Yadav wrote:

> On 28/06/21 06:44PM, Felipe Contreras wrote:
>> Pratyush Yadav wrote:
>> > I have a patch at $DAYJOB that contains a diff header ("diff --git 
>> > a/...") in its commit message, and unfortunately it is not indented. So 
>> > naturally, git-am trips up and thinks it is the start of the main diff 
>> > and tries to apply the diff starting there. It does not apply and the 
>> > patch is rejected as being corrupt.
>> > 
>> > I know one option for me is to manually edit the patch and indent the 
>> > diff header. But I would like to avoid that if possible. Is there any 
>> > way to apply that patch as-is? Is it possible to tell git-am where to 
>> > start looking for the diff?
>> 
>> git apply?
>
> Sure, that is an option. But then I would have to copy/paste the commit 
> message and add the author information manually. Is there any way to do 
> this automatically? What if I have 100 commits like this?
>
> This is a valid Git commit. It would be nice if the Git email tooling 
> could handle it cleanly.

I don't think there is, but it could be fixed.

I had this happen to me the other day and ended up reading the relevant
parsing code, I think if it were a bit smarter we could handle the
common case, i.e. when we find "diff --git" or whatever it is keep
looking and see if we find another one, or perhaps have a "looks like
I'm at the diffstat" heuristic where we'll prefer the "diff --git" that
follows a "---" line, if there' two of them (that's also going to be
ambiguous, but both of them are less likely to happen to the same
commit).
