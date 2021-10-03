Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966DBC433F5
	for <git@archiver.kernel.org>; Sun,  3 Oct 2021 22:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F10D6127A
	for <git@archiver.kernel.org>; Sun,  3 Oct 2021 22:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbhJCWk2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 18:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhJCWk1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 18:40:27 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A8CC061780
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 15:38:39 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z20so6130393edc.13
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 15:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=nwGqpDT4humxMjUsehzudQIaKaGFoBu3IZ/dTNC4nBg=;
        b=OY8XUIYlZyXxv+TwZVQWb1gJsTOrwWPMd+X7OhWZqNxNtRKh/uWgN5Qh7b1A66BKLO
         U91EckhSmD1twTiysasWsUAWjB37DzJnoKMXGpqmi8YaMAAdihy4aCY3Hxs7aBt4aOZ8
         nIi8GxiZNm50bcryrzpGyo5LvmMZSuPOW4wQlYdKfeQEJCdrBd+1zF5PMbAIv+ca+oZm
         0NmmLyW9IO03I3TJx07VbWxEjJPLv4cYIgVhtaB9vedt5OhVI6LDvFCGToWwOTzdVDwD
         zanzK/04v22g4+u08WNTg20JvleEV7sMCSFw3HZnwRe6sJE7aMXzEbExcU0DEqxZI6wR
         Mt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=nwGqpDT4humxMjUsehzudQIaKaGFoBu3IZ/dTNC4nBg=;
        b=Tdtya+n0p8fLu9UcG3mnh2KPokthEPLAQ1HisXmJZo0gCtYaw6myz3QBwPOXDiVT/O
         yuhFCTAjgtxcwHFoz/yLh0IqndY2qYsijTjYG6g7WJNvSGCw4oUlDaN295SubBFEI0BK
         Ke8X6bmcZLYPV3WyCjWwvz0kGvRkVgzOJayJQw1wW/uAt8os1x97fhe/5+veTi+8NAQ7
         fru+8U7tFlGCO+8wkknDypF839RO6xdNMQM0gewUPUaPdeq0nZwtFoHtcMWn14qOq8Jc
         AQGAO6mNGHPegU37IcU9kbbTo9sJU2c+nxGNOHFfCIWkISbnRcmXnnSQ91GVZgR3U3C4
         Hl0w==
X-Gm-Message-State: AOAM5316YO+oX6DLWB1W6OGcgtyydbpGkb7NpmnV30amUQuLFng1+z9A
        asi+HLiv0Rll49X5JJWX9+8dOWKPnjc=
X-Google-Smtp-Source: ABdhPJyiS6YvABgMHSXpygqTlqalhv372eooN8+03xxCAn9k/Ko6kUakS4c+Tf4vSkWm5Dw0tYM+4A==
X-Received: by 2002:a17:906:128f:: with SMTP id k15mr13262665ejb.334.1633300717620;
        Sun, 03 Oct 2021 15:38:37 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id l8sm5702674ejn.103.2021.10.03.15.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 15:38:36 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 04/11] unpack-trees: introduce preserve_ignored to
 unpack_trees_options
Date:   Mon, 04 Oct 2021 00:21:32 +0200
References: <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
        <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com>
        <f1a0700e598e52d6cdb507fe8a09c4fa9291c982.1632760428.git.gitgitgadget@gmail.com>
        <87ilyjviiy.fsf@evledraar.gmail.com>
        <CABPp-BEnGfxqKpqXGKopXFBBshY0tuimQLtwt58wKf9CJS8n5g@mail.gmail.com>
        <87ee97utaq.fsf@evledraar.gmail.com>
        <CABPp-BEEWPF6oBN69PH_GtmqqvAj1HMtDX5ipQxa2bLzyCCu0g@mail.gmail.com>
        <87lf3etaih.fsf@evledraar.gmail.com>
        <CABPp-BGi03JunRaMF_8SJKC00byOnq1kL3JyYhKWatz8-B4RsA@mail.gmail.com>
        <87k0ixrv23.fsf@evledraar.gmail.com>
        <CABPp-BE_aY4smj_b0+Zz=YrURKMniS=DmyMWVc=q2mVDL8zUOg@mail.gmail.com>
        <87k0ivpzfx.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <87k0ivpzfx.fsf@evledraar.gmail.com>
Message-ID: <87sfxhohsj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Oct 02 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Fri, Oct 01 2021, Elijah Newren wrote:
>
>> On Fri, Oct 1, 2021 at 1:47 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
>>>
>>> On Thu, Sep 30 2021, Elijah Newren wrote:
>>>
>>> > On Thu, Sep 30, 2021 at 7:15 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>>> > <avarab@gmail.com> wrote:
>>> >>
>>> >> On Wed, Sep 29 2021, Elijah Newren wrote:
[...]
>>> > I might be going on a tangent here, but looking at that patch, I'm
>>> > worried that dir_init() was buggy and that you perpetuated that bug
>>> > with DIR_INIT.  Note that dir_struct has a struct strbuf basebuf
>>> > member, which neither dir_init() or DIR_INIT initialize properly
>>> > (using either strbuf_init() or STRBUF_INIT).  As far as I can tell,
>>> > dir.c relies on either strbuf_add() calls to just happen to work with
>>> > this incorrectly initialized strbuf, or else use the strbuf_init()
>>> > call in prep_exclude() to do so, using the following snippet:
>>> >
>>> >     if (!dir->basebuf.buf)
>>> >         strbuf_init(&dir->basebuf, PATH_MAX);
>>> >
>>> > However, earlier in that same function we see
>>> >
>>> >     if (stk->baselen <=3D baselen &&
>>> >         !strncmp(dir->basebuf.buf, base, stk->baselen))
>>> >             break;
>>> >
>>> > So either that function can never have dir->basebuf.buf be NULL and
>>> > the strbuf_init() is dead code, or else it's possible for us to
>>> > trigger a segfault.  If it's the former, it may just be a ticking time
>>> > bomb that will transform into the latter with some other change,
>>> > because it's not at all obvious to me how dir->basebuf gets
>>> > initialized appropriately to avoid that strncmp call.  Perhaps there
>>> > is some invariant where exclude_stack is only set up by previous calls
>>> > to prep_exclude() and those won't set up exclude_stack until first
>>> > initializing basebuf.  But that really at least deserves a comment
>>> > about how we're abusing basebuf, and would probably be cleaner if we
>>> > initialized basebuf to STRBUF_INIT.
>>>
>>> ...because yes, I forgot about that when sending you the diff-on-top,
>>> sorry. Yes that's buggy with the diff-on-top I sent you.
>>
>> That bug didn't come from the diff-on-top you sent me, it came from
>> the commit already merged to master -- ce93a4c6127  (dir.[ch]: replace
>> dir_init() with DIR_INIT, 2021-07-01), merged as part of
>> ab/struct-init on Jul 16.
>
> Ah, I misunderstood you there. I'll look at that / fix it. Sorry.

Just to tie up this loose end: Yes this control flow suck, and I've got
some patches to unpack-trees.[ch] & dir.[ch] I'm about to submit to fix
it. But just to comment on the existing behavior of the code, i.e. your
(above):

    "So either that function can never have dir->basebuf.buf be NULL and
    the strbuf_init() is dead code, or else it's possible for us to
    trigger a segfault.".

I hadn't had time to look into it when I said I'd fix it, but now that I
have I found thath there's nothing to fix, and this code wasn't buggy
either before or after my ce93a4c6127 (dir.[ch]: replace dir_init() with
DIR_INIT, 2021-07-01). I.e. we do have the invariant you mentioned.

The dir.[ch] API has always relied on the "struct dir_struct" being
zero'd out. First with memset() before your eceba532141 (dir: fix
problematic API to avoid memory leaks, 2020-08-18), and after my
ce93a4c6127 with the DIR_INIT, which both amount to the same thing.

We both missed a caller that used neither dir_init() nor uses DIR_INIT
now, but it uses "{ 0 }", so it's always zero'd.

Now, of course it being zero'd *would* segfault if you feed
"dir->basebuf.buf" to strncmp() as you note above, but that code isn't
reachable. The structure of that function is (pseudocode):

void prep_exclude(...)
{
	struct exclude_stack *stk =3D NULL;
	[...]

	while ((stk =3D dir->exclude_stack) !=3D NULL)
		/* the strncmp() against "dir->basebuf.buf" is here */

	/* maybe we'll early return here */

	if (!dir->basebuf.buf)
		strbuf_init(&dir->basebuf, PATH_MAX);

	/*
         * Code that sets dir->exclude_stack to non-NULL for the first
	 * time follows...
	 */
}

I.e. dir->exclude_stack is *only* referenced in this function and
dir_clear() (where we also check it for NULL first).

It's state management between calls to prep_exclude(). So that that
initial while-loop can only be entered the the >1th time prep_exclude()
is called.

We'll then either have reached that strbuf_init() already, or if we took
an early return before the strbuf_init() we couldn't have set
dir->exclude_stack either. So that "dir->basebuf.buf" dereference is
safe in either case.
