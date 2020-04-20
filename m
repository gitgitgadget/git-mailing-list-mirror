Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81015C3815B
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 11:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AE3F20857
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 11:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qHQjMvpx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgDTLty (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726277AbgDTLtx (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 07:49:53 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81945C061A0C
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 04:49:53 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id q17so8118690qtp.4
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 04:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=8B6wbSyYh7WnzgUr5SLKda6unMAlhkZyTmXRl8GXS+I=;
        b=qHQjMvpxGGQUsaTHS3/yWfCLKCuMli+jyEkQXV1Tjyu2WqVk2lQkffWYafkRLGkKFg
         GhZr/T/EiiHybG4ACZsPa9vHyf5T8aIhh5uYTs3IGSflJ5Q+MCs9M90jH9CCC+6QZxdg
         BfmNHNlzmo8LcFRQpQVMpO3Fg7/WlonsJt/LyxCRydqQkzzxfF+2q0GFgt4J3ip+RJ54
         LpG+zWsW5SL1Hwo1X/88BD1Bg8sacrTZN7hCEU8N5HOriS/m+qUfN1lI99kaWDwaQgks
         QGye3AqAst6eNA1hoGbertZuhvIpq+yJPre0Yiz33A4fcsmbpk7tgVQK5NoPD7BCz8zx
         t41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8B6wbSyYh7WnzgUr5SLKda6unMAlhkZyTmXRl8GXS+I=;
        b=SOa2cNhOFFZo6fYW+IExx7e79m34teQ2cxouinjstQsuuq+AuAr572ll3WdQ1hPLHJ
         Qba2tg4OOfQd973IBOQ5qyXxJKUX+9yL5Vdk7I2Rk3P6YkwjLHi+pkGSebI508Md/1vK
         yCMgW3HIEUJKj2EjJz0IOY2Asg2XARnAPdxC2ayBQDlg7/BzlK89szkHPT/kJnAt232H
         iBRTYMb//VkILtBTC4Z11jOvbNQdeYvgjpDmFlGWw3BgOM3hVInDFyOWeEji4c2pAz/E
         alB4grluA6ZsNZjpl6VoeX1lcV41QR5DvW7D38i5YJ4mPFcAFWfS4QocUp3PokR+D25F
         Ns1w==
X-Gm-Message-State: AGi0PuYC8helhQpKAsnmCg/dgW41PuSChSLI9krE86YNKoAjS7UID7NX
        H4PLTjNiv9TmVkv9LN5v6KjAyZmK2AI=
X-Google-Smtp-Source: APiQypKEbHNJ11EfXPxhBWKCw7yg+fAZe8hpRp5hN3wx3gY3yh3Ma8eWyfHWDsU2it213FPx3AFqqw==
X-Received: by 2002:ac8:6f17:: with SMTP id g23mr15577778qtv.266.1587383392376;
        Mon, 20 Apr 2020 04:49:52 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id z18sm326495qtz.77.2020.04.20.04.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 04:49:51 -0700 (PDT)
Subject: Re: [PATCH 0/8] t: replace incorrect test_must_fail usage (part 4)
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <cover.1587372771.git.liu.denton@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e231e2db-ecbd-5b74-f563-551d03f568fb@gmail.com>
Date:   Mon, 20 Apr 2020 07:49:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <cover.1587372771.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/20/2020 4:54 AM, Denton Liu wrote:
> The overall scope of these patches is to replace inappropriate uses of
> test_must_fail. IOW, we should only allow test_must_fail to run on `git`
> and `test-tool`. Ultimately, we will conclude by making test_must_fail
> error out on non-git commands. An advance view of the final series can
> be found here[1].

I appreciate your efforts here to use best-practices throughout the test
suite. Too often I look at a test script as an example on which to base
a new test, but then I just repeat a bad pattern.

This series looks good to me.

Thanks,
-Stolee
