Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66519C00144
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 18:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbiHASrR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 14:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiHASrP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 14:47:15 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8E25FF2
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 11:47:14 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ss3so21941396ejc.11
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 11:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=bxT3o36URVC/8HSD7TAj8UIjFFnsj4v861ebvp8edE0=;
        b=p+PoKQ6g3WUqlz7c5hFdsMg76mKwCUnfVLL1I6oMDhrIDoj0a1Mx20bKaXxuht28Io
         3nywVC3Tj9vZkHxAcfAg0GCqDHFoGEP98kMqvvHh6nKynKWKWVT0VvJ2/SD8QsCDXL1f
         1TzNU+JCtMdTcGFDQg/2meYL971c/cHD5OaVlq37L1iApKyJtMVHaptXi48R+FK2IKax
         DY2YbxtKpQwXy4A3pBnBK45chkCYicQ8C3F+yUHO8AwkWauvKaMmZLET1567S3+FhSJY
         nKZMr2GqW2Zt7mwBSYrkMV9GscgKf2rYSkD4zHF0Frq75b3z78NWlFJhgJF5Ue61Ql+u
         YrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=bxT3o36URVC/8HSD7TAj8UIjFFnsj4v861ebvp8edE0=;
        b=LMuk2CbNFlx65x2b+i8ILGzAMWfuVSqtsW0+biOl2tJUcv1/h9hPhPanYfOR+/RMrS
         dHVZsfN8n/SnggvIqldHlf8UzobKUWvhuG0jXXHGWlLD25v90xKgVU2hg0qXspikH6g9
         KiNu+dpQzf22czjZvq3cNkK7BvIM5j5iVwc7WCyUUVCwg+x4npDISO7gO5pl3F9mqhyn
         UPo/E6Szy82lFrInfeKEJ5E+Eu/WEel6t68LblcOdZNJJFnpnUsAe2PCcI3ZOVVsDj4E
         ZTA1n+nwar4lE//U+JHprsGy6QlZGBnQpEh0iQL2+Zbfb+uyk0X9r9Jw6OZjq0thcTfH
         E5jw==
X-Gm-Message-State: ACgBeo0khFC2YvChgrYVXzDTQ15L1hpWnjMmPbNykuQtKqK2rpkDXhR3
        Od0zNiLuk14hxlcxGpsYl78=
X-Google-Smtp-Source: AA6agR5rRxx1+9Sq5qDxOGpMPF7vnQ4Hxy/pQ5N4147C86GqatUDkptcjtnbU547319yL+7gW5PghQ==
X-Received: by 2002:a17:907:2708:b0:730:6cea:2209 with SMTP id w8-20020a170907270800b007306cea2209mr6128146ejk.761.1659379633096;
        Mon, 01 Aug 2022 11:47:13 -0700 (PDT)
Received: from gmgdl ([109.38.143.20])
        by smtp.gmail.com with ESMTPSA id e3-20020a1709067e0300b0070efa110afcsm5447420ejr.83.2022.08.01.11.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 11:47:12 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oIaRb-0093ml-2P;
        Mon, 01 Aug 2022 20:47:11 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        jonathantanmy@google.com, philipoakley@iee.email,
        johncai86@gmail.com
Subject: Re: [PATCH v5 4/6] serve: advertise object-info feature
Date:   Mon, 01 Aug 2022 20:44:57 +0200
References: <20220502170904.2770649-1-calvinwan@google.com>
 <20220728230210.2952731-5-calvinwan@google.com>
 <xmqqk07v7qe4.fsf@gitster.g>
 <CAFySSZAPzO9YzGhsjhG7YRXv+ctTHM2FXzrwRW2bTW4pUt8q7g@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CAFySSZAPzO9YzGhsjhG7YRXv+ctTHM2FXzrwRW2bTW4pUt8q7g@mail.gmail.com>
Message-ID: <220801.86mtcnhkcw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 01 2022, Calvin Wan wrote:

>> OK.  Now we will no longer advertise a bare "object-info", but
>> "object-info=size" (and possibly in the future things other than
>> "size").  How would this change affect older clients who knows what
>> to do with "object-info" but not "object-info=<values>" yet?
>
> This was a tricky tradeoff that I definitely think I should have
> discussed more in the commit message. The issue with how object
> info is currently implemented is that it is very inflexible for adding
> new parameters.
>
> This is how object-info currently parses a client request:
>
> while (packet_reader_read(request) == PACKET_READ_NORMAL) {
>     if (!strcmp("size", request->line)) {
>         info.size = 1;
>         continue;
>     }
>
>     if (parse_oid(request->line, &oid_str_list))
>         continue;
>
>     packet_writer_error(&writer,
>     "object-info: unexpected line: '%s'",
>     request->line);
> }
>
> Object-info supports "size" right now but, let's say I want to add
> "type" as a parameter. OK I add another if statement like:
>
> if (!strcmp("type", request->line)) {
>     info.type = 1;
>     continue;
> }
>
> And we update the docs to say "type" is now supported by
> object-info. If a user now attempts to request "size" and "type"
> from a server that has not been updated to support "type",
> then the user gets an error message "object-info: unexpected
> line: 'type'", which is another situation that is a bad experience
> for older clients. The client has no way of knowing that their
> failure is caused by a server version issue.
>
> Essentially I think at some point we have to bite the bullet and say
> we need to rework some part of the object-info advertisement (or
> if anyone has a better idea of achieving the same goal) so that we
> can make future incremental changes to object-info. If the supported
> parameters are posted in the advertisement, then the client doesn't
> have to first make a request to find out that their requested
> parameter isn't support by the server. While you noted that we can't
> make the assumption now that nobody is using the current
> object-info feature, I think the benefit of the change outweighs
> the cost of affecting the possibly small amount of users of this
> feature. (A quick search on stack overflow for "object-info" tagged
> under [git] returned no questions about it so that's what I used as
> a cursory estimate for how popular this feature is).
>
> Curious to hear what your thoughts on this are Junio, since as
> much as I'd like to create a seamless upgrade experience for
> older clients, I'm out of ideas as to how I would do so.

I haven't looked deeply into this case, but in general for such protcol
incompatibilities we could just create an object-info2, and have that
use some extensible calling convention we wish we'd have used from day
1.

Then have new clients understand both (and prefer the new verb), and
older clients use object-info without breakage.

Or we could call the new thing "cat-file", and have it accept any
arbitrary options it does, and then limit it to some sensible subset for
now :)
