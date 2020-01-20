Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F6CC2D0DB
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8E822314
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTq6jCHC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgATOoY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:44:24 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34212 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgATOoY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 09:44:24 -0500
Received: by mail-oi1-f196.google.com with SMTP id l136so28689900oig.1
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 06:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y9gf7HPwJ5wH1Bqdik3IAC/dWI2SwKR6GVgiruX0LpY=;
        b=DTq6jCHCb7uY1Q7D19cEitv/Bbr07ePRmtdFR6WxuTxD+Xus8gRnTmSDqUNdbXHNJ4
         mpTxYrk81oAR0/ezg8vcJz/KX3EGfeWhkXK0AveI+rPLhtYkfrtwg4iJPO/y4hVfD00J
         58Wd0b42kVwkRr7UdmVmzmkXqKiz3sX/6BhOWvH3Jc2ZJPsDVIjFjKe04EA0VnTzcT9e
         KO9EJiBs/pg9Xb7rc0ZnDzzNkHqNnoa7ZGBLUo8ACNgtYhZE6u87jMbyaOosIGPt6OV5
         UB3Rm/j6O7JXllEcoHW7iddDa56MJQNKLZny9APHzRiP7l/QkUec+fdq8yfeqbBHnyne
         KW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y9gf7HPwJ5wH1Bqdik3IAC/dWI2SwKR6GVgiruX0LpY=;
        b=aHJNtq6pnfRck6glwQLsOOMXIwmw9uaT2s8GjHWPk8t5E9pgBO5gUV5iLyAjRo8ASU
         eQrOW9XbCd08yZeigCmwsydzjIPdjCEt2/OsTmyPl2dF4qSZJ4HdEEHLwCULP+avVHv5
         bcOaZU4qIdhG5UuRuJ6hALvzh/DMkfQUCtC81fXyYIb6LJJ2Zb2zG29s9D1F3WNEFzbo
         8Q0riknUbjiawrRaJxDzzveZ5EoUseg3NRPHmOnQFkRjv8FrjUOl7mB4xth7PxlCrzI+
         n6f++wOoHMUU+oEjaX6/3ikWlcyKs+9/xM5caZLKOcZs184rtUJthFyZjsUCxRMMNRPs
         Sd0Q==
X-Gm-Message-State: APjAAAUhgP556dgfmYtkaGEQtjOaDif2mzOj6QoFJdomNvnXUe9YW0hV
        xEqy2rxjnn0fhPh6ZrR4Doo=
X-Google-Smtp-Source: APXvYqwSdsI5M5J5yvji+nB/lFTCxrSpbJ8lJkUdHTBcAYdi7mpK4xFtcTl2x2HHM5nOTwEwvgUNpA==
X-Received: by 2002:aca:d6c4:: with SMTP id n187mr13265764oig.29.1579531462780;
        Mon, 20 Jan 2020 06:44:22 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id 15sm10930518oin.5.2020.01.20.06.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2020 06:44:22 -0800 (PST)
Subject: Re: [PATCH] fetch: add --no-update-remote-refs
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.532.git.1579274939431.gitgitgadget@gmail.com>
 <xmqqa76lew1l.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <84ea103d-8bb0-6043-bc51-9a83866d4e87@gmail.com>
Date:   Mon, 20 Jan 2020 09:44:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <xmqqa76lew1l.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/17/2020 2:13 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> To prevent long blocking time during a 'git fetch' call, a user
>> may want to set up a schedule for background 'git fetch' processes.
>> However, these runs will update the refs/remotes branches, and
>> hence the user will not notice when remote refs are updated during
>> their foreground fetches. In fact, they may _want_ those refs to
>> stay put so they can work with the refs from their last foreground
>> fetch call.
> 
> I've always hated anything that makes the remote-tracking refs
> "float" and surprise end users.  I even hated that 'git push' that
> pretends as if we immediately turned around and fetched from the
> remote we just pushed when it was introduced, even though I gave up
> by now.
> 
> So I am OK in principle to make it more difficult to update
> refs/remotes/* while the end-user is looking the other way, but I
> had to wonder why "git fetch" is even being done if it is done to
> silently update/catch-up remote-tracking branches automatically in
> the first place.
>
> This is more like a "preload" option---without updating the end-user
> visible set of remote-tracking branches, you can make the data
> available earlier so that the actual "fetch" the end-user runs in
> order to update the remote-tracking branches can complete faster and
> become ready to be used more quickly.  
> 
> Which makes sense.

Yes, we get the pack data earlier, and that's the primary cost of
the fetch command. We can also update the commit-graph using the
hidden refs.

>> Add a --[no-]update-remote-refs option to 'git fetch' which defaults
>> to the existing behavior of updating the remote refs. This allows
>> a user to run
>>
>>   git fetch <remote> --no-update-remote-refs +refs/heads/*:refs/hidden/*
>>
>> to populate a custom ref space and download a pack of the new
>> reachable objects.
> 
> Hmph.  I have to wonder if this should have been the default.  That
> is, when refs/heads/X on the remote is configured to be copied to
> refs/remotes/origin/X on this side, and an explicit refspec says it
> should go some other place (i.e. refs/hidden/X), shouldn't that
> automatically bypass configured +refs/heads/*:refs/remotes/origin/*
> refspec?  In any case, it is too late to change that now.
> 
>> This kind of call allows a few things to happen:
>>
>> 1. We download a new pack if refs have updated.
>> 2. Since the refs/hidden branches exist, GC will not remove the
>>    newly-downloaded data.
> 
> Caution.  Since you didn't make it "refs/hidden/<remote>/*", you
> just made the data you fetched the same way with this shiny new
> "--no-update-remote-tracking-branches" option from another remote
> unanchored and susceptible to GCs.

You're right. I neglected to say "refs/hidden/<remote>/*" in my
message, but it _is_ something I've been doing in my background
fetches.

>> 3. With fetch.writeCommitGraph enabled, the refs/hidden refs are
>>    used to update the commit-graph file.
> 
> I have a moderately strong suspicion that it would be better to make
> this "--ignore-configured-refspecs" and implemented without special
> casign the "refs/remotes/" hierarchy like the code does by
> hardcoding.

Based on this and Peff's response, I think you are pointing me in
a better direction with this. It should make the change less of a
hack and also make it more general to users with custom refspecs.

> I also wonder if auto-following of tags should be disabled at the
> same time.  I have no good argument either way (yet).

Would ignoring the configured refspecs stop auto-following tags?
I'll take a look and see. Otherwise, I'll add --no-tags to my
background fetch command.

Thanks!
-Stolee
