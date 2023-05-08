Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF99C77B75
	for <git@archiver.kernel.org>; Mon,  8 May 2023 22:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbjEHWbu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 18:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjEHWbs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 18:31:48 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148AF212E
        for <git@vger.kernel.org>; Mon,  8 May 2023 15:31:48 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-55a5e0f5b1aso48517257b3.0
        for <git@vger.kernel.org>; Mon, 08 May 2023 15:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683585107; x=1686177107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ROV6FtT430xngsIspGgbgmWFOLgm8h3vYTcMYEOAve8=;
        b=5LhR3xxQjh12oTScKoiCyQbbZ/hk+mnbkXB+KbclV1gCAXcgoiPhIzVlQZUtv61TQm
         Msp3q28bt6it2jkU1bDeuG+ih9gsAXhtpN28r/KE/JxiN6OsOrFpBRm03VRAwVmAm/1t
         j35EWKyaUTUhuklfgBpIvBbd5BY2WcDC9hDVTQP+3AvRw3qllClPiVjLlS6n6WAc8Fyd
         iGbatVdfDC9ih4jhUyUn7bkec3QKpC9KmcRkUSXxl1I2mOOg4IsXKzUD6RzzVllmFSXi
         QjeqyZ4q6resKxxgvjCZa+v5kztFWbrEgD5h9crqDQQsbKqCWzCviCnqwIwTzqCwmAmq
         0hmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683585107; x=1686177107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROV6FtT430xngsIspGgbgmWFOLgm8h3vYTcMYEOAve8=;
        b=K3kcYSZAj2rIhTel5JAWW3HBsycJT1Oz0F6I7BBVm4zLHnsdWHKSs+vMa2bXxCoOgc
         gTEBlXr+8+OsCk2EsNpexZvOUnzZOqYh/PtyG+weJTZ9EzeFUj5zqU7MSEZn8Qp4YB18
         z1fswYbKsY57UrZ70n4DaQ+p6S+mdJSKe7MinWxvKmDeL5jwebcuboGKHLOU79qp4Sp2
         Ypw9X+NfDHZSHyZhUMYp8oypYAnSLuDBKIYHCxGBU9EVwMvc8+e/tOTxiTc5eDbJAUBm
         C9fnJEo9ZVjxoU9tAMTQCVMP6j3pb4XpfXR991pyvIrHOoOszpCXpLHiG6H6LiR/GtgO
         14lg==
X-Gm-Message-State: AC+VfDyYZO3HThI8LsdZaqnWJ5YV2iIoIZyulQ7UajPqaN3RrjPa1Gkl
        vL7WTWeOXtdwVijCYgTe7qETqw==
X-Google-Smtp-Source: ACHHUZ7L0sDwdU4I6tEVtozSzYHxFHf4IEHSMGjr5X6K3PIjFvmXNx86SWpbxrq6QceP0YnI/B9NYg==
X-Received: by 2002:a0d:e0c5:0:b0:55a:1cb0:7982 with SMTP id j188-20020a0de0c5000000b0055a1cb07982mr13760631ywe.23.1683585107232;
        Mon, 08 May 2023 15:31:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v207-20020a8148d8000000b0055a4fe11ce0sm2832978ywa.130.2023.05.08.15.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 15:31:46 -0700 (PDT)
Date:   Mon, 8 May 2023 18:31:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        chooglen@google.com
Subject: Re: [PATCH v3] setup: trace bare repository setups
Message-ID: <ZFl4UVhoR4Hlm2g3@nand.local>
References: <cb72bca46c6ff2a8cf3196408fb53411f7f91892.1682631601.git.steadmon@google.com>
 <e98be8e7f703fc741e06d9208545abc8c24d1a4a.1682962110.git.steadmon@google.com>
 <xmqqa5yicsxd.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa5yicsxd.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 05, 2023 at 03:30:38PM -0700, Junio C Hamano wrote:
> Thanks.  We saw no interest on the list in reviewing this patch
> further, it seems, but I didn't see anything glaringly wrong, see
> no reason not to merge it, and this should help noticing potential
> issues by $corp folks, I would presume, so let's merge it as-is.

I took a look through this thread and would be fine to see this one
picked up, though I did have a couple of questions:

  - Is the plan to eventually disable $GIT_DIR discovery in bare
    repositories by default in a future version? I am still uncertain
    of the assumption that most end-users don't interact with bare
    repositories directly.

    Certainly forges touch bare repositories without always setting
    $GIT_DIR in their environment. But I would imagine that other tools
    indirectly touch bare repositories on behalf of the user. You
    mentioned "go" as one such tool that doesn't set $GIT_DIR, I imagine
    there are many more.

  - If it is the plan to disable $GIT_DIR discovery in bare repositories
    in the future, I'm not sure how visible the extra trace line would
    be. Perhaps that is desirable, since having an advise() call on
    every Git invocation in a bare repository would be noisy.

Thanks,
Taylor
