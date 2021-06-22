Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349B0C2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 18:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17E61611CE
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 18:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbhFVSOz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 14:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhFVSOx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 14:14:53 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C40AC061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 11:12:36 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id he7so35875866ejc.13
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 11:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=t0Xy3idCuFLArPw/OIOoep7D5Z+/mfrtRtsdMBlL3CM=;
        b=awkrGhgY8n+uRyPFJu3AV5OaXQyxhaQ/o3p7UBoS0Zr8mTf8NqLL4rlTmNljSuk0sF
         ExA+lpj3P+BBGbJOFiMxR4JVLw7Lcw8Ll1GyKSdKLQGPIao6gB8svn65wGG4PBf9N5Fa
         sMtw+zuw2a92I1eJnGd+EpvZiN//THpPlaqKF5x3+6LShikvjPuWfswjK8B1R8yi4YC/
         994meKbj1ZU/nadepKLlVjj121dLWIUw7f/i2RLvmlDM80Hp9WWcHPZxssnsmgYbppWc
         7+280cLMONYaYjexFDtmWPDG7WEJ7vqkxHD8iOsBahagZgEd6Gs/GJmT7ZShJiMDluqI
         NtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=t0Xy3idCuFLArPw/OIOoep7D5Z+/mfrtRtsdMBlL3CM=;
        b=OAkMUpWYxKtkX/c+KoVL4QYHP1veNZ9h3KmoSmNLaCmS5tPPlX/Vxp6LUpWGk1pQGZ
         E+hG5J4s5YIVF5roMWfOFctQEogsPC3uQ/BpGUL78vUgzu8gkfDx0HcRWMBDUhcfw4PN
         MfKqOLcHr+l6tdwRahvKMUNm3HQxq7fwOihUZ82HC3wv/73ulzAxsmhmvagqk8C2dEEY
         lO8E3Xx2pS76cGROOIFFr7+qJ4xtVENpUo3NCft3x2P4lRlEv74WEIbNOaqPLmUpM0fg
         +bwIVg2gU0gB9RQK1fecUGkszpRYDXKfQHGMT1GpbqMomTfwMylop4Vk3Vgc56oLzWYf
         lbaQ==
X-Gm-Message-State: AOAM531aLbjFFHxCr7mNeCF6BQYg+H8ijIt21IVtLl/ZrrwMGc18+pjf
        od8b0a/VA3t6VnseXa2aPqs=
X-Google-Smtp-Source: ABdhPJxDxSVONKJYkXfyXZthQtGIIYLCayG12y5rFRtaPJ+I4X27NJr6Ll1pW8IZbfpCozY6WgjEgg==
X-Received: by 2002:a17:906:3794:: with SMTP id n20mr5212315ejc.276.1624385554773;
        Tue, 22 Jun 2021 11:12:34 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id du7sm12438062edb.1.2021.06.22.11.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 11:12:34 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Makefile: add and use the ".DELETE_ON_ERROR" flag
Date:   Tue, 22 Jun 2021 19:34:13 +0200
References: <patch-1.1-9420448e74f-20210622T141100Z-avarab@gmail.com>
 <YNIBRboFiCRAq3aA@nand.local>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <YNIBRboFiCRAq3aA@nand.local>
Message-ID: <8735t93h0u.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 22 2021, Taylor Blau wrote:

> On Tue, Jun 22, 2021 at 04:13:13PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> Use the GNU make ".DELETE_ON_ERROR" flag in our main Makefile, as we
>> already do in the Documentation/Makefile since db10fc6c09f (doc:
>> simplify Makefile using .DELETE_ON_ERROR, 2021-05-21).
>
> This all looks quite reasonable to me. I would be happy to see us use
> .DELETE_ON_ERROR instead of the "write to a temporary file and the move
> it into place" pattern, but my only reservation is nicely summarized by
> Peff in [1].
>
> I do think that .DELETE_ON_ERROR is less robust when running "make" in
> one terminal and inspecting the result in another, but I'm also not sure
> how much we should be concerned about that. On the other hand, we lose
> a nice property of our existing Makefile which is that you can always
> run ./git and get a working binary. The new state is that you might see
> a half-written binary.

I think that here you're responding not to this patch but something more
like what Felipe used DELETE_ON_ERROR in db10fc6c09f (doc: simplify
Makefile using .DELETE_ON_ERROR, 2021-05-21).

These are all part of "mv $@+ $@" patterns, so the change is:

 1) We don't rm $@ at the beginning, so the time you'll have your
    working binary is extended. There's no point now where it disappears
    as the rule is midway through running.

 2) If it dies midway and we don't get to the "mv" part the error isn't
    persistent, your halfway written "foo" gets removed by make itself.

I don't think the way Felipe used it in his patch is an unambiguous
improvement, it would need to be some combination of reverted/adjusted
if we went for the "anything you make must always have a 100% working
copy" general approach in:
https://lore.kernel.org/git/cover-0.6-00000000000-20210329T161723Z-avarab@g=
mail.com/

But as discussed below I think Junio wants to actively not have fixes in
that area, so the point is moot.

> That makes me a little sad, but it does leave us with a much cleaner
> Makefile as a result. So, I'm not really sure how to feel about it. I
> think in general I would be happy overall to see this picked up.
>
> [1]: https://lore.kernel.org/git/YGQdpkHAcFR%2FzNOx@coredump.intra.peff.n=
et/

Yes, it makes me sad too, but as noted above I think you're right about
the general case, and so is Jeff in that E-Mail you linked, but it
doesn't apply to these patches, or my earlier patches.

I'd like us to always have a working binary, but from my understanding
of Jeff and Junio's position on it it's something they'd like to
actively prevent, see the discussion around my earlier series.

I.e. from what I gather they view this "your thing is clobbered as it
builds" as a feature. I.e. it serves to throw a monkey wrench into any
use of git that may overlap with said build, and they think that's a
feature.

So my reading of that thread is that they wouldn't agree that's a "nice
property", but something we should if anything more actively prevent,
say by having a global lock around our "make" invocations that git
programs started from the build directory would detect and BUG() on.

Whereas I think we don't have any practical problem with that, and
insisting that we can't fix that "nice property" makes improving actual
test failures that matter on AIX so tedious that I mostly stopped doing
it as a result.
