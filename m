Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80297C4708D
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 23:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiLGXyA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 18:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiLGXx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 18:53:57 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5C68B3B7
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 15:53:57 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id d20so65038edn.0
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 15:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cq+EQviSDCUiY8bzmtwjv5owgTDZwg0bZNxpuIQMDrA=;
        b=hsEWc7wTXEIP845F/xyyV+kGkkAhxsPID4/hfn220Yse/gKZD/I1CrNNppoegrcKHO
         lJ3oNDqWjt4DpAub5ilEM2nGUNEX8W4l5AOaYt4xoSSCzFAynuwtNxqVA5Mc1q7FPu83
         4IMxo4TCk/75YEVIHUuSP1FLA7yD7sepjiuUMGZlzo0O4jk5YLP+5dKCMu8fbiLXCHSj
         26qBKmMbGi6hZSiK4EZ6UVY4a1pdbBXCMHXfb2Xw8i3s4cPFR/nR3CvJBDBoEQrEU6pI
         5WEIAzYqTeSq2RqDUkLWLKZ3J7BeqYBEm/k0rMRber/OqiqczqDelUeRO5u8HfT9COHF
         uoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cq+EQviSDCUiY8bzmtwjv5owgTDZwg0bZNxpuIQMDrA=;
        b=dhl+aczMzZmfQgY8gnvnNlXeUPBljFjb+QcxbnR8HHSWOUyDekyEP+/p8EXe6ud0iK
         gktB5MOAC5F0iE0E2YCE5dMNN614iFhJ8hFPNK7qlwcoZFr5+q1QARa559Lk+W9fFJNK
         QWI+ekkX1TuZ5b/eMf9ibulUZ8dNboxztDRVDMtV+ULBy6u+4DFKPR5h03VMXfC7WYNb
         N5WKzGAa5NRD26EUFH0IxBUGBehcI0L7lsbESObSWOM2db7zuMmkXv1+TnqV32bM8cd1
         JQIB3i16wIQgWCfdtN9sQgxDKEJApRWfE2NgSEq2JqC3JkO7q9YOLMO6zzPbGSXm0OIk
         XTgQ==
X-Gm-Message-State: ANoB5pkhZtAMcDrOzOjZtdsowVMKWcAIh8JIZ9RdN818y1vLiwTnN9h3
        mCNey9WA0JU4jm6hgnpbTZU=
X-Google-Smtp-Source: AA0mqf5Yd+YKrDAxNzgcKlJa8+DjFaJOUiEiZZAxkrUwGsVVSREUV58q76IlqmzDJfw4i6AlXqxBuA==
X-Received: by 2002:aa7:d905:0:b0:46d:1c38:1537 with SMTP id a5-20020aa7d905000000b0046d1c381537mr1018222edr.29.1670457235421;
        Wed, 07 Dec 2022 15:53:55 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id d36-20020a056402402400b004585eba4baesm2779239eda.80.2022.12.07.15.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 15:53:54 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p34Ec-004i6f-1A;
        Thu, 08 Dec 2022 00:53:54 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 2/3] object-file: emit corruption errors when detected
Date:   Thu, 08 Dec 2022 00:50:27 +0100
References: <221207.86pmcva2s8.gmgdl@evledraar.gmail.com>
 <20221207232623.1439026-1-jonathantanmy@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221207232623.1439026-1-jonathantanmy@google.com>
Message-ID: <221208.86edta93e5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 07 2022, Jonathan Tan wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Yeah, I think that's even better, although...
>
> [snip]
>=20=20
>> > It's also kind of weird that map_loose_object_1() is a noop on a
>> > negative descriptor. That technically makes this correct, but I think =
it
>> > would be much less surprising to always take a valid descriptor, and
>> > this code should do:
>> >
>> >   if (fd)
>> > 	return -1;
>> >   return map_loose_object_1(r, path, fd, size);
>> >
>> > If we are going to make map_loose_object_1() less confusing (and I thi=
nk
>> > that is worth doing), let's go all the way.
>>=20
>> ...maybe we should go further in the other direction. I.e. with my
>> earlier suggestion we're left with the mess that the "fd" ownership
>> isn't clear.
>
> With Peff's suggestion I think we can make the function always close
> the fd. If we find it not to be clear, we can rename the function
> to ..._close_fd() or something like that.
>
> Thanks to both of you for your suggestions.

I think that was my suggestion.

Peff's on top of that was to never have it *open* the fd, but I'd left
one caller doing that.

I.e. that the ownership would still be passed to it, but at least it
would always be passed, and wouldn't be the mixed affair that my initial
suggestion left it at.

I'll leave it to you to pick through this.

I have a mild preference for my latest suggestion as the ownership of
all the variables seems cleanest in that iteration. I.e. we don't need
to xstrdup(), and the "fd" is always contained within
map_loose_object_1().

We still have the "sometimes a path, sometimes I make a path from an
oid" semantics though, but that seems unavoidable.

