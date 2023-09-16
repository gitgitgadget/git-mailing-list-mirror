Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639E3CD13DD
	for <git@archiver.kernel.org>; Sat, 16 Sep 2023 18:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237939AbjIPSiZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Sep 2023 14:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjIPShv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2023 14:37:51 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8189FCE7
        for <git@vger.kernel.org>; Sat, 16 Sep 2023 11:37:46 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-502defbb0c3so5335785e87.0
        for <git@vger.kernel.org>; Sat, 16 Sep 2023 11:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694889464; x=1695494264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vL/Ewe5O75LZClc9qfV2YhCGNjz8FfLo+xLFRNATK0Y=;
        b=Tky8DnJx07cVYxOWf9sZ3z9wVMdEjgkYf2MxTCpA36AFCe7iU1zfw+nP02R2SXsfRN
         i3bYazleLRCbKqyI47KMjQIcj0Fao66P4pTsWtNJvCErvKT9nLmAiMkk9c0lQrms0+eN
         BZB/Y3ThB9dQk1+SrAizAhqkuoz9rOBT26OWC/xWrBdwXrihQG9NMsWNBpX9wuHKZXj8
         IWAkdyAb5wIip5PRQ2/OKopY4pboY2LO+R4BslFowZ98LWEo6YLrG9FZgK1ApqTh7z/e
         tYKhojWKnV5dOfhB4mJ1J1B7BsUf/JeIOAhVdkaYl1XxaxwFsqSEIrYX8sTgfETCNshS
         bvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694889464; x=1695494264;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vL/Ewe5O75LZClc9qfV2YhCGNjz8FfLo+xLFRNATK0Y=;
        b=SdzT8gOjEbv4Yu2a4Tj/V+M4H5lZ7SCfub1sFftTsRn9UxttZFe1MIr20Fzp9wGbbU
         sRK8BHRZmDi5lpF0EKVJ0xUPY9MIVrywsifrG+6nYHD/P7I8lz4O9PX/jFFT+WpEfKsU
         pq/H9UIsfmqb9w9mFO5a0KM1/CUQAeQBKawyXzfHBbYGZiUEEyhUiCRNmjlfNNQ1qa8d
         YTaJ6wd7xhZDMaZRFx7yXJ+pMr8yWivKhaP6tnd5Axga6IrbXHa1DqPdWwx9kSi9tvZA
         J/MUvQ/vs31CB9DwYXfFUs9b5fspXDszCW6B8pS6WojXdu33ArxLHYgd6URawQRWLIJ+
         YXNQ==
X-Gm-Message-State: AOJu0YyH++Qt0ffDpYeYzH+sJvoDoyFg22k/63BDYAgfrPoF4EDU18nF
        otchUZfF/ZzfBYNou6XopTDnyt0e6os=
X-Google-Smtp-Source: AGHT+IHhJIxUGCVfJjAS2xwuZZJdXyQKQ6uDD+AyeHpkwxJ/ZC6HnT+Lf/GrVeMI0UXyQaEIAJq4Mw==
X-Received: by 2002:a05:6512:3685:b0:500:aed0:cb1b with SMTP id d5-20020a056512368500b00500aed0cb1bmr3547957lfs.24.1694889464094;
        Sat, 16 Sep 2023 11:37:44 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id eo30-20020a056512481e00b004fb326d4ff0sm1107519lfb.77.2023.09.16.11.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 11:37:43 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] diff-merges: introduce '-d' option
References: <20230909125446.142715-1-sorganov@gmail.com>
        <20230909125446.142715-3-sorganov@gmail.com>
        <xmqqtts0tof8.fsf@gitster.g> <87o7i7hler.fsf@osv.gnss.ru>
        <xmqqled8h01w.fsf@gitster.g> <87y1h8wbpo.fsf@osv.gnss.ru>
        <xmqqzg1nfixw.fsf@gitster.g>
Date:   Sat, 16 Sep 2023 21:37:42 +0300
In-Reply-To: <xmqqzg1nfixw.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        15 Sep 2023 10:24:43 -0700")
Message-ID: <87ttrudkw9.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> I don't see why desire to look at diff-to-first-parent on "side"
>> branches is any different from desire to look at them on "primary"
>> branch
>
> Yeah, but that is not what I meant.  The above argues for why
> "--diff-merges=first-parent" should exist independently from the
> "--first-parent" traversal *and* display option.  I am not saying
> it should not exist.

I was not assuming you were saying this, as it has been discussed and
agreed upon when --diff-merges=first-parent was introduced, though I
think I now see your point more clearly.

>
> But I view that the desire to look at any commits and its changes on
> the "side" branch at all *is* at odds with the wish to look at
> first-parent change for merge commits.

I think I do now understand what you mean, yet I have alternative view
on the issue.

> Once you decide to look at first-parent change for a merge commit,
> then every change you see for each commit on the "side" branch,
> whether it is shown as first-parent diff or N pairwise diffs, is what
> you have already seen in the change in the merge commit,

Actually, this happens to be exactly one of intended use-cases for "-d".
It's useful to see how some change introduced by the merge looked in the
context of the original commit, or to figure where the change came from.

> because "git log" goes newer to older, and the commits on the side
> branches appear after the merge that brings them to the mainline.

The exact order is orthogonal to the issue at hands, I think.

> Making "log -d" mean "log --diff-merges=first-parent --patch" lets
> that less useful combination ("show first-parent patches but
> traverse side branches as well") squat on the short and sweet "-d"
> that could be used for more useful "log --first-parent --patch",
> which would also be more common and intuitive to users, and that is
> what I suspect will become problematic in the longer run.

Sorry, "-d ≡ --first-parent --patch" you suggest contradicts my view on
the whole scheme of things, for several reasons:

* I still find it problematic if -d, intended to fit nicely among --cc,
-c, -d, -m, -p, --remerge-diff options, suddenly implies --first-parent.
This would bring yet another inconsistency, and I don't want to be the
one who introduced it.

* In its current state -d conveniently means: "gimme simple diff output
for everything", where --first-parent you suggest doesn't fit at all.

* Current -d implementation is semantically as close to -p as possible,
tweaking exactly one thing compared to -p: the format of output for
merge commits, so is simpler than what you suggest from all angles, as
--first-parent tweaks more than one thing.

* To me what you argue for looks mostly like a desire to have a
short-cut for "--first-parent --patch", and my patch in question does
not seem to contradict this desire, as it'd be very surprising if
somebody came up with the name "-d" for such a short-cut. Definitely not
me.

* Finally, if -d becomes "--patch --first-parent", how do I get back
useful "--patch --diff-merges=first-parent" part of it, provided
--first-parent is unreversable? And even if it were reversable, then

   git log -d --no-first-parent =
   git log --patch --first-parent --no-first-parent =
   git log --patch

is definitely not what is needed, nor frequent demand to revert implied
things indicates optimal design. Compare this to

   git log -d --first-parent

that current -d provides for you to get what you need, and that
unambiguously reads: "gimme *d*iff for all commits while following
*first parent* through the history" (while, unlike, -p not requiring
--first-parent to implicitly tweak diff for merges output).

Overall, after considering your concern, I'd still prefer to leave "-d"
semantics as implemented, consistent with the rest of similar options,
and let somebody else define more shortcuts for their frequent use-cases
if they feel like it.

Thanks,
-- Sergey Organov

P.S. I also figure that maybe our divergence comes from the fact that I
consider merge commits to be primarily commits (introducing particular
set of changes, and then having reference to the source of the changes),
whereas you consider them primarily merges (joining two histories, and
then maybe some artificial changes that make merges "evil"). That's why
we often end up agreeing to disagree, as both these points of view seem
pretty valid.
