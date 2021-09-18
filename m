Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BFFC433EF
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 07:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CF48600CC
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 07:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241724AbhIRHqm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 03:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbhIRHqm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 03:46:42 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51A7C061574
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 00:45:18 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id g21so38834246edw.4
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 00:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=CsziwdTrR6Y3yrrL+jSQTcx6HZQAD101u2WLhV2ai1s=;
        b=HaDeTGjCmFaerSqmRjYA43D0F1/Z2n0bT+HVhVal7GWoEeRTcQ1+2Sjs7oCHyScmAO
         hnHrYU/fHdU2+LwE9TlxvfNy29MW98G0QOH7spWH7e5MtdjD/cHfS5xbELZ3kCHIrIah
         PNiopzsMJKmlgHRW6ohYVgr+WS+jDSFGoVNEhrkRhUvT1V/a6vhBK33XFndoyP+gdu03
         rVs5kC9zlTLE0LXzkdZzUTSkuvSEj4plVWtBuKaRoEvXJnxQbo6Wfx138+pE1Z5vKBII
         v98u+sU+avSN2TMytzW0NvbSyKwdlwq5hCgKtRw2S0xF2g9yFi4k80Y0EE228XVKFjdm
         0/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=CsziwdTrR6Y3yrrL+jSQTcx6HZQAD101u2WLhV2ai1s=;
        b=DGNcmvI4W+eAnRnrETwSC6+966gP1/XUrxImKxKyIkn3pztbR9gKtk1h8Q5KbGmiVH
         WakpH+C+qVZtXvy3mwzr1N0raw2BvXiMiiUjtPM0FEzL5qLQTgkuB5nyNT8Zx4F+wTMy
         JWvMlRhxm+KOzReHp1cPY3Qngf4XL/85YQtM4fDDh6JHmcsEtE93F30Y3iNblN0YCpwr
         dByNtZ8er9EDRthOZXiPLNbFo6LBiJSLoxVcOP5sjuS9t9yCkJTO9qpu4JbcXof/8J/Z
         4G99/QRCuxvZPLX0//DE0Grd7gUhM0Wv1hK3YkSVB8FVQCBPT9xVRKqGtJexz0eHjAqW
         M3ow==
X-Gm-Message-State: AOAM531jPKE/N33xDTkavfE2UV2g3qz739j93AfJRFZErEVIYkFfcQMx
        MBEHcNfb4BzHfff6CB9JYPLaOmDB2yI=
X-Google-Smtp-Source: ABdhPJwUB52uFEdYd1VIFHuLUkixLKA/VTEhugoa/EdLm2zTvYLgTm9dCCu8GDbCJVDQx3jU6fVc5w==
X-Received: by 2002:a05:6402:88e:: with SMTP id e14mr17873148edy.342.1631951117189;
        Sat, 18 Sep 2021 00:45:17 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d3sm3724733edv.87.2021.09.18.00.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 00:45:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC] range-diff: make output format more useful for
 "rebase --onto"
Date:   Sat, 18 Sep 2021 09:29:15 +0200
References: <xmqqv92yg5y6.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqv92yg5y6.fsf@gitster.g>
Message-ID: <87r1dmcooj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 17 2021, Junio C Hamano wrote:

> In a range-diff output, we often see an early part of an updated
> series having no changes since the previous iteration.  After
> applying an updated patch submission to the same base as the
> previous round,
>
>     $ git range-diff master..topic@{1} master..topic
>
> to view the differences since the previous edition, we might see
> something like this:
>
>     1:  9a05f02b1d = 1:  a05f02b1d9 t/helper/test-bitmap.c: add  ...
>     2:  78de300e1f = 2:  8de300e1f7 pack-bitmap.c: propagate nam ...
>     3:  7caca3c9f0 = 3:  caca3c9f07 midx.c: respect 'pack.writeB ...
>     4:  72082224f1 = 4:  2082224f17 p5326: create missing 'perf- ...
>     5:  097b89c815 = 5:  97b89c8150 p5326: don't set core.multiP ...
>     6:  a1dd4c97b9 < -:  ---------- p5326: generate pack bitmaps ...
>     -:  ---------- > 6:  bf4a60874a p5326: generate pack bitmaps ...
>     7:  2b909ebad3 ! 7:  54156af0d6 t5326: test propagating hash ...
> 	@@ t/t5326-multi-pack-bitmaps.sh: test_expect_success 'pack.preferBitmapTips' '
> 	 +	(
> 	 +		cd repo &&
>     ...
>
> Now, after noticing that up to step #5 there is no change since the
> previous round, cleaning up the application result with
>
>     $ git rebase --onto 097b89c815 97b89c8150
>
> will help making it easier to see that earliser part did not change
> before committing this in the longer term history.
>
> The output format of the range-diff unfortunately makes it a bit
> cumbersome than necessary to come up with the rebase command line.
> Because "= 5:" gets in the way, copying the two object names from
> there and pasting them as the command line arguments to "git rebase
> --onto" becomes a chore.
>
> Tweak the output so that the change numbers and comparison sign come
> first on the line, followed by two object names and then the title
> of commit, to make it easier to copy the two object names together.
>
> The updated output format looks like this instead:
>
>     1 = 1 a05f02b1d9 a05f02b1d9 : t/helper/test-bitmap.c: add  ...
>     2 = 2 8de300e1f7 8de300e1f7 : pack-bitmap.c: propagate nam ...
>     3 = 3 caca3c9f07 caca3c9f07 : midx.c: respect 'pack.writeB ...
>     4 = 4 2082224f17 2082224f17 : p5326: create missing 'perf- ...
>     5 = 5 97b89c8150 97b89c8150 : p5326: don't set core.multiP ...
>     6 < - a1dd4c97b9 ---------- : p5326: generate pack bitmaps ...
>     - > 6 ---------- bf4a60874a : p5326: generate pack bitmaps ...
>     7 ! 7 2b909ebad3 54156af0d6 : t5326: test propagating hash ...
> 	@@ t/t5326-multi-pack-bitmaps.sh: test_expect_success 'pack.preferBitmapTips' '
> 	 +	(
> 	 +		cd repo &&
>
> Incidentally, it becomes easier to see the correspondence and spot
> the reordering of the commits with this change, for the same reason
> why it becomes easier to see the two commit object names---they sit
> close to each other with their peers.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * Obviously an RFC.  The output format would be fairly subjective,
>    but I do not care deeply enough to make it configurable.  If
>    enough people appreciate the convenience of seeing the two object
>    names and two change numbers next to each other like I do, and
>    nobody processes the current output with tools, then it may be OK
>    to take this patch as the final version, but otherwise, this is
>    only meant as an inspiration piece for somebody else to have a
>    mechanism to allow the output configurable in some way (which I
>    am not intereseted in doing myself).

I think we carved out a sufficient exception in df569c3f31f (range-diff
doc: add a section about output stability, 2018-11-09) to just change
the output.

I do happen to have a one-liner as part of my build process that relies
on the current output, but I've only got myself to blame. Aside from the
change being proposed here I think we can just change it in general if
we come up with better output.

As for the proposed output, I'm a bit negative on it, so first, if we're
trying to note that two commits are the same wouldn't it be much better
to just omit the second SHA-1? I.e. consider this variation of your
proposed output;

     1 = 1 a05f02b1d9 a05102bfd9 : t/helper/test-bitmap.c: add  ...

You might eyeball that for a while before discovering that I switched
the "f" and "1" around, i.e. the SHA-1s look /almost/ the same. Isn't
this better? (or we could use "++++++++++" to not overlead any meaning
"----------" has):

     1 = 1 a05f02b1d9 ---------- : t/helper/test-bitmap.c: add  ...
     2 = 2 8de300e1f7 ---------- : pack-bitmap.c: propagate nam ...
     3 = 3 caca3c9f07 ---------- : midx.c: respect 'pack.writeB ...
     4 = 4 2082224f17 ---------- : p5326: create missing 'perf- ...
     5 = 5 97b89c8150 ---------- : p5326: don't set core.multiP ...
     6 < - a1dd4c97b9 ---------- : p5326: generate pack bitmaps ...
     - > 6 ---------- bf4a60874a : p5326: generate pack bitmaps ...
     7 ! 7 2b909ebad3 54156af0d6 : t5326: test propagating hash ...

(Or whatever other syntax would follow from the shorthand of the "1 =
1". Having it repeated in the human-readable output just for the one
use-case of passing it to rebase --onto doesn't seem worth it.

But then if we get support for say --ignore-matching-lines (which I've
wanted to for a while to omit the Signed-off-by lines you add) we'll
note the same SHA1 if you used that option, but a different one in the
same slot if you omit it (i.e. we'd start showing that part of the
diff).

Then combine that with --left-only or --right-only and we'd ignore the
diff depending on what "side" it was, and then either duplicate the
SHA-1 or not.
