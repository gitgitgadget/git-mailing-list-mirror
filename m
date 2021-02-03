Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67E6C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 12:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EBBD64F87
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 12:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhBCMj7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 07:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhBCMjf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 07:39:35 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87267C061573
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 04:38:54 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id y18so9322953edw.13
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 04:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=y2VmzigI3/uULaTv7vFtYFy+FiiC7/T8yvNWDYcLvDA=;
        b=RpqGmpiBXfxLlVomAXsDvn+t+TUjYR/RjSOiOn778bJedWjP83Wp+p0jBt96fR61oD
         7ysN/bBYqggnwNUepY83gfdMyPghw2RFzGc71/4TMqiG13BI5u2D6vj8u2oAqzjlVuld
         rwU+8FOxjPc3iMgHPjPdUIJCiqBpVYIaOCbuShQ156yEZb9NAHyHw6jxriyng+TBwgK+
         gWjd88XLT1VEa6NqxMJDcDrOQjnrbSI02pS19JuzTxMecJBVHsjeHGTdZ+c5K0Z6Pddi
         INHh7oWVVKC9EgkN6C6Pdzvy3cU/kYpcrlcNn/k10Vd89Zqhl+c18nLzVN6voraUo/6H
         w6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=y2VmzigI3/uULaTv7vFtYFy+FiiC7/T8yvNWDYcLvDA=;
        b=ByBO40mDqTgVwd89sTa5v+lA75wn3nV3Mgx7LbyjZE5qdGPvHajpoAsnaup7v47hdT
         XYFrlE07dGTk1PpvnN1EeGX3Vbmyp8a1cjMyzET9uWTgIe7FwSnPJO08p/GlAIkEskN2
         7BD3AMKTL/GBZxx/oZXUUqxJq57i3/xM9uEkfiEK3H7UtkqwIRZPBYxVWwG1nXC6CIqa
         vMD8DV3nvSTM76cCXc6C2mHWyk7Odc31eh4K6aa8FbAEV55RdnsFsmyC1tpxcrRYS22+
         hFAUrnG7Ci9RnsOAmFJuWbE0kacYaA6FXLdqGygL6HwnVXgYkMeA7HS+HIN6fpOF45qk
         Jm1w==
X-Gm-Message-State: AOAM531KRIfY3gZ6cD8ZMRmqQ8XycsTMRO4F1XdnUi9n77zJnRvKrav5
        iezyDmWP1wQo3Obf+UiWMXZSpUVFbbUj9A==
X-Google-Smtp-Source: ABdhPJxgRK/CFI5aj9Jnm0wskGHeHvgtXKdIM6yS0PdrPYuC7ChgF0pKqd+Q3WWMCLSCLBT3OXr+TA==
X-Received: by 2002:a05:6402:438d:: with SMTP id o13mr2630638edc.135.1612355933010;
        Wed, 03 Feb 2021 04:38:53 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id z13sm811484edc.73.2021.02.03.04.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 04:38:52 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Carlo Marcelo Arenas =?utf-8?Q?B?= =?utf-8?Q?el=C3=B3n?= 
        <carenas@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 00/25] grep: PCREv2 fixes, remove kwset.[ch]
References: <20210203032811.14979-1-avarab@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210203032811.14979-1-avarab@gmail.com>
Date:   Wed, 03 Feb 2021 13:38:51 +0100
Message-ID: <87czxhe36s.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I'm aware of a CI failure related to this series:

On Wed, Feb 03 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>   pickaxe tests: refactor to use test_commit --append

It's because here I fed "\0" etc. to "echo" instead of "printf", which
isn't portable. I've got a fix for this locally, but want to wait for
more comments before sending a re-roll.
