Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11859EB64DC
	for <git@archiver.kernel.org>; Tue, 18 Jul 2023 00:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjGRApC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jul 2023 20:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGRApB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2023 20:45:01 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D25A10DF
        for <git@vger.kernel.org>; Mon, 17 Jul 2023 17:44:57 -0700 (PDT)
Date:   Tue, 18 Jul 2023 00:44:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail; t=1689641095; x=1689900295;
        bh=FdiCH1abLrkQ132+/xC8tpBMt9jijpo2A3DnM03wymc=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=QJe2YfgENpojBmJtYK72UoclU8q4reiTxpsYfkYWwhQ22th87ojrHMaSupPZjjsDa
         RyHibkXwJIfIdJ/Q+AR0VyE/py9yGf4dNQmsVaRtvWAXotB3atSnDuZ1uekTSTmCNb
         wLC76p9Azk+w2LhpxisjkmbmDudD4IniFvN1ULudcJr340qU5QlqqaJQaqSZiN8VG9
         z28Xrk0rUap3r0nQrpIOap9dCAaPS0zrbzDCknT2XE8x4L1fvWBGOJoQgPJU1T7Hge
         Jk9vgGi9UKTX7O5a4qRTMLLNbeRs4TdSo2oWpGG4/X/VyGvnVeSbqnQM9LqBMy1aGm
         VU+L2acq8Gkmw==
To:     phillip.wood@dunelm.org.uk
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t2400: Fix test failures when using grep 2.5
Message-ID: <dyzkftugvd5b4f4wxsg6773fkrdrnbync6idvvi6h7cuuto36w@dbzjnkj3mh2l>
In-Reply-To: <3f3a3f5b-70fd-ec3f-acbb-d585b5eb6cbc@gmail.com>
References: <20230715025512.7574-1-jacobabel@nullpo.dev> <2e22a23f-576f-7a42-ace8-624a5362d9f4@gmail.com> <vn5sylull5lqpitsanlyan5fafxj5dhrxgo6k65c462dhqjbno@uwghfyfdixtk> <3f3a3f5b-70fd-ec3f-acbb-d585b5eb6cbc@gmail.com>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/07/16 04:34PM, Phillip Wood wrote:
> Hi Jacob
>=20
> [...]
>=20
> One thing I forgot to mention was that I think it would be better to
> explain in the commit message that "\s" etc. are not part of POSIX EREs
> and that is why they do not work.

Noted. Will do.

> [...]
>=20
> Oh so we need to search for a space followed by a tab after "hint:"
> then.=20

Okay. I think `\t` is PCRE so I'll just update the string in=20
`builtin/worktree.c` so we can just do `[ ]+` instead.=20

> As an aside we often just use four spaces to indent commands in
> advice messages (see the output of git -C .. grep '"    git' \*.c)

Apologies. When writing up that original patchset I based the
formatting of the advice based on the ones in `builtin/add.c` which
seems to also use `\t`.

>=20
> > So I just went with `[[:space:]]+` as I
> > didn't want to have to worry about whether some platforms expand the
> > tab to spaces or how many spaces.
>=20
> Is that a thing?

It might be? I know copying text through tmux tends to expand tabs to
spaces for me so I figured some other tools or those same tools on
different platforms might do things like that as well. To be honest I
have no idea and figured that I'd just CYA by making it work in the
case that it did than trying to guarantee that it wouldn't happen.

> > [...]
> >
> > If there is documentation (or discussions) on how to use this backend
> > properly I'd appreciate a link and I can try workshopping a better
> > solution then. The warning included in the original patchset reads
> > from that HEAD file as well so it would also need to be adapted.
>=20
> I'm afraid I don't have anything specific, there were some patches a
> while ago such as dd8468ef00 (t5601: read HEAD using rev-parse,
> 2021-05-31) that stopped reading HEAD from the filesystem.

Noted.

> > [...]
>=20
> I think it might be better to just diagnose if HEAD is a dangling
> symbolic-ref or contains an invalid oid and leave it at that. See the
> documentation in refs.h for refs_resolve_ref_unsafe() for how to check
> if HEAD is a dangling symbolic ref - if rego_get_oid(repo, "HEAD") fails
> and it is not a dangling symbolic ref then it contains an invalid oid.

Understood. I'll start working on a separate patch to update that
warning once this patch settles then.

>=20
> [...]

