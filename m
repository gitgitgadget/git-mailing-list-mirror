Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F4BC2D0E4
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 20:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD8D8207DE
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 20:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgKLUGW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 15:06:22 -0500
Received: from mail-ej1-f43.google.com ([209.85.218.43]:34637 "EHLO
        mail-ej1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgKLUGW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 15:06:22 -0500
Received: by mail-ej1-f43.google.com with SMTP id o9so9882480ejg.1
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 12:06:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xZlGgpDpfUQDPHH0/EYVGY+Nkzpqi8DVQObRMKMZTGY=;
        b=NNohSaKPi4u0OAyrMAZVif7AEeqQiVtMtITTVhxR0LzFMPgQ7nwQ879ahibJXalyrv
         nNQtrK1JysmMAKz5/MdHG6j/BIshLeSOTainclYEN6usDzwU8X+9I0OIJFA35+2Byinf
         jOBKCWIIUUyPzPhySvZXAkqNSUXyJnrhK4+EmVXEytEVruqPGSbm68xYETXLPvFsjaNZ
         aKzfH3B26YgSXO3PPxHq0nNv4kvS8ctcbmhYWNs+itHDIWuVUw6GYbmlVSdcsiyRhlRe
         lVKadD96jiBVEnTpEAu+QzSxY+05e56Nsx9pVZbcjjH6k29Tp7XwBCVL4tIHs/Y8kWlg
         47BA==
X-Gm-Message-State: AOAM5311Uclra5E2cVZyXFmji/cZp7haABWV5C0GS33gEOUiENyEBKbJ
        MLcL7jejQb/BeBCLsKcIe45NQX/6yEsrYkJmCpA=
X-Google-Smtp-Source: ABdhPJwFxefxGNn3jhj1fsiv78bzIRyZ0ryeU2pi6aVnNY2T5sTxAw6jNyH8c4X2Sc55FiLYTTk6yMqBt4V6+HH/aA4=
X-Received: by 2002:a17:906:c357:: with SMTP id ci23mr931780ejb.311.1605211580360;
 Thu, 12 Nov 2020 12:06:20 -0800 (PST)
MIME-Version: 1.0
References: <20201112174353.GD4270@szeder.dev> <xmqqk0uqjw4l.fsf@gitster.c.googlers.com>
 <CAPig+cT1zDT1iqRqO-4U8Rwq7p=MFm5Bkn990AVbxMHqp=knmg@mail.gmail.com> <xmqqblg2jt95.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqblg2jt95.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 12 Nov 2020 15:06:08 -0500
Message-ID: <CAPig+cTeiLDFQD6HDhr-or4F+2POfsMkQ2f0H5ipvi7DCkmLRw@mail.gmail.com>
Subject: Re: git format-patch --range-diff bug?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 12, 2020 at 2:00 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > [...] the best "fix" likely would be for `git format-patch --range-diff` to
> > error out when it sees a 3-dot range.
>
> And possibly rename the option.  Giving "--range-diff=<prev>" is not
> an instruction to run "git range-diff <prev>", so it is clear that
> the option is misnamed.
>
> It probably should have been "--[no-]range-diff" boolean that
> controls if we add the range-diff from the previous, whose default
> may be affected by the user of the "-v$n" option, plus another
> option that gives where to find the "previous series", whose
> presence probably trigger "--range-diff" implicitly, or something
> like that.
>
> And the option whose value we are having problem with is exactly
> that "--previous-series=<prev>" option.

You may be right that, due to the name similarity, some people
misinterpret --range-diff as providing one-to-one parity with the `git
range-diff` command, but that was never the intention (as was
discussed during review). Instead, the intention all along was only to
make it easy to embed range-diffs in `git format-patch` output with a
simple and concise invocation, and only for common cases. For
instance, it is quite common for v2 to share a common base with v1, in
which case `git format-patch -v2 --range-diff=v1 <base>` would be
sufficient (when v2 is the checked-out branch). Anything more complex
can be achieved by utilizing `git range-diff` directly; for instance:
`git range-diff {complexity} >>0000-cover-letter.patch`

As discussed during review, I had considered more complex invocation
possibilities for `git format-patch` but ended up rejecting them and
opting instead for simplicity since `git range-diff` itself is a
suitable escape hatch for accomplishing complex cases not handled by
the intentionally simplistic --range-diff option. Thus, I'm hesitant
to go in a direction which adds more complexity to the `git
format-patch` invocation, thus making it more difficult to use
range-diff with `git format-patch`.
