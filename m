Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BF5C4332F
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 15:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345060AbiDGPqX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 11:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345038AbiDGPqT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 11:46:19 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EA4C12CB
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 08:44:17 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b19so8419659wrh.11
        for <git@vger.kernel.org>; Thu, 07 Apr 2022 08:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vmiklos-hu.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ndeeyOnZbsFCHvlbOOzn1txcj6S4GDhlGYANtdt7Ulc=;
        b=KhwLGhL8LZ3TkMr2tcz7w7PtEIIguycdegTOYFPcm2yFx4c2hij7ey7eU6o9r0GVRa
         KWFHqxh+/HzxSk2E69UUkIu1VmnI9NkMtTT46rzB6Wqs043keFEeC07WnLRCjAF3Z46Z
         KNfxjs2sYcpt19sX7YVeRZAfgd8xMrrbFIaaD+iKTiTnRW7XSMyIQN+yvD/VxZ/XRDBO
         A7nVwdyVJZvXM5NJiHsS4twQ+DGPquowSAWKLTIM7rMu6bH8FRTKrfLGZYtTbuzJSi3W
         w9Vyot5Ow7ievGQ6EE9gaDad7CDcrTOtzq6xVOHA8fBoySpDRP1crYWXF11ylSeulz+4
         hefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ndeeyOnZbsFCHvlbOOzn1txcj6S4GDhlGYANtdt7Ulc=;
        b=KIApYCrLG+Tkpzle854Z4pgJeQ6K9i4ckjqhsk1yq2yFbJdi/d0d/qZfTMG8hGYtgD
         7yqs5uH5cxgQU9p9TD/qKzPfgC7Wd2xj9Pd/r65XkcUgYuaxBMb8DOTVPoaVboU2gyzB
         4QlmdyOUSKQXwIxaRaMuEOMNMIoNwGJJ9LvrgeusDO0uMxhsTs9CVp8g9lpaZNl8PyGd
         yU1bUzlF67jXIjMYcdW2XJtOOSm03o6tHzjQo7K9qpudKi4DrORU5sv7OlosZ+wbs/Ts
         YWeGsG1hUZVOq4K7517aDaEe1aT5t0KawhaOowiMCJug4q6shVSHOkTuRM7gFvQ4avd0
         QSyw==
X-Gm-Message-State: AOAM5315hVBaakE8ZEgLkuo7metmid+RkfFcmnnonXGbIQLkS6258Bqw
        yTS88K4QR5/L2dHMsRhSMIadSQ==
X-Google-Smtp-Source: ABdhPJwwe7qZjIQXcnwlzT34Cw0xMeYVbJT+3Z41rYXoM58lFANXGtjnE/63EUM76OOkHDb8Z03RPA==
X-Received: by 2002:a05:6000:1547:b0:206:1b04:3152 with SMTP id 7-20020a056000154700b002061b043152mr11063296wry.367.1649346240270;
        Thu, 07 Apr 2022 08:44:00 -0700 (PDT)
Received: from vmiklos.hu (178-164-175-237.pool.digikabel.hu. [178.164.175.237])
        by smtp.gmail.com with ESMTPSA id 61-20020adf8043000000b00205e1d92a41sm18001730wrk.74.2022.04.07.08.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 08:43:59 -0700 (PDT)
Date:   Thu, 7 Apr 2022 17:43:57 +0200
From:   Miklos Vajna <vmiklos@vmiklos.hu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: git log --since to not stop after first old commit?
Message-ID: <Yk8Gvf/fjVca9hDB@vmiklos.hu>
References: <Yka2GSGs3EIXm6Xt@vmiklos.hu>
 <xmqq1qygy9nd.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1qygy9nd.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, Apr 01, 2022 at 10:51:34AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> We could add a --since-as-filter= option or something, but then the
> user needs to be careful when to stop (and digging down to the root
> of the history, i.e. "never stop", may be an acceptable answer to
> some projects).

I sent a patch to add such an option (which picks the "never stop"
behavior) on 1st, did you see that?

If the idea is OK in principle, but the patch needs tweaking, please let
me know.

Thanks,

Miklos
