Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257EFC433F5
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 16:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237894AbiDFQfX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 12:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237714AbiDFQfD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 12:35:03 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D0B19CCC8
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 06:53:27 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id d10so2778397edj.0
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 06:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=mm7zD8PyWOIIza/BZb33bv90wJP8zMozkNeUfkOCZB4=;
        b=CwIfMj0Hu1a1tpCU69T27E1Io4hNvYcPNpNrqul3wsYe7UdGKGdmpm+BXGQQqNsD1m
         ddIkMiRUqcRfIv4sqXdSkYgvEhhNHfNJsfxCG7O8JDLpiFAffzSUBazA5qoPTSLJ1Zyb
         Y3eFxriF6s6kMOxvhc7/dXBIr8mgK/7GJ/UmXoVELizXqeZwasMx1KeEXdkG2+ug3ma6
         0cI4gr41zfhNOMWiUzWoGMwwTOtyHhH0x+MPkaLtr/wWnb90OzHhQLDds0OmblYeOmF4
         PFZ/mpn3prK5yt7ujUPXvev6dFQxYQeqXUme3oXONAGxGOtJ8pu/TjEXQ+ro2BbKtr41
         3/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=mm7zD8PyWOIIza/BZb33bv90wJP8zMozkNeUfkOCZB4=;
        b=s4IGZ9GcChktjeyOGsBn+ijU8cdYP4yiWbhcdzRqKM7LCRdxigsZga5nf5q03HARR9
         LuPu673oNsH6MvoAqvEkytrCJX99EBIshR5R1Bszu7xsmrVy87g3/eXjmvAhjW226bC3
         O6VaWiShtKRGtwYpgsIl56vgTkMTv7nO/imhpEiqwwhtjjg17/5maUhc8QUG/F+dWxdI
         8gluS72UMR+FxlRca8ER+rKdLZQ6y5i+wMk5GsaPEukWZuzFC+ukt1i5bZ8xLfaKsXvq
         YKQmj4kKgE+4qs2B1IsagOrmKJTkX4SkrtJzZCpUGJ/l613VsSgtyR5MHuEuMu6bvMsC
         HY4A==
X-Gm-Message-State: AOAM531SmdF22bNbA9Id+cL12v2/FEEqfioorqUxUQXC9rXJQwpTenyQ
        3kYRqN8Tg95LlAM68k5xp9vdoCcfps4hLg==
X-Google-Smtp-Source: ABdhPJwiQE4kRqeYcGslzFNtvv7lD4rWd5hUgY/oXDbKYUZtxxZmnCjSSvdm1jGAMpgJflZFe97UQA==
X-Received: by 2002:a05:6402:2812:b0:418:fc32:be18 with SMTP id h18-20020a056402281200b00418fc32be18mr8882289ede.357.1649253205837;
        Wed, 06 Apr 2022 06:53:25 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gb3-20020a170907960300b006dfafbb4ba4sm6649699ejc.83.2022.04.06.06.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 06:53:25 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nc668-000ikU-Pw;
        Wed, 06 Apr 2022 15:53:24 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     rsbecker@nexbridge.com
Cc:     git@vger.kernel.org
Subject: Re: [BUG] git-2.36.0-rc0 - t6200 fails due to library/path issues
Date:   Wed, 06 Apr 2022 15:51:54 +0200
References: <041601d849a8$1441ce60$3cc56b20$@nexbridge.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <041601d849a8$1441ce60$3cc56b20$@nexbridge.com>
Message-ID: <220406.867d82e2sr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 06 2022, rsbecker@nexbridge.com wrote:

> t6200 makes assumptions that ssh-keygen to be used is located in
> /usr/local/bin. This causes problems when we have multiple OpenSSL
> installations - which we do - 3 of them. Our environment supplies OpenSSL
> 1.1 in /usr/local-ssl1.1, with a corresponding version of ssh-agent in a
> different directory. There needs to be a mechanism to override the
> ssh-keygen so that tests will work in this situation.
>
> *** RLD ERROR ***: Unresolved Text Symbol OPENSSL_add_all_algorithms_noconf
> in file /usr/local/bin/ssh-keygen.
>
> *** RLD ERROR ***: Unresolved Text Symbol EVP_MD_CTX_cleanup in file
> /usr/local/bin/ssh-keygen.
>
> *** RLD ERROR ***: Unresolved Text Symbol SSLeay in file
> /usr/local/bin/ssh-keygen.
>
> *** RLD ERROR ***: Unresolved Text Symbol EVP_MD_block_size in file
> /usr/local/bin/ssh-keygen.
>
> *** RLD ERROR ***: Unresolved Text Symbol EVP_MD_CTX_init in file
> /usr/local/bin/ssh-keygen.
>
> I do not know why the test is forcing SSH in /usr/local/bin - it is not
> something coming from our environment, which has PATH set correctly.

Is it:

	SANE_TOOL_PATH = /usr/coreutils/bin:/usr/local/bin

In the nonstop section in config.mak.uname along with:
	
	Makefile:ifdef SANE_TOOL_PATH
	Makefile:SANE_TOOL_PATH_SQ = $(subst ','\'',$(SANE_TOOL_PATH))
	Makefile:BROKEN_PATH_FIX = 's|^\# @@BROKEN_PATH_FIX@@$$|git_broken_path_fix "$(SANE_TOOL_PATH_SQ)"|'
	Makefile:PATH := $(SANE_TOOL_PATH):${PATH}
	Makefile-else
	Makefile-BROKEN_PATH_FIX = '/^\# @@BROKEN_PATH_FIX@@$$/d'
	Makefile-endif
	
?
