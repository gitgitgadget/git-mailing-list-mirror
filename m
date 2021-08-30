Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AE4C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BBD660FA0
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236222AbhH3VEf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 17:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236009AbhH3VEf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 17:04:35 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F5DC061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 14:03:40 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id i6so23652977edu.1
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 14:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=S0OjUEBv1INLX1R5YGdIM+AaeQxPLeIPEk3+L5xcDbg=;
        b=adMbmY7Fs/GTaDvCrIjwTerd990INr0+AksVLGfAtGZ8GY62i3UQL9/CnfGA0OSlv4
         4W9vXpeBW5yMR/lKnFfLQlO619yq+G/2K5z0aDGkQafWWwKF/jUp4DZ6Hg08M9wzaLJr
         zsefeewqtLNSnN12ftXnhSrsBQlM68ozJIui3pYAnSpXNttL2C1REXnNrXmFF6CGywic
         a4V0tNGpcDE8KOYFDvkGD2I0s0WFfvQGEmTOyJLsKFjDIRW2OZKvWHVyXqWeAFFrgRxN
         U+sXdv8rOuhC9Lyj0BoSxEh5a5D3/WXJu4a8n/g5JNwVXYmVlx+YKr4BOTO6mvlIsgRK
         MBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=S0OjUEBv1INLX1R5YGdIM+AaeQxPLeIPEk3+L5xcDbg=;
        b=DNc+Rd1a/6wBOq+Pxecnw86cqa9ZVWmff+6BGI5oD9M/Ru7vIZvL2784Enj4FIzs9h
         Gnm66w21oHnF+fipXRd2mzhHYwfLlIGhM5g1GXoN45KL2AfYJnigY+skU6N4tFre2vnA
         QrsAfk3h7Qd1Wg8UdlgCDoYJ5V2eg0icZl2YpDT/Bj5S5p1rnrZg3vIaji4yRCqJEyFc
         8dRY4n8dJAyKRm5zzxnPPlEoeUQkLyOjMfIBlwwkrBi5IZ0rySz7vHNATpI5ES1VW6Gk
         wBKG8LLyoIAkpLeeGJ1hjD9xBYPBNRyRtTRXI0BXgzN3bJm21nxd5OM7/wWehomzxhTu
         Rpwg==
X-Gm-Message-State: AOAM532r7JG79+Te7qz2eGpPNzaYKzSVSzRLgJ5Re88qNuyn3bxSzDBN
        O95SmFV5Ecb/IXsMjzFjIf8=
X-Google-Smtp-Source: ABdhPJwxttJoKA5oMiwEiaLzE+7sFkRxePAsnBSjXlY8DDXh6e9ltLKtzdEMAX3Fj0HNOWHgVkFj1A==
X-Received: by 2002:aa7:c882:: with SMTP id p2mr16653264eds.46.1630357419281;
        Mon, 30 Aug 2021 14:03:39 -0700 (PDT)
Received: from szeder.dev (84-236-78-211.pool.digikabel.hu. [84.236.78.211])
        by smtp.gmail.com with ESMTPSA id v24sm8056868edq.79.2021.08.30.14.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 14:03:38 -0700 (PDT)
Date:   Mon, 30 Aug 2021 23:03:36 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: What's cooking in git.git (Aug 2021, #02; Tue, 3)
Message-ID: <20210830210336.GJ23408@szeder.dev>
References: <xmqqfsvpr8t5.fsf@gitster.g>
 <87wnp1mqv2.fsf@evledraar.gmail.com>
 <xmqq4kc5ozi7.fsf@gitster.g>
 <87lf5hm0v7.fsf@evledraar.gmail.com>
 <20210804212825.GH23408@szeder.dev>
 <87fsvon5xm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87fsvon5xm.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 05, 2021 at 01:06:55AM +0200, Ævar Arnfjörð Bjarmason wrote:
> > I don't think that in this case we should aim for future proofing when
> > the cost is the additional cognitive load of yet another helper
> > function.  I would instead prefer to go with the really trivial fix
> > for now and wait whether this issue pops up again with other shell or
> > terminal, hoping that this issue is a "one-hit-wonder" [1] and it
> > won't happen ever again.
> 
> ...I'd be happy to remove the helper if Junio would take that version of
> the patch; :)

I have to agree with Junio here: setting 'GIT_TEST_COLUMNS=
COLUMNS=80' for each affected command like the first patch did was
just too ugly.

> But in the topic of the overall approach, I think it's worth
> future-proofing here mainly because it's useful to be able to reliably
> run "make test" on old commits for bisecting, which is a property we
> mostly manage to uphold.
> 
> By narrowly targeting a fix at one specific shell's cleverness around
> COLUMNS we'll leave open a window where we'll fail on other shells if
> they introduce similar cleverness.
> 
> It hardly seems like a stretch that once bash starts doing that sort of
> thing other shells might think to follow suit, and all have their own
> non-standard way to turn it off.

Bash has a lot of non-standard features that other shells decided to
avoid, even when they are really useful and unconroversial.  To me it
does seems like a stretch that other shells will follow suit with
COLUMNS, when our first reaction to Bash's changed behavior was that
it's buggy.

> You also didn't address the other rationale for it, namely that it's
> also future-proofing us for submarine breakages in non-git programs
> which'll understand the new COLUMNS=10, but not GIT_TEST_COLUMNS=80.
> 
> I.e. should our tests rely on their output, and those programs
> themselves change how they treat e.g. COLUMNS v.s. TIOCGWINSZ any tests
> relying on their output will change their behavior.

I occasionally scan through the test logs looking for any new
suspicious error messages from non-git commands and shell builtins, and
to find those error messages I had to collect the list of non-git
commands [1] executed in the test suite:

  awk|basename|cat|chmod|cmp|comm|curl|cut|date|dd|diff|dirname|egrep|env|envsubst|expr|fgrep|find|getfacl|gettext|grep|gunzip|gzip|head|hostname|iconv|id|jgit|kill|ln|mkdir|mkfifo|mktemp|mv|perl|readlink|sed|setfacl|sleep|sort|tail|tar|touch|tr|uname|uniq|unzip|wc|xargs|xmllint|zipinfo|

Most of these are fairly low-level system commands, where supporting
COLUMNS in any way wouldn't make sense at all, or, worse, would be a
serious regression.  Commands like 'curl', 'gunzip' or 'gzip' could
show a progress bar matching the width of the terminal, but our tests
should never rely on something like that, ever.  Then there is 'jgit'
which could support COLUMNS for output intended to the user, just like
git does, but, again, our tests should never rely on that.


[1] It's an incomplete list, e.g. 'cp', 'ls', and 'rm' are
    intentionally left out, because they are too often used in cases
    when they can legitimately fail.

