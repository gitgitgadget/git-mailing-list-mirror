Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799D3C433ED
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 21:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BF9B6100B
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 21:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237155AbhDQVia (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 17:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237106AbhDQVi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 17:38:26 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77A2C061574
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 14:37:59 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id o20so10034951edc.7
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 14:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=BNA+5221flmQo25xMCkGYEqMrfbdapk8jVkNAJAVvHM=;
        b=Zhm/iZlrgQxsXHs8oAZOar1pOuTvpqNJXMUnXFUz3xDWdW3QZwSP8r1bXW+c7t3U27
         7Qgh80kJA5EBuS/9I/nyxhCDkrFLpafuFIptYyUIBHQbkEPZnpu0NBriJCIuWrkK3fYJ
         ddq7Vt+sVNDi4burdmamAx8zf+uJSZTzsMiOULC+buwb0bDfACUAaQMyontbz0MclyB5
         aT9lWCAL1dOMLztiKRLch6biZcKPhIR4XyegiMSZvjJTst3uDDODV0noe+SZZmYk5AoR
         jj2TFHN3KaejKHEoOUQFwnLfwa5yo4/7n0B45VGisoK9dmGomqhks9ckHOR6WGB6qW1o
         oVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=BNA+5221flmQo25xMCkGYEqMrfbdapk8jVkNAJAVvHM=;
        b=AaJ5yPBUDBFqqKelnqQ7+OH8IhvGscEnwXfG2OgbE/XnvkSSt0SHHdtNq3U+Jf1id6
         uuuAotsmFzDrlmBI+Um7aBoMDtKPQyufACP9egGwO9/4XZrFPvKpvmJ5R2B7e8QtAQyp
         aml8UnhhY37NrzEH9mFQytL0aNxZQQE8lrmCo7jrwy4kmGMUhxZvcmALi9twoVIopGoe
         NFqQ33Rl5vOV3mFnZK+hMRNFljU8SE61kYOoNYpSI0KFOW6+fPLZcnkSkcpoQg58jjPh
         fKsAgI2aPs0gM9lSpFHxFf3s24zcFsq/0pfq6WlFSUtPwlE6xU1JyfV1d2ElManZp+8w
         JJVA==
X-Gm-Message-State: AOAM532l1O0gSzBeufdn9z3t280b/t5fRsmUpnE3TOONT48yXKGoQlgz
        o+U6pif46l5P/MBRvA/yl0Y=
X-Google-Smtp-Source: ABdhPJy2q4Fo2J/+4z4v28dEg62tFHCACQHH0fT1FJYzxEbuY4r5mcD7D9pcPNDhsEiB7UmV14CudA==
X-Received: by 2002:aa7:c957:: with SMTP id h23mr17090603edt.301.1618695478404;
        Sat, 17 Apr 2021 14:37:58 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id v19sm3109250edr.21.2021.04.17.14.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 14:37:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] CodingGuidelines: remove suggestion to write commands
 in Perl/SH
References: <patch-1.1-83266f30b67-20210417T084346Z-avarab@gmail.com>
 <bcc64c2d-3469-38ab-3234-fa8984a3d0f9@gmail.com>
 <87r1j91427.fsf@evledraar.gmail.com>
 <YHtFBeWxE2cFlShY@camp.crustytoothpaste.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YHtFBeWxE2cFlShY@camp.crustytoothpaste.net>
Date:   Sat, 17 Apr 2021 23:37:57 +0200
Message-ID: <87k0p01tje.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Apr 17 2021, brian m. carlson wrote:

> On 2021-04-17 at 12:36:00, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Sat, Apr 17 2021, Bagas Sanjaya wrote:
>>=20
>> > On 17/04/21 15.43, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> >> Since then the consensus changed to having no new such commands unless
>> >> necessary, and existing ones have been actively migrated to C.
>> >
>> > What I implied that when we need to implement new commands, it must
>> > be directly written in C (steeper learning curve and more tedious
>> > than implemented in shell script), so I'm against this proposal.
>>=20
>> I updated the v2 of this to note that I'm not really proposing anything
>> new, but just bringing the document in line with reality. For a long
>> time now we've rejected any new non-C things being imported into the
>> tree, unless those that fall under the "such as an importer to convert
>> random-scm-X" language that's still retained in the CodingGuidelines.
>>=20
>> I think that even if you or someone else wanted to write a new thing in
>> Perl or SH we'd want a new way of doing that now anyway,
>> e.g. git-send-email.perl should really be a helper for a C program
>> rather than a stand-alone thing.
>
> I'm also kind of opposed to this change.  For example, I plan on adding
> a utility to fill in SHA-1 compatibility things for SHA-256 repos, and
> that will be written in shell.  The performance benefit of C here is
> going to be minimal, especially considering the fact that people will be
> running it literally at most once per repo, so I don't see a reason to
> spend a lot of time writing C code.

"This change" as in the patch or my informal summary of what I think the
current status quo is?

The change being proposed here isn't to say that you can never write a
new thing in shell, but advice that actively encourages that for
prototyping.

It was written at a time when the top-level glob of *.sh in the project was:

	git-am.sh git-bisect.sh git-checkout.sh git-clean.sh
	git-clone.sh git-commit.sh git-fetch.sh git-filter-branch.sh
	git-instaweb.sh git-lost-found.sh git-ls-remote.sh
	git-merge-octopus.sh git-merge-one-file.sh git-merge-ours.sh
	git-merge-resolve.sh git-merge.sh git-merge-stupid.sh
	git-mergetool.sh git-parse-remote.sh git-pull.sh
	git-quiltimport.sh git-rebase--interactive.sh git-rebase.sh
	git-repack.sh git-request-pull.sh git-reset.sh git-sh-setup.sh
	git-stash.sh git-submodule.sh

I.e. the structure of the codebase was entirely different than it is
today, and it really made sense to encourage prototyping in *.sh first.

I thought it would be uncontroversial to remove advice actively
encouraging writing new built-ins in non-C first, which is not the same
as adding a policy to say that such a thing should never be done.

To have a policy like that is pretty close to my personal opinion on the
subject, but that !=3D the proposed patch.

> I'm not of the opinion that we should never have shell or Perl code in
> our project, nor does it intrinsically make sense to migrate everything
> to C.  Typically we've done that because it performs better, especially
> on Windows, but there are many situations in which those are not major
> considerations and shell or Perl can be a desirable approach.

... but since we're sharing our own opinions :)

As someone with >100 commits in perl.git, I don't think I can be thought
to be uncomfortable with the language.

But FWIW having patched git-send-email.perl the other day, I find myself
wishing that it and similar code was in C.

Because it's got nothing to do with performance anymore, but that >=3D95%
of our non-trivial code is in C, so doing almost anything in either *.sh
or *.perl runs up against a wall of not having the same libraries you
take for granted, plumbing being subtly lacking or different than the
core C APIs etc.

In an ideal world we'd fix some of our plumbing, but in practice
e.g. getting something as basic as git config values is some combination
of incorrect and/or atrociously slow via Git.pm[1].

And for shellscript in particular last I looked we were *this* close to
e.g. being able to git rm sh-i18n--envsubst.c, git-sh-i18n.sh etc. I
wrote that code, but I very much wish it were entirely gone. So as one
example I've put off some general improvement in our i18n infra
(e.g. writing some minimal lib so we don't need to depend on libintl),
but have always given up on the point of dreading having to support such
a thing in shell and Perl too.

So it sucks for the individual author, but at this point the trade-off
of whipping something new up in e.g. *.sh isn't just that the thing
doesn't need to be performant, but e.g. in the case of the gettext
integration means we'll be stuck with the fixed costs of extending
certain core APIs to shell-land forever, whereas currently it's looking
like we might be able to "git rm" much/most of that stuff sooner than
later.

1. I eventually got past that and other things and have local patches to
   reduce the time to invoke git-send-email.perl's by 80%, which sped up
   t9001 from ~30s to ~10s, but it wasn't pretty..

