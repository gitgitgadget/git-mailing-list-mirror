Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF06C43334
	for <git@archiver.kernel.org>; Sat, 23 Jul 2022 04:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiGWExu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jul 2022 00:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGWExt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jul 2022 00:53:49 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03417BB5FF
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 21:53:48 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id w12so7845108edd.13
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 21:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=d+rn2AysEGgva6kfu70mLIcRaK7Hb3qO4Th80b8b5mU=;
        b=g+VBJWhmppOepQm4qSmcl7h4RuDnVPsDyg+WAZM7o2RV7tUKl3lInjMOpePQ/Azlqj
         tc2zEL6GADtkvgA/yPAIrNvdm4XfnoJOQLJtco/s+ba+7IzSA/TwajRc8y4qlMwt/V/o
         Kkz1Zjjv67f6BmKAHuEG/imk5+c6W4+LoSIfcXcBHc58G8SuBcM2xCq3qWpSnDPnAoFq
         D8Aeg7YOio/K2cFas4GEZqpi/pct0+TSTaqqeYgTYrw3tkYZpqAVdKO0++XIQWuL6oo0
         QAfINL50K+aAzBAEMpOuIY98fmESI5ULvcPZZZaZ6nQUDlocdd+BqJWIfXOQX7jOnKvS
         r7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=d+rn2AysEGgva6kfu70mLIcRaK7Hb3qO4Th80b8b5mU=;
        b=ATAgPtKSv6VCsMeKz/Z2EnQBBlijYg80UMu+3sc0Gx/RhnKXA6GT2wIoTwe7avsdIo
         Ae+ly4iUrTC2TzwiME9uoacjPmycvDMoyBq3NUxXkoPzYeCKBTWG5eWOQJCVqweGFAag
         zzlxHmvv6JQ70vYBHyOQ30BxZ06rC2yKXnmrVpgBexnnuHY2tPmuHu6T+UXp/b9LKYiC
         lxb2CZ3aebzoPdIjfHXC3mx6fmY+l0LNxZkaGJBYBuTiNGrFuojfpAkjsZmvUZ2AiWpF
         XvxpE6qpRNHdpMiho/mvYtDQPsbPiw2HZTFpdSeGrj2dq85K5ScgDNcSHfDbthHrcyZd
         R7kg==
X-Gm-Message-State: AJIora8Vo8/6aqROnusonZDIbWvbcSszpVLFKjQrYNBI3EpSNa0WUpfW
        /S7v85qSCq55vd+I4rUUNow=
X-Google-Smtp-Source: AGRyM1vEtO/WWnZwzNy/qvZsJc0bUMdUQmW2bKWTaSlGiQHFAOay7k0nxkpN9acZY6MqmsCMkyOPrg==
X-Received: by 2002:a05:6402:358a:b0:43b:ce8f:df00 with SMTP id y10-20020a056402358a00b0043bce8fdf00mr2778156edc.219.1658552026346;
        Fri, 22 Jul 2022 21:53:46 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id bv4-20020a170906b1c400b00703671ebe65sm2695702ejb.198.2022.07.22.21.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 21:53:45 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oF796-005Oxg-P3;
        Sat, 23 Jul 2022 06:53:44 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, gitster@pobox.com, larsxschneider@gmail.com,
        christian.couder@gmail.com
Subject: Re: [PATCH 1/2] t/t0021: convert the rot13-filter.pl script to C
Date:   Sat, 23 Jul 2022 06:52:59 +0200
References: <cover.1658518769.git.matheus.bernardino@usp.br>
 <99823077be77bc621cfa8ccf3303bd612da343ad.1658518769.git.matheus.bernardino@usp.br>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <99823077be77bc621cfa8ccf3303bd612da343ad.1658518769.git.matheus.bernardino@usp.br>
Message-ID: <220723.86tu78qvjb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 22 2022, Matheus Tavares wrote:

> +my @quoted_args = map "'$_'", @ARGV;
> +exec "test-tool rot13-filter @quoted_args";
> +die "failed to exec test-tool";

You end up throwing this away, but this whole escaping business is just
bad use of the API, you can pass a list to "exec" have it escape
arguments.  See "perldoc -f exec".
