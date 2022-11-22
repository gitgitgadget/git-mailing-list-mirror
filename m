Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3EBC4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 23:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbiKVX7v (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 18:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiKVX7u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 18:59:50 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F78C560D
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 15:59:49 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ud5so39269948ejc.4
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 15:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R45eOElfSdOcXkTDY4eJI89XYZyA0uaWtJdXFdWy8ds=;
        b=ddop38J6pCzcotsPYOCFGLjgxYgHwkDCrkm4zOueCZ0VGR9mC7VBTicUs/PtSgQzFL
         F/NO/FRQytHi2xKmix8ZlxCs3VV8pi0KiAtKFL6sCVCgHK7HnV8E/BRHgWEgBwsi24s4
         QnPf13OLLo8FKhc3OnGS2lMFO2/WY9D6uLbznex3R3xw7+dIjR6ce3WAeMa6JGgZwU+i
         MpS0ahAXSSjFD+qvxluqXQjsM3mHzPhqsPdRCNfG9usIalHMZIZkKhZ/cFvTXynjY6iB
         isA2OdWiA3MsaqqNrAX+m9My3FIa8LZAYYcOSejMvIj3Se9AxSCZvkrlE2J6RTA/b8oG
         6WyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R45eOElfSdOcXkTDY4eJI89XYZyA0uaWtJdXFdWy8ds=;
        b=Du3J6C4W/lx4iKGmwydhdksNbBvVEFM8Lb2OaaS0FBsR7/7tZQSMfpLfzj/nx6huat
         Tj2OHjWrFoRcD4YNV6ZJ/Ww0P7OMfbFVKLHnRH5stLKNFxFaLGjHM0dlp1p+l+ACc87D
         O7cbuL+AfWQpp9RiwsPOmDzRDQWX+/QHtMT7az6/lmOPGS3zQd3+QZJ15Sj+T8JpxSY7
         WNg9IOrxoPLfaOupc2QXHDy2vpo+NqIPvRWGJUAlhiPYS4orcf+bn0AGhpY1IXztedXN
         m1BL8IrVFL5q8NkP2/v8l6TYAJSfe6CsZQcAKT2DLUdrCFMxxksuYAZL8/B3mYqBZA3z
         Zz4A==
X-Gm-Message-State: ANoB5pknRynDk1N8j+tZU22JGS+y5mrDnCGfogT2Z1XqywTFC1XahOWT
        OpiBEyhpouEaFLStO3DH9stpZwWMhkr3Mg==
X-Google-Smtp-Source: AA0mqf7q2ulaTUFemXMRpJsC8QH24+aYi/UFfCTa2i2Pk7ysNNKtyZkAJzrpH7VHgTpaTBzTRkFJPA==
X-Received: by 2002:a17:906:82d1:b0:7ae:63e3:bfc4 with SMTP id a17-20020a17090682d100b007ae63e3bfc4mr13350625ejy.348.1669161587540;
        Tue, 22 Nov 2022 15:59:47 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id e24-20020a170906315800b0078d793e7927sm6520359eje.4.2022.11.22.15.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 15:59:47 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oxdB4-000rRb-24;
        Wed, 23 Nov 2022 00:59:46 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 0/2] worktree: Support `--orphan` when creating new
 worktrees
Date:   Wed, 23 Nov 2022 00:55:50 +0100
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
 <20221104213401.17393-1-jacobabel@nullpo.dev>
 <20221110233137.10414-1-jacobabel@nullpo.dev>
 <CAPig+cTTn764ObHJuw8epOtBdTUwocVRV=tLieCa4zf-PGCegw@mail.gmail.com>
 <221117.86sfihj3mw.gmgdl@evledraar.gmail.com>
 <20221119034728.m4kxh4tdpof7us7j@phi>
 <221119.86a64nf9k5.gmgdl@evledraar.gmail.com>
 <CAPig+cTGATAYCpFcW2F6byf827-_TOyN1FNLfFCm0NdiReYVpg@mail.gmail.com>
 <20221122232647.2jdsp5kioq7muymb@phi>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221122232647.2jdsp5kioq7muymb@phi>
Message-ID: <221123.86a64ia6bx.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 22 2022, Jacob Abel wrote:

> On 22/11/22 12:16AM, Eric Sunshine wrote:
>> On Sat, Nov 19, 2022 at 6:49 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> <avarab@gmail.com> wrote:
>> > On Sat, Nov 19 2022, Jacob Abel wrote:
>> > > I'd support adding an `advise()` for at least the basic case where y=
ou try to
>> > > create a worktree and no branches currently exist in the repository.
>> > > i.e. something like this:
>> > >
>> > >     % git -C foo.git worktree add foobar/
>> > >     hint: If you meant to create a new initial branch for this repos=
itory,
>> > >     hint: e.g. 'main', you can do so using the --orphan option:
>> > >     hint:
>> > >     hint:   git worktree add --orphan main main/
>> > >     hint:
>> > >     fatal: invalid reference: 'foobar'
>> > > and
>> > >     % git -C foo.git worktree add -b foobar foobardir/
>> > >     hint: If you meant to create a new initial branch for this repos=
itory,
>> > >     hint: e.g. 'main', you can do so using the --orphan option:
>> > >     hint:
>> > >     hint:   git worktree add --orphan main main/
>> > >     hint:
>> > >     fatal: invalid reference: 'foobar'
>> >
>> > I think those would make sense, yes.
>>
>> Yes, this sort of advice could go a long way toward addressing my
>> discoverability concerns. (I think, too, we should be able to
>> dynamically customize the advice to mention "foobar" rather than
>> "main" in order to more directly help the user.) Along with that,
>> explaining this use-case in the git-worktree documentation would also
>> be valuable for improving discoverability.
>
> Perfect. I think I've got this working already on my end using more or le=
ss
> the following:
>
>     diff --git a/builtin/worktree.c b/builtin/worktree.c
>     index 71786b72f6..f65b63d9d2 100644
>     --- a/builtin/worktree.c
>     +++ b/builtin/worktree.c
>     @@ -736,7 +736,21 @@ static int add(int ac, const char **av, const ch=
ar *prefix)
>         if (!opts.quiet)
>             print_preparing_worktree_line(opts.detach, branch, new_branch=
, !!new_branch_force);
>
>     -	if (new_branch && !opts.orphan_branch) {
>     +	if (opts.orphan_branch) {
>     +		branch =3D new_branch;
>     +	} else if (!lookup_commit_reference_by_name("head")) {
>     +		/*
>     +		 * if head does not reference a valid commit, only worktrees
>     +		 * based on orphan branches can be created.
>     +		 */
>     +		advise("if you meant to create a new orphan branch for this reposi=
tory,\n"
>     +			 "e.g. '%s', you can do so using the --orphan option:\n"
>     +			 "\n"
>     +			 "	git worktree add --orphan %s %s\n"
>     +			 "\n",
>     +			 new_branch, new_branch, path);

We don't consistently check for this, unfortunately (but I have some
local patches for it), but to add an advice you should:

 * Add it to Documentation/config/advice.txt (in sorted order)
 * Add the corresponding enum to advice.h
 * And to the advice.c listing
 * Then use advise_if_enabled(<that new enum>, ...) in cases such as this o=
ne.
 * End your message with a suggstion about how to disable the advice:
   git grep -W -F 'git config advice.' -- '*.c'

That's rather tedious, sorry, but that's the extent of the current
boilerplate...
