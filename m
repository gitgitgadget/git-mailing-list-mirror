Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042DAC433FE
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 15:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJJPsV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 11:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJJPsT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 11:48:19 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF36F1A81B
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 08:48:18 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id z197so3820433iof.2
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 08:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D/Atg9JfHXv+p8fl6BLwcimrSFzYlMJ3AJWsgCw1BMs=;
        b=2L1KmN734i31M/aEyUluLE/KqFCA12LvV0vhwtz0XmMLaDAQWNi2zenD9kj0402r6T
         tIzmlaONmbYnPWcsiTpN1BVzy6n10bRFRYbwP5qyydBC+AcPP6b/MiYbdGmJj1qZQW9u
         54cG+cZ0JI699HdTejU7Bq24dHujVxxsaPh+O5kauYd9bzCFvxXTfibvgU9ztD6l6gQ7
         GbcZsFoTHQ2VE/d0Rl8jZSuWbNNbb88Yvw0gEMxlQrQp1PdUvX55MXHypagDGNqLhy6F
         l7SzFj1unHP13Lp8MwkAtO4ciPmsHPq6Ix2+wOUuc4NrzR/xVxMuiaaCYOxyTPfSvhx4
         jJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/Atg9JfHXv+p8fl6BLwcimrSFzYlMJ3AJWsgCw1BMs=;
        b=02qqRMfwFRI1wdO/2ldgng7bYrpV9Ry4r65VibAOG0GBWqENnhlr0NPzW8MPrt1Kgb
         iIaT7kV53HoZe+Zsf6HokqJAYB9imGUuXnfcAvfMafqwayfaemsusQyghyJmXEI59/7D
         cQBiXp/ARjd/fJncb33/dZsQHWpHxTvqtAMhaBIpDpXr/fJsqXac5dc+fDIg6v47tqz4
         BvOL/R1NWw7YP7VUN0Zn+fjb+SusoE2bFGKlDY5U+q65l0M4vFUllfg2Rx6teOiOSn7Z
         lqLCkTDZYXpeA7ztQ6dNa4Rf3sU2qo+A8Jkvqrb0K8JUFAZtA4bmtrUXgQgGZneYqLYB
         4ZaQ==
X-Gm-Message-State: ACrzQf0xlayf9fspDnB9VrlMEDRStWIHjJstnkxd7pzOdkObKhE5SU7I
        BtkT+q7OwQu9gCP/GnefTvBPnA==
X-Google-Smtp-Source: AMsMyM4XizZhV8WTtveEYGBiYfxFB2TTOa/ZtQEKGyqC28bsk+bz5a/6/uMaj0X1/LlwyehCMIXgUw==
X-Received: by 2002:a05:6638:2508:b0:363:a763:ae48 with SMTP id v8-20020a056638250800b00363a763ae48mr5844717jat.56.1665416898253;
        Mon, 10 Oct 2022 08:48:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i2-20020a0566022c8200b006a514f67f38sm4417561iow.28.2022.10.10.08.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 08:48:17 -0700 (PDT)
Date:   Mon, 10 Oct 2022 11:48:15 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     rsbecker@nexbridge.com
Cc:     'orygaw' <orygaw@protonmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: Git BUG 2.37.3 and 2.38.0
Message-ID: <Y0Q+v0s5BPYEPq2K@nand.local>
References: <o2ijhZAUIi7nPTwQmsJfpvPIEeLbhvn1AP8rhW2hCNbC380Z2ogDHzZigqJsHI6RwphsIZR3OSJSy-wYvyWv5un632tKynHKFLFPLPEDH2g=@protonmail.com>
 <037801d8dcbe$9d585b20$d8091160$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <037801d8dcbe$9d585b20$d8091160$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2022 at 11:40:18AM -0400, rsbecker@nexbridge.com wrote:
> I can confirm a similar situation on Cygwin at 2.38.0.
>
> $ git log -1 --invert-grep
> commit 5385d4b84047b3c42cde36f1fab83ac57df17ca8 (HEAD -> topic, origin/topic)
> Author: Me <yesme@domain.com>
> Date:   Sun Oct 9 22:26:47 2022 -0400
>
>     rms.yaml: add path variable definition
> Segmentation fault (core dumped)

Thanks, both. I can reproduce it, too. A quick bisection points to
f41fb662f5 (revisions API: have release_revisions() release
"grep_filter", 2022-04-13), which appears probable.

I'll push up a patch shortly which fixes this issue.


Thanks,
Taylor
