Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EFFC433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 09:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbiBAJvv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 04:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbiBAJvu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 04:51:50 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA975C061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 01:51:49 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a8so52174930ejc.8
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 01:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=AbQexgpbrDtu5u9LxK/S0fyLCVE+/NB+JFPzYh4u608=;
        b=Arn0fxppJbbvoq7rEyX7+Qq3jDHl3aEjzNcAaqt/0rxyCn3N6DNpmW3w//tGyfHkJu
         lzTQ0rGOPS0MouOmgiaZ/mMsw7IbvCMDplHT42GJaXJhJyNzbS43bcfegFiDVhaX00nj
         PWeQ5rrlMkECPeevkTTe/VDsj46OkVICKsznHJgMGm9YXrp60wsqUt9yZ2YqOgIHePie
         9YD2NJkSM35rYWPKZJuiommygEXT/EpvWJ5ew7VRy4j7vLRiBwud3DDZe1CikzCz9zpK
         n2Ig1Ed0B6+rNA8SKe6WLaZ7DCTfPwAL1OuY/2KF7yi38a2PTvxCGOMo2nRxWGAWLmdr
         Uqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=AbQexgpbrDtu5u9LxK/S0fyLCVE+/NB+JFPzYh4u608=;
        b=gqIhU4Jt3TIeec5IHgrif6wIQEptE0qj1ec8ILhtEEo7rdq4gb7phmPqAG1sUIscty
         VmGUdq/bfABSY1j4Rr1BvbYgBZY0/JE8OVhF+CbDuLhZ3BjnACUA7SYioKbaiyWGyNIb
         Gend2Rf2O6qEBPuQNUXievz6dgOoee77rjbyvfulWzi0ZJHcrXSah/iPPF6k8FYK71YK
         yOMlwnKMNgmQ82YUY3efhWm9vBjBZryPdspauZvkWRUYDOrRteeIosj54kDd/aIyH6IX
         J1mhbTBdTfYl+LlN5viz3fCHhPUzsTJlDAbSuqrt4VyvAzGvUurlv3W5TUloIcGNrkBn
         Bymw==
X-Gm-Message-State: AOAM530Cfp5dMcH4ASku4mJdAhtSrq38KzWT1oMkL1ENTpIiGnFGKAPk
        LigwX0fsy6LANbB57iWNipQ=
X-Google-Smtp-Source: ABdhPJw8CJG3FeU4JldC4wnqki7ga408rjeh/X+12FcZ7xMDm1/3t57rCEOm5h+kCHZSPTBISLqN0g==
X-Received: by 2002:a17:907:728b:: with SMTP id dt11mr19913518ejc.70.1643709108312;
        Tue, 01 Feb 2022 01:51:48 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id cf25sm15757797edb.63.2022.02.01.01.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 01:51:47 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nEppC-003ya7-G5;
        Tue, 01 Feb 2022 10:51:46 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        John Cai <johncai86@gmail.com>, git@vger.kernel.org,
        me@ttaylorr.com, phillip.wood123@gmail.com, e@80x24.org
Subject: Re: [RFC v3] cat-file: add a --stdin-cmd mode
Date:   Tue, 01 Feb 2022 10:48:38 +0100
References: <20220128183319.43496-1-johncai86@gmail.com>
 <56f851f3-946b-0524-1643-25799ef46b55@gmail.com>
 <xmqqpmo7ix0l.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqpmo7ix0l.fsf@gitster.g>
Message-ID: <220201.86r18map8t.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 31 2022, Junio C Hamano wrote:

> Bagas Sanjaya <bagasdotme@gmail.com> writes:
>
>> On 29/01/22 01.33, John Cai wrote:
>>> Future improvements:
>>> - a non-trivial part of "cat-file --batch" time is spent
>>> on parsing its argument and seeing if it's a revision, ref etc. So we
>>> could add a command that only accepts a full-length 40
>>> character SHA-1.
>>
>> I think the full hash is actually revision name.
>
> There is no entry for "revision name" in Documentation/glossary-content.txt
> ;-)
>
> But to John, if you have a loop that feedseach line to get_oid(), 
>
> 	while (getline(buf)) {
> 		struct object_id oid;
> 		if (get_oid(buf, &oid))
> 			warn and continue;
> 		use oid;
> 	}
>
> is it much slower than a mode that can ONLY handle a full object
> name input, i.e.
>
> 	while (getline(buf)) {
> 		struct object_id oid;
> 		if (get_oid_hex(buf, &oid))
> 			warn and continue;
> 		use oid;
> 	}
>
> when your input is restricted to full object names?
>
> get_oid() == repo_get_oid()
> -> get_oid_with_context()
>    -> get_oid_with_context_1()
>       -> get_oid_1()
> 	 -> peel_onion()
> 	 -> get_oid_basic()
> 	    -> get_oid_hex()
> 	    -> repo_dwim_ref()
>
> it seems that warn_ambiguous_refs and warn_on_object_refname_ambiguity
> we would waste time on refname discovery but I see cat-file already
> has some provision to disable this check.  So when we do not need to
> call repo_dwim_ref(), do we still spend measurable cycles in this
> callchain?

For what it's worth I think this claim that we spend a non-trivial
amount of time on the difference between these two comes from me
originally. I'd had a chat with John about various things to try out in
such a "cat-file --batch" mode, and this was one of those things.

I tried instrumenting the relevant code in builtin/cat-file.c the other
(but forgot to reply to this thread), and whatever I'd found there at
the time (this was weeks/months ago) I couldn't reproduce.

So there's probably nothing worthwhile to check out here, i.e. the
trivial cost of get_oid_with_context() is probably nothing to worry
about.
