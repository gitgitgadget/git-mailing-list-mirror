Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5280DC433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 23:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238868AbiBOXU4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 18:20:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbiBOXU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 18:20:56 -0500
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F27F94D4
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 15:20:45 -0800 (PST)
Received: by mail-pl1-f177.google.com with SMTP id l8so531588pls.7
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 15:20:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V9NXhq0sTsXv6c+oPbr0iDvbAhnCFhNMe1zWbpMj3dw=;
        b=Kren6Jd/G8ncIVdy8v+7AUYCA+IMy8q4Scm08tNFgqJKtCGvTGs/kW3zTLn7n6Ja80
         dDW8cz4accRk22EHfCCz2r2vhhktPIJikQdYIThcjm2kmsYbYA4HuJykNM10HXn7M8hh
         J/slpGepT2dpEPPiqF6Hz6VXwD5Ofn2UaRiGiBQ0RLInGENO1w6tE2Q7y4BcCPBokMLl
         MlbNaVFOxQC+Xj39Sbk/+VDAE1UJk8ADxVeugAVW4G4qnsDLk0rii0PCpru5gqrOC8Uq
         TjWWfQs6B9XmDLnM17/AKg1bAYP8oTt+bLU/T9Doh6nyebchERuMPuyN259Jpcqt4YdY
         //nw==
X-Gm-Message-State: AOAM533O2NQ9M+B/Y3rzCQx+KqDzuW8a+udx/m+JHnaIsnqQCyX3ye2u
        y+X7Vqi1vAZDBGuD5rq/8NTvZbQFXte2IFNO7mw=
X-Google-Smtp-Source: ABdhPJw33UqRDn3TA4ZPugpn7nT+tIkxl7MAOslbr1UtHEwCXVLrV/DwO7u900Yl966QAvRrKTZ/qDjK2rZ6SNixo3c=
X-Received: by 2002:a17:90b:1892:b0:1b8:7a6c:9e7e with SMTP id
 mn18-20020a17090b189200b001b87a6c9e7emr7076492pjb.150.1644967244522; Tue, 15
 Feb 2022 15:20:44 -0800 (PST)
MIME-Version: 1.0
References: <pull.1212.v5.git.git.1644609683.gitgitgadget@gmail.com>
 <pull.1212.v6.git.git.1644862988.gitgitgadget@gmail.com> <a6dd5d72fce8cec430c0ec5da2dd9f0969a7fd91.1644862989.git.gitgitgadget@gmail.com>
 <CAPig+cTwLhn1GZ_=6s0FXL0z=Q=p1w9ZGK0hAV8wfK9RsQYjnA@mail.gmail.com> <1FF9283F-C823-4D26-A39B-6506B900CEB2@gmail.com>
In-Reply-To: <1FF9283F-C823-4D26-A39B-6506B900CEB2@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 15 Feb 2022 18:20:33 -0500
Message-ID: <CAPig+cR2fymDzEupNW3XvQDBmsd4rtQDQq-2ha6ODzbqoeFQ9A@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] cat-file: add --batch-command mode
To:     John Cai <johncai86@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Wong <e@80x24.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 15, 2022 at 5:58 PM John Cai <johncai86@gmail.com> wrote:
> On 15 Feb 2022, at 14:39, Eric Sunshine wrote:
> > On Mon, Feb 14, 2022 at 1:23 PM John Cai via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >> +static void dispatch_calls(struct batch_options *opt,
> >> +               int nr)
> >> +{
> >> +       for (i = 0; i < nr; i++){
> >> +               cmd[i].fn(opt, cmd[i].line, output, data);
> >> +               free(cmd[i].line);
> >> +       }
> >> +       fflush(stdout);
> >> +}
> >
> > If I recall correctly, Junio suggested calling free() within this
> > loop, but this feels like an incorrect separation of concerns since it
> > doesn't also reset the caller's `nr` to 0. If (for some reason),
> > dispatch_calls() is invoked twice in a row without resetting `nr` to 0
> > in between the calls, then the dispatched commands will be called with
> > a pointer to freed memory.
> >
> > One somewhat ugly way to fix this potential problem would be for this
> > function to clear `nr`:
> >
> >     static void dispatch_calls(..., int *nr)
> >     {
> >         for (...) {
> >             cmd[i].fn(...);
> >             free(cmd[i].line);
> >         }
> >         *nr = 0;
> >         flush(stdout);
> >     }
> >
> > But, as this is a private helper, the code as presented in the patch
> > may be "good enough" even though it's a bit fragile.
>
> What you suggested makes sense from a separation of concerns point of view. I'm
> still learning what looks ugly in C :), but I think this is easier to read
> overall than what I had before.

Even with my suggestion, it's still rather ugly for a "dispatcher"
function to be freeing resources allocated by some other entity and
for it to be clearing the other entity's `nr` variable, but at least
it's less fragile. It would be less ugly, perhaps, if this function
was named dispatch_and_free().

A better way to make it less ugly would probably be to introduce a
structure which holds the array of batch_options* and the `nr` and
`alloc` variables, and then have a dedicated function for
clearing/freeing that structure. However, while such an approach is
fine for reusable containers but is probably way overkill for this
one-off case.

> > If I'm reading the code correctly, it seems as if these problems could
> > be avoided by treating `flush` as just another parse_cmd::commands[]
> > item so that it gets all the same parsing/checking as the other
> > commands rather than parsing it separately here.
>
> This is a good idea. I like the reduced complexity.
>
> > If you treat `flush` as just another parse_cmd::commands[], then right
> > here is where you would handle it (I think):
> >
> >     if (strcmp(cmd->prefix, "flush")) {
> >         dispatch_calls(opt, output, data, queued_cmd, nr);
> >         nr = 0;
> >         continue;
> >     }

One other point which would make this suggested code even clearer is
to rename the parse_cmd::prefix member to `command` or `name` or
`token` or something other than "prefix" since it really _is_ the
command name, not a prefix of the command. (You're only treating it as
a prefix semantically at parse time.) Thus:

    if (strcmp(cmd->name, "flush")) {
        dispatch_calls(opt, output, data, queued_cmd, nr);
        nr = 0;
        continue;
    }

is easier to understand at a glance than `strcmp(cmd->prefix, "flush"))`.
