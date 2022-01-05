Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2C7C433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 01:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236835AbiAEBCt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 20:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236833AbiAEBCs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 20:02:48 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A98C061784
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 17:02:48 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id lr15-20020a17090b4b8f00b001b19671cbebso4835140pjb.1
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 17:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CQWw23DVKdykmcBPM/Rfqu1x4Z9oF89Cxxj7bK2BzG8=;
        b=Q6RSJKGGikug61jI4rTZXVFbN2MMYnobZlkzPIgFNIl5Q4cqSkt7Yjbt17EoMqRopr
         khb3v+rFAtol/sDoyf3SBHxcbFLugdOXdqUUuXjW2dfhLUEKtBpMSs8U5yHeaWTRpZjs
         7TyNgSUO+KUvMAU16N5CKosMwY8uEwsX4TceSwlz8K846poVIGWIGKxDiR9m1wcXM5Xm
         Og2zsIjBJR/tjUAwGA45xClT/lYUtf0DwHozwRD7knK/X+5J0ABasroWx/0Q62ECwHq1
         szW9eVqXtQRVH7tQCLGkyyFCLe9eDQkVgcn5m0NYDOTtOytwJy/KkwQvwOJTg19rjvsf
         fkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CQWw23DVKdykmcBPM/Rfqu1x4Z9oF89Cxxj7bK2BzG8=;
        b=paoNRU8p7cjnH6Lt6hnekaTw3lLlzjGGbeHos0Hkpc9GL4zDEzRKM9+3qklJUMRZtd
         dHq4gAI7qrV5z0J1eqbmsByXDpA7gH3q/bKoz7lzxDn+BqQERF2A8hZI+4n9qBng0snR
         9/i4qsD8Sr2BeuUyig3Vt8U+6fq3/cO8/GXOPS036G45rzye1rxweGBviQO05T5ryOF0
         zGhqeThd9AkJq9jHFb5QL7nFaqd7GBXGuGfIpTK1Nx1psTNq2pKiiSv50Ea8aqpQCdiv
         EOQcaxM5D6YdwkhG7dKl18f2yqytfrKqr8eYJNGuiK2yT8LS44Y9xOpJwBCUOagLqAi/
         JrCw==
X-Gm-Message-State: AOAM5331xT4U8XweKMNm6QRZt4cRIMDIRpZUN60od1pcgotF0iu9Yn9r
        ReuEKW5FmoEohg6WI1OWtbGSKBrtfFgDOSVW
X-Google-Smtp-Source: ABdhPJxoIXRxGlT1h64CzenaCYKFq/w1Ly3tIP6dh0xLMtCUVy5/9tjinotOqTMvn22o24xOoeUJ1Q==
X-Received: by 2002:a17:90b:f0b:: with SMTP id br11mr1195728pjb.39.1641344567936;
        Tue, 04 Jan 2022 17:02:47 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:be91:68f:b87b:8d7a])
        by smtp.gmail.com with ESMTPSA id y129sm8021180pfy.164.2022.01.04.17.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 17:02:47 -0800 (PST)
Date:   Tue, 4 Jan 2022 17:02:42 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?Jo=E3o?= Victor Bonfim 
        <JoaoVictorBonfim+Git-Mail-List@protonmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>, calvinwan@google.com,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Review process improvements
Message-ID: <YdTuMlAkVIivp1bg@google.com>
References: <YbvBvch8JcHED+A9@google.com>
 <211220.86fsqnwkzs.gmgdl@evledraar.gmail.com>
 <CAPig+cT+NshUMS+BNLKDMuwOEXKEzS3Ve=hK3kCYEBvJNzXuxQ@mail.gmail.com>
 <J3wlC13aBBawF42_jmIX-9_4S5yvG4W-8miLgPASeby-v_QHn5Vw72gGy8E8WB-TQhGvrvpeC4Y2PnTIy3b1o6In_WHDzZ3s9nf2getOzRU=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <J3wlC13aBBawF42_jmIX-9_4S5yvG4W-8miLgPASeby-v_QHn5Vw72gGy8E8WB-TQhGvrvpeC4Y2PnTIy3b1o6In_WHDzZ3s9nf2getOzRU=@protonmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 20, 2021 at 09:27:41PM +0000, João Victor Bonfim wrote:
> 
> I added on to this on another e-mail thread, however, it got no
> response, specially because I didn't have an e-mail to reply to, so I
> am copy and pasting the messages here.

Since you mentioned not receiving a reply earlier, I thought I would
reply directly to your comments.

I have only recently seen you begin to post here, so welcome! and I
think I saw someone else mention in another thread, but I'll say again
now: in general, please wrap your lines at ~80ch when replying to the
mailing list; having very very long lines like the ones you sent is
annoying for some mail clients, so the Git list convention is to wrap
them. I rewrapped your mail below so that it would fit more easily into
my editor.

> 
> ‐‐‐‐‐‐‐ E-mail one ‐‐‐‐‐‐‐
>  Addressing point #1, titled "Draft a MAINTAINERS file": seems quite
>  reasonable, I would also like to address some matters about this,
>  first is that there is no point of contact for "trusted sources"
>  within the git project and it is quite negative for historical
>  purposes, because maintainers and more prolific parties will
>  inevitably retire or move on from Git themselves and their prestige
>  won't be recorded beyond their commit history within the project and
>  it might lead to their contributions being forgotten. Second is that
>  it is hard to know who is responsible to what from the get go without
>  being in the know already. Third, please make all entries on any and
>  such file that might auto send messages non-committal, why? Nobody
>  wants to receive a message from a third party that the git mailing
>  list deems "trustwothy" only for it to be some scam of sorts that
>  only happened because a modification to the file managed to fly under
>  the radar, so make it a one way pass and all tags are only to people,
>  not from.

I'm not really sure what you mean by "non-committal" here. I will say
that messages coming from the Git mailing list does not imply that
messages are safe in any way; we get plenty of spam and phishing mails
making it past vger.kernel.org's filters. The proposal of a MAINTAINERS
file was definitely not a proposal to modify the review process itself;
as always, the expectation is that code should be reviewed by a number
of contributors to ensure it's doing what it says it is trying to do. I
don't see that that will ever change.

>  Fourth, I, personally, only want to partake on discussions,
>  but barely want to see patches and commits, maybe allow for some sot
>  of group inheritance and group message allow or deny lists? So people
>  that don't want patches don't receive patches, but they can filter to
>  receive only "memory allocation" topics, but they won't receive
>  patches that are for memory allocation, because the "patches" and
>  "discussion" topics take higher system priority than the "memory
>  allocation" topic, be it user by user or system wide. Maybe also
>  auto-filter messages, even in a dumb way or in a sender dependant
>  way.

For what it's worth, in my Gmail web client I filter out any mails
beginning with `[PATCH` - because in web client I am like you and
usually only want to participate in broader discussions. So I think
there is already a solution for filtering the way that you want to.

> 
>  Addressing point #2, titled "Draft a ReviewingPatches doc", and point
>  #3, titled "Google Git team will review cover letters and commit
>  messages internally before sending series to the list": not much to
>  say beyond, people, share your reviewing know how, including you
>  Google folks, if you interpret the reviewing process as an algorithm,
>  it would make sense that all mechanisms of human interaction and
>  review to be shared as part of the code base. So please, Google
>  people, share what and how you do your reviews. It is also a matter
>  of security, if your review process isn't transparent, we can't know
>  whether we can trust everything you provide, because you might be
>  leaving or dismissing problems and it might fly under the radar or
>  malicious action could be taken and, since the group as a whole is
>  already trusted, some malicious code could be included, even if it is
>  not explicitly so.

As I mentioned in my mail, we are only conducting review of commit
messages and cover letters, not of code - specifically *because* it is
so important to perform in-depth code review out in the open, for the
reasons you say. Code review should always happen on this list, and I'm
not suggesting to change that. (That's true of patches submitted via
GitGitGadget too, by the way - we don't perform review in the comments
on those GGG pull requests, for these same reasons.)

As for the Googley review know-how.... like I mentioned in my reply to
the main thread a moment ago, there's not that much "secret sauce". :)
However, if you're curious, you might keep an eye on the #git-devel
channel - we have recently started doing public "review club" live
meetings and inviting the Git community to join us in reviewing patches
on the Git list. The next one is this week, so if you're interested and
the timezone works out, you'd be welcome to join us.

> 
>  Extra notes: As a person with ADHD, REAMEs can be daunting at times,
>  specially when they are boring word walls, and they can be incomplete
>  or repetitive if there are other documents addressing information
>  contained within them, maybe reference files such as
>  "Contributing.md" instead of copying them verbatim? An example would
>  be "To read more on how to contribute to projects, read
>  'Contributing.md'." instead of what is information contained within
>  "Contributing.md", it would help a lot with human to human
>  interactions.

Yes, I agree this is the best way to do documentation. Human ability to
parse or no - having the same information in two places means that
inevitably, one place will become stale. ;)

>  Thanks for the attention, take care!

Again, welcome to the project.

 - Emily
