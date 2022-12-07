Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99901C63703
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 23:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiLGXze (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 18:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiLGXzc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 18:55:32 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B998B39B
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 15:55:31 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id mg21-20020a17090b371500b00219767e0175so26316pjb.1
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 15:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1w1AVju41zfF4K3VlKpHGpQGzfA4nuSBMRMs+gxcYN4=;
        b=rTkitGHzIDsfkisjlw+UXGTH1JQzLle+bR1pxN+cNizGtr1QL+AwbVOtf0okmOtVXK
         JU5Mhhp5W8nbuuF+iRmcBM9FrfKIzNtHvLr9eHwaKhZ/bbJxdzLFOo+PJDxcYwqPyW8L
         Qua87vBuJVoLN1L3U367GsOq+Dw8RX3w+5RWc2Ta/yTuIwLY7X4F+Yp738wizL6SuGtz
         h1sVL/4oj16rDp/SfWIiVxe1c3T2NwWAN+xOPK34gRruIN7MwdW8ynQXsKET+zdPRP/J
         7LpZFk6ph3Q7ruL3TXMSGgu8tA+eDvZfhrIkOlEh4D9BC4pGEDkpdHZXvJv+tmX0LeE9
         LnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1w1AVju41zfF4K3VlKpHGpQGzfA4nuSBMRMs+gxcYN4=;
        b=lrNAeau5++i7V1dEJP4Ne9M9egbtJYxg16hvz+atc0FIco/mS+R6OsFHJgM0XqSHGD
         GnUF7040mjmK/O2DCLzVw9K6bC32pTWSEp+MpXOyD56WJCOl7FeBru85zmbuOVkN8xtF
         8IDaQF1SKQlsUr82HLEyUbDxONstUAMfDCoYxXqBbq2DPQD5wpEuXP1scB7juhV0OwD/
         wHZNOLGxZdnR971gALi65QPvcvZ4dg+Z7CYIm0kLonPkTR4NHHeTgVf3HwLRBR0FclOK
         sN2xBkOkVcEZz6WOrfC6nP+bAIdCAbW4qCwEi8gjfpAgZQK2iue+A2jjOrqkm8MkcUWw
         zbnw==
X-Gm-Message-State: ANoB5pkbYHIaUU1y7KAXqbFkxF28W02IDlLw7UyPBHNG8KVXFe6xqW17
        FeqHPEBAIRSDb7Wg+piGr7D78yCbf64EGA==
X-Google-Smtp-Source: AA0mqf5VpkspNA47yzph4VJuB5wGaq41egcFvaWsMuqGOuNrTOSO97tJizuQNH6zw1+OB2jLqSRaR5GTQIFhAg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:f89:b0:219:5b3b:2b9f with SMTP id
 ft9-20020a17090b0f8900b002195b3b2b9fmr3982290pjb.2.1670457330632; Wed, 07 Dec
 2022 15:55:30 -0800 (PST)
Date:   Wed, 07 Dec 2022 15:55:21 -0800
In-Reply-To: <20221127093721.31012-1-sorganov@gmail.com>
Mime-Version: 1.0
References: <20221127093721.31012-1-sorganov@gmail.com>
Message-ID: <kl6lilimepli.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 0/5] diff-merges: more features
From:   Glen Choo <chooglen@google.com>
To:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We covered this series in Review Club, thanks for coming Sergey! For
those who are interested, the notes are here:

  https://docs.google.com/document/d/14L8BAumGTpsXpjDY8VzZ4rRtpAjuGrFSRqn3stCuS_w/edit?usp=sharing

and reviewers will send feedback to the list separately anyway. I mostly
had comments on the design, so I'll leave most of my comments here.

Commenting on the cover letter as a whole, on first read, it wasn't
obvious to me what this series was trying to achieve because the CL
presents the 5 patches individually instead of a cohesive story. From my
understanding, the story is as follows: we want '-m' (enable
diff-merges) to also imply '-p', but we can't just change the default
behavior, so we do the following instead:

- Add a config option that gives the behavior that we want (2/5).
- Deprecate '-m' by giving '--diff-merges=on;hide' as a synonym and
  encouraging users to use that instead (1,4,5/5).

Patch 3/5 is completely separate. There was some resistance to it during
Review Club, but if we still want this, it might be worth splitting off
into its own series so that we can keep the discussions separate.

During the discussion, it also appeared that this "modification of '-m'
semantics" refers to a patch that changed the default but got reverted
due to breaking legacy scripts. It would be extremely useful to include
a link to that previous patch and the discussion around its revert,
especially given the discussion about whether users actually need
'-diff-merges=hide' ([1] and elsewhere).

[1] https://lore.kernel.org/git/CABPp-BHaPpQdO-uBT6ENHAM1Y-c=SBxktH-S_BTtxJvfd1qSpw@mail.gmail.com/

Sergey Organov <sorganov@gmail.com> writes:

> 1. --diff-merges=[no]-hide
>
> The set of diff-merges options happened to be incomplete, and failed
> to implement exact semantics of -m option that hides output of diffs
> for merge commits unless -p option is active as well.
>
> The new "hide" option fixes this issue, so that now
>
>   --diff-merges=on --diff-merges=hide
>
> combo is the exact synonym for -m.
>
> The log.diffMerges configuration also accepts "hide" and "no-hide"
> values, and governs the default value for the hide bit. The
> configuration behaves as if "--diff-merges=[no-]hide" is inserted
> first in the command-line.

I had the same concerns as Elijah, which is that this behavior is
probably clearer as a separate flag (like "--hide-diff-merges"), which
is more consistent with how '--diff-options' is used today, which means
that:

a) it is easier to explain to users
b) the implementation is simpler (I'll comment on Patch 1 code
   separately)
c) it makes Patch 4 obsolete

But I'm not convinced that we actually want this behavior at all. I
don't see why a user would use a flag that says "do nothing unless
other flags are given". I don't find the 'alias use case' compelling,
because the user still has to choose whether to pass '-p', so at that
point they could just add a different alias.

I haven't dug through the code/ML to figure out whether '-m' requiring
'-p' was an intentional feature or not, but if you could find the old
thread where you changed the default (and it got reverted), that would
help the discussion a lot :)

> 2. log.diffMerges-m-imply-p
>
> Historically, '-m' doesn't imply '-p' whereas similar '-c' and '--cc'
> options do. Simply fixing this inconsistency by unconditional
> modification of '-m' semantics appeared to be a bad idea, as it broke
> some legacy scripts/aliases. This patch rather provides configuration
> variable to tweak '-m' behavior accordingly.

I thought that Junio's suggestion to implement a flag that acts like
'-m' with '-p' [2] was quite a good one (maybe '-M' or
'--diff-merges=show'), since I think that very few users would actually
set this config, but the ones that would actually use it can just
replace '-m' with '-M'.

[2] https://lore.kernel.org/git/xmqqfse37c0n.fsf@gitster.g/

> 3. log.diffMergesForce
>
> Force specific log format for -c, --cc, and --remerge-diff options
> instead of their respective formats. The override is useful when some
> external tool hard-codes diff for merges format option.

This might be better off as its own series, since the change isn't
related to '-m', but I'm worried about the precedent that this sets.
To my knowledge, CLI options always overwrite config, but this is the
opposite. I would prefer not to do this, especially if the use case is
to work around an external tool (since it is arguably the tool that is
broken).

> 5. Issue warning for lone '-m'.
>
> Lone '-m' is in use by scripts/aliases that aim at enabling diff
> output for merge commits, but only if '-p' is then specified as well.
>
> As '-m' may now be configured to imply '-p' (using
> 'log.diffMerges-m-imply-p'), issue warning if lone '-m' is specified,
> and suggest to instead use '--diff-merges=on,hide' that does not
> depend on user configuration.
>
> This is expected to give a provision for enabling
> log.diffMerges-m-imply-p by default in the future.

Since '-m' without '-p' is a mistake in most cases, I wonder if we
should just emit this warning today (maybe via the advise() API). Even
if we don't keep '--diff-options=hide', deprecating lone '-m' and giving
a warning seems good to keep.
