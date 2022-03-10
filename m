Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C48C433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 20:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245304AbiCJUl2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 15:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245280AbiCJUl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 15:41:28 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E642610F23A
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 12:40:25 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 17so7315597lji.1
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 12:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DpgCO9HF0Q6evPL5AZJBw8h8541nUmZZSNoHLPsnbSU=;
        b=ZrCs/Sfxx4UAc4Y4QnFlOUkFdGi+2x+0cbC1bj9zaGOB31xeEFHorgRF7SOsz8VH3u
         etxNU/jleS/lxAEY9tocs+rY4zQejlswvWOC8cvT2Utqh8FpulEvfNC78gmYZkdKicHT
         IKZKdCLqDYrKzjMSQ8EyfBcOSkCqqsoka54WE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DpgCO9HF0Q6evPL5AZJBw8h8541nUmZZSNoHLPsnbSU=;
        b=KYHYZvGzGJbtjWb9Hihr7gBYyWKjspwSAPncORAXQ0vk22bm27UPET8WdvteQR4N1t
         eruWmQwp2H9v9NGtsFB1I/I/wQW8THbv86ttQQlkYmNe4wUlsr29zrzFyLwPoibP1Baa
         Y1gGkKsV8d/+4F4JY4bCkPj39kdQmh82dAeM1e/HrUhhVMkCHehmfRvAL2v3ykPeKnqh
         QKBX0uw45fV/YDSzaJeT6P6/N14D0NzLQQKorFKB+6ZPEZpneNQxIlolJOP3WwRuSuE6
         Yf7uvzENjnAiRLrEmC2lWNkBfyeIAZQaadD5t0gmjTVoqDV+ndlo+/7Ij5L6uPnuJ1jm
         T8lg==
X-Gm-Message-State: AOAM531483rtnaq3gKjArXd3QFt38iXDKlRGVKKc1oQ0dTg05jDozV5Q
        4qJghFIDoWQccGnyfT1MYZbJc0y3vmzSCetXbRM=
X-Google-Smtp-Source: ABdhPJyKUrOJXwSRwyufYf1B/eqsAsDTOFZd8sfM8eqNmhrk+51yLOTpRwynVm3HVO8e71Au4tQNOw==
X-Received: by 2002:a2e:bd08:0:b0:247:f70c:d1e4 with SMTP id n8-20020a2ebd08000000b00247f70cd1e4mr4272215ljq.68.1646944823632;
        Thu, 10 Mar 2022 12:40:23 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id k12-20020ac257cc000000b0044836dac11fsm1163711lfo.135.2022.03.10.12.40.22
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 12:40:23 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id s25so9458876lji.5
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 12:40:22 -0800 (PST)
X-Received: by 2002:a2e:924d:0:b0:246:370c:5618 with SMTP id
 v13-20020a2e924d000000b00246370c5618mr4056661ljg.358.1646944822659; Thu, 10
 Mar 2022 12:40:22 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgh8emJn-+FtxN=m_SCPiP6cGKHU-5ozzV9tWBMxn+xcA@mail.gmail.com>
 <xmqqo82dd0qv.fsf@gitster.g>
In-Reply-To: <xmqqo82dd0qv.fsf@gitster.g>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Mar 2022 12:40:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg+n_-btzoyMqnDYsJxFYAyUh0Kb=TkpS8RiD_h3G=_cA@mail.gmail.com>
Message-ID: <CAHk-=wg+n_-btzoyMqnDYsJxFYAyUh0Kb=TkpS8RiD_h3G=_cA@mail.gmail.com>
Subject: Re: RFC: Using '--no-output-indicator-old' to only show new state
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List Mailing <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 10, 2022 at 12:13 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Sounds like the "apply --no-add" in the opposite direction ;-)

I was thinking more the opposite of "--ours/theirs" when merging, but
yeah, I guess "--no-add" is technically even closer.

> I would find it handy myself, too, though I tend to read my patches
> after applying to my tree so the postimage is usually an invocation
> of "less" away for me.

Obviously just looking at the file itself is always an option, and I
do that too. But I traditionally do that "grep -v" trick as I'm
verifying the patch before sending it out (or before committing)
because it's such a nice way to limit the output just to the changed
parts.

> I do not think it is a bad idea to have an option to give only the
> postimage and another option to give only the preimage.  It would
> also trivially allow people to show the side-by-side diff in GUI.

I suspect people doing GUI's are happy just parsing the '-' and '+'
lines themselves, since they want both sides anyway.

For example, 'gitk' already has that diff/old/new checkbox, that does
exactly what my patch does.

And I doubt anybody wants gitk to re-run 'diff' just because somebody
clicked another option - it's only used to visualize the diff that was
already done differently.

Of course, I might be wrong. I didn't actually look at what 'gitk'
does. Maybe it _does_ re-run diff when you click that thing.

But that gitk behavior - which I also do use - is probably the best
way to explain the feature.  It's just that I also want to get that
"New version" behavior for plain "git diff" on the command line.

I don't know what a good command line option would be, though. I'd
like it to be somehat short, because the whole point of this is to be
a convenience feature.

So "--new/old"? "--pre/post"?

Or it could be something random, and tie it with the existing "-U"
option, where "-U+" would be "positive side only", and "-U5-" would be
"5 context lines, negative side only". Very dense and convenient,
maybe not all that intuitive?

                 Linus
