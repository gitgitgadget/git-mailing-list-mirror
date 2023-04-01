Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9C5C761AF
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 02:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbjDACjV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 22:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjDACjU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 22:39:20 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2FA113C2
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 19:39:18 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id j7so29454032ybg.4
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 19:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680316758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ovn2r/WJ2LLo33IkMTQiXPkRVCfRFfbRfYAm5axhcUQ=;
        b=HKsuwkz6RvqDmp0w4Y6l7ZOmzHBp6qq7U3tbmwMtdhF9EooKyfvz8hSoU6Boc1BXSp
         RuIdD7DXpgnQbZZg1fSEpsMDJF9p8zSjIfZiRV9FTQPUPFXmSkPzV3uFEa3c+M8r9NZp
         x1Ahd1kp9WirlJzhqkOJKLhDVH6q20N546ksY8Gf4UWbcnJPFgvgLeHpwbEyBI6ikgkO
         f08xxtIST090tKb+5rx0auZ92YsO+U1+PC8jClLIgA0lA4iOEOj6vmhXGlPSKIfkysU7
         B+jw8Nt+UhUzjodfxh7y18mYePFDVXkw2K6W5+gZLwDrn9HdriZ0hzlWSi1EoNV3+4Bq
         aOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680316758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ovn2r/WJ2LLo33IkMTQiXPkRVCfRFfbRfYAm5axhcUQ=;
        b=4yXmTYc9Emd8KcQC4wSRy158B2VLRzkh0pPMy/cbGCJ7MYTUmDI9uOuGul26XMRQYt
         WPX96V+CCgj8D/sRlj++xLCkxPnZXsfjnBMPaJ+HGc6B/5kJPJjLq8e5i0RM6mEAmgkv
         fHUpaj2yykAvpZtZrXvBK4Xy+aqXHseI4dJ2ocE/4xm+xcJtWj2BODWQ1TtnKiAR6rBX
         m0Pzr35XEU0iaDydYUq8C7DerJ6w0oF2g18kxBqXZt1lBuAZfo1N/RAHWDF2W5kVopdC
         Cy9BPDKdZa0BYjAJIT/mYy1DG6F63LANBVgBPlYbAFlwL6mIoSR3VpVAJODsxhSBhdhl
         zqYw==
X-Gm-Message-State: AAQBX9dBj0rtAfkDmHQZlu0l0kE/PASmq95QynBkTBWzlkbgUIJTb9n/
        dIIoU1VK6U0JDB9e2BPpHPXWHTtOMV8MmOdvbZ4=
X-Google-Smtp-Source: AKy350bc6cHQt6aicZxy+fD57yGqIluMIN6DfMc+6CeaZIMAAgeQ/mXNdXWsbwbyEmTbnFa1DgC2l8Eiet/Tmd1Ffmc=
X-Received: by 2002:a05:6902:70d:b0:b45:5cbe:48b3 with SMTP id
 k13-20020a056902070d00b00b455cbe48b3mr19232495ybt.0.1680316757970; Fri, 31
 Mar 2023 19:39:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230328173932.3614601-1-felipe.contreras@gmail.com>
 <ZCONCVC2ITBJWoBA@tapette.crustytoothpaste.net> <xmqqh6u3d119.fsf@gitster.g>
 <CAMP44s0eSDBXZEN9fRPdxV4GKLqckKtujMLDPORDjHfsdypDBQ@mail.gmail.com>
 <xmqqa5zu4ka3.fsf@gitster.g> <CAMP44s3xVL0UHCHh2Ei=STTx=grkpvUTfj6o9roe3tL35GhG4Q@mail.gmail.com>
 <xmqqv8igbd8e.fsf@gitster.g>
In-Reply-To: <xmqqv8igbd8e.fsf@gitster.g>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 31 Mar 2023 20:39:06 -0600
Message-ID: <CAMP44s0eQqvDTevs_tNqnc4Z_ZaOb4PoEXdSFmXxJn9Nyd5Emg@mail.gmail.com>
Subject: Re: [PATCH 0/6] test: make the test suite work with zsh
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 31, 2023 at 7:30=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> >> The criteria is more about what our developers are expected to be
> >> familiar with, and what is reasonable to force our developers to
> >> become sufficiently familiar with.
> >
> > That is not true.
>
> We probably should agree to disagree.

You can decide to disagree with a fact, but it's still a fact.

It is a fact that portability fixes have been merged to the code with
zero consideration to what "our developers" would have to be
"sufficiently familiar with" (which is very little, if anything).

I provided dozens of examples, and in this particular response chose
to only pick two.

>Let me respond by picking the first example from your message and then sto=
p.

Sure, but that's just *one* example of many that prove what I'm saying
is a fact, and I explain below it doesn't apply.

> > This patch 77e572653b (t0050: fix printf format strings for
> > portability, 2010-12-21) fixed a problem that was specific with dash.
> > Did our developers have to learn the details of such issue? No.
>
> The code before that change was feeding "\xc3\xa4" to printf,
> expecting that it would be an acceptable way to spell hexadecimal
> byte values, which was wrong.  The commit improved portability by
> rewriting them to spell the same byte values in octal.
>
> Yes, our developers have to learn to avoid hexadecimal byte values
> and the commit serves as a reminder for them to learn from.

Even if that were true (which it isn't), that has *absolutely nothing*
to do with the patch in question.

Developers would have to avoid that practice because it breaks dash,
not because you picked the patch.

This is a red herring: merging or not merging the patch makes no
difference to the practice.

And this is a prescriptive claim from you. *You* say that our
developers have to learn that practice, and that's your opinion of
what our developers should do. But that doesn't mean that our
developers did actually learn that.

> When a developer writes printf format with '\xCC' hexadecimal,
> reviewers would need to catch it as a mistake, and that commit makes a
> good reference why we insist on such a rule.

Yes, according to you, and regardless of whether or not you merge the patch=
.

> But still, it *is* forcing our developers to learn one more rule.

Not true. The fact that such code breaks dash is what is forcing our
developers to learn that rule, not you merging the patch.

Most developers would not even notice that you merged the patch. And
such practice would not be shared in a memo, notes from the
maintainer, or update of the CodingGuidelines.

You may be expecting such practice from developers after you merge
such patch, but that's very different from developers actually knowing
that they have to adopt this practice.

> There is a trade off: is it worth supporting dash by forcing our
> developers to stick to the rule to write octal and not hex?  dash is
> used as the default for some distros and considered one of the
> standard ones, and is worth supporting even if we need to stay away
> from some stuff people may have picked up from other shells like
> bash.

zsh is the default in macOS.

Is macOS less important than some distros?

> In any case, once we declare that "we aim for our scripts and tests
> to work with dash and bash and these other shells", our developers
> are forced to stick to intersection of these supported ones.

Once again: red herring. Merging a patch has absolutely nothing to do
with you declaring such an aim.

And if that were true, there would be a declaration of "Git now
supports dash in its test suite".

When did such a declaration take place?

Moreover, the declaration has nothing to do with the patch.

> It takes a judgement call.  And "don't write literals you feed
> printf in hex, instead do so in octal, because printf built into
> some shells do not like it" is something reasonable to force our
> developers to stick to (as it allows "dash" to be thrown into the
> set of supported shells).

Nothing to do with the patch.

> I however do not see "don't use path or status or options or 0 as
> shell variable names" falls into the same category

Another red herring: because this is not something that anybody is
suggesting to actually do.

---

The fact is that $0 is used nowhere in the tests.

You can decide to disagree with what `git grep '$0' t/t????-*.sh`
shows, but it's an unobjectionable fact.

Not that it matters, because I just sent another patch with `emulate
sh -o POSIX_ARGZERO`, which doesn't require changing $0, so you'll
need another rationale to not support zsh.

Cheers.

--=20
Felipe Contreras
