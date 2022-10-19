Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B168C433FE
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 02:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJSC7q convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 18 Oct 2022 22:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiJSC7n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 22:59:43 -0400
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BDD22B01
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 19:59:35 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id o13so8497463ilc.7
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 19:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ZVLiBgDxefONdKiGcErCzRd8X1M+ul9HaGO/6vOwls=;
        b=b6IxTMnAUNBVBsFU+SCr/HnxImrSLCTgsh3qgj5IpvKviD7s/9sx6gAKXE8Ql/VeeZ
         GZZSNY4xrU3SWjiCseOo2tQ6wgSmrPJ0iOU3SXP9WMl+WmRWKKj/E9Dv3T1LVXiBL2r2
         ZVAWNi31yhyd+6pZRoE770iKuMmeYccKWbfZc8oKY68eqfm5Tm7yadVIHfKowbDvruwE
         UlXeaQQ3dgnFit+0p+1dUlN3wLRP9/UKRzQA+YWkUEdI1O7lt07j9Jrq3xEu4I905MS6
         m4Fc8MBBKgSuLbC5ikzP0BNDmbhwBYIRPaP1LIgWkOzYGAvSF0+c9e4zONkPEiinjinF
         gN7g==
X-Gm-Message-State: ACrzQf1K6eLzRgFSuaBuV/p7mfElgxXMigXHKC1VSh1fKe1X3x9cQNHK
        14h9PwEnRghie86YFFaI2l+Xcf98Z/AfqOePx7U=
X-Google-Smtp-Source: AMsMyM6QC9fSjGDpz+DYAU+Ba1ac5BKemhtRGTMs5Bq6iQ7CwgBQWD6GCrRqt1XsrO6kMO182xcGt5qErenoaxUlslY=
X-Received: by 2002:a05:6e02:1909:b0:2fc:7bd1:25c0 with SMTP id
 w9-20020a056e02190900b002fc7bd125c0mr4333620ilu.147.1666148374685; Tue, 18
 Oct 2022 19:59:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.5-00000000000-20220422T094624Z-avarab@gmail.com>
 <cover-v2-0.4-00000000000-20221019T010222Z-avarab@gmail.com> <patch-v2-3.4-78ef8636c57-20221019T010222Z-avarab@gmail.com>
In-Reply-To: <patch-v2-3.4-78ef8636c57-20221019T010222Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 18 Oct 2022 22:59:23 -0400
Message-ID: <CAPig+cS8jvUn9bR=1ywWgCC3gPosgycdcdbm+aASo59mXz6rfw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] Makefile: really use and document
 sha1collisiondetection by default
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Mike Hommey <mh@glandium.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Eric DeCosta <edecosta@mathworks.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 18, 2022 at 9:03 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> When the sha1collisiondetection library was added and made the default
> in [1] we never updated the documentation added in [2] early in that
> series once the default was flipped to DC_SHA1 in [3]. Furthermore the
> INSTALL file has been claiming that we use OpenSSL by default since
> [4], and hadn't been updated for the sha1collisiondetection switch.
>
> The interaction between NO_APPLE_COMMON_CRYPTO and DC_SHA1 seems to
> have been missed in [3], so ever since DC_SHA1 was made the default
> we've still used Apple's CommonCrypto instead of
> sha1collisiondetection on Darwin and Mac OS X.
>
> Instead off all of this we now:
>
> * Don't have a DC_SHA1 know anymore (using it is an error), you need

s/know/knob/

>   to set NO_DC_SHA1 instead to use any optional *_SHA1 implementation.
> * Re-arranged the algorithm inclusion in hash.h to correspond to
>   NO_DC_SHA1, and "#error" if we have no defined SHA_*, rather than
>   silently picking block-sha1/sha1.h as a fallback.
> * Have an INSTALL that reflects reality. We were still claiming to use
>   OpenSSL's SHA-1 hashing by default.
> * Have Darwin and Mac OS X use sha1collisiondetection, like everywhere
>   else. There is still a NO_APPLE_COMMON_CRYPTO knob, but it's used for
>   things unrelated to SHA-1 (see [6]).
> * Have a rewritten discussion of SHA-1 and SHA-256 in the Makefile
>   which covers all of this.
>
> Let's also change the CI for "osx-clang" to test with the new
> APPLE_SHA1 knob ("osx-gcc" uses the new sha1collisiondetection
> default).
>
> In practice this will spot issues like the one noted in [7], as
> testing with just two backends should be enough to spot unportable
> code. Ideally we'd have other CI jobs to test the various SHA-1
> combinations, but for now we have better CI coverage than before.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> diff --git a/Makefile b/Makefile
> +ifdef DC_SHA1
> +$(error the DC_SHA1 flag is no longer used, and has become the default. Adjust your build scripts accordingly)
> +endif

bikeshedding: Do we really need to penalize (abuse) people merely for
asking us to do what we're already doing anyhow?

Or do you have some future plan which wasn't stated in the commit log
but which explains this sort of hash stance?
