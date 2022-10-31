Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42C3FA3744
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 23:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiJaXrB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 19:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiJaXq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 19:46:59 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF47E08C
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 16:46:58 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id f5so11762242ejc.5
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 16:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qTAOpTOuRJXHhd375phd5Gpt5qIqu6dIGjky922xg/E=;
        b=I5Ty5tpBYMdT5moEIRH2bYEScAMwp5kbxAJlsaYlU80qBlM073BWrJ7qKkY64GdI5Z
         jvzyb2gTnXOsxz8zlGrllYNsjHC4E0C8qnBarecVgCQ0PffWRkZTccREcmcBL+1sQr36
         8Nl8hKaRJ+cxfbFfpgk0fEVnq/eO5qd51rPbLTJCUPWLKBTWU72X4+QFm7zeH7AqNK52
         xVmDThOs0EZT0x5v4Mgby73ITCcBN3woag/YSQJfaQkuFfty5r7/RsDnvhvg180/fAEF
         Z9ZNPcE8/6lFfDuzumHz6dGJL4BfjCdAvrnPJaJ0OYHqVr5JEfQQwpEeVkvRht9d92jG
         ij8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTAOpTOuRJXHhd375phd5Gpt5qIqu6dIGjky922xg/E=;
        b=BYaITnrlaXpXR8dHbN742J8YYJWEki5I6L5W4d4vDrIHkwhekepR0TV2AdbNqzgv96
         mLZ6oaR9SaM5WL1F3XZZ/MhtAEl3bYw/OtGN4w4Y8gd5cNwgoBfAC7G6M9ySjsDPjwWI
         q4NFsPAtcvA422V//8Zp7pW3K1en9DwHNaIa7ULc+PRdjl7G9p+P/ozirT07/OTPNrPA
         iyLedVV0c1FAGs+YjtT9D+308tj+9L4LpzT7U8IqYAA/DG4rdcYQ5qGJKf1T1Zo0acxZ
         Sxue1XXexmJWjePmDOMA4aE6pFV+6+9ulrAL9dbrwDFsvf+v5QkfnbgWc+a9HI7B/7h8
         AZOw==
X-Gm-Message-State: ACrzQf1aUSLFFCYDrgHeyrOOqJx9W9aI9UgaoxKcrsiqS7g05yPBjJre
        sp45CXA56fuJ50kT1jg0wDglaBiZaiB8fQ==
X-Google-Smtp-Source: AMsMyM4Hw8g10gGvpQo84btvZIJSOfBT3oJV0KbuBFTi6qZgmkWGPw0DLqyWzyUFeogoZCGlfCPkOQ==
X-Received: by 2002:a17:907:97d5:b0:7ac:5f72:6c1a with SMTP id js21-20020a17090797d500b007ac5f726c1amr15336426ejc.126.1667260017150;
        Mon, 31 Oct 2022 16:46:57 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id lb15-20020a170907784f00b0078d22b0bcf2sm3452055ejc.168.2022.10.31.16.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 16:46:56 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1opeUa-00Av21-14;
        Tue, 01 Nov 2022 00:46:56 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: ab/make-bin-wrappers (was: What's cooking in git.git (Oct 2022,
 #09; Mon, 31))
Date:   Tue, 01 Nov 2022 00:45:24 +0100
References: <Y19dnb2M+yObnftj@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y19dnb2M+yObnftj@nand.local>
Message-ID: <221101.86mt9b5zf3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 31 2022, Taylor Blau wrote:

> * ab/make-bin-wrappers (2022-10-30) 3 commits
>  - Makefile: simplify $(test_bindir_programs) rule by splitting it up
>  - Makefile: define "TEST_{PROGRAM,OBJS}" variables earlier
>  - Makefile: factor sed-powered '#!/bin/sh' munging into a variable
>
>  Resolve issues with the bin-wrappers/% rules where "make
>  bin-wrappers/git" would generate the script but not "git" itself.
>
>  Waiting for review.
>  source: <cover-v2-0.3-00000000000-20221026T143533Z-avarab@gmail.com>

I've since sent a v3, hopefully addressing outstanding feedback:
https://lore.kernel.org/git/cover-v3-0.4-00000000000-20221031T222249Z-avarab@gmail.com/
