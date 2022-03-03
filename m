Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65BFC433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 11:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbiCCLEi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 06:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbiCCLEa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 06:04:30 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F85A154737
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 03:03:44 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id f8so6083435edf.10
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 03:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=mIWVa4TA1qAJUe5qVNnzAX80qG32x+yAuyBEUo9WDx8=;
        b=pAxODdewIIzr17LwHdghWRJP7icj4jKPXgw1eEoyS1p0DewX39qFmTws3Q55nry0ww
         uLcWP49b2ZqK6nU56BviWIAgdRE1HeT/9gBv7KIzD2k7kHKk4GUeWHQm9T7v9PRjcp2y
         jMWxFI+fRqXXQD50Mzns2AXtMxUIQ0BhkGfJZ0EGbEDiMLIA4s3rPgeG67xBln4c4pDS
         M+cAV35VXxNN0U1JtQLHo1VM65bocdEU81A/EVhVR5QTxOsxY8yyngGiaf4Bp8enclD9
         KMDBrjg08exfIZPORNh+6Be5I4rmzo4C4uCKlkBypvNoZrx2hvNctd/bJBgwC+jObmvk
         jl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=mIWVa4TA1qAJUe5qVNnzAX80qG32x+yAuyBEUo9WDx8=;
        b=UQBwp0GgpK11+bIxyXdva/K4JcEDK3wq8B5QMqGzcO4L1Pm7Xc3S8hw5r51CPSGJEB
         m0CwjyHyk8bLoMPzY4FBVfDkX7vB9mLoI9Qn7dzXc4k+wdCa2O2YnkpaXLMAv6ftmA7a
         9yk3blevj0uBb+b2jy91Sv6bAf5WE1VFBppmeT1UNbfCMKQHVRsgkH7yGpy7E7B9btDC
         IuK5ZjbUNUqyPzibA0ngJouaTm5zVxLGzQSoSd4nSPl543KnjsmQjCy1d+opxM1+OCDm
         XhafNzo18tnNL7emWmU9tE7dTO49TNagM93nts9LQMRINGuMn9Nb2rLPmoRMsD2L5xiD
         IGFg==
X-Gm-Message-State: AOAM532xGhNPtGmxAxCZomUI2AtsYTUwNlabmibPbBdkY8MSF4F2wshm
        EKgJZ7ewrJROi25Lq5EUTmLPanwngELUqw==
X-Google-Smtp-Source: ABdhPJwJasTr+fWeTd3eC3ODHECHRbx5HImRh3c65v6vQN5OajyQgWoSFDi8r92RVR2oxVy+QYnx1A==
X-Received: by 2002:a05:6402:4396:b0:412:b131:fca6 with SMTP id o22-20020a056402439600b00412b131fca6mr33470727edc.133.1646305422665;
        Thu, 03 Mar 2022 03:03:42 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bm23-20020a170906c05700b006d597fd51c6sm581770ejb.145.2022.03.03.03.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 03:03:42 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nPjFE-000Rb5-TE;
        Thu, 03 Mar 2022 12:03:40 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        gitster@pobox.com, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] builtin/remote.c: show progress when renaming remote
 references
Date:   Thu, 03 Mar 2022 11:51:08 +0100
References: <70a0325ca8ab0492a9b0873ee3fba576c5ab90b9.1646173186.git.me@ttaylorr.com>
 <220302.865yow6u8a.gmgdl@evledraar.gmail.com>
 <Yh/1zFChEXz7r1vN@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <Yh/1zFChEXz7r1vN@nand.local>
Message-ID: <220303.8635jz5mcz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 02 2022, Taylor Blau wrote:

> On Wed, Mar 02, 2022 at 08:00:59PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> So please have this by "int progress =3D 1", and have a "PARSE_OPT_NONEG"
>> "no-progress" option instead, there's no reason we need to propagate the
>> existing UX mistake in "reflog expire".
>
> Yes, I agree that `git remote` is unlike other commands where you have
> to opt _in_ to see progress, not out.
>
> But I deliberately avoided doing anything about it here, since this
> patch is more about making an existing set of arguments (`git remote -v
> rename`) do something more useful than before, and not adding a new
> option.
>
> In other words, I felt that because you could already run:
>
>     $ git remote -v rename old new
>
> that it was better to punt on any changes to the option itself until
> later.

So first, I must say that I was just entirely confused when I wrote
this. I managed to somehow read this code and also mentally mix up that
you were patching git-remote and not git-reflog, hence linking to those
"reflog" patches.

By way of explanation I think that's because I started thinking "oh
yeah, it's that one special case where --verbose shows progress..." :)

But in any case, for *this patch* I think that also means that using
--verbose here makes even less sense, because --verbose for "git-remote"
is:

    Be a little more verbose and show remote url after name.
    NOTE: This must be placed between remote and subcommand.

Although reading it over it seems that was written for "git remote -v
[show]", but we don't entirely hold to it already, but in any case let's
not also conflate it with what should be a "--no-progress" here.

> On a similar note, it would be nice if this option worked on either side
> of the sub-command, like how you can do either of:
>
>     $ git multi-pack-index --object-dir=3D... write
>     $ git multi-pack-index write --object-dir=3D...
>
> But I don't think we should let perfect be the enemy of the good here,
> in case you were suggesting delaying this patch until we sort that issue
> out.

I think per [1] and your [2] we agreed to move forward in not adding any
more of these subcommand-level options. I.e. I was arguing in [1] that
it might be a good idea for e.g. --no-progress or --verbose, but the
consensus was to go for your [2] of declaring that it's always the
subcommand that takes the option.

(Which as an aside, I'm fine with, and have come more around to being
the Way It Should Be since then).

So just doing:
=09
	diff --git a/builtin/remote.c b/builtin/remote.c
	index 6f27ddc47bd..047bcda57c5 100644
	--- a/builtin/remote.c
	+++ b/builtin/remote.c
	@@ -674,7 +674,9 @@ static void handle_push_default(const char* old_name, =
const char* new_name)
=09=20
	 static int mv(int argc, const char **argv)
	 {
	+	int progress =3D 1;
	 	struct option options[] =3D {
	+		OPT_BOOL(0, "progress", &progress, N_("show progress")),
	 		OPT_END()
	 	};
	 	struct remote *oldremote, *newremote;

Would be consistent with [2] and not mix up --verbose and its (probably
somewhat inaccurate already) documented promises with this new output,
and improve the UX by turning it on by default.

1. https://lore.kernel.org/git/87zgsad6mn.fsf@evledraar.gmail.com/
2. https://lore.kernel.org/git/cover.1631980949.git.me@ttaylorr.com/

>> [I reversed the order you wrote the following, due to the obvious
>> digression...] :)
>
> ;-), thanks.
>
>> As an aside I think the reftable code "emulates" the D/F conflicts of
>> the files backend, but I'm not sure (this is from vague memory).
>
> Perhaps, though I'm admittedly not familiar enough with that work to
> tell know for sure, either. I don't think I have a ton to add to the
> lower part of your reply, so I'll stop here.

:)
