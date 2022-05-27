Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40D0C433F5
	for <git@archiver.kernel.org>; Fri, 27 May 2022 08:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbiE0ICd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 04:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiE0IC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 04:02:27 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A556644D9
        for <git@vger.kernel.org>; Fri, 27 May 2022 01:02:26 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id c93so3145818edf.7
        for <git@vger.kernel.org>; Fri, 27 May 2022 01:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=FbECyR5XwFQpb70BBI5OdZ8uecyaJkXcF5ZJMy3CEhk=;
        b=UWw6le3HiOcYWGrlcl113GJG/5fBjTzhv+CW94XV7TFL/FXXXvt8Ae2g5yK+VnkluL
         R8a3nsuypjNmEoEUZYLV7QEo2Lenjxi5dFn+BY1DEf00yQ42K+1GZztr1J0GSakWHbRL
         mMyoCoKILfczaKPNxcAQktMqSVFpvK3xzqd1qK75csrghRgrcRDewHUaX0dmYkUiTTBY
         rnfnXjghEeaiVlmodXscJkiYsgj+yyT8oOZJJ9KGmwOJMfKY1VFwRmXBeQZxZyP/fJEP
         /NLDeTRchjgwbfdFG1n8coBiFOEmZdyRzRE0sA/0Rqji+bhTGNOg05by7b0GqAAD24p6
         jaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=FbECyR5XwFQpb70BBI5OdZ8uecyaJkXcF5ZJMy3CEhk=;
        b=qOa8F4ndyplZsaU2PaMbaBqsLgtrjAX4Wigpv8eRo7P2OO2t0ykOBJQCy7xOivlSZM
         zmvVpCZKpjy4UmaqvHb4Sqm4kY+ffwsDRbwUQ4ACI6u8IVo70E5+6Qd5zGGJkfYzM2A6
         IOmVnUtIiL8GwNGBmWD7FS17xCbIZukq84pBnV+iIMaYfGF8bmhWSnBHICXWkS/VwVEY
         cOM2K9tpbHVz9Wcf2vgjqEu8rSFnI5AWsg0PiuMmZUXdvuhzCSe/d4AIvy4ES+cmbf86
         1qwghcmPIvuWIpDQP2pSlkpW6LnekHkYhfBnaYfuOx39z3voRHaH8jl2ud+rY8Qof9W3
         ExQQ==
X-Gm-Message-State: AOAM532tuIVCI+4PbhAxeJ5eqAMVkN+OAnaV96OqQsr+FR5zOlUFMFUs
        YyZoQaSSnrJquLll1CTFDp0=
X-Google-Smtp-Source: ABdhPJyNEyf4BbBSb0fAkLcwT4JHSlFQBcRZ1Br/R5lUClie7WF5FvwqaMT3PEFBNTrE+ffvDt27uQ==
X-Received: by 2002:a05:6402:27cc:b0:42b:42eb:d50c with SMTP id c12-20020a05640227cc00b0042b42ebd50cmr31663910ede.16.1653638544514;
        Fri, 27 May 2022 01:02:24 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id o17-20020a056402439100b0042aa5a74598sm1868958edc.52.2022.05.27.01.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 01:02:23 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nuUvP-000K5K-9v;
        Fri, 27 May 2022 10:02:23 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Kevin Locke <kevin@kevinlocke.name>,
        Derrick Stolee <derrickstolee@github.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] setup: don't die if realpath(3) fails on getcwd(3)
Date:   Fri, 27 May 2022 09:48:43 +0200
References: <80eeba2b2a58af2a5497f398beb5c03447c41f61.1653003552.git.kevin@kevinlocke.name>
 <7c064f43ed426c9e3b54e1ae5313d6b9332a47cb.1653141169.git.kevin@kevinlocke.name>
 <1580ad10-43f6-bc73-901a-b65b1aea73ff@github.com>
 <YozlZ9DPrRLPBTBP@kevinlocke.name>
 <CABPp-BGZTDKorz+CFScfTfx47c+TuJaAD_Zyyo1Jj_tymYkVXQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CABPp-BGZTDKorz+CFScfTfx47c+TuJaAD_Zyyo1Jj_tymYkVXQ@mail.gmail.com>
Message-ID: <220527.865ylr4d4g.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 24 2022, Elijah Newren wrote:

> [...] So, I think the signature of free() is just
> wrong: it should have taken a const void* all along.  Unfortunately,
> the wrong type signature sadly makes people feel like they have to
> choose between (a) dropping the added safety of const that the
> compiler can enforce for you during the lifetime of the variable, or
> (b) leaking memory you no longer need.

Hrm, don't you mean that it would be better as:

	void free(void *const ptr);

Not:

	void free(const void *ptr);

But standard C doesn't make much (any?) use of the former form for its
library functions by convention.

c.f.:

	cdecl> explain const void *var
	declare var as pointer to const void
	cdecl> explain void *const var
	declare var as const pointer to void

I.e. the whole point of malloc() is to give us a pointer to memory that
isn't "const". If we stored that in a variable that was "void *const"
we'd save ourselves from some amount of foot-guns, but you're rarely
doing pointer arithmetic accidentally, so probably not really.

But yeah, we really should have this documented somewhere, i.e. the
cases where we "lie" and expose a "const char *" which is really (as far
as the machine is concerned) mutable.

The confusion being that we're seeking to overlay our own "no, this
isn't mutable" on the basis of our desired API boundaries, not just to
use it to inform us & the compiler about the "real" nature of the
underlying data.
