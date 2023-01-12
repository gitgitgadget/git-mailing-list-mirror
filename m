Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDBFC54EBC
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 16:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238687AbjALQ3h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 11:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240156AbjALQ2w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 11:28:52 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D460CD58
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 08:27:48 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id hw16so34206348ejc.10
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 08:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bKccTKcwUyR4IfqjfpjSGJkLKzoV0Iw0YoDiF4oDnbE=;
        b=IsgcM3Q3URLeU9i+xNsf0jTE1iEh2mC+XsSlwF8rk/zn9EEoxRSqrBUdbKtx2jLgk8
         YptfaLmNeLx+yVbraopU4Yir2KOjA8fU6Y0meeVj3Q4QPOl/xuNdVB93Hhx9TrGm/EFh
         lvSmxm25GE/8K+35qbqkZnzImBM+jBY+vGEme+kVyER+ERVmWdpJMDAt/fHSuXTVNiJ9
         c67Gj5LD/2Fl6oe/EKF0zngJ4OwkmQmoeHZ7bnsctBTguKp0YTcI+dF1ipo70DlwADJR
         3YhOpuBIISAjcNTVrHX8rrfl3NNEWcaao7hC8YyzwVdZfDOhQGgxPZGJDXQz2/ptk84l
         obdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bKccTKcwUyR4IfqjfpjSGJkLKzoV0Iw0YoDiF4oDnbE=;
        b=tBTwROnJR8npwbnC2I4cdyOBkQezzTsfpSvaUQAJCk2fHsXfD9LqLEXqbwELxLAEPq
         OyyPj7yWK4EnRgdqpPdMrghPO5NtwUdTVYRkPtL/B3t7i84X8UGn1DOa4iouU4elxula
         VEeZZiPDYAKCz0cLftXnJ4fEWltHE+/xgdqHzRqNqhfAsH9B8hKgLAMU+03pqLVID68T
         UL/nIo7/Ro71sWQWOS4CLEM85inNtBaZUCvWrJgZzY3au4pqTrSwASKaJKcN8KAlO0Q+
         t/nyopmgrCcUlvO9JllrK6aOkP1w7SOkhw1AxhLHWWrungYvUVfP9GDg2JqUTRchebfV
         N2kA==
X-Gm-Message-State: AFqh2kpncgIJcpv2bbNEAnMxQ03dnXr/N4r003zkwIm9nIXBKdd4Jbp1
        D9gzJFnKGsTnEIf/eJnrq7I=
X-Google-Smtp-Source: AMrXdXuwU/oheBCiSBRDikHgLBfXbQ+3tqxppFyxIT2a2KaSwjnFbxnIyT2bH7vcsdAM1lGj3XiaAw==
X-Received: by 2002:a17:907:a707:b0:7c1:75e9:1180 with SMTP id vw7-20020a170907a70700b007c175e91180mr68852145ejc.22.1673540867395;
        Thu, 12 Jan 2023 08:27:47 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id a20-20020a17090680d400b007c4f32726c4sm7583415ejx.133.2023.01.12.08.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 08:27:46 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pG0Qc-000KhS-1O;
        Thu, 12 Jan 2023 17:27:46 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 0/5] cleaning up read_object() family of functions
Date:   Thu, 12 Jan 2023 17:22:04 +0100
References: <Y7l4LsEQcDT9HZ21@coredump.intra.peff.net>
 <f1028cba-5fc6-3584-3f21-545550012e9d@github.com>
 <Y77/T8dktee3wOA5@coredump.intra.peff.net>
 <230112.86fscg2jbm.gmgdl@evledraar.gmail.com>
 <Y8AyTE3OS7HCAzKH@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <Y8AyTE3OS7HCAzKH@coredump.intra.peff.net>
Message-ID: <230112.86v8lbzpj1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 12 2023, Jeff King wrote:

> On Thu, Jan 12, 2023 at 10:21:46AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> I agree that it's probably not worth it here, but I think you're just
>> tying yourself in knots in trying to define these macros in terms of
>> each other. This sort of thing will work if you just do:
>>=20=09
>> 	diff --git a/object-store.h b/object-store.h
>> 	index e894cee61ba..bfcd2482dc5 100644
>> 	--- a/object-store.h
>> 	+++ b/object-store.h
>> 	@@ -418,8 +418,8 @@ struct object_info {
>> 	  * Initializer for a "struct object_info" that wants no items. You may
>> 	  * also memset() the memory to all-zeroes.
>> 	  */
>> 	-#define OBJECT_INFO(...) { 0, __VA_ARGS__ }
>> 	-#define OBJECT_INFO_INIT OBJECT_INFO()
>> 	+#define OBJECT_INFO_INIT { 0 }
>> 	+#define OBJECT_INFO(...) { __VA_ARGS__ }
>
> Right, that works because the initializer is just "0", which the
> compiler can do for us implicitly. I agree it works here to omit, but as
> a general solution, it doesn't.
>
>> Which is just a twist on Ren=C3=A9's suggestion from [1], i.e.:
>>=20
>> 	#define CHILD_PROCESS_INIT_EX(...) { .args =3D STRVEC_INIT, __VA_ARGS__=
 }
>>
>> In that case we always need to rely on the "args" being init'd, and the
>> GCC warning you note is a feature, its initialization is "private", and
>> you should never override it.
>
> Right, and it works here because you'd never want to init .args to
> anything else (which I think is what you mean by "private"). But in the
> general case the defaults can't set something that the caller might want
> to override, because the compiler's warning doesn't know the difference
> between "override" and "oops, you specified this twice".
>
> It's mostly a non-issue because we tend to prefer 0-initialization when
> possible, but I think as a general technique this is probably opening a
> can of worms for little benefit.

You're right in the general case, although I think that if we did
encounter such a use-case a perfectly good solution would be to just
suppress the GCC-specific warning with the relevant GCC-specific macro
magic, this being perfectly valid C, just something it (rightly, as it's
almost always a mistake) complains about.

But I can't think of a case where this would matter for us in practice.

We have members like "struct strbuf"'s "buf", which always needs to be
init'd, but never "maybe by the user", so the pattern above would work
there.

Then we have things like "strdup_strings" which we might imagine that
the user would override (with a hypothetical "struct string_list" that
took more arguments, but in those cases we could just add another init
macro, as "STRING_LIST_INIT_{DUP,NODUP}" does.

For any such member we could always just invert its boolean state, if it
came to that, couldn't we?

Anyway, I agree that it's not worth pursuing this in this case.

But I think it's a neat pattern that we might find use for sooner than
later for something else.

I don't think it's worth the churn to change it at this point (except
maybe with a sufficiently clever coccinelle rule), but I think it's
already "worth it" in the case of the run-command API, if we were adding
that code today under current constraints (i.e. being able to use C99
macro features).
