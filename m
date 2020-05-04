Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA479C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 23:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82BB02064C
	for <git@archiver.kernel.org>; Mon,  4 May 2020 23:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhxNiUqa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgEDXZP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 19:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgEDXZP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 19:25:15 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137FBC061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 16:25:15 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a31so171831pje.1
        for <git@vger.kernel.org>; Mon, 04 May 2020 16:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kgNfXpH3JnZcMw135ER4EQ1wZ048ZWZfGBsW6FSwD68=;
        b=lhxNiUqaZvQmiiyukXMp454xuiGOMeCElV5AvQMA1bX0FRZXWBLVyx/VYgEJiny6pw
         mpsozs2dFhs6zo/h/Yrr0m8j8Z0yBjlBIZLg/TglBo1u+Pe7T20GEPmEwxA9gDIbgv0Y
         Rl0G9WC8epW0J8ihmmqcVgbxE2E4IUvz3lFGXyUrgtNqEehu37v6FZisb8Q+v8D/HTtz
         f0fzFWASHp4z+/rYA6Y7XTrhq0RG0W9nGgyf/u5HIXa1ovdoUVgV9/0C3SINBtaqc8kY
         S+U2g6NhkX748YHS6Gf/xVAF6siM+mIFLv4SrlcJac+oUzV4mbJ1YujvvQ2+L36XPNaU
         GOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kgNfXpH3JnZcMw135ER4EQ1wZ048ZWZfGBsW6FSwD68=;
        b=DjTzFALwoo8Ao3cX0IE4YHagspN98gkU/Uh6jzr0P3XPt2uLQ8e+gCpZyrhskxD3Bi
         o84KbqqSApEV2CAV6HZMFv+sGLSTgEL5U/HwmAUz6kJj7pyVQGzlijAgVBzg0PKdA4fm
         GVT3ARf5+Z49qnuvgjmhgA1ryDwtO3SBpfrDX4zeE8I9QhEpzBi3KVKx/l4UCs4iayUj
         iJQZWDikwkiAVsdQ4Hc64DsEfbX4jM4bsHcsjpwP4t23AOVQ9e26VXrS/mrG+Psy5214
         DmcFZNA6BCbTx+6qg5pMQAKj+pfwjpfqUE2oVNh1+wKL0TMx+EVmLQAJfXuAs0CQDy8S
         kyFA==
X-Gm-Message-State: AGi0PuZayfLiLVUm/BQZ3RFrYXWQUI0M7m8Y5pGzJty7S8esjSkXuKeZ
        gqjNWFP5ZjtqpAx5L2uHWmM=
X-Google-Smtp-Source: APiQypK8x19jkwaDhI1dsFKISjzh1Gwwd6BWlR7XT+LzvKELS/iNZxzX4nZbCteUVdu2KYad+DQbog==
X-Received: by 2002:a17:90a:f689:: with SMTP id cl9mr231945pjb.43.1588634714589;
        Mon, 04 May 2020 16:25:14 -0700 (PDT)
Received: from localhost ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id d12sm87296pjx.1.2020.05.04.16.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 16:25:13 -0700 (PDT)
Date:   Tue, 5 May 2020 06:25:11 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 10/12] tests: when run in Bash, annotate test failures
 with file name/line number
Message-ID: <20200504232511.GB29599@danh.dev>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
 <cover.1586538752.git.congdanhqx@gmail.com>
 <ce0038598704e03becc65731a71abf596bdfbe98.1586538752.git.congdanhqx@gmail.com>
 <20200504174636.GG86805@Carlos-MBP>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200504174636.GG86805@Carlos-MBP>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-04 10:46:36-0700, Carlo Marcelo Arenas Belón <carenas@gmail.com> wrote:
> On Sat, Apr 11, 2020 at 12:18:12AM +0700, Đoàn Trần Công Danh wrote:
> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index 0ea1e5a05e..40a00983f7 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -657,6 +657,18 @@ die () {
> >  	fi
> >  }
> >  
> > +file_lineno () {
> > +	test -z "$GIT_TEST_FRAMEWORK_SELFTEST" && test -n "$BASH" || return 0
> > +	local i
> > +	for i in ${!BASH_SOURCE[*]}
> 
> this line breaks with NetBSD's sh (and probably other POSIX complaint shells)
> 
> the Coding Guidelines mention "no shell arrays" and while the tests are more
> relaxed against that rule, usually workarounds are needed, as it is shown by:
> 5826b7b595 (test-lib: check Bash version for '-x' without using shell arrays,
> 2019-01-03)

This function will be called in CI only, and when the the shell used
is bash, to annotate the faulty line.

We have a test guarding it already.
So, I think it's fine.

-- 
Danh
