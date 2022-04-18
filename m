Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C30C433F5
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 16:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346407AbiDRQtr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 12:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345270AbiDRQtp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 12:49:45 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B6E30F49
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:47:05 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id i14so1895649ljn.5
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GxEKTfon/IFsrlv1wYLor0E5/InyRg/o2K20s5WZ2i0=;
        b=YifrG/21RB7YN71XYbqo3sIc3n+p2oyHDcg0wp9IdOP5dgH2roZuDUvxUJUZjseDj5
         1KoZp13ThtWEopeqO3Sfi2NjRwMGrsgCK8acoX0igWGqnDeQk1ttAUs1LLkXi4XMZeTp
         38IPbyauWVIwM0EAshDHnLlpAOEzoQ+/rBcEhwf2AyMnsJnhxf7Uf+pesUfUf8uWPlkr
         nliBWolbMdKs5G/MRYEBHzbmNkCQyZx0BpCBtLBsjgmLzpqKvUvqAjLSq/X9j/5P8nOp
         AGB6A+q29dsYgDaALGZdSFjbW9WL8o2Au1UWYE9Edf7OG6j9a6Tj2yHeCoOvQB4T9IS1
         xVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=GxEKTfon/IFsrlv1wYLor0E5/InyRg/o2K20s5WZ2i0=;
        b=vr7ESdSzrMbZT0vJL76okJAW0hMC8u3PdVaHIraCWdSjNIrnpEQgbx7xWQzxnSpDcB
         qq19m24GvrX0eFQAOQ/o5glTaPQzFwAo5UVDY2cNKpIqCTycNGdggkTwlPrQVCEtlbvx
         EkYnPSSkAwmdWDV8vNdJBxiI0vLMEmeRfuzFjFbSjKwfUHHEvIBhduU66v/QEx84DCyu
         TixnezyJfcomocbQwMy96J2YDGNlLpYq1/atFwQKAvvoUHlujWTKb9mLbmmiCVrUhq22
         ty7+0iX+MflbTAayzKQ4RETkN1ppvWuJwbvB4c/sCGTmZkh3xGVXDZG9W52Li7HAPEYL
         Txvw==
X-Gm-Message-State: AOAM5303sTTwa5w62JFXaL/tylny3mQwfCEqWQr3oLFflrEpczyrGoAC
        hRA6bJm5uVJbIU8H+ICvSybXdDsa2KE=
X-Google-Smtp-Source: ABdhPJy2F6rJbUunOn+Yx0GOcrzjIbcdwyvMQV4I/JgR+JwnLpgH8Qwx0jWWbsszOan3fV7y72uQWQ==
X-Received: by 2002:a2e:a90c:0:b0:24a:fe8f:595c with SMTP id j12-20020a2ea90c000000b0024afe8f595cmr7909256ljq.423.1650300423356;
        Mon, 18 Apr 2022 09:47:03 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id bi2-20020a0565120e8200b004484aaaf818sm1262677lfb.13.2022.04.18.09.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:47:02 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     git <git@vger.kernel.org>
Subject: Re: Current state / standard advice for rebasing merges without
 information loss/re-entry?
References: <CAPMMpojjs4sjKdN6DAJFSwERdjq9XQgi35CcqkXu7HijadHa1Q@mail.gmail.com>
Date:   Mon, 18 Apr 2022 19:47:01 +0300
In-Reply-To: <CAPMMpojjs4sjKdN6DAJFSwERdjq9XQgi35CcqkXu7HijadHa1Q@mail.gmail.com>
        (Tao Klerks's message of "Mon, 18 Apr 2022 13:56:38 +0200")
Message-ID: <87h76qwd8a.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tao Klerks <tao@klerks.biz> writes:

> Hi folks,
>
> The discussion around Edmundo Carmona Antoranz's recent "git replay"
> proposal ([1]) led me down a rabbit-hole reminding me I really don't
> understand where we stand with rebasing merges, and I don't think I'm
> alone.

Neither do I. Status-quo seems to be sub-optimal, or worse. I,
personally, still use 2-step merge workflow, see below.

>
> I understand the standard advice at the moment to be something like:
> ---
> Use a recent git client, use the '--rebase-merges' option (avoid the
> --preserve-merges option if you find it), and re-resolve any textual
> and/or semantic conflicts manually (possibly using rerere if you know
> what you're doing).
> ---
> Is this correct?
>
> This current state/advice seems... suboptimal, at best, because it
> ignores any information encoded in the original merge commit, as
> clearly documented in the help. It will often result in you having to
> resolve conflicts that you already resolved, *where nothing relevant
> to that merge/commit has changed in your rebase*.

This is IMHO the least important of 2 drawbacks of this method. The most
important one is that it silently drops user changes, that is major
deficiency that, e.g., forces me to split my merges into 2 commits: the
merge itself (along with formal conflict resolutions) and the semantic
fixes to the merge needed by the project. This is constant headache.

[...]

The above deficiency was the main reason of the:

> Similarly, Sergey Organov refers to a thread/discussion four years ago
> [3], largely involving a debate around two implementations (his and
> that of Phillip Wood?) that are largely theoretically-equivalent (in a
> majority of cases), with a lovely explanation of the theory behind the
> proposal by Igor Djordjevic / Buga [4], but that discussion appears to
> have dried up; I can't tell whether anything came of it, even if only
> a manually-usable "rebase a merge" script.

I still hope rebase will finally start to rebase *all* commits, at least
by default, rather than trying to re-create (some of) them out of thin
air.

I'd love to implement that myself, but unfortunately it won't happen any
time soon, sorry.

> Finally, Martin von Zweigbergk mentions his git-like VCS [5] which
> stores conflict data in some kinds of commit as part of a general
> "working state is always committable and auto-committed"
> state-management strategy; I may be misunderstanding something, but I
> *think* the resulting conflict-resolution information ends up being
> reusable in a manner theoretically equivalent to the strategy
> described by Buga as referenced above.

I still think that Git got it right by *not* storing things like that
(e.g., renaming paths / moving contents), so I'd still propose to
*rebase* merge *commits* as *content*, without any additional info being
used, if at all possible. As I wrote in the aforementioned discussion,
we should not confuse "merge-the-process" and "merge-the-result". It's
the latter, the commit, that should be rebased no matter what
particular process has been used to get to this commit, in accordance
with general Git philosophy.

Besides, merge algorithms themselves are subjects to change, so a merge
performed 2 years ago might end-up being rather different when attempted
with a new algorithm today, rendering information stored from an old
algorithm useless.

That said, I'm not opposed to storing/using additional merge
meta-information in general, but it should be an *option* rather than a
requirement, to only improve otherwise reliable content rebasing
algorithms.

Thanks,
-- Sergey Organov
