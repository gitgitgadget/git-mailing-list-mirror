Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4330C48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 20:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 980AC613BD
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 20:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbhFPUau (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 16:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbhFPUat (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 16:30:49 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC28CC061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 13:28:42 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 5-20020a9d01050000b02903c700c45721so3837663otu.6
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 13:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=WzvPRxL68cM9Z+B+vffZZcU9LTOjMODeZMvoRRvdd6I=;
        b=GtIWfi6yWL+atJTzKABOXg00TH/tnSOjfGgADYoDn0df+gZ/wAMD5Z4TJfeyVHOn2Y
         6VSpOgaHRimuPTJH1HNd8qrQHqgnQPn2Uq5VPMcHw8m9qoAHENNuTs/Q/T1GXoi7HJff
         A1ou0xl76mDXpCBxQOTmVrc/CEB5367iXgSqHoqVPAwZNz8E2mKO0tI97+A2sda/kqgd
         vW9kl5zzfiIWXko+63R8vTDvddJ6OWLayKhhuiy0I7zWANZ6Eqhn9w2R0P0DxPSt+vw8
         Cor4qz4/Ff+4dJVyOaUYdDz0XpO4izfLQoqzL3yGeYXiZdT79lBOt3tcFyS6NsckR2q8
         DD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=WzvPRxL68cM9Z+B+vffZZcU9LTOjMODeZMvoRRvdd6I=;
        b=rVLYAERTMngHJBT0VtGXh4dp+XlVz2IrCVOlTqZ80C3rGFpmC/n5j/LZUUw/BDsxCK
         RvozNy4OIsDrwN4NJR16dzuZ1fNArXW20uxrkBehuobn2vafAt4JcrhZ4s9wOOM/1Z0e
         Jlby92Wpw/Kj1NHjyDW84mmxeoT/BBK8WHJ8zoKNupvbY9nc9IveDXpHkqZCQPISXBcL
         QzYkf7IGflWyM5nz+tt/+HLkxLUUCyhPorIqGQWje11y7HbuTfFNllzRFIFp5Ifvqbyc
         Rqp43HXMMOlr+QvVc5yHKgGV2V9rQgfZs2UIfFdxPo1yTRS8hWDrrq8lckODY8wGkQE4
         nrTg==
X-Gm-Message-State: AOAM5311b1VkqY7lM6W/tWzwF6Ww5FYTiTLZUfr4ild+IorgIWUezC9e
        P1pEEyasBcXVmI8GwlaSL48=
X-Google-Smtp-Source: ABdhPJw94vMSc5JKnSTZVj81iinA9BUW8I6MLV+gEkwTsBITbUSsHxDpwYYgUIBVjGW0JRteuQbJFw==
X-Received: by 2002:a05:6830:1f05:: with SMTP id u5mr1407328otg.322.1623875322190;
        Wed, 16 Jun 2021 13:28:42 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id y7sm634416oix.36.2021.06.16.13.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 13:28:41 -0700 (PDT)
Date:   Wed, 16 Jun 2021 15:28:40 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Luke Shumaker <lukeshu@lukeshu.com>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60ca5ef868f40_60272086d@natae.notmuch>
In-Reply-To: <87tum0zfub.fsf@evledraar.gmail.com>
References: <20210614043450.1047571-1-felipe.contreras@gmail.com>
 <87tum0zfub.fsf@evledraar.gmail.com>
Subject: Re: [PATCH 0/2] extra: new concept of extra components
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> =

> On Sun, Jun 13 2021, Felipe Contreras wrote:
> =

> > This patch series introduces the concept of extra components. These a=
re
> > components which are not yet part of the core but are good enough for=

> > distributions to ship, and in fact, they already do.
> =

> I like this direction.
> =

> > The measuring stick I'm using to gauge if a component in contrib belo=
ngs
> > in extra is simple: are we already running tests for them with
> > 'make test'?
> =

> I have a CI failure in one series of mine that seems to be a lack of
> updating to CMake in contrib/buildsystems, perhaps we should be adding
> that to extra/ too, i.e. extending this to the "make test" run by CI?
> =

> Not something that should hinder or necessarily be included in this
> series, just a note about a related component.

Yeah, but then it would be less clear which components belong in extra.

I suppose if `make test` also runs the test-extra target, then the
my initial definition of extra is still maintained.

> > And we might move some components from the core which aren't realy pa=
rt
> > of the core to extra, like gitk, git-gui, git-p4, and git-svn.
> =

> I'd also like to see us run the tests for the likes of mw-to-git,
> diff-highlight and subtree by default, at least under CI or some
> "extended tests" mode, even though we may not install them by default.

extra components are not installed by default, you would have to do
install-extra.

Do you think mw-to-git and similar should be installed with
install-extra?

-- =

Felipe Contreras=
