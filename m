Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EF7C05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 01:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjBBBDQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 20:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjBBBDO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 20:03:14 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC4168109
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 17:03:12 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id lu11so1730356ejb.3
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 17:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ynF+47CzNfFKsT7cDRkZpo/jAdZLyJqbWlMoWQEXoX4=;
        b=oUtIBiKoDx73Z0hRNq8Q2eAwi6O/iTQxkc/3JQbIio0I0NSpKU38mEP/m9cAXjiZVS
         hpGAupWAuCgD8027Q4iF+3tobI++OnmxfvWowMsI8R/ZdEZ8Pz2A0/Cn6nfw/ktMeuih
         2LsTqj2Uv2TGNwz7OEIJmD7q4RyPI508USlLNOUAfkTGuDKNL0MaRkE9NnnasKf4ve5y
         ey0gpHQ1ceteFDwQ9mqj3mztia9N2A4mvBLqctogFzQXGK37peXFx5yfx7oQZeEcQd4Y
         rEVi9+i0sWsN7DdUDK0NvxX1gjgmDTnQ7gyF9Bl7OGZr6gpBbSEok37CPuKQXrblJhHR
         gOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ynF+47CzNfFKsT7cDRkZpo/jAdZLyJqbWlMoWQEXoX4=;
        b=B0BKUfCTgW62xxk8NFzXY/MbMPc9/E8Z+6n1VDgNJTTCbkwqe8PwZnom60VEmLOuq/
         BjmK7j1XmsisvK5CwtY9RSDuD0VkJAV2Q7LcRFZ1CKpLtUPFpO0DJ4VxdEjLk4tV0x5W
         6e7mU1UnMs3PYks/+lp8IKA5rPqlw9pw2vpRa1GyYZ79VBF+yav1yh1hT2hlIkEApbIg
         V1K7lOfjKRoSQVj7beq80HOmKyDROQ4UPrxgttERxqIeKyrWINK61LlpKgVCcgADNVO9
         N1ubCYRglcD7t+avqabnSjtKtcug4IT+EbrAsizbvAXuk8ClHHMOuypXtT+2tUr6qXSX
         e4kQ==
X-Gm-Message-State: AO0yUKUO0qVx3nbW0R606m8RifIYG3wgOn6PCZTaLyEg2Wu8XuRR3CBb
        5mTTm5SZ1Lsv+5JOoM7JM1E=
X-Google-Smtp-Source: AK7set8vtZBW41CyXF+N1HW34SW5nwwIJaU0H/vYv+dKEPjIWwYVyw4L1b50cBRa84XyNGoxh5Sgbg==
X-Received: by 2002:a17:906:5283:b0:879:8752:9fb2 with SMTP id c3-20020a170906528300b0087987529fb2mr4608204ejm.67.1675299790454;
        Wed, 01 Feb 2023 17:03:10 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id os25-20020a170906af7900b008874c903ec5sm6229641ejb.43.2023.02.01.17.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 17:03:09 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pNO0K-002OMO-2F;
        Thu, 02 Feb 2023 02:03:08 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eli Schwartz <eschwartz93@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Stability of git-archive, breaking (?) the Github universe, and
 a possible solution
Date:   Thu, 02 Feb 2023 01:42:48 +0100
References: <a812a664-67ea-c0ba-599f-cb79e2d96694@gmail.com>
        <Y9jlWYLzZ/yy4NqD@tapette.crustytoothpaste.net>
        <20230131150555.ewiwsbczwep6ltbi@meerkat.local>
        <Y9mXB1LaYSUJBlwF@tapette.crustytoothpaste.net>
        <230201.86pmatr9mj.gmgdl@evledraar.gmail.com>
        <Y9ry5Wxck4s/X2B+@tapette.crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <Y9ry5Wxck4s/X2B+@tapette.crustytoothpaste.net>
Message-ID: <230202.86r0v8q3oz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 01 2023, brian m. carlson wrote:

> [[PGP Signed Part:Undecided]]
> On 2023-02-01 at 09:40:57, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> "A spec" here seems like overkill to me, so far on that front we've been
>> shelling out to gzip(1), and the breakage/event that triggered this
>> thread is rectified by starting to do that again by default.
>
> Sure, that will fix the immediate problem.
>
>> But so what? We don't need to make promises for all potential git
>> implementations, just this one. So we could add a blurb like this to the
>> docs:
>>=20
>> 	As people have come to rely on the exact "deflate"
>> 	implementation "git archive" promises to invoke the system's
>> 	"gzip" binary by default, under the assumption that its output
>> 	is stable. If that's no longer the case you'll need to complain
>> 	to whoever maintains your local "gzip".
>
> I don't think a blurb is necessary, but you're basically underscoring
> the problem, which is that nobody is willing to promise that compression
> is consistent, but yet people want to rely on that fact.  I'm willing to
> write and implement a consistent tar spec and to guarantee compatibility
> with that, but the tension here is that people also want gzip to never
> change its byte format ever, which frankly seems unrealistic without
> explicit guarantees.  Maybe the authors will agree to promise that, but
> it seems unlikely.

Maybe they won't, the point is that an upgrade of git wouldn't break
github in the way that's been observed, instead that potential breakage
would happen whenever the OS (or whatever's providing "gzip") is
upgraded.

So, if gzip promises to never change such sites can upgrade it without
issues, but if it does they'll presumably need to pin it forever.

And those sites that don't care about "git archive" stability can use
whatever their local "gzip" is, without caring that the output might
change.

>> If we wanted to be even more helpful we could bunde and ship an old
>> version of GNU gzip with our sources, and either default to that, or
>> offer it as a "--stable" implementation of deflate.
>
> That would probably break things, because gzip is GPLv3, and we'd need
> to ship a much older GPLv2 gzip, which would probably differ from the
> current behaviour, and might also have some security problems.

We're way off in the realm of the hypothetical, I don't think we need a
gzip fallback, we can make it the issue of the rare downstream user who
needs such stability.

But if we shipped a last-good gzip my understanding of software
licensing is that we could ship the GPLv3 version.

The issue with combining GPLv3 and GPLv2 works is if you do something
like upgrade our wildmatch.c to the GPLv3 version (ours is derived from
an older GPLv2 version). Then our combined work is derived from two
different licenses.

But if you're just invoking a different process those two sources can
use incompatible licenses. There's established precedence for that
throughout the industry, and it's the FSF's position on the matter.

So if we offered to build a gzip for you from GPLv3 sources shipped
in-tree that wouldn't infect the rest of git's GPLv2 code, any more than
Debian shipping both git and gzip is cross-contaminating the two.

It might cause us some hassle with distributors for whom any mention of
GPLv3 is anathema (e.g. Apple), but I understand that that's general
paranoia about its patent clauses impacting the distributor, not a
license incompatiblity.
