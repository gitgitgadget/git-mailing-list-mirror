Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D90C433F5
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 16:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68B8F60FA0
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 16:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbhIRQMG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 12:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbhIRQMF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 12:12:05 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE98AC061574
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 09:10:41 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id j18so16067746ioj.8
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 09:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6GNSLd/OKlKETI+kbKlO2so9Umq/QfajoO4Kw9rg1UI=;
        b=pM5m5S6lASqfxlx6vkEiVAsBZ5aMCggk0ZM2o7DanBQh5laVjjsj9itBAQz9187SHO
         w588jjt1zyEO9Ds8FH+fT0u7Rl7NE7u/2F2qO3QtBTDnL8Wgk0X671xpDgGJNwgqR6eK
         /FIt00I1wYA3FlFlRpBFWLKy+jGPumD84YTfjkeABT2LxT7XuR+agrvG75+1GW91nSod
         mWqiA4Tbz2ucL1ZwlcQqMUnsV716sbF+oXOk3PjzkXAWdNwcjtZlypzClJMO08c8kCsB
         Vrzp2Buh+i/xt71WZl4ydcBKI4QDXdf08TR75rtWpHeeSmTILrP03of7VZcXKG1WNNEv
         14Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6GNSLd/OKlKETI+kbKlO2so9Umq/QfajoO4Kw9rg1UI=;
        b=qQlwvlVFnponlAXU+K/Q6iGFO7GIbYJDLP/1VYjhuDCT6IfEpq1HuSNgsAmvYsO4pM
         SkMioDBJz2Ceir5v7FXx8cgULWhzCEw2ea5mUoPZW9iAm9EuPff1HvTbfrzZABa1/wxF
         YjCg1Zt76aVg5MpTj2VvmPmyWCKspxM1gca7f3MN3aQM+V/j2H9CQCuJ+FmknCJ16cgL
         KLHVyWqv9RSB0gdSVWNCBYAC20tZE+4G/aqljTGl79Acznn6oxvWhL9RqdIYF7RHid99
         lzxnNan8Krl2EeXGMw2eeEtUK9cNHcoQkpzjiSZphM/X/UnoRp9lJiyeC1GnCvrLhTLi
         Pibg==
X-Gm-Message-State: AOAM532ncnY/xfsR9LPpxrDLyABZWGftGqtEG3moIn1CFRTeCHzkegj/
        K4l9d5sBF7coF1bN8EtO4RJk+g==
X-Google-Smtp-Source: ABdhPJz2CJ5oX1JUorPJTn0kbCKgLVQ9vXXVxTsRfjXN+/qURgQQvD2M3Xthxx6YhNViMkb2bA/RWA==
X-Received: by 2002:a5d:9355:: with SMTP id i21mr13275287ioo.12.1631981441276;
        Sat, 18 Sep 2021 09:10:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a15sm5631406ila.34.2021.09.18.09.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 09:10:40 -0700 (PDT)
Date:   Sat, 18 Sep 2021 12:10:40 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Taylor Blau <ttaylorr@github.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: Git in Outreachy?
Message-ID: <YUYPgF6tRQ5ERYWL@nand.local>
References: <YTGLLQCvlnT17jo8@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YTGLLQCvlnT17jo8@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[+everybody from upthread to cc]

On Thu, Sep 02, 2021 at 10:40:45PM -0400, Taylor Blau wrote:
> Are we interested in participating in the December 2021 round of
> Outreachy? September 3rd (tomorrow at 4pm UTC) is the initial community
> application deadline.

The project deadline of September 23rd is fast approaching, and we do
not have any proposed projects or signed-up mentors.

If you are interested in mentoring, the time to sign-up and propose a
project is definitely ASAP :-). You can do so by clicking "Submit a
project proposal" at:

    https://www.outreachy.org/communities/cfp/git/

Thanks,
Taylor
