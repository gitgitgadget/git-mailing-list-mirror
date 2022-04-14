Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B51C433F5
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 15:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346050AbiDNPtt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 11:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352710AbiDNPRm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 11:17:42 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB841ADD7E
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 08:05:23 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ks6so10654259ejb.1
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 08:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=NrYloA68qxvR1sx7bF3TmJj9V3vFKCykYO0sEwBBqPo=;
        b=IfV0LSPAeZm2daaUpLw+e61J3pIBcLogWdDXHktx4kg9FWDO2T7QMb1y2BTjkX8aUz
         /msUctgOh/iOmOuQkS0fcbji5qWnFVS+1LpAGKImOjf2QWgtGKrrbTWFXCKiYB4c9slW
         Dsde/iWeU8I+q4inRy+9laFxwSRTqSUXXTTSgUPWMHO3vdPibegRKKJnWgKYsf5GipRZ
         6wzbnC2gYS0cSRrUiIJ+aOv6HaZ1dQeOQ44l8/YW1sxHvgJyVYjRuUD2ON5y9YsVDH4b
         HnFLZ2l2EqyAracOkgCiVCk84qBK1dCVnfcGaGLWpyfhab3LAnjl8xhSQi2VcTBtPzaT
         CdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=NrYloA68qxvR1sx7bF3TmJj9V3vFKCykYO0sEwBBqPo=;
        b=rfw/WA5O2BmR+JX7bwEcpBWPtL4wZvAoZ0cYvixsuW1/H1fgQeCQaFrzCUcgXbQNZm
         T+ftGHaJ8jDQTS4RFZdU8SjtrV9yErLjJdG6cBFZWb0wch+MfX0qIqRUy/CbDz8fDVnX
         2OSXSy/sZ5MUly8TY797Ro5VnuKS14UubHTjB3Jmng07AUawAynSCBt8VPy9x/LxLqyx
         BzayAzQw+SXKg9s1Q5XPCr+RJJE+VfUZjABPnfVr9HupAGgEz/RvmAin4xtEAc7R/8RM
         fcRpUX91/Mm1cb9l/XDS4VwSeE1Xlg6DPrJeY+k8JF3Lvu29n3+nfII5gP7FLG8kIebl
         5+pg==
X-Gm-Message-State: AOAM532KycYZAiaJ9Ztn8UZADtMbN9yKt8SIsDsMJXxUyP7MMyFr9AR2
        7WgblJ3x6Dr3juorkW3mrdg=
X-Google-Smtp-Source: ABdhPJwZbBl0wOUt7T6gGw0zfCheKqbUYYYZNoh/z7nvTCPo6jPQRnkm42aL3FVu6ViB6KalLYsjeQ==
X-Received: by 2002:a17:906:32cf:b0:6d5:83bc:e962 with SMTP id k15-20020a17090632cf00b006d583bce962mr2818510ejk.108.1649948722158;
        Thu, 14 Apr 2022 08:05:22 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i41-20020a0564020f2900b004204c9911a6sm1123239eda.10.2022.04.14.08.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 08:05:21 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nf129-005T1Y-07;
        Thu, 14 Apr 2022 17:05:21 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v3 2/3] CodingGuidelines: hint why we value clearly
 written log messages
Date:   Thu, 14 Apr 2022 16:04:59 +0200
References: <20220126234205.2923388-1-gitster@pobox.com>
 <20220127190259.2470753-3-gitster@pobox.com> <YiFYQBWBVq/HQULM@google.com>
 <xmqqv8wu5zpr.fsf@gitster.g> <xmqq8rs82m4f.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq8rs82m4f.fsf@gitster.g>
Message-ID: <220414.86lew7d7tb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 13 2022, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Emily Shaffer <emilyshaffer@google.com> writes:
>>
>>>> + - Log messages to explain your changes are as important as the
>>>> +   changes themselves.  Clearly written code and in-code comments
>>>> +   explain how the code works and what is assumed from the surrounding
>>>> +   context.  The log messages explain what the changes wanted to
>>>> +   achieve and why the changes were necessary (more on this in the
>>>> +   accompanying SubmittingPatches document).
>>>> +
>>>
>>> One thing not listed here, that I often hope to find from the commit
>>> message (and don't), is "why we did it this way instead of <other way>".
>>> I am not sure how to phrase it in this document, though. Maybe:
>>>
>>>   The log messages explain what the changes wanted to achieve, any
>>>   decisions that were made between alternative approaches, and why the
>>>   changes were necessary (more on this in blah blah)
>>>
>>> Or maybe "...whether any alternative approaches were considered..." fits
>>> the form of the surrounding sentence better.
>>
>> Quite valid observation.
>>
>> Documentation/SubmittingPatches::meaningful-message makes a note on
>> these points, and the above may want to be more aligned to them.
>>
>> Patches welcome, as these have long been merged to 'master/main'.
>
> Another thing.  If you (not Emily, but figuratively) haven't watched
> Victoria's talk https://www.youtube.com/watch?v=3D4qLtKx9S9a8 on the
> topic of clearly written commits, you should drop everything you are
> doing and go watch it.
>
> And with what we learn from it, we may be able to rewrite this part
> of the documentation much more clearly.

The slides for it are at
https://vdye.github..io/2022/OS101-Writing-Commits.pdf (not in the video
description, but at the very end of the video).

It's easy to nitpick/improve existing examples, so here goes :)

The main commit message example in that talk starts as just "Make error
text more helpful", and ends with a better version as:

	git-portable.sh: make error text more helpful
=09
	The message =E2=80=9CNot a valid command: <invalid command>=E2=80=9D is
	intended to notify the user that their subcommand is invalid.
	However, when no subcommand is given, the "empty" subcommand
	results in the same message: "Not a valid command:". This does
	not clearly guide the user to the correct behavior, so print
	"Please specify a command" when no subcommand is specified.

For our CodingGuidelines I think it would be useful to have some version
of "if you can explain something with prose or tests, prefer
tests".

I.e. other things being equal I'd much prefer this version
(pseudo-patch):

	git-portable.sh: don't conflate invalid and non-existing command

	 git-portable-test.sh | 2 +-
	 1 file changed, 1 insertion(+), 1 deletion(-)
=09
	diff --git a/git-portable-test.sh b/git-portable-test.sh
	index c8bd464..e03f4a8 100644
	--- a/git-portable-test.sh
	+++ b/git-portable-test.sh
	@@ -5,7 +5,7 @@ test_expect_failure 'usage: invalid command' '
	 '
=09=20
	 test_expect_failure 'usage: no command' '
	-	test_expect_code_output 129 "Not a valid command: " ./gitportable.sh
	+	test_expect_code_output 129 "Please specify a command" ./gitportable.sh
	 '
=09=20
	 test_done

It ends up basically saying the same thing, but now we're saying it with
a regression test (test_expect_code_output doesn't exist, but let's
pretend it's test_expect_code + a test_cmp-alike).

What it does entirely omit is the "why".

Now I realize I'm nitpicking a slide shown at a conference, which by its
nature needs to show a small pseudo-example, but I think this applies in
general:

While "why" is a good rule of thumb I think it's just as important to
know when not to include explanations and when to include one.

For cases where something is straightforward enough (as in this case,
the RHS of ": " is clearly missing) I'd think omitting the explanation
would be better, as we should also be concerned about the overall signal
ratio.

(Now, if anyone glances at my own commit messages they'll see I'm
thoroughly in "throwing rocks from a glass house" territory here :) I'm
not saying I'm consistency practicing what I'm preaching).

But just like comments there's no right answer, when one person thinks
an explanation is different from another.

But it is unambiguously the case that we can often replace prose with
tests, and in those cases we should almost always prefer that.

It's also the case that even if everyone agrees that a "why" is needed
there's multiple ways to store that information. One is via commit
messages, another would e.g. be that same commit updating some shared
guidelines about goals/examples of CLI usage.

So in this case, if a Documentation/CodingGuidelines had clear examples
of preferred usage, we could just point briefly point to that as
rationale.

While git's commit messages are excellent, I think that's one area where
we really need improvement. It's rare to dig into some old code where no
rationale can be found for it, either in the commit itself, or in the
preceding ML discussion.

But it's unfortunately (at least in my experience) more often than not
the case that you really do need to consult those commit messages or ML
archives, even for things that have come up a *lot* of times, they were
just never documented in-tree.

There's all sorts of reasons for that which are not the result of any
person doing anything wrong, but I do think it's something we could and
should focus more on as a project.

The barriers of entry for adding documentation or adjusting existing
documentation are much higher than adding a one-off explanation in a
commit message.

Partially (and probably mostly) that's a really good thing, but I can't
help but wonder if we're getting that balance right given the (in my
subjective experience) end result of us often lacking good docs, while
we're not lacking if one searches for replacements for those docs in
commit messages or the ML archive.

One more thing that I think is not explicitly covered (I skimmed the
slides, but haven't gone throug the full back yet): Minimizing diffs.

E.g. the talk shows 287fd17e3a1 (sparse-index: prevent repo root from
becoming sparse, 2022-03-01) as an example, which has this hunk:
=09
	diff --git a/dir.c b/dir.c
	index d91295f2bcd..a136377eb49 100644
	--- a/dir.c
	+++ b/dir.c
	@@ -1463,10 +1463,11 @@ static int path_in_sparse_checkout_1(const char *p=
ath,
	 	const char *end, *slash;
=09=20
	 	/*
	-	 * We default to accepting a path if there are no patterns or
	-	 * they are of the wrong type.
	+	 * We default to accepting a path if the path is empty, there are no
	+	 * patterns, or the patterns are of the wrong type.
	 	 */
	-	if (init_sparse_checkout_patterns(istate) ||
	+	if (!*path ||
	+	    init_sparse_checkout_patterns(istate) ||
	 	    (require_cone_mode &&
	 	     !istate->sparse_checkout_patterns->use_cone_patterns))
	 		return 1;

I think this is a worthwhile thing to consider as a replacement:
=09
	diff --git a/dir.c b/dir.c
	index d91295f2bcd..93a2320ae57 100644
	--- a/dir.c
	+++ b/dir.c
	@@ -1466,7 +1466,8 @@ static int path_in_sparse_checkout_1(const char *pat=
h,
	 	 * We default to accepting a path if there are no patterns or
	 	 * they are of the wrong type.
	 	 */
	-	if (init_sparse_checkout_patterns(istate) ||
	+	if (!*path || /* we consider an empty pattern to be no pattern */
	+	    init_sparse_checkout_patterns(istate) ||
	 	    (require_cone_mode &&
	 	     !istate->sparse_checkout_patterns->use_cone_patterns))
	 		return 1;

I.e. trying to optimize for smaller diffs whenever possible. It this
case the word-diff for the original is:

        /*
         * We default to accepting a path if {+the path is empty,+} there a=
re no
         {+*+} patterns{+,+} or [-* they-]{+the patterns+} are of the wrong=
 type.
         */

Now, obviously another small isolated example that's not worth
nitpicking in itself, but just serves to make a larger point. It's clear
why the rephrasing was done in that case, because the patch adds the
"!*path" check, so it makes sense a-priory to have the comment reflect
that.

But one thing where advice about "narrative structure" and good prose
tends to break down when it comes to software development is that we're
much more focused on reviews of incremental additions than many other
fields, where it tends to be more about the final product.
