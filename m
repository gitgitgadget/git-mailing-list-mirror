Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189F8C433B4
	for <git@archiver.kernel.org>; Tue,  4 May 2021 19:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF546611AC
	for <git@archiver.kernel.org>; Tue,  4 May 2021 19:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbhEDTze (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 15:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbhEDTzd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 15:55:33 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3284DC061574
        for <git@vger.kernel.org>; Tue,  4 May 2021 12:54:38 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id g7-20020a9d5f870000b02902a5831ad705so9326431oti.10
        for <git@vger.kernel.org>; Tue, 04 May 2021 12:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=Ye+kixk5S/TSzlifEVNLfWFw4ai4Bw0sEoLHw91FoB8=;
        b=Jknj65rjzueWFCNlS+dF5+OL6ADyQEWL7MQkipt5JzMDnYe/09p1EImB87BMApM+00
         MiOBzfC8nkJ+g6cltTF1HUXDe6mZ1Hv+Bck5t5CPDQcuSJLF0nV9zLambRZXLcWlcJek
         em0f3NbwWtwwQ01SrRX9pxj3PWJBet9jA0cIGCkUgIjmWbE6jKm4RKCNEdwh5vLfQK/r
         EpKVjX+amc877yhN/rZmOQJF5UVvuKsjUEdxv69nAEFsYzsdACaGKTbEULOooroMN+s9
         /C1XN2d8CJk0kk9kX2Zxs1PXhb6+ArH4vi0N66YInpA809kV4xGtlgOqdPXAAgqWpwFB
         Gf2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=Ye+kixk5S/TSzlifEVNLfWFw4ai4Bw0sEoLHw91FoB8=;
        b=uc0p5741FVojj7GqezNPkIsqcMAXEaFeAZvURrc/gHrp1pd1SR2RYS0T7kGnNrUp5f
         rUrRdVLcr6v5Q305HcMur56cmDXmJaEhkne8Na+bXTTp61uQu8Ui5K89wB3v5dIck9rx
         z3dRy3I5STdf2e5RnxBEh10C7HsI+dRdjP6V0EieZ5unTAxaEjGZFyDIKOW+Y6z8CxMc
         4FjTXchCM45euHC0xvOuX3q2dJSRO0Q4I/4wQyRPeDhHoV+U5w4mrqZ/Dlri+8Rf0TgL
         zSEbH4UUHsdi/zU3xAPUErieUtoIgsSKH4t+X61CMr/3tf/p6I+AnyXRdnje5xQC7S4P
         0+aQ==
X-Gm-Message-State: AOAM530yW+ttMkCY1hAFbf+DoEJe4dPfzfNKP8nXSYhuTmaGX0d/IywT
        y0ZeXyV3dew1PX9Cbma7vYpxMYkgPjw/ZA==
X-Google-Smtp-Source: ABdhPJxjALzptoLx2vbvmKV1bh0NMBODzh24XChHm4WlsAaPeqpQ/74+1/caDdSAk2QkXPAYepxU1Q==
X-Received: by 2002:a05:6830:108c:: with SMTP id y12mr21123166oto.276.1620158077573;
        Tue, 04 May 2021 12:54:37 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id w3sm972757otg.78.2021.05.04.12.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 12:54:36 -0700 (PDT)
Date:   Tue, 04 May 2021 14:54:32 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?R8OhYm9yIEZhcmthcw==?= <gabor.farkas@gmail.com>,
        git@vger.kernel.org
Message-ID: <6091a67824041_b32c320862@natae.notmuch>
In-Reply-To: <CAPiPmQnb=XMaF2+YkryEbiX8zA=jwa5y=fbAGk9jpCExpbS4Rw@mail.gmail.com>
References: <CAPiPmQnb=XMaF2+YkryEbiX8zA=jwa5y=fbAGk9jpCExpbS4Rw@mail.gmail.com>
Subject: RE: git switch/restore, still experimental?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

G=C3=A1bor Farkas wrote:
> the "git switch" and "git restore" commands were released two years
> ago, but the manpage still says "THIS COMMAND IS EXPERIMENTAL. THE
> BEHAVIOR MAY CHANGE.".
> =

> i'd love to use them, but this warning gives me pause, perhaps i
> should wait until it stops being experimental, i worry that it might
> change in behavior unexpectedly and cause problems for me.

It's precisely because the behavior may change that they are labeled as
experimental.

I have 15 of experience using git, and I have tried to use them but to
me they are too cumbersome.

For example I would expect this to work:

  git restore @~ -- file

But it doesn't, I need to specify `-s @~`.

git checkout is more user-friendly to me, so purpose of git restore is
defeated.

If the interface is changed, perhaps it will be useful to me. It isn't
at the moment.

Cheers.

-- =

Felipe Contreras=
