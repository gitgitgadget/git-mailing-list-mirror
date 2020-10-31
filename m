Return-Path: <SRS0=d2Ax=EG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B55C388F7
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 18:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 615022068D
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 18:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIt9CvH7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgJaSCV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Oct 2020 14:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgJaSCU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Oct 2020 14:02:20 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0258C0617A6
        for <git@vger.kernel.org>; Sat, 31 Oct 2020 11:02:19 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id x20so8006359qkn.1
        for <git@vger.kernel.org>; Sat, 31 Oct 2020 11:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rbs4znWaPOvC3W91EZXFiGU2s4wRZO7A5ea2RuUew1A=;
        b=lIt9CvH7YAK4maQtfR1LSFAels7VI9e7JJbGVkx2iodkXMTquSFYOsHQeNeK7NyPZa
         qwDEPpWev0fb/ZrCctsMCkiXDhSJkn5B+MVrlR3eSSAYty1VL7UOb+msBrnlBu+Wu71p
         gyo05mv6WSUP0lauin+tj6Hm3x57mbwNgc8t8QFjAd/5gBTXk3+kFZsSE5wjJXqZEsf+
         6/1NcijYR/6f0lw677lwjmbrHtiKrfZZ2+p1kBROcAkwjgEW/sK05CgDBMwuPWjyBeOJ
         MVIUlfNdBV+fHHLcyczIZ0pY+VNwUyEeF1vffW0o1NgEIYppkHkK99Y/GkIshXaasbbc
         PCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rbs4znWaPOvC3W91EZXFiGU2s4wRZO7A5ea2RuUew1A=;
        b=Lh4u3i5pItLcSLwS8toM8R17/aU8pVvMGYbraDNJuRRiaxLvFPjIAczOOdbFDEGh72
         YV4+xqsFoh4f7eLXmCTT0mvLU4Z9qLUJz6HY3wy4rCyRXUH4o9Kwg3zVCBTXHk6rqvqc
         AGWJGkSkd2HUEpm52Wyk/BZ1pqKOcrIa1vpvv9THGt/UlAX3F2Cpe3AJfJh2TRTpKY+q
         mUQ33+G3iuNjxEfeA7IuYk9sY82cJo9dCC7zFrlNhCJmeF1+vacYfCEaSjomYQ5fzmIg
         boHCPwcU2LCwv8VB4GLLiziPpcrs8tPTa3JaLt7Cl/o45H6z2A/08sVJJhHW8l2f3zFZ
         8OsQ==
X-Gm-Message-State: AOAM532DbbMMnY3yk+X12MF71M03JEawyP5jBBavQ8iS0E4K1lYU2fjC
        lRQVaKQFM3wip8yIvAHVtyCnRBTSEPkJPA==
X-Google-Smtp-Source: ABdhPJx287uPbxrPD2O1Lvy0duANxQg1xxyV1rO2cJ8/EONNB3Zr4kHrrOqcCfU60VLGteofGpaHjA==
X-Received: by 2002:a05:620a:697:: with SMTP id f23mr6713924qkh.374.1604167338961;
        Sat, 31 Oct 2020 11:02:18 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id z30sm4720930qtc.15.2020.10.31.11.02.17
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sat, 31 Oct 2020 11:02:18 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 6/6] blame: enable funcname blaming with userdiff driver
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <xmqqy2jo6a0z.fsf@gitster.c.googlers.com>
Date:   Sat, 31 Oct 2020 14:02:16 -0400
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Thomas Rast <tr@thomasrast.ch>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <81143637-F77C-49C5-B55A-57E92AC45881@gmail.com>
References: <pull.774.git.1603889270.gitgitgadget@gmail.com> <a1e1c977d0978424fb07c97be0479f43a325cbea.1603889270.git.gitgitgadget@gmail.com> <xmqqy2jo6a0z.fsf@gitster.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Le 29 oct. 2020 =C3=A0 16:40, Junio C Hamano <gitster@pobox.com> a =
=C3=A9crit :
>=20
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>=20
>> In blame.c::cmd_blame, we send the 'path' field of the 'sb' 'struct
>> blame_scoreboard' as the 'path' argument to
>> 'line-range.c::parse_range_arg', but 'sb.path' is not set yet; it's =
set
>> to the local variable 'path' a few lines later at line 1137.
>>=20
>> This 'path' argument is only used in 'parse_range_arg' if we are =
blaming
>> a funcname, i.e. `git blame -L :<funcname> <path>`, and in that case =
it
>> is sent to 'parse_range_funcname', where it is used to determine if a
>> userdiff driver should be used for said <path> to match the given
>> funcname.
>>=20
>> Since 'path' is yet unset, the userdiff driver is never used, so we =
fall
>> back to the default funcname regex, which is usually not appropriate =
for
>> paths that are set to use a specific userdiff driver, and thus either =
we
>> match some unrelated lines, or we die with
>>=20
>>    fatal: -L parameter '<funcname>' starting at line 1: no match
>>=20
>> This has been the case ever since `git blame` learned to blame a
>> funcname in 13b8f68c1f (log -L: :pattern:file syntax to find by
>> funcname, 2013-03-28).
>=20
> Good find.
>=20
>> Enable funcname blaming for paths using specific userdiff drivers by
>> sending the local variable 'path' to 'parse_range_arg' instead of the
>> yet unset 'sb.path'.
>=20
> Hmph.  The reason why sb.path is not set to path at this point but
> later gets set is?  I am wondering if this is leaving an unneeded
> room for sb.path and path to diverge by mistake.  IOW, I wonder if
> it is better to set sb.path as early as we figure out which path we
> are interested in, forget we have local variable "path" and use
> sb.path consistently throughout the code.

I asked myself the same question, and could not come up with a=20
good answer. I don't know if you read what I wrote in the cover letter
(which I would have included in the in-patch commentary for this here
patch if GitGitGadget had this feature), but I'm copying it here just=20
in case you did not:=20

* In patch 6, I considered fixing that bug in a different way by
  initializing sb.path inside blame.c::setup_scoreboard. This function
  already receives 'path' as its second argument, so changing that would =
not
  impact the API. Probably Thomas thought that sb.path was already
  initialized in sb when he modified =
builtin/blame.c::prepare_blame_range=20
  to also send sb.path to line-range.c::parse_range_arg in 13b8f68c1f =
(log
  -L: :pattern:file syntax to find by funcname, 2013-03-28).=20

  Initializing the path in setup_scoreboard would mean we could also
  simplify the API of blame.c::setup_blame_bloom_data since it would not
  need to receive path separately and so its second argument could be
  removed. I went for the simpler alternative of just sending 'path' to=20=

  parse_range_arg instead of sb.path since it felt simpler, but if we =
feel
  it would be better to actually initialize sb.path in setup_scoreboard,
  I'll gladly tweak that for v2.

> But that is merely a potential future clean-up.  The local variable
> path is still used one more time in the error message given when
> this parse_range_arg() fails, so at least this change makes the use
> of path more consistent.  I like the simplicity of this fix.

I also like its simplicity, and that's why I chose to submit this as v1.
But I completely agree with you that it is "dangerous" in the sense
that some further modifications to the code could then make the same =
mistake
and use 'sb.path' thinking it is defined when it is not.

So I'm thinking of instead initializing it in setup_scoreboard for v2.

Cheers,

Philippe.=
