Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC9CC433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 23:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbiKVXFV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 18:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbiKVXFP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 18:05:15 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D58690591
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 15:05:13 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id z63so3655708ede.1
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 15:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MK0YhmkXTAQ9NN/tfudU2XPAo6MRdW2Tz5raKEygNos=;
        b=Eq3d16bMYKdN2g7Vl71/QI+jQ5MR0uIWTdSJrVT8f4xgzjN2hRZ5Auu/VorvRIx5M7
         b347dxvIZQgoomIE3FqUwsjk13U+cj7WcQflGGYfzyl4ud8H7BmN9bYzT+BiHUus3U/5
         Tu1FInRJLqpW/4e0cMTUz1txlHaYsjjGYXYwFdaIC1YYa3rhKioSXw/EFnJdWAUic4jB
         j0KldtMJPF2c2tsHwkv5FfOy5XemiRdq7InVwXGNyZ/dTsDJdIpkglgDSXMAY2XX+2xE
         t3nJjYUCloE7q+pVWwXCPilf2YrBboxqNevNCJ/RmLqKIr5FgUYqFESJzoA5qv3cb0bB
         k51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MK0YhmkXTAQ9NN/tfudU2XPAo6MRdW2Tz5raKEygNos=;
        b=plQfrZcyiBUDF1/zgf9mfS7VNldmwOE8gC+U0avpxotHNeY9nFnwTZ5/4A30ljPyTl
         X54PMgC+i8s1KS9Z561lrShWj8q426/6Ma699Malw5WYa4rqfIdAlikAATyo9oT2Ndf+
         Due2Y1pZ9NBQ+nK+8aFkTdGKctfrPv4e/4+C6+veVQhilF/yavvE3LqFK4pRwDPba6ON
         qv0tIP0YM1/SPGUvQJn7xPeNp0Hz0C2Cxq6PYhHzPSXbRZzTFnV9nIvGpuVKvCnIeRLx
         wgYaup/uulDRc9HFY7SDHtyadENrvuPYuxSVxYfbPf1hSeooR+YfMoJkzxshf+AokW0+
         hLwg==
X-Gm-Message-State: ANoB5plrSuYLQCg0HWmgZjIQLjbrdHGfbnZTOPp6Smdmg3g3biZfuJ6i
        ZJQ9Yah99/uB+U7o6IgqAuY=
X-Google-Smtp-Source: AA0mqf4qYNRq1rHSxP2D47PsdwBvfO7ELi3M7Ds2sXpFQVUlUepZ3zDx0KuJpJOXLs2IzQDhsr5r+A==
X-Received: by 2002:aa7:cc93:0:b0:462:6b8e:1ddb with SMTP id p19-20020aa7cc93000000b004626b8e1ddbmr22524094edt.276.1669158311781;
        Tue, 22 Nov 2022 15:05:11 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id kg9-20020a17090776e900b007acbac07f07sm6569388ejc.51.2022.11.22.15.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 15:05:11 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oxcKE-000pSV-37;
        Wed, 23 Nov 2022 00:05:10 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] t3920: don't ignore errors of more than one command
 with `|| true`
Date:   Tue, 22 Nov 2022 23:57:20 +0100
References: <febcfb0a-c410-fb71-cff9-92acfcb269e2@kdbg.org>
 <221122.86mt8iaamz.gmgdl@evledraar.gmail.com>
 <271dd9e6-3575-a46f-4c92-fa202aaf95d7@kdbg.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <271dd9e6-3575-a46f-4c92-fa202aaf95d7@kdbg.org>
Message-ID: <221123.86ilj6a8ux.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 22 2022, Johannes Sixt wrote:

> Am 22.11.22 um 23:24 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> On Mon, Nov 21 2022, Johannes Sixt wrote:
>>> -	grep 'Body' .crlf-message-$branch.txt >.crlf-body-$branch.txt || true=
 &&
>>> +	{ grep 'Body' .crlf-message-$branch.txt >.crlf-body-$branch.txt || tr=
ue; } &&
>>=20
>> Any reason not to make this:
>>=20
>> 	-       grep 'Body' .crlf-message-$branch.txt >.crlf-body-$branch.txt |=
| true &&
>> 	+       sed -ne '/Body/p' <.crlf-message-$branch.txt >.crlf-body-$branc=
h.txt &&
>>=20
>> ?
>
> Yes: I have tested my version, but not this one.

I don't find that too surprising, as unless there's a discussion of "I
tried xyz, but it didn't work, so..." a submitted patch is unlikely to
have tried various alternatives for such a trivial fix, but just gone
with whatever the author tried first.

But in case it wasn't clear, the implied suggestion is that unless there
is a good reason to introduce a pattern of:

	 { <cmd> in >out || true; } &&

That we should use another suitable command with the simpler use of:

	 <cmd2> <in >out &&

If the result is equivalent, as subsequent maintainers won't need to
puzzle over the seemingly odd pattern.

We have that "sed -n -e" in somewhat wide use:

	$ git grep 'sed (-n -e|-ne).*/p.*&&' | wc -l
	54

The only existing occurance of this "grep but ignore the exit code" I
could find was:

	t/t9001-send-email.sh:  { grep '^X-Mailer:' out || :; } >mailer &&

For which we can also:

	-       { grep '^X-Mailer:' out || :; } >mailer &&
	+       sed -ne '/^X-Mailer:/p' <out >mailer &&

And which I'd think would be great to have in a re-roll, i.e. "here's
these two cases where a grep-but-dont-care-about-the-exit-code could be
replaced by sed -ne".

But if re-testing this is tedious etc. I don't mind if it goes in as-is,
but then I'd think we could safely emulate the t9001-send-email.sh
pattern of using ":" instead of "true"; we don't need to invoke another
process just to ignore the exit code.



