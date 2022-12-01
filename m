Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F2AC4321E
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 09:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiLAJgs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 04:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiLAJgq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 04:36:46 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D685EFA8
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 01:36:43 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id d6so1583962lfs.10
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 01:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+f0JQ6X5nf7k0ZL93P6pSFgn2/Dw3y6orFmn16bJ4TE=;
        b=JOXXBMsp8pZbV0rv5w+HpwJcz2kTBtrpM7czyhxpnImIRi4l4zVfTkmIyo6fYGbeoN
         H2lpnnzF6JSPYXf8ZqyVuUx9sdUVSt1vuNaAlWoFZGS6jGH1PNqbS3P1UuvQww/m8ebY
         OEUAW//8t7Vct6VkGzEGGjfk3jRbjI/DAkmJ7wVA57i+ePeGYbZkj3SNFTSsbykOAFgb
         g/4aH2M05pOQ12BKJra3HbPiBvg2/oSdrNQ25fmZteHWkLlb6MdBkGkkD9ga3SybrMv/
         rx01kRUWzSg2MH4OhTPPCXbe+fbW/bOYZZshASAF1G+XTIEFdknc+Yi5YVIk06tN9N57
         FpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+f0JQ6X5nf7k0ZL93P6pSFgn2/Dw3y6orFmn16bJ4TE=;
        b=7kpKzB23AmwfMdaLwqJzHKs2O2a78RdnrOqUcWgqQk/ct2aqL2omBavAeosG8KacQa
         q+dMnvmWQL8xOrttYRYLGV+tyvIpxO2J+ALIOy5bgkC4oJnw44ZTCMxTWbbfT9TpmMKu
         qDO1zXShfj3iN9OgW55/VflF+YKB+8R4OHQ/NzyXDu110NbunoTUgagIVtoDVnJ6Xj9Q
         UDf5EMN89LRVYLfQVSCaFlSVoE7olU265v/q1uY9JWINhYW4b5DDU6n84LYgLah6SJ3Q
         Jcfjjye9nN7RQHhzBYNtLE49pAvLTtUjPNqmXsQXkVysqIlsIshLaMTeSb9dyO2H0xIE
         Khog==
X-Gm-Message-State: ANoB5plapTrztjlhqVkhybodydWXEiCe8/91KBY224fksF8uH2u0F1+3
        hvN6NUa7rw777bPRSZkfAmzml+KUioQ=
X-Google-Smtp-Source: AA0mqf7CGrYmuxtmLhk3m1Cqwbvz7bTEAFPJCAuMZL6IM5cuTh5I8bH29k22VWiKuHAfoC6eGFwPDg==
X-Received: by 2002:a05:6512:2c86:b0:4a2:6df5:edb9 with SMTP id dw6-20020a0565122c8600b004a26df5edb9mr17391018lfb.675.1669887401736;
        Thu, 01 Dec 2022 01:36:41 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u11-20020a05651206cb00b0049464d89e40sm579504lff.72.2022.12.01.01.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 01:36:41 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/5] diff-merges: more features
References: <20221127093721.31012-1-sorganov@gmail.com>
        <CABPp-BHaPpQdO-uBT6ENHAM1Y-c=SBxktH-S_BTtxJvfd1qSpw@mail.gmail.com>
        <87lenstwfh.fsf@osv.gnss.ru>
        <CABPp-BEY-Xma8=MbXpw+En7TayzhYOmYYAHD6hudOQv=GnOT=Q@mail.gmail.com>
Date:   Thu, 01 Dec 2022 12:36:39 +0300
In-Reply-To: <CABPp-BEY-Xma8=MbXpw+En7TayzhYOmYYAHD6hudOQv=GnOT=Q@mail.gmail.com>
        (Elijah Newren's message of "Wed, 30 Nov 2022 18:21:00 -0800")
Message-ID: <875yevh3dk.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Wed, Nov 30, 2022 at 5:16 AM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:
>>
>> > On Sun, Nov 27, 2022 at 1:37 AM Sergey Organov <sorganov@gmail.com> wrote:
>> >>
>> >> 1. --diff-merges=[no]-hide
>> >
>> > This seems problematic to me.  Currently, all the options to
>> > diff-merges are exclusive of each other; the user is picking one of
>> > them to determine how to format diffs for merges.  Now you are
>> > introducing the ability to combine various options, leading users to
>> > think that perhaps they can run with all three of
>> > `--diff-merges=combined-dense --diff-merges=remerge
>> > --diff-merges=separate` or other nonsensical combinations.  Shouldn't
>> > this [no-]hide stuff be a separate flag rather than reusing
>> > --diff-merges?
>>
>> Yes, it's a precedent indeed, but I don't see any actual problem here.
>> Unlike git silently dropping changes on rebase, this can cause no
>> damage.
>
> Sure, read-only options for querying things won't cause future damage.
> That doesn't mean that the UI for commands like diff/log/grep/etc are
> unimportant, though, and certainly doesn't excuse intentionally
> creating bad UI for them.

I just don't see it as a bad UI, sorry.

>
>> I think I can emphasize that we now have "formats" and "flags"
>> in the documentation, where "formats" are mutually exclusive (the latest
>> specified wins), while "flags" are cumulative.
>
> Why not just give it a different flag name, so that "formats" and
> "flags" are clearly separated without even needing a lengthy
> explanation?  That'd be much simpler to understand and explain.

What I did is the best I was able to think of. The --diff-merges
introduces namespace for everything related to formats of output of
diffs for merge commits, and 'hide' fits there perfectly. User doesn't
need to look elsewhere to figure entire set of capabilities.

I honestly don't see how to improve the UI by introducing yet another
option, especially provided the letter has its own drawbacks.

>
>> >> The set of diff-merges options happened to be incomplete, and failed
>> >> to implement exact semantics of -m option that hides output of diffs
>> >> for merge commits unless -p option is active as well.
>> >>
>> >> The new "hide" option fixes this issue, so that now
>> >>
>> >>   --diff-merges=on --diff-merges=hide
>> >>
>> >> combo is the exact synonym for -m.
>> >
>> > Why is completeness important here?  Perhaps I should state this
>> > another way: when would users ever want to use this new "hide" option?
>> >  I got through your cover letter not knowing the answer to this, but
>> > was hoping it'd at least be covered in one of your commit messages or
>> > documentation changes.  Maybe it was there, but I somehow missed it.
>> >
>> > Is the only goal some sense of developer completeness for these
>> > options, or are these end-user-facing options of utility to actual end
>> > users?  I'm hoping the latter, but if so, can that be documented and
>> > explained somewhere?  I'm pretty sure this is explained somewhere in
>> > an old mailing list discussion, but where?
>>
>> Completeness is essential as I want '--diff-merges' to provide all the
>> needed capabilities, and one of them was actually missing, that is there
>> in the '-m' semantics, exactly as I said in the descriptions.
>
> I ask you why a user would want to use this option, and you simply
> assert that it's a "needed capabilit[y]"?  Could you explain *why*
> it's needed or helpful for users instead of just repeating the
> assertion that it is needed?

I'm trying to explain that the use-case(s) is(are) at least the same as
for existing '-m' option, and '-m' is used in practice, so it must be
useful, right? Who am I to judge? So I don't.

For me one of the goals is to let people replace '-m' in scripts/aliases
with '--diff-merges=on,hide' and eventually let '-m' behave better as a
short user option, similar to '-c/--cc/--remrege-diff'. And then it
might happen that 'hide' is actually useful elsewhere (see below for a
try), as it often happens once particular functionality is properly
factored out of given use-case.

> If I can't figure out why it's needed or useful for users despite
> having read your cover letter, commit messages, underlying source code
> and documentation, and this full thread, then there may well be
> something wrong with me...but it seems likely that many users will
> also have difficulty figuring out why this option is useful.

Then they are still free not to use it, and I doubt they will try to
find why it's useful in the commit messages anyway, so do we need to put
something into the documentation then? What do you suggest in addition
to the functional explanation of the 'hide' that is already there?

That said, what comes to mind, as a use-case, I figure you might try to
define an alias for 'diff log' that will use 'remerge' format by default
once diffs are requested using '-p':

$ git config alias.lr 'log --diff-merges=remerge,hide'

and check if this 'git lr' is useful.

Thanks,
-- Sergey Organov
