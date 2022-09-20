Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CD0C54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 10:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiITKuf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 06:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiITKua (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 06:50:30 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DDA3F1C8
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 03:50:28 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id y8so3190447edc.10
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 03:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=aps/Ls37AZN2Xp/g8jjK0lIkVuXai5xBoQTylfBIeRY=;
        b=RhmDt4pMZ7W6DuH6+MPupTOb9No1uD8RrSfND+WxfggNMmKN2+4K8G5srFb7JD7tMX
         XF4xdUVmBUwV+OTa/CkXdK5ivh/WW4ZfTxtNJi/bMCFMKXl2XYrXyA06WGk9KUOoFD5q
         8StVtDqG1JMBi4n3TefMzj1Wy2E+P6B+sctuX69RvafGDrJwk50DgIlZkFwdcqHLoXf1
         nem92sVJv7FMntDup6WPUJ/HgGAjL2tsdrw0UgnhgSvAzz2O8zRF0eGv+AQSK1yVsvsF
         AG8RZJnDAQNx8HY9c0QoMibep5QVmo7eelb695xHGPPwDAnIms705flOKlEQ+LyKPPhY
         v8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=aps/Ls37AZN2Xp/g8jjK0lIkVuXai5xBoQTylfBIeRY=;
        b=g+B8uRnobFICtbL8ai0csH30Be7hIcmJvX64e58xXpatFXHC+Htg3WSNNpSl+fwqTq
         7Kr7LE55pJsBqZceiKzeKKbJfPQFKuFrbUYLtDQRjbbbAkRy2GfJ7+tiwI1P1jwt7ihw
         OEIAzxzQ/Wv0eko54iypgPWKQiBfR9iXKKPeVIj3YeyzHjSIYBqK+nfVTkrdSD9FvET1
         a5K9ewQ5tY6NaVoZAb2d62vVjNAVEoVEMZyS5en/UO+iWGTTpveLwHywrzn+FkdBnO4X
         hxf2cCVgrOvftEYsEBQ267YP043rds1jYf+AdHGl1xPcuVwpYn4SqrAwYAf7lSYeUWsk
         UTYA==
X-Gm-Message-State: ACrzQf11BgKKjbwwySrmtsWlydnkXyXtp4Ta0xiCPZ5+cZTuUqH+KEZl
        7m6ODU8HJ5Z45Lle7YSH3Bvxudf+PcA=
X-Google-Smtp-Source: AMsMyM5nkGJ2DR3g/qWVzqtZK8bqByvOeDfcSNZDjx+3eQFD3O08GuOQDxdw4EO1h67B471AfEfQ9g==
X-Received: by 2002:aa7:c610:0:b0:44e:9a0f:753a with SMTP id h16-20020aa7c610000000b0044e9a0f753amr19192772edq.140.1663671026537;
        Tue, 20 Sep 2022 03:50:26 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id b3-20020a056402138300b004528db1e834sm1056544edv.57.2022.09.20.03.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 03:50:25 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oaapc-001HtY-2a;
        Tue, 20 Sep 2022 12:50:24 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     "Florine W. Dekker" <florine@fwdekker.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        git@vger.kernel.org
Subject: Re: Wildcards in mailmap to hide transgender people's deadnames
Date:   Tue, 20 Sep 2022 12:23:05 +0200
References: <2e846a72-a4c6-2a5a-255a-15eee037f574@fwdekker.com>
        <854127f2-55aa-5636-813d-d91b8a4cdcbc@web.de>
        <f13bc5aa-dadd-a895-eeca-79bd77c5363b@fwdekker.com>
        <220919.86mtav60wi.gmgdl@evledraar.gmail.com>
        <YyiIkMcADVu+Qbht@tapette.crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <YyiIkMcADVu+Qbht@tapette.crustytoothpaste.net>
Message-ID: <220920.86edw65ngv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 19 2022, brian m. carlson wrote:

> [[PGP Signed Part:Undecided]]
> On 2022-09-19 at 11:20:13, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> I.e. I think a "deadname" use-case of this would probably:
>>=20
>> * Have some comment at the top of .mailmap about why some values are
>>   over-encoded (or perhaps it would be obvious to everyone working on
>>   that repo why someone was encoding the "plain ASCII" A-Za-z0-9 space).
>
> I don't think we need to do this.  First of all, it makes people curious
> and nosy, and it draws attention to the situation when in many cases,
> other contributors might not even notice as they're updating the
> mailmap.=20=20

Sure, to clarify I meant this is something that a downstream project
using the .mailmap might want to add, or they might now.

> Adding lots of attention is going to add the potential for
> harassment.

I'm in no way minimizing that potential for harassment, doxxing etc., in
fact I'm vehemently agreeing whith that point. But I think this gets to
the crux of our disagreement.

I think it would be irresponsible of us to provide a feature that looks
as though it can in any way mitigate those concerns.

If you're someone that's worried about being harassed if someone makes
the link from your previous identity Y to your current identity X where
you already have Y as part of a public git history. The right answer is
to not submit a change to the .mailmap to explicitly connect the two.

>> But should not:
>>=20
>> * Assume that other tools such as "fsck", "check-mailmap" or even "log"
>>   won't have future features that make de-obscuring these values easier,
>>   or something that's part of a normal workflow.
>
> Your statement that you intended to write exactly such a feature was the
> main reason I dropped the SHA-256 hashed mailmap series.  I don't think
> it's constructive to offer or propose to offer such a feature in Git if
> we're trying to obscure people's names in the mailmap, and as such I
> would want to see a guarantee that we wouldn't implement or accept such
> a feature.  I don't see the point of obscuring names in the mailmap if
> we're just going to print them next to each other in the future, and I
> don't think it's moving us towards a solution to suggest that we might
> do that in the future.

I haven't gone back and re-read that whole thread, but I think I was
mainly pointing out that we or someone else can and probably will write
the trivial reverse mapping.

Hence my point above, even if we carefully scrutinize every change to
git.git to ensure that we never implement a feature that de-hashes the
hashes you proposed all it'll take to defeat the entire mechanism is
something trivial like:

	diff -u <(git log) <(git log --no-mailmap)

> I'm happy to resurrect my SHA-256 hashed mailmap series if we're
> all willing to agree to not implement trivial decoding features.

I'd think you'd want to be really clear about what that forward promise
would entail. E.g. I've sometimes wanted a way for "git log" to report
when it munges commits due to adding notes, re-encoding the data etc. If
someone submits that sort of feature should it always explicitly leave
out mailmap-related rewrites?

And even if it does, who do we think we're really helping in the end,
given the trivial way you could get that with an external "diff" with
the one-liner above?

> I also have an alternate proposal which I pitched to some folks at Git
> Merge and which I just finished writing up that basically moves personal
> names and emails out of commits, replacing them with opaque identifiers,
> and using a constantly squashed mailmap commit in a special ref to store
> the mapping.  This doesn't address changing identities in existing
> commits, which as we've seen are nearly impossible to fix, but it does
> address new ones.  I've sent it out at
> https://lore.kernel.org/git/20220919145231.48245-1-sandals@crustytoothpas=
te.net/.

As I understand the difference in this scenario a hypothetical future
repo's Y commit's authorship would have been opaque in the first place
using this mechanism, and via your "refs/mailmap" you'd have mapped
Y=3DBob.

You then make a future X commit, and map X=3DAlice, and have a .mailmap
entry which mapped Y=3DX, but that entry would refer to the opaque value.

That certainly changes things in a fundamental way, and goes most or all
of the way to mitigating what I've been pointing out as a flaw in these
proposals.

I'd still be very much on the fence about whether we'd ever want to
recommend that to someone concerned with "harassment" and the like (as
opposed to a milder social preference), as all it would take to get to
that point is someone having a copy of the older "refs/mailmap" to
unmask the previous "Y".
