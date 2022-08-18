Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B08BC32792
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 15:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343934AbiHRPAv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 11:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343935AbiHRPAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 11:00:16 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DB34F66E
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 08:00:13 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u14so2030479wrq.9
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 08:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=Ew6UokQZLdtMDTgeqFxl9r0EnBvYh5H6ZfIpU/ftRrg=;
        b=lkNA6ldvOdeFfIiHLiFLokVsg+sCAAPipQL1kixVjXpY09zhq0oN9PqlkEdfaQEQaL
         k+FGyustiwDKryA6qbsWMqHA2SV1B7tR6hWHj4HrHDfImSj5gyFXhzrG3b8f3zDdY4lY
         XaDgUqWtYqJ/2HSZxynqIpS7VnVGlKTc+xESYkKyv6Z7RKrzmCWftSaQQnIsaJUKDJkz
         vXGag7Nm9kc6m2qQUyw0QM+LNiVzjR3f8pSFTAVsb3e80U6mXm1d7zSxNBrG/D7jzgAf
         edE/Fx8vE9Mm2xXD27gz9D17yiBYdWsft88Q/b6MtNzwBT7zLVL3u5aUCpaTTwbeTemn
         rUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Ew6UokQZLdtMDTgeqFxl9r0EnBvYh5H6ZfIpU/ftRrg=;
        b=ADSJQWHxiwouzf9dw99OkAlNK3fuKICDG941FkxeIUwqVvNtYcD4fTAkw/iJ9qS2rz
         5dQkpX+nQxgbxTalUUAJBTgFvFcS5qCa94BN58sJckEo8EJ0EaBgADKM6XQaCbOmf3gO
         pf1SV6vroeCYRPl7FDAD3hwFBD+5gl7Du6g0xT221qNrrelpu4kFVIdJWfBSuKvqfhwX
         InujzKCmX56YFX5LG1nqF6UJW6OyJo8SqryS3WIo6K2NDtiYR61schzWa3RwHdk5yxIV
         ov1CkoPQzj+movjwym5cszjgCyT3EC00todTPZ9Jb3pfbwKkEakOpydri7PY0xNoSWKw
         4gpw==
X-Gm-Message-State: ACgBeo3Oz8T2zh2y8MoF2tK97JSKG5pA9GJKiuiPJ7TRkNUDYp7vfJz/
        1WNWlQOtp0WW58RAkLDuk58=
X-Google-Smtp-Source: AA6agR4PWIIufD/Z7uuXU274rKEWjzdKSW2nB99O4Eo5w3/98OP/+thbC8tZ2H8saAqq+jo0zVY7aw==
X-Received: by 2002:a5d:43d1:0:b0:225:2707:dee with SMTP id v17-20020a5d43d1000000b0022527070deemr1862896wrr.25.1660834812215;
        Thu, 18 Aug 2022 08:00:12 -0700 (PDT)
Received: from gmgdl ([213.220.124.15])
        by smtp.gmail.com with ESMTPSA id p30-20020a1c545e000000b003a500b612fcsm5723788wmi.12.2022.08.18.08.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 08:00:11 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oOh0C-000HET-2O;
        Thu, 18 Aug 2022 17:00:08 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 1/4] sequencer: do not translate reflog messages
Date:   Thu, 18 Aug 2022 16:55:54 +0200
References: <09rn6r61-38qo-4s1q-q7qq-p5onp6p87o44@tzk.qr>
 <cover.1660828108.git.git@grubix.eu>
 <ea6c65c254bb08b20ea6c4d81200b847755b555c.1660828108.git.git@grubix.eu>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <ea6c65c254bb08b20ea6c4d81200b847755b555c.1660828108.git.git@grubix.eu>
Message-ID: <220818.86zgg18umf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 18 2022, Michael J Gruber wrote:

> Traditionally, reflog messages were never translated, in particular not
> on storage.
>
> Due to the switch of more parts of git to the sequencer, old changes in
> the sequencer code may lead to recent changes in git's behaviour. E.g.:
> c28cbc5ea6 ("sequencer: mark action_name() for translation", 2016-10-21)
> marked several uses of `action_name()` for translation. Recently, this
> lead to a partially translated reflog:
>
> `rebase: fast-forward` is translated (e.g. in de to `Rebase: Vorspulen`)
> whereas other reflog entries such as `rebase (pick):` remain
> untranslated as they should be.
>
> Change the relevant line in the sequencer so that this reflog entry
> remains untranslated, as well.
>
> Signed-off-by: Michael J Gruber <git@grubix.eu>
> ---
>  sequencer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 5f22b7cd37..51d75dfbe1 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -575,7 +575,7 @@ static int fast_forward_to(struct repository *r,
>  	if (checkout_fast_forward(r, from, to, 1))
>  		return -1; /* the callee should have complained already */
>  
> -	strbuf_addf(&sb, _("%s: fast-forward"), _(action_name(opts)));
> +	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
>  
>  	transaction = ref_transaction_begin(&err);
>  	if (!transaction ||

I 95% agree with this direction, but the other 5% of me is thinking
"isn't this fine then? Let's keep it?".

I.e. from the very beginning we've really tried not to translate file
formats and plumbing, to the point of having the (now removed) "gettext
poison" facility to try to smoke out any such cases (but it wouldn't
have caught this one).

We've even done this to the point of not translating things like the
"revert" template, even though that's an entirely "soft" file format as
far as anyone being able to rely on it goes.

But reflogs are local-only, if you're using Git in German isn't it
useful to you to have this messaging in German too? We don't "push" them
around, and to the extent that there's shared environments they (should)
ensure LC_ALL=C if they care.

Of course more useful would be if we wrote it in some language-agnostic
format and changed it on the fly, but perhaps we've inadvertently run an
experiment here that's shows us this is fine?

We do have some translated "file format" output already, notable
whatever we write into the "gc.log". Perhaps we should treat this the
same.

I'm *not* noting the other 95% argument(s) for accepting this change,
just playing devil's advocate for the 5% one :)


