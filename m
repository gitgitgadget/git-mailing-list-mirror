Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9A5C4332F
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 13:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiJRNyI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 09:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbiJRNxx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 09:53:53 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B79AD03B5
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 06:53:41 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id w18so32317525ejq.11
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 06:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ic8y3RKRL14HF++Dmi1EOxZ/zVlHkMVeWJ3bGyEDyiY=;
        b=IwHYvcVxoAJRsO7IAPCksSJtpnG9bLJRSKe/3UGZdkTN0woHa0WXC7dl87jXc1R5bT
         TWAYqyEaRpUKPPnpoho2ByqZTeAefPm0fQdHE1AXjqDe8biyTKq+JDkxdZu3udcGGocz
         3RtoNCIXqLjUwEj1IIVv3MZ8HsggD7W9g1cF4MvhgkOpMdtK3kGZWeLqfzBREc2nDxLQ
         Bn/sKCW7dXqMkMG/4uwjB667MfBYUJpk54gAtB8DD4ju4qGrrMbMn9H0rI24NmMljj0C
         9mdz1dNgCsLhDO56s2XwMnY2Eh4qGEltzJXFv3UR4VYmslsQGNlWMYKbh0DovKFRJOcE
         VgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ic8y3RKRL14HF++Dmi1EOxZ/zVlHkMVeWJ3bGyEDyiY=;
        b=oUxFYv2LOp4lX+kPOQjIsQSnpg4VIA52OHOsl2r5ZP4O0ZyTsNXVUdZktCCDRQDB9A
         Sr2ro1L9CDrPHSPDWA2NftvhhyVujwuRj3h2wa3IWWgsE2vPOaljp8NsbVY3dAtNad2C
         tyeN3Sr6PdD5jxJU8hEu4R65sFem9zU7UwHUQetjupaCNhvb8YnGboXUkc7yrT33j7Oj
         WdpHyElyUtmc/Qi4vuyLixJeUYB04bla+TmNKJuAuSBW8Tg3EFJKZXZgrGNiRvGh/4AQ
         RBWBp6A81QNVSpr7BUc+nszbdy+z/XJc5rYu9BrughmFrh8TTdh437nid2lNt1uF7rJe
         OEtQ==
X-Gm-Message-State: ACrzQf0pDfajbrgVeRBhyF7G5oqz04QgFDJk8VmHbSFry5MW0G2+a7Ct
        +FLgpoWDmpLy/9cwt5O4ZX/9m09stqgcpQ==
X-Google-Smtp-Source: AMsMyM58RLE9WeUi3FdiTy/LmBg0PmwxC47h30qgR4UwT7f4V04vT2NCHta2xIptJovLHD5Hk/9t7A==
X-Received: by 2002:a17:906:c152:b0:78d:9dbb:150b with SMTP id dp18-20020a170906c15200b0078d9dbb150bmr2422675ejc.542.1666101219786;
        Tue, 18 Oct 2022 06:53:39 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id n25-20020a170906165900b007317f017e64sm7581069ejd.134.2022.10.18.06.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 06:53:38 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1okn2H-005mWo-2g;
        Tue, 18 Oct 2022 15:53:37 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 2/5] cmake: copy the merge tools for testing
Date:   Tue, 18 Oct 2022 15:49:13 +0200
References: <pull.1320.v2.git.1661243463.gitgitgadget@gmail.com>
 <pull.1320.v3.git.1666090745.gitgitgadget@gmail.com>
 <9faca9d5cbe706c00d03ca2a125f2e113294a548.1666090745.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <9faca9d5cbe706c00d03ca2a125f2e113294a548.1666090745.git.gitgitgadget@gmail.com>
Message-ID: <221018.861qr5i6fy.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 18 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Even when running the tests via CTest, t7609 and t7610 rely on more than
> only a few mergetools to be copied to the build directory. Let's make it
> so.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  contrib/buildsystems/CMakeLists.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index 6ac20bc5054..0c741e7d878 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -1078,7 +1078,8 @@ if(NOT ${CMAKE_BINARY_DIR}/CMakeCache.txt STREQUAL ${CACHE_PATH})
>  	#misc copies
>  	file(COPY ${CMAKE_SOURCE_DIR}/t/chainlint.sed DESTINATION ${CMAKE_BINARY_DIR}/t/)
>  	file(COPY ${CMAKE_SOURCE_DIR}/po/is.po DESTINATION ${CMAKE_BINARY_DIR}/po/)
> -	file(COPY ${CMAKE_SOURCE_DIR}/mergetools/tkdiff DESTINATION ${CMAKE_BINARY_DIR}/mergetools/)
> +	file(GLOB mergetools "${CMAKE_SOURCE_DIR}/mergetools/*")
> +	file(COPY ${mergetools} DESTINATION ${CMAKE_BINARY_DIR}/mergetools/)
>  	file(COPY ${CMAKE_SOURCE_DIR}/contrib/completion/git-prompt.sh DESTINATION ${CMAKE_BINARY_DIR}/contrib/completion/)
>  	file(COPY ${CMAKE_SOURCE_DIR}/contrib/completion/git-completion.bash DESTINATION ${CMAKE_BINARY_DIR}/contrib/completion/)
>  endif()

I mentioned that I hacked up a "root cause fix" for some issues in cmake
in 1/5. Continuing that this works, but is really just a
hack-for-the-hack fix, where we should fix the root cause:

Which actually, is really simple:
https://github.com/avar/git/commit/30f2265fd07aee97ea66f6e84a824d85d241e245

As you know we fake up the $GIT_BUILD_DIR for cmake, but then later in
the recipe (i.e. here) we have to scurry around and adjust that because
for some stuff we mean contrib/buildsystems/out/<path>, whereas in
others we mean the original <path>.

So here (and this isn't on you, we had this before) if you run "cmake"
and e.g. tweak the mergetools sources we'll need to re-copy them, blah
blah blah.

But we can just ... not copy it at all, and have the test-lib.sh learn
that some stuff it needs from whatever the "build dir" is, but other
stuff is *always* relative to the root of the project.

So, for most of that & the context it simply goes away, we don't need to
copy po/is.po, the tests can just know where to find it, ditto
mergetools/tkdiff (which is not generated), and the bash completion.

