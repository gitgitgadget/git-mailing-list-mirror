Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58FEC4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 21:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiLOVU3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 16:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiLOVUG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 16:20:06 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EE956D66
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 13:20:00 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id b16-20020a17090a10d000b00221653b4526so203420pje.2
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 13:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zHLfGidvuI2qBWpzylFgxWuTVxUfZ/PIrUDVBn/gHxY=;
        b=feuHaAhU2VX0jhWDhjIz/aCHLKnB1+rz+AvoWPDN5Q6D3US2De648yElqHbXevbLO9
         6t6K32ICNWSNawhIln64IrmDMvbpO+lWozVklq4n1z0sEA/fRi8BgDhhabJo/SROh8S/
         H3W0OPuGRC9Uki4qSRrtt+dl0zuX63HctVpJpk6PbmJq1bTpvvdr9cVySibIOFIy0eia
         a2cziYUhlLT61MNRNNUlvBDZIhAAUObpoQmeuynIcKSK9gSqeqRwVr7odr/ZTp9O+RpO
         fBQYxJr0xLxXgVZL4CBzBya9qxzKsyCR+jz0lnrtKjMHTjGXeFiWwAh5ru9+HSGdFFMK
         DE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zHLfGidvuI2qBWpzylFgxWuTVxUfZ/PIrUDVBn/gHxY=;
        b=RqtDiQ9nmpflNG5J+rFkqy2Ze8zh+siINB4I80DAbyyYoJqREo4Ya1Llva43QNru3L
         VFlqc1BkFHFrTHknKB222Ed8t3dzZsGChBYmoA8fLSXAgomN54EsWI0C9HuKLIFdeic4
         Q1j1KsnFLslrcaePoR1xME195Fw1Hkko+AwI8ooupUpn30kn8z32C5GggKMexu0Rnwo4
         QoJWH3J1p18hBZQIREe5Dn4GnzPX3oVv/+J7UsZTj/ZXoR58S0HAFtwBzQuKkt5YHDdW
         N2wm6iKIIh/R0+iy+izVKeEL12uVoaqdrb54z4O4WmNa2UNcAsDX4ifvTwu0kM/LvsJr
         PUXA==
X-Gm-Message-State: ANoB5ploe4cciMF/hevjNZFNhwulFB28LjbEYbljf5KbZ9bMG9um4gTz
        3ycypBdxekPgtiG7tFOEES5WPPa0Chb8dg==
X-Google-Smtp-Source: AA0mqf589pZ3o9m3KLt2AmyHCUjlsst206AEd/hm5lHZC39tbRDqEa5e7XJt2qNBi1FvKHAUeczHt4T/2vWkMA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:d547:b0:189:5c50:ce5 with SMTP id
 z7-20020a170902d54700b001895c500ce5mr69951956plf.14.1671139199488; Thu, 15
 Dec 2022 13:19:59 -0800 (PST)
Date:   Thu, 15 Dec 2022 13:19:57 -0800
In-Reply-To: <cover-v4-0.9-00000000000-20221215T083502Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-v3-0.9-00000000000-20221119T122853Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20221215T083502Z-avarab@gmail.com>
Message-ID: <kl6lzgbocqki.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v4 0/9] Get rid of "git --super-prefix"
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Robert Coup <robert@coup.net.nz>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks! I only spotted typos this time, so I think this is ready to
merge once we fix those.

(FYI I will be OOO for the next 3 weeks or so, so don't wait on a
response from me :))

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Changes since v4:
> * I ejected the previous 10/10 to refactor "git fetch". I have more
>   patches on top of this to do some post-refactoring (e.g. saving
>   memory churn by getting rid of "submodule_prefix" from "struct
>   repository"), but none of that's essential for now, so let's drop
>   that patch.

Okay, dropping the "git fetch" refactor probably makes sense in light of
bigger refactoring.

This might be premature (since the patches aren't out yet), but I'm a
bit apprehensive about removing "submodule_prefix" from "struct
repository". You've noted that it isn't needed right now (which I'll
grant), but it feels taking away API features that we'll need soon=E2=84=A2=
 to,
e.g. run library functions against arbitrary repositories, some of which
may need additional submodule information. Feel free to CC me on those
patches, perhaps my fears will be unfounded :)
