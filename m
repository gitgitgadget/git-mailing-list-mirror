Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065A5C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 13:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbiCHNkZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 08:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiCHNkX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 08:40:23 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5485E1FC
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 05:39:27 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id kt27so39429054ejb.0
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 05:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=7IorD6TVfGE4MJv3AwCHt6gyjUkuA72+NAlBEX59xu0=;
        b=nWZaXwqxyeZxzAWWtoZCSyMgaERwRoFVdN+7AAaK6s2RjgVupI7aiPYHStzE/Oo3mA
         A8fP8jKUplzQR6xGaviGW4ZjXK5JH0blP7AkQ9jC5XcGLCELgou3U2ufgcljoD0Jt/C+
         BqFP8FVfVXSUoIgWP/s14HCOSK9iJBtowSh3ygnu85fvFOjEaBQpQdYsSFXOf0F2QjkJ
         jeJfcTNRgggfJjeskMoBRc7rNX9+Bcpe3wNMQ5bGEBwoB6klzmsMWN7iwwGG3ZdvlBK3
         0AtkywWbWgaizvLU2izRJPotxc3n/sIb9Az7Lgage6I4APXtXCnLtODhE8CjlFhBksoR
         G5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=7IorD6TVfGE4MJv3AwCHt6gyjUkuA72+NAlBEX59xu0=;
        b=4TQMXJUE1FDBV9eBJ9bEjcmqaUJFEzFFeF7B28ooOAjiRPPQpkvON8hsSL1eiB23ZJ
         InlZHqNf4hgikYD1dkdBvyXXVYPAlVm4EnIlgX8ZJ3f1Zg8/E7Nzn4jMd5ROc4c6zhCh
         ut9niMbHTiLeusONxe3MCEPN8ZH6c7lIn1QZNtsHsJOpe/M1F8WZMWyi8b6lQhPj6YGR
         fQfHxcBz58jB6hDXBbHGFvO/lzrH99D34Ab4fKPdZHB65esA89fFpGM1Xd53wnpahx3+
         ACost8gCzR+8uKoKQUlXLMcI1tEBzoggjgE4Z3Rte1yxQy5zP6q/V5jVRdRH5/0BnYe7
         weDQ==
X-Gm-Message-State: AOAM530lnlmJRJ4jqa8IScy7eXp32easybwsovNVJp4/d32ulBKvP7OU
        l8RHLCEMAY3aD0eNcOJjzHE=
X-Google-Smtp-Source: ABdhPJyOnqAI719GfcQi6DvxE+ViuY7ZMw/z9mQRaOlgYwuMdO3ppT+kgdylIGvtSd00NtE+71I9/g==
X-Received: by 2002:a17:907:1c81:b0:6da:626c:b789 with SMTP id nb1-20020a1709071c8100b006da626cb789mr13873916ejc.607.1646746765779;
        Tue, 08 Mar 2022 05:39:25 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bm5-20020a170906c04500b006ce6f8892a5sm5891626ejb.7.2022.03.08.05.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 05:39:25 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nRa3g-001v1f-HO;
        Tue, 08 Mar 2022 14:39:24 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] block-sha1: remove use of assembly
Date:   Tue, 08 Mar 2022 14:38:06 +0100
References: <20220307232552.2799122-1-sandals@crustytoothpaste.net>
 <20220308022240.2809483-1-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220308022240.2809483-1-sandals@crustytoothpaste.net>
Message-ID: <220308.864k48y35f.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 08 2022, brian m. carlson wrote:

I think the $subject of the patch needs updating. It's not removing all
the assemply from the file, after this patch we still have the
ARM-specific assembly.

I don't have a box to test that on, but I wonder if that also triggers
the pedantic mode?

Perhaps:

    block-sha1: remove superfluous i386 and x86-64 assembly

?
