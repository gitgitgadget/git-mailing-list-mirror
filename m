Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B110A20756
	for <e@80x24.org>; Tue, 10 Jan 2017 20:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751956AbdAJUvF (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 15:51:05 -0500
Received: from mail-it0-f43.google.com ([209.85.214.43]:36401 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751155AbdAJUvE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 15:51:04 -0500
Received: by mail-it0-f43.google.com with SMTP id c7so49891731itd.1
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 12:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=P9dgyDbbP/CJW+KQ1vMCsF1+NXnedq5rbSdp9PrmEOI=;
        b=lvYu7npzVz+dCaMB5uUH8St2w1cz0HO8Dffo/bDmHU90N+/AKWbFQGaOF9K9N6mD8c
         sRNXm8gB82291AA0JvhM7w9+QwM6lyBf00nsbNJkmB/SG5mFfgJBDMM146lMGQoxp+Pl
         FI1baBIwa90Hw95PkB6Xq2YJHk1tC3HG+y/lgO0O1AymZvXU9PDnYTECRNjAyHhprFEN
         8x96+KERpZfBCEmXjHJsgmjclsUWgb8ujyC9dX4XjPVelObkyCJbI+EnSMNCdjKXQ5R8
         a0JcT9072F3Nk1LhJMWYzTSSsnQFSFn6C2iig4/zicXG8kbUq08mS5Ai7jPS5Tw4DT5w
         QONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=P9dgyDbbP/CJW+KQ1vMCsF1+NXnedq5rbSdp9PrmEOI=;
        b=jb/1zE6+2pNw0zzcq9eiqP3Fsr3qXPV6EPXOdHbezuLdTmcggwWIsGAewXQpgjC5ut
         KpczbF4XBBkAEyCzWxuhhnoVoMnVrYa8sjx7EeUnLdHpeNha7VFbo5QTIaixSJETV9kF
         m3PcrpSh/2qaV1tcLJaPTY559pcTwWQj8Bscq0HK5mkFRuvOm9O/mvHKRXzwmOZUduc+
         aq0G27HD28vO77OXJtkn+8e6BnIZ16JnHznEjltxwSRCmKxTjNITu9GQy1XI+D9lyR/y
         OXyVy6jPfylfJgefbOKnYpurxKJ7C8ZVBA5gdd0ruFWy86PznB9S2V0j6jC5ZXWKLXpc
         97Fw==
X-Gm-Message-State: AIkVDXJEOCH5yp8bfS4kitoKnn3mwr09eRJOnxsROrsX/kOOjndmnbr2UtqmCwo1T0kUe8bcZdwZXsNQzAWdSSbY
X-Received: by 10.36.65.161 with SMTP id b33mr5191283itd.114.1484081463551;
 Tue, 10 Jan 2017 12:51:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Tue, 10 Jan 2017 12:51:03 -0800 (PST)
In-Reply-To: <xmqqd1fusmsu.fsf@gitster.mtv.corp.google.com>
References: <20170109194621.17013-1-sbeller@google.com> <20170109194621.17013-5-sbeller@google.com>
 <xmqqd1fusmsu.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 10 Jan 2017 12:51:03 -0800
Message-ID: <CAGZ79kbXVCvZuj6rTckGwOfFtRSFpx9p611oKfFLAayTgB242Q@mail.gmail.com>
Subject: Re: [PATCHv2 4/5] unpack-trees: factor file removal out of check_updates
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 10, 2017 at 12:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> This makes check_updates shorter and easier to understand.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>
> I agree that 3/5 made it easier to understand by ejecting a block
> that is not essential to the functionality of the function out of
> it, making the remainder of the fuction about "removing gone files
> and then write out the modified files".
>
> The ejecting of the first half of these two operations, both are
> what this function is about, done by this step feels backwards.  If
> anything, the "only do the actual working tree manipulation when not
> doing a dry-run and told to update" logic that must be in both are
> spread in two helper functions after step 5/5, and with the added
> boilerplate for these two helpers, the end result becomes _longer_
> to understand what is really going on when check_updates() is
> called.
>
> Is the original after step 3/5 too long and hard to understand?

It is ok to understand for the current state of the world,
so please drop 4 and 5 for now.

In a future, when
* working tree operations would learn about threading or
* working tree operations were aware of submodules
then steps of 4 and 5 would be longer, such that the check_updates
function may require further splitting up.

As far as I understand the operations now, a working tree operation
is done like this:

* First compute the new index, how the world would look like
  (don't touch a thing in the working tree, it is like a complete
  dry run, that just checks for potential loss of data, e.g.
  untracked files, merge conflicts etc)
* remove all files to be marked for deletion
* add and update all files that are new or change content.

check_updates does the last two things listed here, which in the
grand scheme of things looked odd to me.

When introducing e.g. threaded checkout, then each of the functions
introduced in patch 4&5 would be one compartment, i.e. the function
remove_workingtree_files would need to have all its tasks finished
before we even queue up tasks for updating files, such that we
do not run into D/F conflicts racily.

So yeah, maybe this is too much future-visionary thinking, so please
drop 4/5; I can revive them if needed. I think I mainly did them
for my own clarity and understanding.

Thanks,
Stefan
