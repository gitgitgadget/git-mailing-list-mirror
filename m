Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97807C10F1B
	for <git@archiver.kernel.org>; Tue, 27 Dec 2022 23:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbiL0XhN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Dec 2022 18:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbiL0Xga (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2022 18:36:30 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465B410B5A
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 15:32:53 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id fy4so14655969pjb.0
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 15:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btx7m7L/XqWto0bBL9l4k56VMBxDNXmVuz4TzihD2CQ=;
        b=OEVrg58V7MpU2Ap20IKlVy9J5MWR9/D8S0oAdADZvXTCm4DjdQ51V5R5dUkbX0JJmg
         +8CmOe06gRvCznH5TouXLmdDF1jArQgil5j8q5jS1odAh+ih1LXBRpKwWIYjMzTFXR6r
         tf5XtbgVJQRnCwQvCy1V88b5X5n0VbdyUpdiTqe4mxjr9UYz+JAPSvGXd5hXDjJO6o3B
         xjoChuHPRUakvVItMeuNpeZ6OLaS8kUUzKKqpSGTVZXExXEIGoBUwwPmcZmJsudmzeRK
         OJh/JX0KQ4wT05RKzwjxzkyKQuSoIqXI4doNT7MJq27rJbnWkS8oVMwQatOkhPiOoMh8
         B6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=btx7m7L/XqWto0bBL9l4k56VMBxDNXmVuz4TzihD2CQ=;
        b=0Ks78/YDKfyKFjb3h6aK+C23PiIP6qtwRvaF3MCu4idDIYykLLnKNcWfxLiYL0fSYW
         77CcwVe/+YQrlAJn3u5B0bqabCQ3T+vUEteUBxIql1vCyJEf1gMjednYt2DQa38xQVqN
         HJKiHllMcXc+9M+vvXNFqL3/8k60mPoCL1FqqzVVLUDlwMMZCVo+ZxY6nQd3LqvdlRcc
         k9J2rwGBeMxRGwoIMG0a3dASP7W7waVVfE7eOgoAqdK59ySO8JIC1evlwys/7w2QPo31
         SvyUERhq5uy0/9UwAAl8bvcmbs7bic24Ervh2bL3jk5usfLfF/MSuQmYUfGIELYU3xVL
         ZiFw==
X-Gm-Message-State: AFqh2koMy/2930jmCq8kINXaMeqj7dHCXWTMDC3+jJzbpmLf/pU58Qqn
        aGfORJCcAirvGtCEbZkJPoRATTbUk7qwNw==
X-Google-Smtp-Source: AMrXdXv8qggaYb1Uw9EVVz/av4dfyQBAeVY8rFA3YdxHq8FU8c3wfOPATVPsIjaje/NIV5EIpxrsJg==
X-Received: by 2002:a05:6a20:a6a7:b0:9d:efbe:e601 with SMTP id ba39-20020a056a20a6a700b0009defbee601mr32186709pzb.29.1672183953620;
        Tue, 27 Dec 2022 15:32:33 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id t16-20020a634610000000b00473c36ea150sm8176897pga.92.2022.12.27.15.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 15:32:33 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Hubert Jasudowicz <hubertj@stmcyber.pl>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/2] builtin/bundle.c: segfault fix style & error
 reporting follow-up
References: <xmqq5ydzpwtk.fsf@gitster.g>
        <cover-0.2-00000000000-20221227T183708Z-avarab@gmail.com>
Date:   Wed, 28 Dec 2022 08:32:32 +0900
In-Reply-To: <cover-0.2-00000000000-20221227T183708Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 27 Dec
 2022 19:39:08 +0100")
Message-ID: <xmqq7cycqv73.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Here's a couple of general improvements on top of ab/bundle-wo-args,
> we should also report to the user that they were missing the <file>
> argument, as 2/2 here fixes.
>
> Ævar Arnfjörð Bjarmason (2):
>   builtin/bundle.c: remove superfluous "newargc" variable
>   bundle <cmd>: have usage_msg_opt() note the missing "<file>"
>
>  builtin/bundle.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

I have no strong opinions on the second one, but the first one is a
definite improvement.  Will queue both.  Thanks. 
