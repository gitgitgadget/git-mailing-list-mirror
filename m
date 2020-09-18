Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483C1C43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 17:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0921221707
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 17:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgIRRIS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 13:08:18 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:46862 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgIRRIR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 13:08:17 -0400
Received: by mail-ej1-f65.google.com with SMTP id z23so9013084ejr.13
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 10:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bcnCEpLP7T3yzfv1d50lFRmFE6huLHVSYKPRtHLDmuM=;
        b=IyzlKW//AgSryJh+Rm8HfInPhUCnv2dTiw7UFwRaJ9f8opTOK1kD63H6Qr7g7oQPZ+
         iHeGxStwssiLCc8VWhtC+P0rbeyBNRqoGv3skGE3dFaoiig2oNFi973FlItpvHYZ2cqr
         AoHydJmRpywIyWSLA3Iz1h53xykLgo7+s6eD5naUWfFIp7gaAavzqe+YBrowh+uYT3Ep
         FlneJN4JiCqjGIgzqdWI1mIrFHWRh7oMzWI1mkvh1s4AeyUEP/Fs/Yy280+OkRR53H0Y
         XZtV/tMfQN8zJ0irnMQfFtu02yuDvPL+2BKu1SmnAaRmfFQHc7gRJOphgCXRBxWOFDAJ
         lptQ==
X-Gm-Message-State: AOAM533N9f21/y00fiNBm94PsPiEaBF1htjHUeJ9CtOb6LKLDTlnZPAf
        MAD6iTc0zBz+uQ+Wn9Hd+TGNCpcL/bMn2ubThgQ=
X-Google-Smtp-Source: ABdhPJz2uhlSIbeJA8qDeIGqsroNk3VHNQ24QdQmx8lOrUHjeA4VmdZpbaapwJSFQprl28eGEyGbLp0d1sacutfEVvM=
X-Received: by 2002:a17:906:c0d1:: with SMTP id bn17mr180586ejb.311.1600448896148;
 Fri, 18 Sep 2020 10:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600427894.git.liu.denton@gmail.com> <42d282988961545fb1ab6405a08368d14ffa1450.1600427894.git.liu.denton@gmail.com>
In-Reply-To: <42d282988961545fb1ab6405a08368d14ffa1450.1600427894.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 18 Sep 2020 13:08:05 -0400
Message-ID: <CAPig+cTVwOiB2OB1oHCsBn_DNMncDpiD0Pi-tuaUmKyMf9qEEw@mail.gmail.com>
Subject: Re: [PATCH 4/4] hooks--update.sample: use hash-agnostic null OID
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 18, 2020 at 7:19 AM Denton Liu <liu.denton@gmail.com> wrote:
> The update sample hook has the null OID hardcoded as 40 zeros. However,
> with the introduction of SHA-256 support, this assumption no longer
> holds true. Replace the hardcoded $z40 with a call to
> `git rev-parse --null-oid` so the sample hook becomes hash-agnostic.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/templates/hooks--update.sample b/templates/hooks--update.sample
> @@ -60,7 +60,7 @@ esac
> -zero="0000000000000000000000000000000000000000"
> +zero="$(git rev-list --null-oid)"

Definitely want a s/rev-list/rev-parse/ here.
