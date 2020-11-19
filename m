Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E18C388F9
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 11:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E143F246CE
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 11:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPiHtDT3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgKSLKr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 06:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgKSLKr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 06:10:47 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04479C0613CF
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 03:10:47 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id 142so5781695ljj.10
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 03:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OK9Lcw5oSRDd3vUsncJ1LJnDJO5wr4ZTsZoI6euLuRw=;
        b=cPiHtDT3EqQIo4UxZWQZzAQhhZnuT8F0Ztfv+g0bmoDX2xsMlVY8dEXoicO/6lKxUA
         v+Fx3NryG4lFxiSqZxOhhof3yLHQ4z0n6w2xDiNtWSfWnX/YxD7Mfa117RNewgEohocv
         g3kQE9zXEmERjGBf8p2YdrRRVjQC3cwt6pkwlAsXeMTooOZjtUQAB/VHSrfn6QYrsx+v
         lmMhlouAuaHEKHW5UXnVN3sP4MDX56TXypiDM5vi3Krly17Roo5kRfg8xxitWGViRWrY
         pn7/9xyMmIdpOmMaxHO/U+mt8ONfyehxU5S3FJhJRz5JTQuVYKNGx+Yn12OkjetTvP25
         3HXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=OK9Lcw5oSRDd3vUsncJ1LJnDJO5wr4ZTsZoI6euLuRw=;
        b=ffpd+8ZrH4VjIKC/yQY9g/mslkb7GHEHLGZMbq1PgJnCoGMKzYlXoLhZW7mtGjwkse
         ssM73FJF7kGCa3+mlEc6jI+XhTOVCeVcDMVMQOHbxPoSNQ2CLKOg4QpfMyPXGymsWoRI
         JSJQxix2RbemyQoUZTcQQnKOtJFLBlJeLqmsAeXg8GNEegz6dBtZSK+7YcOulMX/SAYI
         lqgnDywDwjenh+idGudFFba/bBrkJCH2CnPpUWAVSs1+DxR2fVY1OmOTHy/vrZMVNEh4
         9O+tHj9f8CFx/3BgpikifLle7lLhSngm1Byk0zVT35jFnTucvDOqz6wJWcm1d3LjZwrM
         BeXg==
X-Gm-Message-State: AOAM532Ts5T18AIzloslz4GVsud0qRxkAft8yOaRhVDBAoDBhwrfMIgG
        eqafWZQnsnFValUUgNdHuIA=
X-Google-Smtp-Source: ABdhPJyttXOQsPTZdZyW5W3OHWlzt/8q+d/Q2kNBvubQElTiFNlTMxOZX4fM7sVquCrunzYNt2/Yng==
X-Received: by 2002:a2e:8681:: with SMTP id l1mr5977812lji.170.1605784245519;
        Thu, 19 Nov 2020 03:10:45 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id s12sm3935429lfd.71.2020.11.19.03.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 03:10:44 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 00/28] Use main as default branch name
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
        <87r1oraewl.fsf@x220.int.ebiederm.org>
        <xmqqv9e34mq5.fsf@gitster.c.googlers.com>
        <1389dabc-33c9-1e65-a3de-43729a6c2e70@iee.email>
        <xmqqh7pmyuzn.fsf@gitster.c.googlers.com>
        <7df660f2-ad74-7d1f-eb13-a0edadffbfbf@iee.email>
Date:   Thu, 19 Nov 2020 14:10:44 +0300
In-Reply-To: <7df660f2-ad74-7d1f-eb13-a0edadffbfbf@iee.email> (Philip Oakley's
        message of "Thu, 19 Nov 2020 10:35:45 +0000")
Message-ID: <871rgpr497.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> On 19/11/2020 01:51, Junio C Hamano wrote:
>> Philip Oakley <philipoakley@iee.email> writes:
>>
>>> An alternative in the other direction is to go with the 'not currently
>>> on any branch' (detached at nowhere) but then require users to
>>> deliberately create their first branch with their chosen name. This
>>> moves the 'backward incompatibility' to a different place, which may be
>>> easier to manage.
>> As has already been mentioned by Peff, I do not think that is a
>> workable alternative, especially given that people are generally
>> afraid of and easily get confused by being on a detached HEAD.
> Yes, our use of the technical phrase 'detached HEAD' is confusing,
> compared with the more pleasant 'not on any branch', or 'not at a branch
> tip'. Such is the curse of knowledge.

To me "not on a branch [tip]" is also confusing, as in fact you are, as
is easily seen after you perform a few commits, and now HEAD points
directly to the tip of the branch (that has no other references).

I wonder why Git didn't rather adopt "unnamed branch" or "nameless
branch" to describe this mode of operation?

-- Sergey
