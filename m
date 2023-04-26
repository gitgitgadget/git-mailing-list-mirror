Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECE7C77B73
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 03:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239332AbjDZDp5 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 25 Apr 2023 23:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239000AbjDZDp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 23:45:56 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C5910C2
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 20:45:54 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-74df47ad36eso320075285a.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 20:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682480753; x=1685072753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=njw3MXE+xRdQD8oMmSMwH7imdltFCxWuEgwz2wcYmJQ=;
        b=bLAMbSkmEpGwkRKCPBvGbsq+uL9KD2sB3p8YrlCmeu262XW0lq53om+mlH5h71/P2I
         NosKByuFGsM6IQNLzoCBe+rnXisy5ikq80baTY1K5Q8T8GdpYMABm5ytuGEbedBh8dW5
         Snf0x5fe3C0fMlkHSVWNz5rEBbEb63SkPP5evKD6zqcHILmb3xL3ddnLWiM6ID3iyYxh
         UJXcGLNnhsnyXCPW3RV6RvAEVO2JUPquI9rTOKef+BBTaS8i6QOXJRL/twI1ezoYxdU7
         BW4fhgjELV7RFKNoT1M0epQ2V9Mn33I/LSOdcx7aadKEnWmNsVzfhg6QFPCz1Q8jSVZ+
         CBdQ==
X-Gm-Message-State: AAQBX9eRRhwOfxydVitMMy/a0xQom6n8dEKeqWyPX8Nh4DbmBAftIpNz
        EXp2y4QW7HqOlzNvUbWmZVq+yWATYnx7kNRFOhlJXF/0
X-Google-Smtp-Source: AKy350bLXH5dx1BvUI/pmAxXXP+T5a2I8lWsNvFsE+JgrPemHrm8/vxyHhXTQ8+eCcJk0hAS5x1lQGan6hcxmt0ZPiQ=
X-Received: by 2002:a05:6214:194d:b0:5fa:2ae4:4203 with SMTP id
 q13-20020a056214194d00b005fa2ae44203mr34900524qvk.37.1682480753471; Tue, 25
 Apr 2023 20:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230426013428.53206-1-carenas@gmail.com>
In-Reply-To: <20230426013428.53206-1-carenas@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 25 Apr 2023 23:45:42 -0400
Message-ID: <CAPig+cSN=DYXuCmO4-ewN20mibqH7o+zESDbwXG8c0QW0TVVrA@mail.gmail.com>
Subject: Re: [PATCH] developer: remove gcc 12 workaround
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 25, 2023 at 9:47 PM Carlo Marcelo Arenas Belón
<carenas@gmail.com> wrote:
> Since 846a29afb0 (config.mak.dev: workaround gcc 12 bug affecting
> "pedantic" CI job, 2022-04-15), DEVELOPER mode has this workaround
> for the version of gcc that was released with Fedora 36.
>
> That version of Fedora is about to be EOL and latest versions of
> the compiler don't have that bug anymore, so remove the workaround.
>
> Tested not to trigger with latest gcc packages from the last 3
> Fedora releases, including gcc 13 from Fedora 38.

The commit message doesn't explain the benefit of removing this
workaround. Is it because it's a maintenance burden? Or is it
preventing some future planned improvement in this area? What is the
justification for penalizing users who might be stuck on Fedora 36 for
some reason or another?

(I ask these questions as a person who regularly is stuck on old
platforms for which it is increasingly painful or impossible to build
or install modern software.)

> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
> diff --git a/config.mak.dev b/config.mak.dev
> index 981304727c..6d07ef3692 100644
> --- a/config.mak.dev
> +++ b/config.mak.dev
> @@ -94,9 +94,4 @@ endif
>  endif
>  endif
>
> -# https://bugzilla.redhat.com/show_bug.cgi?id=2075786
> -ifneq ($(filter gcc12,$(COMPILER_FEATURES)),)
> -DEVELOPER_CFLAGS += -Wno-error=stringop-overread
> -endif
> -
>  GIT_TEST_PERL_FATAL_WARNINGS = YesPlease
