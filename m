Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4B6C2D0A3
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 04:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0A652225E
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 04:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kLpPv6pW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422044AbgJZEOr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 00:14:47 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:43666 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422104AbgJZEOp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 00:14:45 -0400
Received: by mail-io1-f73.google.com with SMTP id f5so5085601iok.10
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 21:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=4hNBZ6qbe9zEE0H1VRLvrA5Wk/JdlnHHj4vFuHm2olw=;
        b=kLpPv6pWoiYIEqCrfqep0kN6bu5fP7N3OvwzMcZTyTapQyGqAj+yukgMCCZsp7zVV/
         33r0Eewc/fOa9ZePCyNODhuck4vmOogidgCM+Rf1gXrxKLBLhG+SuaEsjLWTy9FfOTQR
         WamlSs7SQ/rk5Sb7X35Fk/L9l+aHP30c+vp3+GmNaQbmH5j3yUUwM75y7ZwtpNskUjTg
         A55VMXWRJwKtN+Asa/lCBgY+aekRcVI6N8leYmxZW/SWWa9tNI6tMBxJ4JaP1vlgOQB2
         pstwU5W+dH7VICTjwt2TYl7iKTduFySvb8uOWvZv4XbYkMscCAhdEk8hlpv3SH+BMMCY
         p6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4hNBZ6qbe9zEE0H1VRLvrA5Wk/JdlnHHj4vFuHm2olw=;
        b=inIooGAFlVepojwfokcTkBRvE5OVZjMWBV983ASQBvqv0LOE0KSllWpnGL9/hfEMS1
         zYRK4j1z74w3kR77289jh7Xatus/JotjLxn5wvemoofxzep2WNL7X8Hrmnc6QXYIuTv/
         FHCxUHYYoemsCpt1NyiHRuE4fEVA3idqlSloS1psBopIux5C/RxvsY4TZAHkDhRvqqCX
         KhaLTRoTNIDNR5r03zekYOEqB+Q3tPcCuSTFYOBVGm3yfYIh/SUVLGJ5CX/bugXp3NGi
         KUaguYrmLoQ3WNohHz6Xq7ydukX8tJSzf3zp/UtvmOAWeT+XhkDpf5ubPz3v4G/k1/4P
         Tc5w==
X-Gm-Message-State: AOAM5335rLCv2zPC3L0UcYCPKnPfMzVYlxjPgzeocg6UcsfDxUevsDrG
        QSujqcGREb8BEEEhYaGYWq/hdczgmJvd
X-Google-Smtp-Source: ABdhPJxZQatiDoh7rVZnFTfQALryTKAWS8/CH6mfDac9gJJ7QsUF7glg52CceGJ6Z7NJOYf3kpXbyBJvM0t4
Sender: "shengfa via sendgmr" <shengfa@lins.c.googlers.com>
X-Received: from lins.c.googlers.com ([fda3:e722:ac3:10:2b:ff92:c0a8:cb])
 (user=shengfa job=sendgmr) by 2002:a02:5849:: with SMTP id
 f70mr9856710jab.97.1603685684506; Sun, 25 Oct 2020 21:14:44 -0700 (PDT)
Date:   Mon, 26 Oct 2020 04:14:43 +0000
In-Reply-To: <xmqqd01ans4h.fsf@gitster.c.googlers.com>
Message-Id: <20201026041443.1362933-1-shengfa@google.com>
Mime-Version: 1.0
References: <xmqqd01ans4h.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: Re: [WIP v2 1/2] Adding a record-time-zone command option for commit
From:   Shengfa Lin <shengfa@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, nathaniel@google.com,
        rsbecker@nexbridge.com, sandals@crustytoothpaste.net,
        santiago@nyu.edu, shengfa@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> Yes, we could check it in datestamp(), but ... 
>>
>>> Initially, I thought this would be sufficient to show "-0000" in commit log
>>> message. However, I found that the show_date function is used for "decoding";
>>> converting timestamp and tz to more readable format. Then I realize the
>>> function won't distinguish between +0 and -0 as it only takes in a tz as
>>> argument. As a result,...
>>
>> ... I would have imagined that you do not have to deal with all
>> those complications if you don't hook this to such a low level of
>> the call graph.  That is why I wondered:
>> ...
>
> Let me answer some of my puzzlement myself; that is, I would have
> understood the change well if it were explained to me this way, and
> if that explanation matched what the patches did ;-)

Yes, I agree.

> The topic has two major parts.
> 
> The code that prepares the timestamp to be recorded for the current
> user, who wants to record an anonymous timezone "-0000", is one (and
> the easier) part.  And this part could be done all inside
> ident_default_date() without touching anything in date.c; when we
> need to call datestamp(), we are getting the current time for the
> current user, so we can mask the timezone.

So for this part, there is no need to modify datestamp in dates.c.
We could modify ident_default_date buf after datestamp to set the last
5 bytes to "-0000" using strcpy.

> The other part is that we need to read the timestamp from existing
> records, and if we choose to distinguish between timestamp in UTC
> and timestamp with anonymous timezone, we'd need to devise a way to
> encode the anonymous timezone differently.  It is where the extra
> bit that says "this bit does not usually mean anything but only when
> the offset (which is a signed integer whose valid range is set to
> between -2400 to +2400 by date.c::match_tz()) is zero, and this bit
> is set, the zone is anonymous" comes in.

Yes, that's correct.

> 	Side note.  I suspect the damage to the callchain can be
> 	limited much narrower if we didn't add this bit throughout
> 	the API.  What if we instead pick a number outside the valid
> 	range of offsets, say -10000, as a sentinel value and passed
> 	that throughout the code when we want an anonymous zone?

Good idea.

> 	The functions in the callchain that care about the timezone
> 	must understand how anonymous zone is encoded anyway, so to
> 	them it's a matter of using an int plus one bit or using an
> 	int that can have a special value.  But other functions in
> 	the callchain whose sole purpose (with respect to the
> 	timezone information) is to pass it between their caller and
> 	their callee as an opaque piece of data, using just a single
> 	integer is much less error prone---the patch does not have
> 	to touch them at all.

That would be easier to follow and requires less changes as well.

> Thanks.

Thanks for the clarification. Now I think we have a much better
understanding. I will try to do a better job describing patches
next time.
