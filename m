Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893B2C4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 18:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238551AbiLNSZi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 13:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238863AbiLNSZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 13:25:16 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54E22A706
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 10:24:17 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id b2so46594891eja.7
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 10:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MH7wBcitmV6fMOADyfPqUIH0urAQoT15NBYFk2/NSvs=;
        b=AryH0QNZi/bULfnoILIEKIUsUcqc878Ti/mxJ2oiDkcdx+6QDL9t6H2Iva5Lcj0oye
         SEYGIbZ7/jM0wA5uRauquGUY4N/CbRjfP61X/FV1Rkcut6Y4f2UqTqqUcOuwi3srerG/
         IzpaeMcaG4z5t32kYH8+jPUZs06w5Crgdj+eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MH7wBcitmV6fMOADyfPqUIH0urAQoT15NBYFk2/NSvs=;
        b=E52gAWMXrChm/L4heev08LK4JTCWlOHk80Vm48e6xQTmVZbkLR8K8+Bc1C5Bf9cmSM
         ew+8CkcKcnBTGO160m9emnU0KzqTy8pn3sFoWL7R7OsydaVYRXmuALDNfcuXDFCuryFZ
         QyOKlD6NMkgV0iU8MCWn5rLSm1BUnE6Kro+jcexixtt0t8V3662IEjbcvqrKLtAD0ck8
         NrCyTKEKYUT2ofP0F0o3JbhOihMYoVTXi6Zduoc12bC+dZDrtGBTsvBA79WAyhZYf8hf
         ofAW3h2y+wGkXW2H9bof6rqY0S9eV4k9yWh3lmylQxvHPGp/5GLbIuygVzLkJRXzT9jE
         sWOw==
X-Gm-Message-State: ANoB5plkL0XpqsrWiDcPfpl7GEpeg1i3esYrzgosIor/uzGLnrPfy+2U
        9kzBxozd2IpNLUmS+B79Csc47r/uUbM8mIP+iF6rag==
X-Google-Smtp-Source: AA0mqf6Ucdo+yT/4WIsK29Fm4fEp93G9n1w8u2IR3EN7UyCdtHbKH+tE+FFkfOawYKXSyCwbvoNMD/zTsrQV1Atrdq8=
X-Received: by 2002:a17:906:78a:b0:7c0:d88b:4326 with SMTP id
 l10-20020a170906078a00b007c0d88b4326mr20638316ejc.108.1671042255990; Wed, 14
 Dec 2022 10:24:15 -0800 (PST)
MIME-Version: 1.0
References: <CAKu1iLWvd+PVOK405Q+SNDyyYnhbi=LtovZvWw55y6eQqoRpaA@mail.gmail.com>
In-Reply-To: <CAKu1iLWvd+PVOK405Q+SNDyyYnhbi=LtovZvWw55y6eQqoRpaA@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Wed, 14 Dec 2022 19:24:04 +0100
Message-ID: <CAPMMpoi=6x5VbSh=Lkbi7WJKudGpQS2U_GnJk8GJi+ArJNp2EA@mail.gmail.com>
Subject: Re: [PATCH] git-p4: preserve utf8 BOM when importing from p4 to git
To:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 14, 2022 at 7:11 AM Tzadik Vanderhoof
<tzadik.vanderhoof@gmail.com> wrote:
>
> From: Tao Klerks <tao@klerks.biz>
> > Fix the handling of utf8-with-BOM files when importing changes from
> > p4 to git, and introduce a test that checks it is working correctly
>
> I don't really understand the problem that this patch addresses, but I
> feel it was incorrect to modify the behavior of git-p4 in this way.
> This change has made git-p4 behave differently than the native
> Perforce tools.

Hi Tzadik, first of all my apologies for the fact that these changes
broke your flow - it was clearly not the intent to cause any users to
have to change the way they do things (or, worse, make it impossible
for them to work, or cause BOM-presence inconsistencies in their
repos).

When you say "This change has made git-p4 behave differently than the
native Perforce tools", I suspect there's a misunderstanding, but
you've clearly uncovered a git-p4 "workflow bug" that this change
introduced.

The git-p4 tooling can be and is used for a number of different things.

If I understand your usecase correctly, you keep a local git repo that
you work in, and others around you continue to use p4; you
(presumably) don't share your git repo with any other users.

Under those single-user circumstances, it makes sense that you expect
your git repo to contain "your workspace's understanding" of the
perforce repo/contents, rather than "the actual contents of the repo"
- and in fact, if I understand correctly, the fact that your workspace
has a specific view on what's in the repo (does UTF-8 BOM stripping)
means that the git-p4 "submit"/"commit" command finds unexpected
differences between your git files and your p4 workspace files, when
trying to submit git changes into your p4 workspace.

In other use-cases where the git repo is shared between multiple
users, or where a perforce-to-git migration is facilitated by this
tooling, it is critical that the result of importing a perforce
repo/branch into git be "faithful", retaining the actual contents of
UTF-8-BOM files - including those first 3 bytes that are ignored by
many text-file-processing systems, but significant to others.

>
> Perforce already has a "variable" (setting) to control this behavior.
> If P4CHARSET is set to "utf8-bom", the BOM will be added to files in
> the local workspace of type "utf8".  If P4CHARSET is set to "utf8",
> the BOM will NOT be stored in the local workspace file, even if its
> type is "utf8"!

This behavior makes sense for workstation tooling like the "p4" tool,
but to the best of my knowledge it does not make sense for "repo
cloning" tooling.

Unless I'm misunderstanding something, git-p4 was working as you
wanted before these changes, precisely *because* you had specified
P4CHARSET=utf8 in your workspace (and you're the only one using your
git repo, or all others set P4CHARSET the same way and have the same
BOMless perspective in their worktrees), so git-p4's buggy clone/sync
behavior (swallowing UTF-8 BOMs when importing repo history from
perforce) matched your p4 workspace's intentionally configured
behavior.

There is a complicating factor here that may be clouding my
understanding: Perforce has two server modes of operation, "unicode
enabled server" and... non-unicode-enabled? Normal?

The idea that there are utf-8 files stored without BOM (and stored, in
fact, as type "text"), and utf-8 files stored with BOM (as type
"utf8") is a notion of the not-unicode-enabled Perforce servers. It
may be that no such distinction exists / can be stored in "unicode
enabled servers" - I need to do some testing with such servers to
better understand how this works. As far as I understand, you must be
using a "unicode enabled server" as the p4 docs say P4CHARSET must
always be unset / set to "none" on "normal" servers (and must always
be set, with "unicode enabled servers", even if implicitly to "auto").

>
> Whatever the problem was that motivated this change, it should have
> been solved using the Perforce variable P4CHARSET, not by modifying
> the behavior of git-p4.

Obviously if the conflict with workflows like yours had been
understood, the change would not have been made as it was.

However, I'm not sure that I understand your proposal here to solve a
problem "using the Perforce variable P4CHARSET". The problem was that,
on standard Perforce servers, when you add a UTF-8-BOM file, it gets
stored with type "utf8". When someone else syncs that file, they get
back what was put in - a UTF-8-BOM file. This is the way you generally
expect/hope a VCS will typically work. Conversely, if you add a UTF-8
file that does *not* have the BOM, it will be stored as type "text" -
and someone syncing it will, again, get out what was put in. This is
perforce client tooling working correctly/normally.

git-p4, on the other hand, does not use "p4 sync", it uses "p4 print",
and with this command, the BOM is *not* included on "utf8" type files.
This is not dependent on P4CHARSET, it's just an aspect of the
contract of "p4 print" - it expects the recipient of text-derived
files to parse the p4 "type" and  handle any encoding transformations
(like adding a BOM) accordingly.

Again, I'm not attempting to defend the breakage - just outlining why
I don't see how "using the Perforce variable P4CHARSET" would solve
anything.

> This new behavior has made it impossible for
> me to submit changes to files of type "utf8"!  Any attempt fails with
> "patch does not apply" and the erroneously added BOM is the cause.

I will try to understand the "unicode enabled server" behavior today
or tomorrow and see what options might make sense.

> I propose rolling back the patch that introduced this behavior,

Junio is the expert here and has noted it's a little late for that. I
obviously defer to his expertise as to git's release and backout
strategy.

I would like to have a go at understanding what the options are (how
we can get correct and functional behavior for all users), before
proposing a specific course of action.

> and if
> that is not possible, I would like to submit a patch that adds a new
> setting in the "git-p4" section that will enable users to opt out of
> this new behavior (for example a boolean setting "git-p4.noUtf8Bom").

I suspect that is the easiest tactical solution, but I'd be concerned
that this would require users like you (on such unicode-enabled
servers, with the P4CHARSET=utf8 setting locally), to "discover" the
cause of submission errors they get, and discover the setting that
would enable them to work around it. At least in the medium term, I
would prefer to find a way to have git-p4 intentionally respect the
"P4CHARSET" setting (with a warning about repo faithfulness if you're
losing any data or causing potential repo inconsistency along the
way).

As a workaround for you in the immediate term (and sorry, I feel
super-dirty even writing this) the only option I see for "git-p4
submit" to work would be for you to, when this happens, temporarily
change your P4CHARSET value to "utf8-bom" and re-sync the affected
files in your workspace, before you "git-p4 submit". I have not tested
this, but given my limited understanding of your situation it seems
like this would work.

If you already have a different workaround please let us know what it is!

Best regards,
Tao
