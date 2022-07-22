Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE5CC43334
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 23:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiGVX3E (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 19:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiGVX3C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 19:29:02 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDD788E2E
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 16:29:01 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id b25so4718604qka.11
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 16:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=+qMFtJseL4CmszLMZk7/mEc9XVfzozAVtcyGilI5NDE=;
        b=kkwilxM/uSNDvhvuClYAUnNqOyfC9h27nYCHaA+7749jDV0Nj96JfhdDsM9Mb7focP
         5w+aWHmwTbyNVVBb4iRO3l6u57kn5YSVL7cda6DqmSIctt21amWjRE/MidiJrf2Fk2UU
         8ipOKPR68rNDAWKuFuChVY1lyZoqr9gbK2+Vo7leUvOBQF3Zp63q9P61mYs+i1u8DiOP
         /4Z+v5x8N7mI4ax6w3f7vxDXjWv1D9lGTJuG1L3hSJjuq41CaHX9gbKg6GpUTc2hSz9e
         cofVCFC2+2wX7nxF6xrozCFfPgD4JQc174vWo/Y50bxqpEQ3FAvPJiwseTkesKppvGDq
         yFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=+qMFtJseL4CmszLMZk7/mEc9XVfzozAVtcyGilI5NDE=;
        b=1pMZNti5YaaoEprNmQ41NzK6Z8YMm6syHacISFdK20sUwFa0wWCWf87L2/261qJm64
         1lNsP5Nfvctu5pOFun66pEBFeDLooMD0kaGo6P7WCgCTC25H+U1wkb66dv20jtNjt5OR
         WqeUXUoskzdCAgN8bxjJJn1IIYi8vpIl2/KT2u2heCImaZVXz7QCccakEV6yZzTLlKbm
         Q4YJS/la8rzZsSvisHf56nyYWZKnNrmFWNdmVnlBpYfykjqTHe5IOvuMh1rgw7rpj6Ad
         SBEpCUzvwzAp1UQxunga2xUUEki1WxVtSQTXe9S+z2UH63qpknpoQEJxn97LJu4ieUaG
         voMw==
X-Gm-Message-State: AJIora/5bIMDFqYoZrQeJ06KMmLBD7j/RfGL+ZCAW2TYioFxL67EQtrb
        0acLbUeFeHn+m2nMr25GSt2eq9IuductpQ==
X-Google-Smtp-Source: AGRyM1tXYez5Gqv2TBvMX/OW2KmJxs5UtOh7TrsG79sUec0BGDnNj/+6SWkUAtTYP1/UFnyNEURpmQ==
X-Received: by 2002:ae9:eb88:0:b0:6b5:cc0f:1a54 with SMTP id b130-20020ae9eb88000000b006b5cc0f1a54mr1880213qkg.330.1658532540835;
        Fri, 22 Jul 2022 16:29:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h4-20020a37de04000000b006b58aa4e0e0sm3991730qkj.24.2022.07.22.16.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 16:29:00 -0700 (PDT)
Date:   Fri, 22 Jul 2022 19:28:54 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH 0/2] cat-file: support NUL-delimited input with `-z`
Message-ID: <cover.1658532524.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This short patch series implements a `-z` mode that is compatible with
the `--batch`, `--batch-check`, and new `--batch-command` options in
`cat-file`.

This came out of a request from a colleague to support `cat-file`
invocations that refer to a tree entry whose name includes a newline
character.

The implementation is mostly straightforward, though the second patch
(which contains the main substance of this change) has a few additional
thoughts on areas for future cleanup. The first patch is preparatory, but
could easily be squashed, too.

Thanks in advance for your review!

Taylor Blau (2):
  t1006: extract --batch-command inputs to variables
  builtin/cat-file.c: support NUL-delimited input with `-z`

 Documentation/git-cat-file.txt |  7 +++-
 builtin/cat-file.c             | 28 +++++++++++--
 t/t1006-cat-file.sh            | 72 +++++++++++++++++++++++++++-------
 3 files changed, 88 insertions(+), 19 deletions(-)

-- 
2.37.0.1.g1379af2e9d
