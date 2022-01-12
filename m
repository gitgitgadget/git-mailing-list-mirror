Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCDEC433FE
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 18:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344576AbiALS5O (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 13:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344479AbiALS5E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 13:57:04 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD0AC061748
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 10:57:04 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id d3so3283426ilr.10
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 10:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cbE2/ES5QP4FDtpk9x3+qJD7TjBYV8ti6QywMXXvab4=;
        b=vXDf5D8fLEOIYwkRwP6UbSNIZsVQKQ+7+IPN6rRz5puksM/KkNTUysY9uMzC8w36hr
         oVTSer1YjLaUA9lw9QWf0/29SHaSVuMj+/VU1PuAz2IBjVsTMYx2tCchNJRMKOmtvkYS
         JE4VY4Ho6JAFnepp/oNP6jOQ2M6C/gAHGcEAUrq0+RSUv5Sou4zbbkTbHfcm25k9CB+A
         ts+rTZXAUir4VYGBKvouCKQ5P8YovhT2xpg/HlQVVnhH2c//519yAnWp3BMvhZQVrSRw
         DE+UpdajfknhPAobhuzbFuXGwK6BLQjTUK2ri7jRH0BF09raZGj4LQQAG4qA51kzr45J
         Ed8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cbE2/ES5QP4FDtpk9x3+qJD7TjBYV8ti6QywMXXvab4=;
        b=bQ8wVf0poiVZ8EIf1cHekmp9y5Y38OHsxHWHuY4Qdyh+i18+IVWN9TAaql3UNjjrwf
         tvpvso3VPrAqMpaezLTjdS4JUuhQ7ejYfSFEOWliWTvrt5MtnQrN+5817ZywV/vV0eoU
         tbZ9fEswBsrXG6pY9quwlfGwLqxOpfZ8F2wuJChoQxPHjs/7nhEkDdf5jX61ECh/+6Or
         6iG+mf0pChhAOyp3GcakuZVD86D5jYwDNABhacyhX5dDHU7n7mJ2Ha/2JykoH5+DKQC8
         1biZx1aVBwERtcJH8DHOhntoRBmwk9dAHdqs6cj3piSK3BuBC7hmXizvu6cX9+XZ2Lz/
         5Mew==
X-Gm-Message-State: AOAM531/PWeP1c8YbszxFhcoPPCv3n/tTtBBSOkksy/GMhPfmEhKlBNQ
        if0p+6KrsG+tFozczL2YYTRJWg==
X-Google-Smtp-Source: ABdhPJwJoQCWbNUKNH/ag43Zxpi/wxhjIdgL+86hG77Upw9fMnx8kjEws6FvZiFgvrIW6qqw2Xk9MQ==
X-Received: by 2002:a05:6e02:109:: with SMTP id t9mr418233ilm.3.1642013823779;
        Wed, 12 Jan 2022 10:57:03 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h23sm361227ila.81.2022.01.12.10.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 10:57:03 -0800 (PST)
Date:   Wed, 12 Jan 2022 13:57:02 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v2] t/gpg: simplify test for unknown key
Message-ID: <Yd8kfgEq+EOMSc2C@nand.local>
References: <20220107091432.581225-1-fs@gigacodes.de>
 <20220112120757.874714-1-fs@gigacodes.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220112120757.874714-1-fs@gigacodes.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 12, 2022 at 01:07:57PM +0100, Fabian Stelzer wrote:
> To test for a key that is completely unknown to the keyring we need one
> to sign the commit with. This was done by generating a new key and not
> add it into the keyring. To avoid the key generation overhead and
> problems where GPG did hang in CI during it, switch GNUPGHOME to the
> empty $GNUPGHOME_NOT_USED instead, therefore making all used keys unknown
> for this single `verify-commit` call.
>
> Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Signed-off-by: Fabian Stelzer <fs@gigacodes.de>

Reviewed-by: Taylor Blau <me@ttaylorr.com>
