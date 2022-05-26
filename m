Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F795C433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 10:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245664AbiEZKat (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 06:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbiEZKap (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 06:30:45 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A865BC6E4A
        for <git@vger.kernel.org>; Thu, 26 May 2022 03:30:44 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id t26so1313686edt.0
        for <git@vger.kernel.org>; Thu, 26 May 2022 03:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=eYHeuqYQZWSHKuEBLxHQh+TNwhBFwHK70MWmIsQHA1M=;
        b=Fp3PzVmL/VVi9LKIjY+JEc90c3fue90x3XdUo9UOexLvI4xOft/q8lc5UOrmRXabWY
         IqH7RD/p81pb/h+ujkGYx2fsR83U3SgdmeyrIfBRDxR/swOL2sW0+rKjj4yDQBoFYh6d
         jkdM/+UTx32z9Ic2GF3pFOMlkzYoqEcXDkJ3IMqS2XwTjAVYNjzETRJf624SPqtgzwls
         Ls8Zw3RwNbt5sIBqjsIcGp5rJ+3v9Wl+Xko7csxc6DqFQFDFVzkJlLJNKLfGbAuESAB8
         Co6iN08UBYYiKMwybvmMfBcSUTMAJIANQhALiqsK9QZzOKQFPTvcfUmfoXas3LEtqTIx
         QAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=eYHeuqYQZWSHKuEBLxHQh+TNwhBFwHK70MWmIsQHA1M=;
        b=N8yDgtlxOcBnOUe/pttmV8rJSKJ9xU9dbWY+5CbLTJHiubRSofcMSPChzIzRWL9frV
         DidqsuB0mmXO0QI1m/sCWL2R03BIF0+37rR74SRDEntxcrLo8fR7L4vXQSZM+JEbo4Yd
         pPWnuFHRUAkfDHuGNRfejizQHKQ6cQKWFLg6/a/k1pn4hYeU6gnenjQRsPHSP/MNAkY9
         gwTlhS7pGxqylQXBjgMDHUFooHUCDPDd+MZks4nIrXhJqxcYqhEXiRw0bqSZNAy2IFfo
         jP3n6kLwG3RBXQfhm3EO8tdQatufCzQ4T4rKPesW/DMCKi3wcNvDT2NMChdtDgbDWmlx
         oAQA==
X-Gm-Message-State: AOAM532rl9Ht2jr4XiS6M96DPt6gmYP2qGkFcHEjPCDOqDAdE0ndCJGV
        bqac68Mr+wdk+QRC/cD8TqtBfLLd6018DQ==
X-Google-Smtp-Source: ABdhPJzpw9tsE3nuIZbmoGNeWg890exyDBzlGOhfWA+TPpBrdFWOlX1pYbR6wETbwbnr4Vlf/a7BDw==
X-Received: by 2002:a05:6402:1341:b0:42a:f7cb:44dc with SMTP id y1-20020a056402134100b0042af7cb44dcmr38329230edw.165.1653561043197;
        Thu, 26 May 2022 03:30:43 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id t19-20020a056402525300b0042617ba638esm650171edd.24.2022.05.26.03.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 03:30:42 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nuAlN-000CJO-LB;
        Thu, 26 May 2022 12:30:41 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 0/8] hook API: connect hooks to the TTY again, fixes
 a v2.36.0 regression
Date:   Thu, 26 May 2022 12:16:23 +0200
References: <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com>
 <nycvar.QRO.7.76.6.2205251308381.352@tvgsbejvaqbjf.bet>
 <xmqqbkvl8s88.fsf@gitster.g> <xmqqczg13xpy.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqczg13xpy.fsf@gitster.g>
Message-ID: <220526.86pmk060xa.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 25 2022, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Absolutely.  I wonder how involved is would be to revert the merge
>> of the whole thing from 'master'.  It may give us a clean slate to
>> rethink the whole mess and redo it without breaking the existing
>> users' hooks.
>
> I tried the revert, and the result compiled and tested OK, but I am
> tempted to say that it looks as if the topic was deliberately
> designed to make it hard to revert by taking as much stuff hostage
> as possible.

No, it's just that...

> At least one fix that depends on the run_hooks_opt structure
> introduced by c70bc338 (Merge branch 'ab/config-based-hooks-2',
> 2022-02-09) needs to be discarded.  7431379a (Merge branch
> 'ab/racy-hooks', 2022-03-16) did address an issue worth addressing,

...we've made some use of the API since then, including for that bug
fix...

> so even if we revert the whole c70bc338, we would want to redo the
> fix, possibly in some other way.  But it also needed an "oops that
> was wrong, here is an attempt to fix it again" by cb3b3974 (Merge
> branch 'ab/racy-hooks', 2022-03-30).  The situation is quite ugly.

...although for that last one if you're considering reverting that fix
too to back out of the topic(s) it should be relatively easy to deal
with that one.

> As you hinted in the message I responded to in the message I am
> responding to, if we can make a surgical fix to make the new and
> improved run_hooks_opt() API build on top of run_command(), instead
> on top of run_processes_parallel(), that would give us a cleaner way
> out than discarding everything and redoing them "the right way".  At
> least, the external interface into the API (read: the impression you
> would get by "less hook.h") does not look too bad.

I have a pending re-roll of this topic structured the way it is now (but
with fixes for outstanding issues).

I understand your suggestion here to use the non-parallel API, and the
reluctance to have a relatively large regression fix.

I haven't come up with a patch in this direction, and I'll try before a
re-roll, but I can't see how we wouldn't end up with code that's an even
larger logical change as a result.

I.e. this would require rewriting a large part of hook.[ch] which is
currently structured around the callback API, and carefully coming up
with the equivalent non-parallel API pattern for it.

Whereas the current direction is more boilerplate for sure, but keeps
all of that existing behavior, and just narrowly adjust what options we
pass down to the "struct child_process" in that case.

I can try to come up with it (and delay the current re-roll I have
that's almost ready), but I really think that reviewing such a change
will be much harder.

The current proposal is large by line count, but it's relatively easy to
skim it and assure oneself that a new parameter is being passed in, and
that all the proposed behavior change applies only to the one caller
that passes in that new parameter.

Whereas switching to a new non-callback based API will require carefully
going over the parallel API line-by-line, assuring oneself that the
non-callback version is really doing the same thing etc.
