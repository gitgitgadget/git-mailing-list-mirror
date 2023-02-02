Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2773BC636D3
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 00:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjBBAcn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 19:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBBAcm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 19:32:42 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617DA70D5E
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 16:32:41 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ml19so1698369ejb.0
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 16:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=57Ed71AXyEeHaWGmuUVKqEWc4Me2tpLBAq1Y8zYGZ0s=;
        b=HcwME3CaV5x7QXUhrZWJZh0xL1LwJP+vuMwZiaieer/t5qK8N8ssARbwUKaS07YyC1
         kmh+3Sa0MeUW0gcXSg35Pt0XDzER+L4hX9mFlfJZ/v+wlPSeQP2jDolMogUWBrlB6+g/
         JN1YkbLKzqeKeRkTpqvehdnlxoorlH+ZFe1e65WfhF523kDAmjBw44fB1FhlqCtfS5JR
         9gbaFaTGV8PwDYD7PKFC9fxFNtz2bWO+xrbgEJiba8NBc3XeR+lSoXJjEwS3JtH+N/k9
         0VAevDkrWv7pv6Tdd+AplUgW2GU79+GjEk8ziS5mUklnvkI73EiEMzEbv7X8YAeww3fK
         zkpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=57Ed71AXyEeHaWGmuUVKqEWc4Me2tpLBAq1Y8zYGZ0s=;
        b=QLGqUb1waoQ5tU3eW26R8XIHuC9nLK3ysgKCpvQQRsM0r4JAkhhwVjHHrTnNi9JFz2
         XW/H3n0KAmyWQ+u/anxSrz6u7QvA9MBiKubEUa1bVqGPNzVOaS0hY1q61TAafYBRAcLV
         ZnHV/kWQoXdV1eCUfwh2HSCoH76iBmhzQ82atSbTDzqR+jYIBb1qXIF+NVvBQkZj/Kvn
         ohzOqqq20iKmcdl7n+VmAvaPuLvxfKmJgIzyzJPgrj4+ZCNiMtyLjzvAyTXGV9+FMM99
         0rHxob05s8y/alxEES9DcXWNyZTc5TUwYEtn0UbkK6BA3LTaQ/6lmTDhPlfkURXgwvEn
         kTLQ==
X-Gm-Message-State: AO0yUKVzHWBH5NVAq+zT0OyyymauQ2qUsl+oKuqo+7tj15fI9BYKPNgt
        LawWmLuygDEzGognSpnmfKrGjkS1ZkOeK86H
X-Google-Smtp-Source: AK7set8jKli8ORHxnp0V4nS0BYw9C1kVFsMZwHz55Aq1pk/fnD4jFal6J+gTUawfxzrBrORSflsA0w==
X-Received: by 2002:a17:906:5ac7:b0:882:1b70:8962 with SMTP id x7-20020a1709065ac700b008821b708962mr4157668ejs.76.1675297959920;
        Wed, 01 Feb 2023 16:32:39 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id ci22-20020a170906c35600b0087bcda2b07bsm9405901ejb.202.2023.02.01.16.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 16:32:39 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pNNWn-002NVd-2f;
        Thu, 02 Feb 2023 01:32:37 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>,
        git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        Bernhard Reiter <ockham@raz.or.at>,
        Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH] imap-send: replace auto-probe libcurl with hard dependency
Date:   Thu, 02 Feb 2023 01:20:31 +0100
References: <20230201113133.10195-2-worldhello.net@gmail.com>
 <patch-1.1-3bea1312322-20230201T225915Z-avarab@gmail.com>
 <xmqqlelhx973.fsf@gitster.g> <Y9r84bezJ0scapwC@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <Y9r84bezJ0scapwC@coredump.intra.peff.net>
Message-ID: <230202.86v8kkq53u.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 01 2023, Jeff King wrote:

> On Wed, Feb 01, 2023 at 03:22:24PM -0800, Junio C Hamano wrote:
>
>> > Let's also hide the old --curl and --no-curl options, and die if
>> > "--no-curl" is provided.
>>=20
>> In other words, if we are building imap-send, we sure know cURL is
>> there, and there is no need to tell a running imap-send not to use
>> cURL to talk to the IMAP service?  I am not sure the linkage of this
>> change with the rest of the patch.  Isn't that a totally orthogonal
>> issue?  Your imap-send might be cURL enabled, but unless we stop to
>> ship with our own IMAP routines compiled into imap-send, --no-curl
>> does have a purpose.
>>=20
>> Or did you just forget to document that we stop to ship with our own
>> IMAP routines in the above?  If so, as long as it is made a bit more
>> prominent in the proposed log message in a reroll, I would be happy
>> with such a change rolled into the same patch.
>
> FWIW, I had the same urge as =C3=86var, to drop the non-curl support
> completely, and was puzzled that his patch did not have a big code
> deletion. ;)

FWIW I arrived at this from looking at the mandatory $(shell)-outs in
the Makefile, and wasn't looking to drop the OpenSSL code.

Then in looking at that, I found that we could probably make the curl
dependency mandatory.

> The problem is that the tunnel mode still relies on the non-curl code.
> There was a series to address that a while ago:
>
>   https://lore.kernel.org/git/ab866314-608b-eaca-b335-12cffe165526@morey-=
chaisemartin.com/
>
> but it ran into the problem that curl did not support PREAUTH
> connections (which is one of the main points of tunneling). It looks
> like that got added to curl via their befaa7b14f, which is in curl
> 7.56.0 from 2017. That's not old enough for us to require for http, but
> might be OK for a marginal component like the tunneling mode of
> imap-send.
>
> I think there was also some question of how you even get the tunnel
> going. Curl really wants to have a single socket descriptor, not two
> pipe descriptors, so there may have to be some trickery with
> socketpair(). There's more discussion in the linked thread.

That's neat, I didn't know about that attempt.

> So I think there's a path forward here for getting rid of the legacy
> code (and I'd be really happy to see it gone; it's imported code that
> does not seem super well maintained by us). But until we do that,
> disabling --no-curl doesn't seem like that big a win, if that code can
> all still be triggered for tunnel mode.

I think the biggest win is that we're dropping the dual curl/OpenSSL
codepath for everything except the "tunnel" mode, which is really
obscure compared to the already-obscure functionality of the main
"imap-send" tool.

It would also get us part of the way to e.g. depending on 7.56.0, as a
hard dependency on curl (and a newer version than we usually depend on)
would reveal if anyone's got an issue with that stepping stone.
