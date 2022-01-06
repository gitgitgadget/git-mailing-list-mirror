Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8288FC433F5
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 23:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245329AbiAFXC0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 18:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245283AbiAFXCZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 18:02:25 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E26C061245
        for <git@vger.kernel.org>; Thu,  6 Jan 2022 15:02:25 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id o203-20020a1ca5d4000000b003477d032384so366755wme.2
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 15:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5i2X51+AHaiHi4BUqxfFvrbVgiinVM1ku2ZJbZ24/qo=;
        b=e5q6JrSG8HmZJtcA/dq9bY6N0Ccw6Q/rEAB9GHdj/ogZQOKQVl+MGV+WLCrN1tgWup
         eJiLnmoWZ2k42IYc83QyGWMqr7aRLthjtRS9NdPqc5vbIL05yRWV66XMvxPJL+NhNpgo
         F+DXx1j8sfhaKOSAST03Pa7fyBUbA4mcxd8mbhRBDaVfE83JdovVC1Kda9LP6fyjMTAN
         rar8UGPUOwxOh8qFfJtQmks+wWlYhqN2tR8lDhjFwN/fXIz43q1kQB/gq5v+VWC2ofGY
         1jqRfi9E3+Wt0V3MFA8piQV2IbufLbCD01UlbwrCMJ5C0eEvMt1xrM5I9bYHBFkfvPvn
         fEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5i2X51+AHaiHi4BUqxfFvrbVgiinVM1ku2ZJbZ24/qo=;
        b=t+inY5abLZQS8GVGbsR3BWkjdXLCcccDlNrlcxcZ2X8BWsS4GhWa+Mb6kLA8j9tFxz
         jC6ccocqpXbs+rgl3/FvMzLj2X3CENoUE4I3PPJ/8jJhDnQoPcg062Mw/oV4x0vLqYWT
         ohrFGoYGfrSr53/N/ALbud+vOqW4C13TrGAjhca5QEWWylEEiDL5yZNDwYXZHRiU8bPV
         vxfFHYnN5cwDN6bbinqPyIARwrYTMolwuBL+w6xlLBkYVT9TYvuviCJ/Rv2L/A6COQ9M
         uwtnql8M7qLNAp8oWM5iXMZbezsfb5DsxXq6TOms+pqdxwbhgiApFM9DPYxyj05hhtyj
         Kb5g==
X-Gm-Message-State: AOAM530EG2H6nqz2G+Iwz9S7ZNWL4BjojPFaXxe1bs2kpxN3Sxlwy/GO
        ZIyI9QEmdMvYaBQeW2PckrgljgPdlXa1XPx4
X-Google-Smtp-Source: ABdhPJw/pzw/KyBhJ420T47TjJOYdKt61MqfqOzuLb0FIkgBFIVOeiKsekfIfbpPglPaNal1N7Mx9w==
X-Received: by 2002:a7b:c396:: with SMTP id s22mr6318438wmj.121.1641510143743;
        Thu, 06 Jan 2022 15:02:23 -0800 (PST)
Received: from smtpclient.apple (global-5-143.nat-2.net.cam.ac.uk. [131.111.5.143])
        by smtp.gmail.com with ESMTPSA id 11sm4241079wrz.63.2022.01.06.15.02.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jan 2022 15:02:23 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] apply: Avoid ambiguous pointer provenance for CHERI/Arm's
 Morello
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <xmqqczl4bhmo.fsf@gitster.g>
Date:   Thu, 6 Jan 2022 23:02:23 +0000
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BE9D3BD5-EC19-4881-872D-CEB4039A382D@jrtc27.com>
References: <20220105132310.6600-1-jrtc27@jrtc27.com>
 <xmqqczl4bhmo.fsf@gitster.g>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6 Jan 2022, at 22:53, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Jessica Clarke <jrtc27@jrtc27.com> writes:
>=20
>> On CHERI, and thus Arm's Morello prototype, pointers are implemented =
as
>> hardware capabilities which, as well as having a normal integer =
address,
>> have additional bounds, permissions and other metadata in a second =
word.
>> In order to preserve this metadata, uintptr_t is also implemented as =
a
>> capability, not a plain integer, which causes problems for binary
>> operators, as the metadata preserved in the output can only come from
>> one of the inputs. In most cases this is clear, as normally at least =
one
>> operand is provably a plain integer, but if both operands are =
uintptr_t
>> and have no indication they're just plain integers then it is =
ambiguous,
>> and the current implementation will arbitrarily, but =
deterministically,
>> pick the left-hand side, due to empirical evidence that it is more
>> likely to be correct.
>=20
> What's left-hand side in the context of the code you changed?
> Between "what" vs "ent->util" you take "what"?  That cannot be
> true.  Are you referring to the (usually hidden and useless when we
> use it as an integer) "hardware capabilities" word as "left" vs the
> value of the pointer as "right"?

Left-hand side is what, right-hand side is ((uintptr_t)ent->util). The
bounds/permissions/tag/etc need to be inherited from somewhere, and as
an arbitrary empirically-best choice when otherwise ambiguous we choose
the left, i.e. what. The alternative would just be to error, which will
result in strictly more code failing to build for CHERI despite such a
guess being correct most of the time.

>> static uintptr_t register_symlink_changes(struct apply_state *state,
>> 					  const char *path,
>> -					  uintptr_t what)
>> +					  size_t what)
>> {
>> 	struct string_list_item *ent;
>>=20
>> @@ -3823,7 +3823,7 @@ static uintptr_t =
register_symlink_changes(struct apply_state *state,
>> 		ent =3D string_list_insert(&state->symlink_changes, =
path);
>> 		ent->util =3D (void *)0;
>> 	}
>> -	ent->util =3D (void *)(what | ((uintptr_t)ent->util));
>> +	ent->util =3D (void *)((uintptr_t)what | =
((uintptr_t)ent->util));
>> 	return (uintptr_t)ent->util;
>> }
>=20
> I actually wonder if it results in code that is much easier to
> follow if we did:
>=20
> * Introduce an "enum apply_symlink_treatment" that has
>   APPLY_SYMLINK_GOES_AWAY and APPLY_SYMLINK_IN_RESULT as its
>   possible values;
>=20
> * Make register_symlink_changes() and check_symlink_changes()
>   work with "enum apply_symlink_treatment";
>=20
> * (optional) stop using string_list() to store the symlink_changes;
>   use strintmap and use strintmap_set() and strintmap_get() to
>   access its entries, so that the ugly implementation detail
>   (i.e. "the container type we use only has a (void *) field to
>   store caller-supplied data, so we cast an integer and a pointer
>   back and forth") can be safely hidden.

Those would be better if you want a less-minimal change. I can easily
do the first two, but the last one may or may not take me a while to
figure out given I=E2=80=99m not familiar with git=E2=80=99s C =
internals.

Jess

