Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B59BC3A5A7
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 12:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiLHMeW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 07:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiLHMeU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 07:34:20 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157F42AC
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 04:34:18 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id n21so3469374ejb.9
        for <git@vger.kernel.org>; Thu, 08 Dec 2022 04:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QGvP/75VLqnVwo0h70Pvnb38gkq3HK1Cic/uM9HR5Bw=;
        b=CLI8F1rzkKVZP1yrigCMurUDDKmALE1QacQ4AkVLUr4heig3l+xJIwqnsIby0aliLl
         o3Dsp2xPobBja6/fOHCENDwYIIxqnZqtiAzEmksL/EcLdQKwcamNAS6Y17ynhypq/wGl
         x4GdMZE87kEl5N/KanChBnwK8OazMq+vUWLnXljpeOZgvO+jjCdv5uNP150NE5cNxblq
         LiZhM+uoVG0pi5OMuUsDJB1Z9n+e9mLjXWRbeSpro/GknMvywBku/2waL43mr/6H8+J2
         9M4ZMo3XYwdUl9TLpun+38x3X7130gcyXZG8fbyuIfaJtGGc89yzKoQFTUMIfHK+j5+C
         KX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QGvP/75VLqnVwo0h70Pvnb38gkq3HK1Cic/uM9HR5Bw=;
        b=RJjfzCjAq1XaKuf70JJ9t46SOKs7xAMS6koHWUsD34l5/QoW/K9nWSI5r1kCdmeUs6
         kFhhbEdNQkWVqsc4pCU5z+c2qpn6dJNhbpIp69SnvB29sE+IVFss1WAsLiFSnF1wCHCO
         vm00dPWkGXUHRAVs/2ai/Lyi62zO369jy54YxL6/ESLVsvkP4tKyE092oVdWStnuT+DJ
         z+K03mvJimVVVLr6iYTRhBLhuhXI+Lpko45pQ0XuisFvyCw1KMyh7Uu0/m9SIwI5+vyb
         vBDD4olo+eBsGHyjzm0j/pel13ADj1rjYFJxhVQci/DKJfrwCNIZSFVL7bBx19He0pZb
         7uUQ==
X-Gm-Message-State: ANoB5pnKjMmQkCXfkmV0cujLgZxRkQ2VUhbbAhduI71dbNtCw8HPH5tY
        k7gm+is/UJCu9LAmm9stgUA=
X-Google-Smtp-Source: AA0mqf5sYDAL/64SwltdERshu0nuzfKpEhrRGv0TaZ/4daIpfXM+sI1XwFeCU+9Hv8d7tEHvQs6bPg==
X-Received: by 2002:a17:906:1984:b0:7c0:8c83:79b8 with SMTP id g4-20020a170906198400b007c08c8379b8mr1767551ejd.53.1670502856477;
        Thu, 08 Dec 2022 04:34:16 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id fe17-20020a1709072a5100b0073d7b876621sm9597930ejc.205.2022.12.08.04.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 04:34:16 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p3G6R-00534s-1u;
        Thu, 08 Dec 2022 13:34:15 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] CI: don't explicitly pick "bash" shell outside of
 Windows, fix regression
Date:   Thu, 08 Dec 2022 13:20:01 +0100
References: <patch-1.1-08dc682926a-20221207T031459Z-avarab@gmail.com>
 <patch-v2-1.1-c34fd06623a-20221207T120220Z-avarab@gmail.com>
 <271d275e-df40-76e5-3930-89ab63961fb2@dunelm.org.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <271d275e-df40-76e5-3930-89ab63961fb2@dunelm.org.uk>
Message-ID: <221208.86sfhq6pmg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 08 2022, Phillip Wood wrote:

> Hi =C3=86var
>
> On 07/12/2022 12:03, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> When the "js/ci-github-workflow-markup" topic was originally merged in
>> [1] it included a change to get rid of the "ci/print-test-failures.sh"
>> step[2]. This was then brought back in [3] as part of a fix-up patches
>> on top[4].
>> The problem was that [3] was not a revert of the relevant parts of
>> [2], but rather copy/pasted the "ci/print-test-failures.sh" step that
>> was present for the Windows job to all "ci/print-test-failures.sh"
>> steps. The Windows steps specified "shell: bash", but the non-Windows
>> ones did not.
>> This broke the "ci/print/test-failures.sh" step for the "linux-musl"
>> job, where we don't have a "bash" shell, just a "/bin/sh" (a
>> "dash"). This breakage was reported at the time[5], but hadn't been
>> fixed.
>> It would be sufficient to change this only for "linux-musl", but
>> let's
>> change this for both "regular" and "dockerized" to omit the "shell"
>> line entirely, as we did before [2].
>> Let's also change undo the "name" change that [3] made while
>> copy/pasting the "print test failures" step for the Windows job. These
>> steps are now the same as they were before [2], except that the "if"
>> includes the "env.FAILED_TEST_ARTIFACTS" test.
>
> What's the motivation for this part of the change (which is completely
> unrelated to the choice of shell)?

That the stated aim of [3] was to bring back the code prematurely
removed in [2], this is merely an attempt to bring us back to that
pre-image.

> Having the test failures under
> "Print test failures" makes it easy for new contributors to see where
> to click to see the full output for test failures. Now they will
> appear under "Run ci/print-test-failures.sh" which while not terrible
> is not as clear.

Maybe that's worth doing, I just thought it was as unintentional as the
"bash" change, [2] didn't advocate for changing the "name" fields, or to
add a "shell". Just to bring back [3]. It didn't, and this change does
that.

Maybe we should add "name" fields to everything, but I think that's best
done as a follow-up, and not argued on this regression fix (which is in
"next" already).

But just to comment on the substance of that:

I don't think it's worth it to do so for the *nix recipes.

Unlike e.g. "bundle artifact tar" in the Windows recipe -- which really
benefits from that "name", rather than dumping some opaque command at
the user -- the *nix ones are self-descriptive.

We're not adding any new information by giving
"ci/{install-dependencies,run-build-and-tests,print-test-failures}.sh"
an explicit title. The current implicit title gives you a description
*and* reminds you of what script in ci/* is driving that step.

But this change really was not intended to take a stance on that
question, just to complete the incomplete revert in [3].

I really don't feel strongly about it. But if we are adding titles to
the *nix ones, let's add it to all of them, just as with the Windows
recipe. That wasn't done in [3], which along with the lack of commit
message mention of this change is why I inferred that it wasn't
intentional.
