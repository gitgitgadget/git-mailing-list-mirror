Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B06C636D3
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 02:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjBICTo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 21:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjBICTm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 21:19:42 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341D31C325
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 18:19:41 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id dr8so2294497ejc.12
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 18:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n0ajWVHB/2QfC3Jgdtt82zuLCXEVJ9nSmq/5D9kwjl4=;
        b=p6cIWXi4eIhHqVLcKLzDI+exQ8p2c+52WNudWk4bF37MBLImFAbAoduFvhC2uC/xgw
         SRcY9WQRCMclkDY0kgxY6iz+VFAe2pRYOThohrj+BEqZ5hs+nk2LrGik9LE1J5Iy12dS
         mS3df5H6rfBU5RosUHqrOD4+MNq+ldc3t672emUeB98YtUQCf6hY/MqoBFOHDr5XA95M
         pSKIDZwgPwCY+C5H74QTgJRE32Rv0ByIo/1GdjSsOySoKK9jRRb1VzlJL5ToqC8or9yV
         kT4kAXmMqwI/fphc/3gtAOCr5YHuXxWZ28NWVNHWGJ5jtJOy/Zh92xAkp+tTX4888muH
         J0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n0ajWVHB/2QfC3Jgdtt82zuLCXEVJ9nSmq/5D9kwjl4=;
        b=huY9xAXrVhdQujXRuwoqg7f/Ni0SMHQaS7KZIKV2hRUNQzk2qrxL1mLGAe3OOm0xyt
         4MiXQOdAuE9xNOS9OkPTkxNivf1RXaJh0HGE5GXcQj/eNkCHqdeGymtZBphck+mFDfog
         AgTeftBqdvKs96cnlgxAMjP7x1ClHoRHA1EMNKa8KEMgxbTsPsOmBbd7dNsE/CSIkYtO
         XwFNsIlJicjFFyeJoJi6kRlsQ1gXDiTlLsh/mfrNDeFLclKZsApPgdudCyzl2QxCAbWk
         acXg0s7Fbj1pasWeb0a2/VtBmXS3pSWRl1fvUD9y7EVSDxY0DkOUwPUH1kbxEnHXaMr4
         iO/Q==
X-Gm-Message-State: AO0yUKUbFwhla6nRdjq/gCgKAYYjiaXz+TQ4eV4OeIR0esyrA4IPD3cM
        PVxEIvYPfiigXNB3HRV4pNn80TrZqAthy6cI
X-Google-Smtp-Source: AK7set8VNGDWCobWmGYTQvqBWoAqHqX+g4jTRztP2+hCd+8h7TzLGQReeoZQ3mq5ltLmAE1HAlQiOw==
X-Received: by 2002:a17:906:a287:b0:877:573d:e919 with SMTP id i7-20020a170906a28700b00877573de919mr9999035ejz.20.1675909179736;
        Wed, 08 Feb 2023 18:19:39 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id p3-20020a1709060dc300b0088f132432cdsm227536eji.61.2023.02.08.18.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 18:19:39 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pPwXC-001bq4-1o;
        Thu, 09 Feb 2023 03:19:38 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] test: make SYMLINKS prerequisite more robust
Date:   Thu, 09 Feb 2023 03:15:07 +0100
References: <xmqqwn4sq73f.fsf@gitster.g>
 <230209.86k00rzqsz.gmgdl@evledraar.gmail.com> <xmqqbkm3ppn8.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <xmqqbkm3ppn8.fsf@gitster.g>
Message-ID: <230209.86ttzvy405.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 08 2023, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> I wonder if something like this is in order?
>>
>> I don't have much to contribute on that front, but this is really
>> missing some "why", this worked before, why is it failing now? Do we
>> have any idea.
>
> Your guess is as good as mine.  I do not do Windows.
>
> Thanks for independently noticing the uninitialized strbuf.  What I
> have queued has it fixed already locally but there isn't much point
> to send another copy out to the list ;-).
>
>> All in all a simple helper, but isn't this redundant to "test_readlink"?
>
> Not at all.  We need to avoid the Perl one for this purpose.  What
> matters is whether "git" considers if symlink is working.
>
> Perhaps our readlink(3) emulation we have in compat/ may hardcode
> our "knowledge" that symlink is not available in Windows, which may
> not match what the POSIX XCU emulation in our Windows environment
> offers, which apparently ran "ln -s x y && test -h y" successfully,
> and who knows what test_readlink that is written in Perl thinks?

Yeah that's fair, I wonder why we haven't replaced this already...

FWIW I think this is what perl will dispatch to on Windows, so it makes
your point, it has its own NIH Windows emulation layer:
https://github.com/Perl/perl5/blob/blead/win32/win32.c#L1983-L2026

> We
> are testing "git" with the test suite, so even if with some magic
> that is still unknown to compat/mingw.h it knows how to read what
> "ln -s x y" left in "y", until compat/mingw.h::readlink() learns the
> same trick, asking Perl to decide SYMLINKS prerequisite would not
> help our test scripts at all.

We could always see if they return the same answer :) But not worth
pursuing in this case.

>> If you're trying to avoid leaving litter or cleaning up that's not
>> needed anymore with these lazy prereqs for a while now (they get their
>> throw-away temporary directory).
>
> Indeed, I just did not want to add another cruft, but 'x' and 'y'
> are already such crufts, so I could have just done
>
> 	ln -s x y &&
> 	test -h y &&
> 	test-tool readlink y >x &&
> 	test $(cat x) =3D x
>
> to use one of them ;-)

Yeah, I mean you don't need to avoid cruft, because the whole directory
is about to be rm -rf'd

Now that I've dug it up I see you implemented that in 04083f278d1 (test:
allow prerequisite to be evaluated lazily, 2012-07-26).

I was recalling 53ff3b96a87 (tests: make sure nested lazy prereqs work
reliably, 2020-11-18) as the more recent change, but that just solved a
nested prereq edge case.

