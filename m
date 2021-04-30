Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FE1C433ED
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 09:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3F9F61474
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 09:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhD3JoK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 05:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbhD3JoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 05:44:09 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4A6C06174A
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 02:43:21 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id h10so81858115edt.13
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 02:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=jzZ5X/mBl72op457Qif0dXTs28wXZ9Np2RAITF0oZk4=;
        b=oj9WbMyvVNOiSvfpSyMISM1noEZQrcxiEfUiLh4qfNgFtyoApUDsWDtACNNOD16Pye
         WSOBdUqoVRQmG1RcAOnVKoxcnEXFnjEd73CasDAeeNWGHz3W6+LdBYb9M98q/6sdA8vj
         yfVL5EJNk24RfVjcQGAtgaLwFvixdejlbcnRp2JWKZp+XFJvNls80616K0UjWPbRg509
         uFMfA6MeW2mhk/Dv4WwqPhFieKUjY+/iYZ3hATqBZFIzuoAZFaxpgNZnqOeyqCe9NNjG
         S4WqJmdZJHqVKAYM8dadT3fDQruPYnmg+mSnFYRf03S18ZLwSx17zquTfJsiWTxJ7WO2
         HwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=jzZ5X/mBl72op457Qif0dXTs28wXZ9Np2RAITF0oZk4=;
        b=UZciQwM6oaSECleRGBIri8i5BU7fwePGZrR43GHrh1AfwIb+QTQE+uaFZFr4C532OM
         qvQsVkqQY8pgnJf4VHWN+VL8C9ivhgG4WEtIqtjVTQNAX54/pYidDNj4KWgXtkDK2Cx9
         Xm7SjjjP2QQ1qBdjgS5Ey0rPQZAv1vzp58BbpUZWHxkLwjW+lxnRHtJkp4bBAHJpDQX9
         LhlcCCoLAYL5fgoxov6nK3XVIbvbgXWy0rHLcYCJLcA+NFsj5UIFj/amkQPU6EQ7bF5/
         l20JIk0GsBhla7Pcy33PvbVsXTfUV4RBONmN04CdogLohR2kcHwRsaTVAhi2fR/ZhUkB
         gLyw==
X-Gm-Message-State: AOAM532KZtuvcorHyHtvva174nSLoabDzB2PbdE7rVm2lEe470On1RVY
        i/sJfGXB1B/TJ3JO8Lnko1Y=
X-Google-Smtp-Source: ABdhPJy8IQHY1xwnd+IbXWazbpdMrwr2SMwVxkvOYqw/BUQidW5RdGt30nV5IOXNv+lQ+hnd/dnRqw==
X-Received: by 2002:a05:6402:138f:: with SMTP id b15mr4745569edv.121.1619775799792;
        Fri, 30 Apr 2021 02:43:19 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id y16sm1606195ejp.36.2021.04.30.02.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 02:43:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Danny Lin <danny0838@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Luke Shumaker <lukeshu@datawire.io>
Subject: Re: [PATCH v3 02/30] subtree: t7900: update for having the default
 branch name be 'main'
Date:   Fri, 30 Apr 2021 11:38:52 +0200
References: <20210426174525.3937858-1-lukeshu@lukeshu.com>
 <20210427211748.2607474-1-lukeshu@lukeshu.com>
 <20210427211748.2607474-3-lukeshu@lukeshu.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210427211748.2607474-3-lukeshu@lukeshu.com>
Message-ID: <87zgxgxg3t.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 27 2021, Luke Shumaker wrote:

> From: Luke Shumaker <lukeshu@datawire.io>
>
> Most of the tests had been converted to support
> `GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main`, but `contrib/subtree/t/`
> hadn't.
>
> Convert it.  Most of the mentions of 'master' can just be replaced with
> 'HEAD'.

Looks good to me. FWIW (without having looked carefully) I'd have
probably just set up a "sub-proj" remote and done a "git fetch" after
configuring a refspec during the setup, but just s/master/HEAD/ is the
smaller change to just fix the "bug".

> [...]
> @@ -994,6 +994,7 @@ test_expect_success 'push split to subproj' '
>  next_test
>  test_expect_success 'subtree descendant check' '
>  	subtree_test_create_repo "$subtree_test_count" &&
> +	defaultBranch=$(sed "s,ref: refs/heads/,," "$subtree_test_count/.git/HEAD") &&
>  	test_create_commit "$subtree_test_count" folder_subtree/a &&
>  	(
>  		cd "$subtree_test_count" &&

This though needlessly peeks into the raw refstore. Use branch=$(git
symbolic-ref --short HEAD) instead. See e.g. my
https://lore.kernel.org/git/patch-08.11-7fb8849ce66-20210423T072006Z-avarab@gmail.com/
