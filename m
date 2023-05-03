Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40146C77B75
	for <git@archiver.kernel.org>; Wed,  3 May 2023 19:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjECT1Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 15:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjECT1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 15:27:24 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD347A94
        for <git@vger.kernel.org>; Wed,  3 May 2023 12:27:16 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1ab267e3528so5635975ad.0
        for <git@vger.kernel.org>; Wed, 03 May 2023 12:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683142036; x=1685734036;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=40e3H01LxHF/b3ncOEkqQAdsfIZ6XzwnhHDtduetxIg=;
        b=HMlxz4FhviNGdllu/iNyvKlvVvl++0S43GCAD2NaAAmvkC64xvVwpzPJunRqPfe4zM
         ekgMEDVzpxm9058qnz2BlcCv3OiMJNRphsicE2ivRubpF9dIRRxy5Fv4BlgSVnmPpc+Y
         Vc9Wqd19YCv1wXzcxPaMgOwWge98AwOM/EHoR74WSNuzm1xFelFQV/ITh9mrsKcTLx3K
         Vsd9GsN0lHiZIhhW0k18q6pBYxstkX4K7GOmmc66h9KVl/UtjPsu61HUeq3X71lAWA3t
         saXvYv2RUrUHIZxP20vUVT/B9El+iVmgdqINNQWXGno8ZXDGzS5H8/j4TyRcfFfHBXx1
         E6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683142036; x=1685734036;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=40e3H01LxHF/b3ncOEkqQAdsfIZ6XzwnhHDtduetxIg=;
        b=Hctb3Ve//k4h2oz6TXdF18y5XC6YdcoWy6owo85ou03vTlQKcAY8NLtUGSRcrVkO7Q
         7o1h12eEGw6dGkeL57bk+utHI9EET+DQ8re55KE0r5iLoZHQe8phnJQCBF2RNs+QVRss
         GZynjR8hKnYwXTfDhG/BRSacRj9Aqo3dsNGKwqzv6tCfHr+iQmhNpzYJ2v2ZS97idN9O
         ylg0eeFjZN/gCi80yY30bWp+1I2h4OuVHdKgepCLZDt4onL2l5/2eF43qOVyT2AQFA4v
         4F7ZWAOrcr8rUFe7P06Pts2c9KpYSjvCQaDIL2gUQBhYmPH0bi6Pahx4YV9HelmnupuX
         o2Pg==
X-Gm-Message-State: AC+VfDyD5BvCA9QKAmHQq8JahkHh/gQauDWP9S4iLcsMRYl7VClT9sgf
        vrbxvWNwQnKuN5/A9mRRUGQ=
X-Google-Smtp-Source: ACHHUZ5M95/H3cBh9Kt/3GALflOqi5zJpqpHAHUfx8GVj2WEYI4BVuOiKdLSl6uXAXvBTdd5byDqRg==
X-Received: by 2002:a17:902:e810:b0:1a6:7ed0:147e with SMTP id u16-20020a170902e81000b001a67ed0147emr1494039plg.33.1683142035674;
        Wed, 03 May 2023 12:27:15 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902cece00b001960706141fsm1886467plg.149.2023.05.03.12.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 12:27:15 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        eyvind.bernhardsen@gmail.com, sandals@crustytoothpaste.net
Subject: Re: [PATCH v4 1/1] docs: rewrite the documentation of the text and
 eol attributes
References: <20230501023533.35370-1-alexhenrie24@gmail.com>
        <20230503044656.221175-1-alexhenrie24@gmail.com>
        <20230503044656.221175-2-alexhenrie24@gmail.com>
        <xmqq8re5wg9r.fsf@gitster.g>
        <20230503190000.5icpfm5k3dxgoq4d@tb-raspi4>
Date:   Wed, 03 May 2023 12:27:15 -0700
In-Reply-To: <20230503190000.5icpfm5k3dxgoq4d@tb-raspi4> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Wed, 3 May 2023 21:00:00
 +0200")
Message-ID: <xmqq5y99qkq4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

> On Wed, May 03, 2023 at 09:06:56AM -0700, Junio C Hamano wrote:
>> Alex Henrie <alexhenrie24@gmail.com> writes:
>
>
>> > ---
>> >  Documentation/gitattributes.txt | 59 +++++++++++++++++----------------
>> >  1 file changed, 31 insertions(+), 28 deletions(-)
>>
>> Will replace.  Unless I hear objections soon, I'll mark it for
>> 'next' and merge it down.  Thanks.
>>
> That's all fine with me - no objections.

Thanks for a quick response.  Let me merge it to 'next' on the next
integration cycle.
