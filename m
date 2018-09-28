Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17A4C1F453
	for <e@80x24.org>; Fri, 28 Sep 2018 19:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbeI2Bys (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 21:54:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52275 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbeI2Byr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 21:54:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id 189-v6so2979269wmw.2
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 12:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5cXmplK1xgHEbV4KDoaoEgYWIIXPbLTC8rs9XfVpDks=;
        b=QiXjxRCyUxXDm7YF8Wa/bDqStSNHqOOarr2y/NNiPmhwCajPHT7ic6IZoKm16251cJ
         AfvCeYXq7Si9TqBpGe8VVj2CG6rRoehnyge0eRjgDAVSniTHKavb0Q24gUl8lWYDxNh4
         7iC8RQMytpAKaHCWeoMuih+TQydS0aC7P4AqSYMcu4Wy/MPC1OsviMRzGVkXUwTFUI/3
         YeDyM7H1CYkKsI2A04lfHYSptH2X6w1c9nFb/gLTEugJ2s+ORWelB16Y04bFjMC7CG1w
         guiiumrR0x9Rvlapt93VA0KOpTSbQjPKOTppZjIw9A/krR4KVDPr2hTv1/evPt1F+7OY
         DPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5cXmplK1xgHEbV4KDoaoEgYWIIXPbLTC8rs9XfVpDks=;
        b=IhsH1quwbx1V90Et1VQMIGSXpybL1iSgobDYS62QLXT3fqyHO03NZk3aZT2Y/bkOh3
         uwXimI/aqgNKOEMG0dun4vf4NKQl/Nzad4N36nou9rM99IeNX89KwornQUCqyAxxd4/F
         Fg4ugALIm7Zd0RNfxz/xzcMdPTV5/J3V0wZO8Naob1TC5VuVtMCLmYl4Pdp5U+NGuPUZ
         3h8x+rgzlfZoKBtxLb72nyJgbLLwruYBnazYDasHz/C52tCOmMSv6mdyN+JpI4ylFbsx
         YOOECB6T3z9n02tf3EMO5VNysfUKpJ/xyRg41o/TcqGMu0F3rL/EtfjkAaNg9UhY9ZJ+
         m2nA==
X-Gm-Message-State: ABuFfoiA1smd315+M4dbYQe9wYT22y/JHNqi6g9DDWQ6OKzQFff8YbqQ
        Zv8BfwwlC7BELBh1EIy7c2s=
X-Google-Smtp-Source: ACcGV61vhVvdWFWWQUofrxTuWLH/pzReurQD4Ge7qNJy/QzUrX29sq3TPbAczKBWMt4QptruLS6ftw==
X-Received: by 2002:a1c:cb4d:: with SMTP id b74-v6mr2616660wmg.123.1538162971758;
        Fri, 28 Sep 2018 12:29:31 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n11-v6sm7297874wra.26.2018.09.28.12.29.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 12:29:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kyle Hubert <khubert@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Improvement to only call Git Credential Helper once
References: <20180928163716.29947-1-khubert@gmail.com>
Date:   Fri, 28 Sep 2018 12:29:30 -0700
In-Reply-To: <20180928163716.29947-1-khubert@gmail.com> (Kyle Hubert's message
        of "Fri, 28 Sep 2018 12:37:16 -0400")
Message-ID: <xmqqva6pbeud.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kyle Hubert <khubert@gmail.com> writes:

> Subject: Re: [PATCH] Improvement to only call Git Credential Helper once

Nobody will send in a patch to worsen things, so phrases like
"Improvement to" that convey no useful information has no place on
the title.

There probably are multiple ways that credential helpers are not
called just once and many of them probably are legit (e.g. "get" is
not the only request one helper can receive).  It is unclear why
"only call helper once" is an improvement unless the reader reads
more, which means the title could be a lot more improved.

	Side note: this matters because in "git shortlog --no-merges"
	the title is the only thing you can tell your readers what
	your contribution was about.

> When calling the Git Credential Helper that is set in the git config,
> the get command can return a credential. Git immediately turns around
> and calls the store command, even though that credential was just
> retrieved by the Helper. 

Good summary of the current behaviour.  A paragraph break here would
make the result easier to read.

> This creates two side effects. First of all,
> if the Helper requires a passphrase, the user has to type it in
> twice.

Hmph, because...?  If I am reading the flow correctly, an
application would

 - call credential_fill(), which returns when both username and
   password are obtained by a "get" request to one of the helpers.

 - use the credential to authenticate with a service and find that
   it was accepted.

 - call credential_approve(), which does "store" to all the helpers.

Where does the "twice" come from?

Ah, that is not between the application and the service, but between
the helper and the user you are required to "unlock" the helper?

OK, that wish makes sense.

It does not make much sense to ask helper A for credential and then
tell it to write it back the same thing.

HOWEVER.  Let me play a devil's advocate.

The "store" does not have to necessarily mean "write it back", no?

Imagine a helper that is connected to an OTP password device that
gives a different passcode every time button A is pressed, and there
are two other buttons B to tell the device that the password was
accepted and C to tell the device that the password was rejected
(i.e. we are out of sync).  "get" would press button A and read the
output, "store" would press button B and "erase" would press button
C, I would imagine.  With the current credential.c framework, you
can construct such a helper.  The proposed patch that stops calling
"store" unconditionally makes it impossible to build.

> Secondly, if the user has a number of helpers, this retrieves
> the credential from one service and writes it to all services.

It is unclear why you think it is a bad thing.  You need to
elaborate.

On the other hand, I can think of a case to illustrate why it is a
bad idea to unconditionally stop calling "store" to other helpers.
If one helper is a read-only "encrypted on disk" one, you may want
to require passphrase to "decrypt" to implement the "get" request to
the helper.  You would then overlay a "stay only in-core for a short
time" helper and give higher priority to it.

By doing so, on the first "get" request will ask the in-core one,
which says "I dunno", then the encrypted-on-disk one interacts with
the end-user and gives the credential.  The current code "store"s to
the in-core one as well as the encrypted-on-disk one, and second and
subseqhent "get" request can be served from that in-core helper.

	Side note: and the "store" to encrypted-on-disk one may not
	even need passphrase, even if "get" from it may need one.

"We got the credential from some helper, so we won't call store"
makes it impossible to build such an arrangement.

The above is a devil's advocate response in that I do not mean to
say that your proposed workaround does not solve *your* immediate
need, but to point out that you are closing many doors for needs
other people would have, or needs they already satisfy by taking
advantage of the current behaviour the proposed patch is breaking.

So, I dunno.  I certainly do not think it is a bad idea to stop
feeding _other_ helpers.  I also do not think it is a good idea to
unconditionally stop calling "store" to the same helper, but I can
see the benefit for having an option to skip "store" to the same
helper.  I am not sure if there should be an option to stop feeding
other helpers.

Thanks.
