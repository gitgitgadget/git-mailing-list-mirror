Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3CFC77B75
	for <git@archiver.kernel.org>; Fri,  5 May 2023 17:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbjEERsI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 13:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbjEERsE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 13:48:04 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2159A1E998
        for <git@vger.kernel.org>; Fri,  5 May 2023 10:47:39 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-55a20a56a01so36353977b3.3
        for <git@vger.kernel.org>; Fri, 05 May 2023 10:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683308778; x=1685900778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=07NN2A8IdY5ciQugSvTX3TQTTZ1EsDB4Clh2fjHngaw=;
        b=qqubh+rbHrMo0BzNLWBpTjsRU9k7AOgIV6z/q6DRKPrEDKDIqYthYV9l00vhuVRfYT
         gQECV69hhfXFPZhHu32dCLx70h8+y8uLsLndvkp4KHvKxcgBhTwjCQ7e0o41OK+m0Y+Q
         kqZRVziaQTDDqX67+cDy2Qr6n0stKpgLN7muihmafTX272RrjIpxJlSNaweDMR5T62Zo
         7dpuAj2EF2Z0D23xlOLlypjiqytLbJG6C74I5I0zedTHCkF+QdrkxiB8hl5xvsUjNraB
         /9Mskm6Of6G3eINjTRFFTpk3Uk72LPsMXRd8Yf4J3LxL42Jk5aeVKPDdYLcD7+P3iY1G
         GZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683308778; x=1685900778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07NN2A8IdY5ciQugSvTX3TQTTZ1EsDB4Clh2fjHngaw=;
        b=TViHDxJnDtPnlZcqxiUcAVTg/6YY/v7VZeA5r3lliokuwt2UNq9CnKhk/DVjwbv002
         gA2g89bAa9Yv+X7ryMV4PMMAZW3OIQHxJWTdX8r2tl9eiCdlamSOob3aRvilhpgcrUf5
         5L7RE7or27RULXjpvql8u14ECRoZAyY0bj1hgsLmj+hj2H7Ot0sXxDaiOhHZK2ElDzFg
         a6aPBc+4S3cL0eiFe2mbxQRXFpjqaio8YXtoKIwTVPtC6SMtfU0EgCVHpjm3dQPZkKYB
         CK+7KawEpJ+Gr3OjXuCSQQKwMyeTJ5VOtNPeKhrWnBUrJfzvJ8CDu5ebeO3aytX8812M
         6t8w==
X-Gm-Message-State: AC+VfDxuskxKYyAL0Bf6s/q2X2vc6ji9JJqZYwc0se6Vtr+Jq+3o15Vv
        XyXFKtVKFXNMo+LkY8rbupsB2Q==
X-Google-Smtp-Source: ACHHUZ7W5OAnzDTJL+JDViGx9+pzya4y0MVnbvIMCkgM1qQFDr9qUp2XH4B1jibxu4BjDYcg+I9Jpg==
X-Received: by 2002:a81:4fcd:0:b0:55a:8b11:5f6a with SMTP id d196-20020a814fcd000000b0055a8b115f6amr2481575ywb.19.1683308777770;
        Fri, 05 May 2023 10:46:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b78-20020a0dd951000000b0055a931afe48sm612715ywe.8.2023.05.05.10.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 10:46:17 -0700 (PDT)
Date:   Fri, 5 May 2023 13:46:16 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/7] contrib/credential: avoid protocol injection attacks
Message-ID: <ZFVA6MyjUE+L+x9P@nand.local>
References: <cover.1682956419.git.me@ttaylorr.com>
 <bd745f48-038f-f4f2-2041-f4b2c7bd0d20@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bd745f48-038f-f4f2-2041-f4b2c7bd0d20@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 05, 2023 at 11:24:44AM -0400, Derrick Stolee wrote:
> > But the new "wwwauth[]" field does allow this attack to take place.
>
> In particular, because this should be resolved before 2.41.0-rc0.

Yes, definitely.

> Each patch was simple to read and well-motivated. I was particularly
> happy with this diffstat:
>
> >  contrib/credential/gnome-keyring/.gitignore   |   1 -
> >  contrib/credential/gnome-keyring/Makefile     |  25 -
> >  .../git-credential-gnome-keyring.c            | 470 ------------------
>
> The rest of the changes looked to be obvious improvements, so this
> v1 LGTM.

Thanks. Much credit is owed to Peff, who worked on these patches with
me. And FWIW, dropping support for the gnome-keyring helper was his
idea.

Thanks for the review :-).

Thanks,
Taylor
