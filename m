Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9076CC4363C
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 15:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 231A3206F0
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 15:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="utMGe7b0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731945AbgJHP5n (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 11:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731925AbgJHP5l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 11:57:41 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F77C0613D6;
        Thu,  8 Oct 2020 08:57:34 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id h24so8826859ejg.9;
        Thu, 08 Oct 2020 08:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=XvMgROSzuESaOzQKx7kh2yMiXeKygcT+Y838NKvx+Wk=;
        b=utMGe7b0UZ9Ghbr0xIiMxfvyGOVXoV03nSf8CntJlYmO7vB7xtLD4aHUNjc2/1/YU/
         BGvibLFWsc7ym63F744U8+Dvg+MPLLlIe39KKft9fTFf/JCqV0QFyzJlB84X3j9CzYYd
         cfn/JosupL/LZGDneCw4hVCPbbk6S1oOd2KhScE0ig21aIYVuv9lVo2/qwjSHU48qgho
         Gpt7+nG/UgQvrPPQNVb8oBF2ZDIT4aT1IGb85RFKmEclC+uDsDYwytwnia23jiGG9kUm
         7Ue5TkRy+YK44QofgRJ3mlyWceuPw1r/kNv5Ypo/k+9ncvxrA5bz4VdxXU/ozMBNJbsB
         f5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=XvMgROSzuESaOzQKx7kh2yMiXeKygcT+Y838NKvx+Wk=;
        b=Zpw06G8rgKWf94hqs/RtHuRV1f04M94xkR8cCKwEiZMr+EgjByEb3k+cT4mImPzsCi
         97BQjDisWF5PpMr2jpX5fhX58tqkZdXj/k0mUp4Ziy9Wd7SkuyLYHjoSriDEnBdJK/bH
         120Dh9ymx/g+9vhR1SD50is9FXMp8RRuA5xXrLeEbuoZkjb5Xm4IkRPf6EMTwo/tMloM
         wF7uUjmxO2wgCDfEm+/EaYANr8UwfyySwiKVwi34P0Ndz1f71RrlqmOKEIcp3p+Hywri
         0iD9XyHIo3rut8BoGF6KlPUNQw0CBbMI3EFLFjkPqljrlGb5FB+bW/g9JNxzbitiF5J/
         mVnQ==
X-Gm-Message-State: AOAM530JE+mMk/nhgpjr1UlfMnFc9lj8Lg/XLR0eoMtXt45HXo01PvYi
        OtF39D1ieX6QIjlQWkzNlQ4=
X-Google-Smtp-Source: ABdhPJyOmtOhHIUCQ1CMgl2VfYfvlPZw97lvJG+K35XaFBwxl0BqyCNtiL5xNtxS6W8gKNz5ugHDoQ==
X-Received: by 2002:a17:906:60d6:: with SMTP id f22mr9505409ejk.250.1602172652413;
        Thu, 08 Oct 2020 08:57:32 -0700 (PDT)
Received: from evledraar (dhcp-077-248-252-018.chello.nl. [77.248.252.18])
        by smtp.gmail.com with ESMTPSA id q27sm4473794ejd.74.2020.10.08.08.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 08:57:31 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        tytso@mit.edu, Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] core.fsyncObjectFiles: make the docs less flippant
References: <87sgbghdbp.fsf@evledraar.gmail.com> <20200917112830.26606-3-avarab@gmail.com> <xmqqv9gcs91k.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2010081012490.50@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <nycvar.QRO.7.76.6.2010081012490.50@tvgsbejvaqbjf.bet>
Date:   Thu, 08 Oct 2020 17:57:30 +0200
Message-ID: <87eem8hfrp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 08 2020, Johannes Schindelin wrote:

> Hi Junio and =C3=86var,
>
> On Thu, 17 Sep 2020, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>
>> > As amusing as Linus's original prose[1] is here it doesn't really expl=
ain
>> > in any detail to the uninitiated why you would or wouldn't enable
>> > this, and the counter-intuitive reason for why git wouldn't fsync your
>> > precious data.
>> >
>> > So elaborate (a lot) on why this may or may not be needed. This is my
>> > best-effort attempt to summarize the various points raised in the last
>> > ML[2] discussion about this.
>> >
>> > 1.  aafe9fbaf4 ("Add config option to enable 'fsync()' of object
>> >     files", 2008-06-18)
>> > 2. https://lore.kernel.org/git/20180117184828.31816-1-hch@lst.de/
>> >
>> > Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
>> > ---
>> >  Documentation/config/core.txt | 42 ++++++++++++++++++++++++++++++-----
>> >  1 file changed, 36 insertions(+), 6 deletions(-)
>>
>> When I saw the subject in my mailbox, I expected to see that you
>> would resurrect Christoph's updated text in [*1*], but you wrote a
>> whole lot more ;-) And they are quite informative to help readers to
>> understand what the option does.  I am not sure if the understanding
>> directly help readers to decide if it is appropriate for their own
>> repositories, though X-<.
>
> I agree that it is an improvement, and am therefore in favor of applying
> the patch.

Just the improved docs, or flipping the default of core.fsyncObjectFiles
to "true"?

I've been meaning to re-roll this. I won't have time anytime soon to fix
git's fsync() use, i.e. ensure that we run up & down modified
directories and fsync()/fdatasync() file/dir fd's as appropriate but I
think documenting it and changing the core.fsyncObjectFiles default
makes sense and is at least a step in the right direction.

I do think it makes more sense for a v2 to split most of this out into
some section that generally discusses data integrity in the .git
directory. I.e. that says that currently where we use fsync() (such as
pack/commit-graph writes) we don't fsync() the corresponding
director{y,ies), and ref updates don't fsync() at all.

Where to put that though? gitrepository-layout(5)? Or a new page like
gitrepository-integrity(5) (other suggestions welcome..).

Looking at the code again it seems easier than I thought to make this
right if we ignore .git/refs (which reftable can fix for us). Just:

1. Change fsync_or_die() and its callsites to also pass/sync the
   containing directory, which is always created already
   (e.g. .git/objects/pack/)...).

2. ..Or in the case where it's not created already such as
   .git/objects/??/ (or .git/objects/pack/) itself) it's not N-deep like
   the refs hierarchy, so "did we create it" state is pretty simple, or
   we can just always do it unconditionally.

3. Without reftable the .git/refs/ case shouldn't be too hard if we're
   OK with redundantly fsyncing all the way down, i.e. to make it
   simpler by not tracking the state of exactly what was changed.

4. Now that I'm writing this there's also .git/{config,rr-cache} and any
   number of other things we need to change for 100% coverage, but the
   above 1-3 should be good enough for repo integrity where repo =3D refs
   & objects.
