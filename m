Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1DFC43334
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 13:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbiGGNDs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 09:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiGGNDq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 09:03:46 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3D438A6
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 06:03:45 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ez10so2146672ejc.13
        for <git@vger.kernel.org>; Thu, 07 Jul 2022 06:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=lgVL4AlM5EKuWsAnI9KcMeeaMg2ZDj0wOHUH/+2cPhk=;
        b=GyxoXuHkqvCETcdiTObNHT/1JiiZqvAJYRly1xbmmmEX4E6BUwK8w+Ylzr/C0a0kap
         17sXNYYbiRfaOjrQKL/8/va0UEIbkNT574oyofD101XgpFQFE953IN2VPzCcSmkfSV1p
         f4ZWJV/6uo3j8Zga4YZ58iZqYcgPTKZJYUCG0+xRqRMuKSBsRaBQ9gAkEGATrkq4/oGG
         xn9SALhfbKrkXIXUTk5Su0tEXG1U+KWEVZ53ZGjo8t5sOVrvdZLxC5WNSFuIYXUblUSC
         huFsPtvr4/oCZmqZX3HthL3WK/hDtuxF+31PpV5Q9KFb06U9jUaX40OaBPDwGOkAghAB
         pO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=lgVL4AlM5EKuWsAnI9KcMeeaMg2ZDj0wOHUH/+2cPhk=;
        b=Vg3uYCKYOO7gUpLsDQ1WhCUOibPDbYzXYhntOz4kVrquJ12/dpWSjmuO57fTGI+6EL
         HKXuE8eamYqWmH+Os99J5aA4FzQN2KDy6SYs/ShqlOXb80bJ5QLKxXPzRqbQDCekYMfu
         6/BwqmgIVNOsoPDV+Asbwp8OGK8iABUDA8AqDX/NvXM7iAhMUfwwajDrSWfJPV2rI2j1
         CHMDF6MwmD1k7rfJsECz2O7ICUKxX6eHhNg/V2qu3OIZIAFC2pmyFwwlLAOcOVbIxvSO
         8hs2fsqosrVAPUAlUjszdldnFGgqcfYQr40seQhU2g6zX9cZE4nPAnvEbKK8K3hc7EWb
         H1aQ==
X-Gm-Message-State: AJIora+NQgTe17z7YDsqrpRQS2AM3S/j/L5Bq9bpsoRkj4N5kanqlo9W
        dbsxrlmSygVzEtXnTYwqDDdZQ56iA44=
X-Google-Smtp-Source: AGRyM1uQoRaOEtnddXaeN/ObGYaXmpJfCgNnuyJQGPxgwUE6kqxz++L+gsGZhqHFICIm+k1MqwrS/A==
X-Received: by 2002:a17:907:9801:b0:723:dc27:2225 with SMTP id ji1-20020a170907980100b00723dc272225mr45716649ejc.472.1657199023789;
        Thu, 07 Jul 2022 06:03:43 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id c27-20020a170906155b00b00726c0e63b94sm13980841ejd.27.2022.07.07.06.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 06:03:43 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o9RAU-004IIm-58;
        Thu, 07 Jul 2022 15:03:42 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [RFC PATCH 1B] credential-cache--daemon: close input before
 exit-ing
Date:   Thu, 07 Jul 2022 15:00:17 +0200
References: <c344938b-afe9-edef-1e0d-fbe2425c8c01@ramsayjones.plus.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <c344938b-afe9-edef-1e0d-fbe2425c8c01@ramsayjones.plus.com>
Message-ID: <220707.86pmih847l.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 07 2022, Ramsay Jones wrote:

> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>  builtin/credential-cache--daemon.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
> index 4c6c89ab0d..556393498f 100644
> --- a/builtin/credential-cache--daemon.c
> +++ b/builtin/credential-cache--daemon.c
> @@ -138,6 +138,7 @@ static void serve_one_client(FILE *in, FILE *out)
>  		 * process actually ends, which closes the socket and gives
>  		 * them EOF.
>  		 */
> +		fclose(in);
>  		exit(0);
>  	}
>  	else if (!strcmp(action.buf, "erase"))

This is called by a function that will also close stdout, shouldn't we
be closing it here?
