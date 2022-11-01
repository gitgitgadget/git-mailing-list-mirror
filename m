Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F60C433FE
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 08:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiKAIaX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 04:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiKAIaT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 04:30:19 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709443B5
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 01:30:18 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id b2so35318417eja.6
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 01:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iFmE8fE2Zjc/wp99da/nxrkpMR5sJ3qwbbbFkOi4NxM=;
        b=jfGkxV7pksIzzZkiqINnMhZcBLqNuce2+xSFRJe2FNPMJ3PCQo9f+1Su2HgTF/hSXX
         U2UsA+z3Bvo6/FIw0HUVXGvnmmYKVZ83+R+QOY4de4uQP2J8gnLQaMA0eyEgJ2SYRq+R
         jPv0WBTt0aDzvodwdX2+hoXj1yrAcXCezOEIAaIhlXWpPQi2+GKt5dKZ9LtFbezoW9gH
         vOlKHXQKgcjDn868gwM09lr3owHV5z5/zzpN7fiLT1eAimWS+kgevkij5dlnn7b0Gn7s
         yXFdiDVn7sqWfm3Ne+Pcmm+FTX7f9N8F3PDaEOg5y2kmu+/1yvYSqexP+2/liGZL+1T/
         bBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iFmE8fE2Zjc/wp99da/nxrkpMR5sJ3qwbbbFkOi4NxM=;
        b=bl17RaOeW3s+pbbnQNBFsHOTvBA7WVhhYCOB8nFZt5C7y/+1zYlNl+WQXk5L4yK7Qo
         gtUWWdHaoXhiCTIVpurNTZ+jOJLLBdtaDyA/fUVD2ySmVkFWHOdHlrZ+aG7HAU8BBnzg
         7k7ZYObIhpnKpdDT1jBYHqmZQc2JmE/fpGQO2ApVvXRspnFRyF9L6Bpdz0DXMs8J9a2J
         IbXgeUMimOlrJ/ZYh9IiNgr7hs6apohy2PSZT60EWzCiVHaLEzNglUQj0YQoGuCniOVB
         mNSGu0T4VwqYQxL5gEBbd5kYkrmlcISvKDjHlT0EUM1HX1+ke3HtbDistmr/+5jhf1IY
         eE4w==
X-Gm-Message-State: ACrzQf1VFHpleqh8wUdml6rbwhwbwxM8XFhcC5VcF7WrhBtGUwqAmaJ9
        msDilhSg0LNc58+Z1R3LFek=
X-Google-Smtp-Source: AMsMyM6ibCCJ0XYgMSlE8vuXjPwvlLCOXXasaKS2qmeHqLOCFpVBTttVc0acTfw/IvXw/B/fYFRpfQ==
X-Received: by 2002:a17:907:1c01:b0:78d:eb6e:3807 with SMTP id nc1-20020a1709071c0100b0078deb6e3807mr17345158ejc.481.1667291416911;
        Tue, 01 Nov 2022 01:30:16 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id t6-20020a1709063e4600b007abaff3a97asm3894832eji.221.2022.11.01.01.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 01:30:16 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1opmf1-00BARS-2Q;
        Tue, 01 Nov 2022 09:30:15 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] t5516/t5601: be less strict about the number of
 credential warnings
Date:   Tue, 01 Nov 2022 09:15:00 +0100
References: <Y2CDrZNgNZ+flJBK@coredump.intra.peff.net>
 <Y2CD6GBl6ORqKsug@coredump.intra.peff.net>
 <221101.861qqn5ovf.gmgdl@evledraar.gmail.com>
 <Y2DNS0W5vgk2Q3qJ@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y2DNS0W5vgk2Q3qJ@coredump.intra.peff.net>
Message-ID: <221101.86sfj33wmg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 01 2022, Jeff King wrote:

> On Tue, Nov 01, 2022 at 04:29:31AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > It is unclear as to _why_, but under certain circumstances the warning
>> > about credentials being passed as part of the URL seems to be swallowed
>> > by the `git remote-https` helper in the Windows jobs of Git's CI build=
s.
>>=20
>> ..this description dosen't match what the patch is doing, okey, so
>> there's a case where the remote helper swallows the warnings, i.e. we'll
>> emit fewer than we expected...
>
> So I really didn't revisit this commit much at all, and was just trying
> to save Dscho (or Taylor) the work of having to rebase it, if we go with
> my patch 1.
>
> IMHO it is OK enough as it is, but if I were writing it from scratch I
> probably would have given the rationale that the tests are insiting on a
> dumb, sub-optimal behavior. And flakes or inconsistencies aside, they
> should be asserting only the presence or absence of the message. And
> probably would have left each at "grep" and dropped the test_line_count
> totally.

Do you mean that even if we fix the bug and consistently emit one and
only one such message you'd like to have the tests not assert that
that's the case?

I do think that UX is important enough to test for, particularly if
we've had a bug related to that that we've fixed. I.e. if something in
the direction of my [1] goes in.

> It is not even clear to me that the remote-https is the one being
> swallowed (at least, I have not seen an argument or evidence that this
> is so; it does seem plausible).

It is the case, the only ones that are going to be duplicated are the
"warn" ones, because for "die" we'll die right away in the parent
process.

Which is what I'm trying to get across here, and why I'm a bit
confused. I.e. I thought you'd agree that we should test that we emit
exactly one warning if & when we've fixed the underlying issue.

That issue is already fixed for "die", so even if you want to loosen up
the test your [2] should only keep the first line removal/addition in
the first two hunks, and drop the 3rd one.

>> > @@ -654,7 +654,7 @@ test_expect_success 'push warns or fails when usin=
g username:password' '
>> >  	test_must_fail git -c transfer.credentialsInUrl=3Ddie \
>> >  		push $url_userpass 2>err &&
>> >  	grep "fatal: $message" err >warnings &&
>> > -	test_line_count =3D 1 warnings
>> > +	test_line_count -ge 1 warnings
>> >  '
>>=20
>> ...but then why are we modifying these codepaths that have nothing to do
>> with invoking the remote helper, i.e. where we die early before we get
>> to that?
>
> If you're arguing that we should only do s/=3D 3/-ge 1/ for the test that
> is flaking, I could buy that.

I'm saying that if we're doing a handwaivy-fix and saying "sometimes the
message gets swallowed" and fixing this blindly without checking how it
works, then changing "=3D 1" to "-ge 1" doesn't make sense.

It should be "-ge 0", i.e. surely that "one warning" can get swallowed
too?

Now, I know that never happens, because we'll always get at least
one.

I'm just saying that as soon as you stop to think about that you must
also come to the conclusion that the "die" ones are OK as-is.

That's because the reason we always get at least one is the same as
we're always guaranteed to emit just one in the "die" case: The parent
process emits it, then dies.

>> And even if some of this was invoking that remote helper and we were
>> modifying it blindly, then presumably the helper swallowing it would
>> result in 0 some of the time, so "-ge 1" would be wrong.
>>=20
>> (That's not the case, but it's why I think the patch doesn't make much
>> sense).
>
> I thought the point is that the outer program calling the helper would
> consistently produce the error, always yielding at least one instance.
> The helper one is generally "extra" and undesired.

Yes, exactly. Which is what my fix[1] the root cause addresses.

Anyway, I'm just trying to help here. If you/Johannes/others want to go
with the "hotfix" as-is that's fine my me.

I just don't see what the hurry is, it's been this way for two releases,
if it's flaky that's been the case for months, I'd think we could just
fix the root cause.

1. http://lore.kernel.org/git/RFC-patch-1.1-0266485bc6c-20221031T204149Z-av=
arab@gmail.com
2. https://lore.kernel.org/git/Y2CD6GBl6ORqKsug@coredump.intra.peff.net/
