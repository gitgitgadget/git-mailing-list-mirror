Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A21C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 08:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B08C6105A
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 08:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbhIPIHT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 04:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234767AbhIPIHS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 04:07:18 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E787C061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 01:05:58 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id q3so13558063edt.5
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 01:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=TzRn7C/TS+BwYdfq3Riy4jRTyvdv95j/GaeEvWps/TM=;
        b=N4yJfhmYJRvr79VD0SHSTJHr5nBYb5ASm5LgF9XdmcJX862f2RzkJdTQBNDtBX2yFP
         YkiqSIveww99R5q+g9qbAml9Bk/+zWR4lZqGXBrVwAsq+m7HHpdcNkPcsbbCom91IaQd
         ex3JIBOntcZCElVDgakU8XYzSTtvEc7dTMlJ04fGyQlMA23JyV0Qf/oEivsLe9PV1lLY
         cHfmnR2oAiZ5/MbFrKJ7TKzBOIM+Bo4Mq4lckajg1jopEXNS4AWKeipXRjplWBti9nkm
         xxJypG8wYO73sl5CDLT3bBfkjROet99FVgVNvISvAUtYACObiQCSRIr0h7SLXulUbs7/
         txZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=TzRn7C/TS+BwYdfq3Riy4jRTyvdv95j/GaeEvWps/TM=;
        b=a+wzn9tbdN63ee9tNrwOEZ2bmuDVS8rsCuYc4AF2Y96485Q6Pq74wnGqBVIUaKBXLg
         Cd9qr0WHWucj0dXIuw83Cj8N3IRm0sxTONb+q6FoSj8u7C2q/vL4OzMR7pQmg2Y0S0x5
         i+Z0NY++dYCNCJ4Cw/Qo++G8W8592fd5zqBI/ngL5KY+ccT3u0+/Qn6o5aZ34r9UXvrj
         2tbXqSxDpYjHd9TPOq0WoTpBjooF5zpoyXYMhudeM+iUUBumC0c2pwGZsxQselrzcEaW
         0BPXEsmjUlgVI2HGP31OEx1hp0XJPQXjPfsemelMyZyLVLhE1YIePgbCNfb7I3P6aRtI
         etDw==
X-Gm-Message-State: AOAM530ZZ8r/OJ65Sq8QuwMVLsDKGwJPkRUItNblhAfpMGgzWn1GgTb3
        8mBA5DBZBMwlUwuM+pCH+7CeqffxL8c=
X-Google-Smtp-Source: ABdhPJylgJTb8PTWLs/32be0kOi/nxRQA+gI9f3bai1lIdwMlL5ZX7Ww/mbHdgD1mARxT530WwCEnA==
X-Received: by 2002:a17:906:a59:: with SMTP id x25mr4796049ejf.33.1631779556602;
        Thu, 16 Sep 2021 01:05:56 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y5sm1060271edt.21.2021.09.16.01.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 01:05:55 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 1/7] trace2: fix memory leak of thread name
Date:   Thu, 16 Sep 2021 10:01:24 +0200
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
 <5f557caee004f22cee33e8753063f0315459d7e1.1631738177.git.gitgitgadget@gmail.com>
 <87fsu5m649.fsf@evledraar.gmail.com> <YULZbQgxuyw8iJ/R@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YULZbQgxuyw8iJ/R@nand.local>
Message-ID: <87ilz1gd24.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 16 2021, Taylor Blau wrote:

> On Thu, Sep 16, 2021 at 07:35:59AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> So I think this patch can be dropped from this series, since it's exact
>> duplicate of my 48f68715b14 (tr2: stop leaking "thread_name" memory,
>> 2021-08-27) in ab/tr2-leaks-and-fixes, currently in "next" and marked
>> for a merge with master.
>
> I agree it can be dropped.
>
>> When submitting a series that depends on another one it's best to rebase
>> it on top of it & indicate it as such in the cover letter, Junio can
>> queue such a series on top of another one.
>>
>> In this case I'm still not sure why this fix is here, i.e. surely
>> nothing later in the series absolutely needs this stray memory leak
>> fix...
>
> But there's no need for Jeff to depend on your branch, since (as you
> mentioned) this cleanup isn't relevant for anything else in this series,
> which is a sort of grab-bag of miscellaneous clean-ups.

Indeed, to be clear it was just general advice about queue-on-top.

But to clarify what I was getting at here: If we just came up with the
same diff I'd have assumed Jeff just hadn't need the change in "next",
but since he clearly has I was confused by it being here.

I.e. it doesn't *seem* like anything in the rest of the series depends
on it, so why have it here at all since the bug is being fixed anyway?
Or if it does depend on it in some subtle way I've missed, perhaps it
does need to be queued on top of ab/tr2-leaks-and-fixes, and the
relevant commit/subtle dependency needs to be called out in a commit
message.

Or maybe Jeff had just come up with this independently, noticed it just
before submission and just updated the CL, not the patch or series
itself :)
