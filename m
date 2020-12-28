Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01A6C433E6
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 15:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A96D3229C5
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 15:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438886AbgL1PFy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 10:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439057AbgL1OKg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 09:10:36 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFFEC061795
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 06:09:56 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id d8so9192269otq.6
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 06:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=zT84UNN0Kqg5apobELVUK5nKw0Vaeu44K/JvG3O1nVc=;
        b=sHMXzj0KMJWRLfYjwnuJGGVAfOSeKH9RTVn4j2FtatU/wssYkr0+4pZQdIVn2YMLTl
         b0gIYtOiJtPSaq78oY6KSeK6eLzSmMCSUvBexUPbsZ1xd7/BS8E6ExpjPV7RUYr9pitA
         od1a5sonNhwTdYUcCRpscG+uEkkaBiUuNeAYo7yk8pwx9DdxTy/cf2oIDXxojaqBxu51
         2hkOqHGbN3xLYgPpLbGrWX1wZxJsPNQjv9Rf9Y0FMord/cDZj67ZZfOgqdrIZDT4B6fh
         cdHei0hQ1I5HMt3oAyX0Q/cYtSyGyLRtIH3rQ4mGC540PdU6jxKnd1V/VGtMuxiBCA58
         aMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=zT84UNN0Kqg5apobELVUK5nKw0Vaeu44K/JvG3O1nVc=;
        b=eFCodkZJ7CLtZYq04QyoOwViK583iRw3v/R7J//wuwexMvFyfV6ti94hj1cBqH0kM5
         RCDQ7bCxYoTGpRyay+YXX2uOXjmm+knFhrlQtjDQ1/TdPHxqoHmAFOIA9C4ahdRjVpxq
         dFSzGMkGkEUsV6hbaPJ9u6LM0yFwTwaZd/zfxFte85P35Luc4/lT1ezRWBNXxPUhtBwf
         OkqML+4AyTeLX2tLEy4WbYc4X0BXzaajOmC0tWM1ETlG4YYPD7btmk6GRCpbYptl7oTa
         SWtvRIlW9b7/EBJ76OUZ6Kedm022+l26xzvClFoSfrYSf3ITKCz5x+gPi6kJ3aT+1VSg
         EGqA==
X-Gm-Message-State: AOAM533l7qeZu3v+yWXEPEgBT9m8pnZPEq8ovBcRCNHOtVJXLqNCOnVR
        mw2yrBxm46JF1cGdBloGfyo=
X-Google-Smtp-Source: ABdhPJwwGCBPb/ZILHnZkBuE/RJEOU6JxoEB6sI+1LVyLT8BA2BhqyEMH4assCgBjDIK/gg96PXgXg==
X-Received: by 2002:a9d:170d:: with SMTP id i13mr33143494ota.106.1609164595737;
        Mon, 28 Dec 2020 06:09:55 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id t26sm9229366otm.17.2020.12.28.06.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 06:09:54 -0800 (PST)
Date:   Mon, 28 Dec 2020 08:09:53 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <5fe9e731de0e5_209d20845@natae.notmuch>
In-Reply-To: <xmqqh7o6jjt1.fsf@gitster.c.googlers.com>
References: <xmqqh7o6jjt1.fsf@gitster.c.googlers.com>
Subject: RE: [PATCH] SubmittingPatches: tighten wording on "sign-off"
 procedure
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> The text says "if you can certify DCO then you add a Singed-off-by
> trailer".  But it does not say anything about people who cannot
> certify.  A natural reading may be that if you cannot certify, you
> do not add the trailer, but it shouldn't hurt to be overly explicit.

It doesn't matter if a person *can* certify, what matters is if the
person *does* certify.

In a weeding ceremony when asked "do you take this woman to be your
wife?", the answer that is looked for is not "I can".

Do you or don't you? Is the question.

> diff --git c/Documentation/SubmittingPatches w/Documentation/SubmittingPatches
> index d12094bac5..b091730771 100644
> --- c/Documentation/SubmittingPatches
> +++ w/Documentation/SubmittingPatches
> @@ -307,35 +307,35 @@ wrote the patch or have the right to pass it on under the same license
>  as ours, by "signing off" your patch.  Without sign-off, we cannot
>  accept your patches.
>  
> -If you can certify the below D-C-O:
> +If (and only if) you can certify the below D-C-O:

If you certify the bellow D-C-O:

>  [[dco]]
>  .Developer's Certificate of Origin 1.1
>  ____

-- 
Felipe Contreras
