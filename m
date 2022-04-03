Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01D7C433F5
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 14:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbiDCOjW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 10:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiDCOjT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 10:39:19 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B111A3298C
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 07:37:24 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id u9so3082135edd.11
        for <git@vger.kernel.org>; Sun, 03 Apr 2022 07:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=0nv6zpk2uXf51T7rLuXBIvVrg9p++Wfl0LbR7exPlgI=;
        b=aJJpxjnJMG4c7VjOdWQ4vNqe7+fORbp7e58kgZU2vuneBeDl5qHk56U/UZkkZgHIYe
         gpirifSpi91VB/OLKKMd9/kpyqVtY7dYxRInOsgsyyUskWidBO+/PWU3MxJcY8BP41mf
         v6UN7bwBb1zqH25M2m7hb0uCMvqJxr4W5xr3adCy1s5f0Pa0gHu6hUSx5I2u65wackQc
         SDTpxZ2TrFdi0Y1F/WAifwUztN4lTUdiTx62xHg9cMhbFf7yfBKMOFy49a8tdqKRZQ03
         m1OXu+EvUsWZUNnIcV/Ylx6Wh4jBoF0SAOraSud5oSrC/NcJeJCy7WcJALRKWWs6FQqw
         j/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=0nv6zpk2uXf51T7rLuXBIvVrg9p++Wfl0LbR7exPlgI=;
        b=CY9J4ACIKvGbXMy+VmTYXoTFQ/DKPCMWtxEixCENW5FwFg6ZGCVPgwNkmqcvo8WvEH
         Xkh6z6WQGhSFlIC5TPQsKFjMqSqJkPpXCnl6AKtdJBbkTGwZvTmS0rWANy8xKdObJNtS
         MXkv4Vk5sbwJm0rMc7dfwoC/GClhAbkIiXDAqUGEJLy9yynWlybjOuyRO70cqA7dMjuH
         Ec2Ek/iLmHlwLhZn+yZVNIzySo7mk0HF1lxs5s7heYaxvGyUo8BrUZmaaFE4Z1zctQkf
         XQrxUXp4ZbqXjt4rh8R77nBqWZqWkwO2MQyFBPmItQj8US7w6yd7l/Hm3cuJa5A7dOtR
         Ey5w==
X-Gm-Message-State: AOAM530k0CJWu15+uV0QrfxS045EaqpwJfQbnqEAaXTLVMHvm9KgzO1C
        bjOV54yuWwCzO0lwtosyRdc=
X-Google-Smtp-Source: ABdhPJyluUu/ZU0UOPeAIo7av2ES85Sg0vrfj/mYC+ktDbj1RaBCnIpYRxxdKFBxxqq4wY34YGRipw==
X-Received: by 2002:a05:6402:2219:b0:418:ed4e:f999 with SMTP id cq25-20020a056402221900b00418ed4ef999mr28896450edb.121.1648996643208;
        Sun, 03 Apr 2022 07:37:23 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id o12-20020a50c90c000000b0041907e62024sm3891753edh.85.2022.04.03.07.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 07:37:22 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nb1M1-002EsN-QS;
        Sun, 03 Apr 2022 16:37:21 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?Jean-No?= =?utf-8?Q?=C3=ABl?= Avila 
        <jn.avila@free.fr>
Subject: Re: [PATCH v2 1/6] i18n: factorize generic failure messages
Date:   Sun, 03 Apr 2022 16:34:31 +0200
References: <pull.1181.git.1647813291.gitgitgadget@gmail.com>
 <pull.1181.v2.git.1648915853.gitgitgadget@gmail.com>
 <4bba3e1f6cb9cdc35b0dc8da440e38de256b4d2b.1648915853.git.gitgitgadget@gmail.com>
 <4b46ba19-3a39-7317-42fb-4fd4bba09b36@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <4b46ba19-3a39-7317-42fb-4fd4bba09b36@gmail.com>
Message-ID: <220403.86wng6kzby.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Apr 03 2022, Bagas Sanjaya wrote:

> On 02/04/22 23.10, Jean-No=C3=ABl Avila via GitGitGadget wrote:
> [...]
>> index 04ce33cdcd4..30a4b81257d 100644
>> --- a/setup.c
>> +++ b/setup.c
>> @@ -1506,12 +1506,12 @@ int daemonize(void)
>>   		case 0:
>>   			break;
>>   		case -1:
>> -			die_errno(_("fork failed"));
>> +			die_errno(_("the function '%s' failed"), "fork");
>>   		default:
>>   			exit(0);
>>   	}
>>   	if (setsid() =3D=3D -1)
>> -		die_errno(_("setsid failed"));
>> +		die_errno(_("the function '%s' failed"), "setsid");
>>   	close(0);
>>   	close(1);
>>   	close(2);
>
> Why not simply "'%s' failed"?

I think saying what failed is helpful in any case, a user who knows
nothing about *nix APIs might be quite perplexed at their source control
telling them their fork failed, why not the spoon? :)

So including more context helps.

But also because there's languages where adjectives like "failed" are
different depending on the grammatical gender of the subject.

So even if the original and translation would be needlessly terse in any
case, the message would also become imppossible to translate in a
gramatically correct way.
