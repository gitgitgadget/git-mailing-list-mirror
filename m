Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EB3C433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 00:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7639764DD3
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 00:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhBWAR7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 19:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbhBWARs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 19:17:48 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419A8C061574
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 16:17:08 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id p2so24016081edm.12
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 16:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=p2NtuDnIEOXVewJ14/KKRqY+FsY3tI5/zQjVFWbPFcc=;
        b=pPJitaYRBSOZsJaUI+movHkf5PEWyQy119sUp8JUNodCWN+5eij93aV2G9WBZlYtls
         CCuJD3CEIgtn7Tudkh5IyTie2068Wnj+3p4WYlScd0EcuH2jq/osMQZhhgu0AID11WuU
         t38aa7ucIhA7Y0u36RP5TV5sSADzFlSTF4LLeHKerUSZB91iBOCHVP/5KUlVw0+GwAaA
         FSJL1v9Fg5MDbw+fhpvi172n9QBnHAhyHvrcvZX6nHVVPBPnYl6KV+vjW8PmN94w1Zyy
         fhZNCbCuSWvNcPRx4wZjHu2jJ+omevesxc+3RrPX7JyMCiJlfl6Oq0vk/zGv9LHakj+I
         AlvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=p2NtuDnIEOXVewJ14/KKRqY+FsY3tI5/zQjVFWbPFcc=;
        b=juprRFqV9OkT7bLfDeaYa1M0pLd5ulbOAxL5EPSYu4JpCjjA7NdMKCuiONGNhJbzMQ
         wIXjLoJ+njv4/B+wQkYWX6zHyKa4gk2IFhKopI/+RqXOteGovTRklVYS7aJtVe+iPxMf
         OjVrGHHPql1+2u3OUiofF8lgGa+xaZiQAUnbQUn6O881x0loS6CV2VXdpn3L3ku4Ckf8
         9FpBUGn5rSNtfpj0DpLqROZDVUFuJ5CJV3sGZ/+0d5rXe19BPBXOzthB6HqCgjX3QZ+i
         KMX+K2Sh5DJJNavvnLZrvUsDNZjMJ1ocI/Tk7TFAR758Hl1oxGN7DhXZ095NEQ9mUgN+
         /JeA==
X-Gm-Message-State: AOAM531bmdCxpzUuZ+tF2MRzLTyBeL0qyGvrrOfR4V7BVHkJXS2x/WcZ
        RQ+CglOeu2iYMgJGFGfRDWSQxSUj+Brtdw==
X-Google-Smtp-Source: ABdhPJw3EpTs3UnSCNes/6okLdbq1zz2vNTO9lwi0MXpaZ4MT7WH9oPm3NrNonzJt2PGY1RrYV1EOg==
X-Received: by 2002:a05:6402:c84:: with SMTP id cm4mr22782801edb.276.1614039426894;
        Mon, 22 Feb 2021 16:17:06 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n13sm248989ejc.84.2021.02.22.16.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 16:17:06 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Stefan Monnier <monnier@iro.umontreal.ca>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: New orphan worktree?
References: <jwvwnwqrqwd.fsf-monnier+gmane.comp.version-control.git@gnu.org>
 <CABPp-BE1QXA0ohB9D-tqKpzDTok0BMsGQjotmcqMxfs9AL5noA@mail.gmail.com>
 <CAPig+cRzXd+zd+xVisaW+HToSaGzAE28acGmxwRxNU4bczHXbw@mail.gmail.com>
 <87wnv688u4.fsf@evledraar.gmail.com>
 <CAPig+cQ9oqMWjBkyRt-SQFuyfAGkMu1J-U6ZCCJqeL0a_3ynkw@mail.gmail.com>
 <87ft1o8mi0.fsf@evledraar.gmail.com>
 <CAPig+cSkL+5otKUWwm=CLaRR+j71wW61U7LWtmuUHO+7bZaY_g@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CAPig+cSkL+5otKUWwm=CLaRR+j71wW61U7LWtmuUHO+7bZaY_g@mail.gmail.com>
Date:   Tue, 23 Feb 2021 01:17:05 +0100
Message-ID: <87czwr8wou.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 23 2021, Eric Sunshine wrote:

> On Mon, Feb 22, 2021 at 4:45 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> On Sun, Feb 21 2021, Eric Sunshine wrote:
>> > Rather than making --orphan a boolean flag, we'd probably want to
>> > mirror the behavior of the other commands and have <branch> be an
>> > argument consumed by --orphan:
>> >
>> >     git worktree add --orphan <branch> <path>
>> >
>> > That would make --orphan, -b, and -B mutually exclusive, much like
>> > they are for git-checkout, and much like -c, -C, and --orphan are
>> > mutually exclusive for git-switch.
>>
>> I see now (but didn't before, I haven't really used "switch" before)
>> that that's how it works.
>>
>> But that doesn't seem to make much sense as a UI, maybe I'm missing
>> something but how do you:
>>
>>     git switch --orphan existing-branch
>>
>> Just like you can:
>>
>>     git switch -C existing-branch <start-point>
>
> When responding to your initial email, I noticed this same shortcoming
> of --orphan in both git-branch and git-switch, and assumed that's why
> you made it a boolean in combination with -b/-B in "git worktree add".
> Before writing that email, I did put a bit of thought into how one
> might support a "force" mode but didn't include my thoughts in the
> message.
>
>> It's actually this exact use-case that prompted me to write the --orphan
>> patch. I wanted to create a "meta" orphan branch in my git.git, but had
>> an existing local "meta" (from Jeff King) that I'd happened to have
>> checked out long ago which I first needed to "git branch -D".
>>
>> Wouldn't it make more sense for a feature like this & back-compat to
>> start with switch's "--orphan" implying "-c", but you could also supply
>> "--orphan -C" instead? And in worktree have -b and -B work like they do
>> for other branches.
>
> I'm not sure I follow. In git-switch, --orphan does not imply -c even
> though --orphan also creates a new branch (thus seems to work similar
> to -c); it is nevertheless mutually-exclusive with -c and -C. The same
> goes for --orphan in git-branch.

I think we're on the same page with regards to what I meant. I.e. I
don't see how it makes sense to conflate the type of branch we want
(orphan or not orphan) with whether we want to clobber that branch or
not (switch -c or -C, or worktree -b or -B)

> As far as combining --orphan and -C (or -c), I'm not sure how we would
> arrange that using the existing parse_options() mechanism. It seems
> too magical and has potential for weird corner cases.

Isn't it just having --orphan be an OPTION_STRING with
PARSE_OPT_LASTARG_DEFAULT. I.e. to support:

    git switch -b branch --orphan
    git switch -B branch --orphan
    git switch --orphan branch

And:

    git worktree add -b branch --orphan
    git worktree add -B branch --orphan

I didn't test it, just skimmed the code.

> Since git-worktree doesn't yet support --orphan, we certainly have
> more leeway and could go with your proposal of having --orphan be
> boolean and always requiring it to be used in conjunction with -b/-B.
> However, I'm quite hesitant to take that approach since it breaks with
> existing precedent in git-branch and git-switch, in which case
> --orphan takes its own argument (<branch>) and is mutually-exclusive
> with -b/-B/-c/-C.

In git-branch? Isn't it only git [checkout|switch] that takes --orphan?

But yeah, I agree that it makes sense for "worktree add" to be
consistent with "switch". I was just wondering if we couldn't fix what
seems to me to be a small options UI issue while we're at it.

> When I was pondering the issue before writing my original response,
> two thoughts came to mind. (1) "git worktree add --force --orphan
> <branch>" would be one way to make your case work; (2) given how
> infrequently --orphan is used, we just punt and require people to
> first use "git branch -D <branch>" if necessary (which has been the
> status-quo for git-branch and git-switch). The latter thought is
> superficially tempting, though it doesn't help in automation
> situations since "git branch -D <branch>" errors out if <branch>
> doesn't exist, so a script would first have to check for existence of
> <branch> before attempting to delete it prior to using "git worktree
> add --orphan <branch>".

I think not having a -B or -C equivalent at all would be preferrable to
having a --force special-case just to work around the lack of it for
--orphan.
