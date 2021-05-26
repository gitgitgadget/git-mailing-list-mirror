Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5C5C47088
	for <git@archiver.kernel.org>; Wed, 26 May 2021 18:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05612613BF
	for <git@archiver.kernel.org>; Wed, 26 May 2021 18:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbhEZStK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 14:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235744AbhEZStC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 14:49:02 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85599C06175F
        for <git@vger.kernel.org>; Wed, 26 May 2021 11:47:28 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id k4so2105463qkd.0
        for <git@vger.kernel.org>; Wed, 26 May 2021 11:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4Y5EvXajcWELGEwV63uIRWGdfR8nvOk2FjY8u9h54AI=;
        b=rorj/Qy9NzSY+NhMxi6jXl5eJMNZ4P59T4lRuwzTYfhcDlPWd2gpH+at16ask0cxka
         VQxVaX29K+VBeYQRgr8Jo/jEUwx2kbN1rQQhJSourgQoxhvqoLxnHL5IGuOPo7YiDAMb
         TFK/0n4lhnS+5bGoTILFqKWqpBdMAjdRZ6O+N+oV50C0Nm409ebo7K7zcj87JCPLO5PK
         6g+GxCWLn1RB8fIUCH7SL0JOO1hnQUnhhypU6ekycrmcMcuyZlrlbSEn1nqO33IyrdaL
         7jegFasurgPGZEn48BhrfqkfIoZsqxyaTMCmaLyA04U7CdHfNXTbGKle3R3CjBezgf2t
         2N5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4Y5EvXajcWELGEwV63uIRWGdfR8nvOk2FjY8u9h54AI=;
        b=blvGBmnIWtYcIdIPbjR48wDK63JczJKmZTqTZCyZ37Ofc5R+U7uOYU4QUPEaB3TR+D
         wE63XPTMcJN2FzsiyLaGEKrY0e9YGv6iMp1HmrVnN3sp1kbiPGIgHSuRwfC1jxhmkJfz
         VU6POtTBZiXFcsN14V6Sk1CwABdMxIt6nG7TB92n1DZDNmZA30JQ62cfypgOsxDTO1qa
         hXOELCat9FDIgswEx4SDvX7nycsIlLzmHmkX0Zla2utempqx8a0Cx/9lOD2BdlDyyVk4
         BFvKvNjuD31ZROa7oN6nPmWBN5pyQQL5Ly91bpuqPT8U+VO6/7/0oRf19Rsb3EnMYTP2
         SGWA==
X-Gm-Message-State: AOAM532lcUBVrfNILIFWIS3PjoQfzt+b5DOx4prlwlNt2TKb70kT9NEB
        sIiZcKG2BqiBaw/WSfJSy9suAQ==
X-Google-Smtp-Source: ABdhPJwxo1R8sRZboP4i3xaNmdbCocJDSSsREUNvsq983TTmL/wlq13Ne/SNbXR5KrIbZZlPTrmNGw==
X-Received: by 2002:a37:5c84:: with SMTP id q126mr45030754qkb.21.1622054847767;
        Wed, 26 May 2021 11:47:27 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:fd7b:5b8e:7238:b804])
        by smtp.gmail.com with ESMTPSA id a21sm2069086qtm.54.2021.05.26.11.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 11:47:27 -0700 (PDT)
Date:   Wed, 26 May 2021 14:47:26 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>,
        Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
Subject: Re: Should we do something with #git-devel on Freenode?
Message-ID: <YK6XvmrtrdkJvsnI@nand.local>
References: <CAJoAoZ=e62sceNpcR5L5zjsj177uczTnXjcAg+BbOoOkeH8vXQ@mail.gmail.com>
 <YKViF9OVLeA95JPH@google.com>
 <20210520071141.GZ8544@kitsune.suse.cz>
 <YKaaBj0KmJ3K5foC@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YKaaBj0KmJ3K5foC@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 20, 2021 at 01:19:02PM -0400, Jeff King wrote:
> So if there is a critical mass of useful people that will hang out on
> the Matrix equivalent of #git (or whatever other tool), then that may
> become a new place. And people who want to do that should let people
> know where they can be found (whatever happens, I'd appreciate a PR to
> https://github.com/git/git-scm.com updating the "Community" page).

Emily tweeted today [1] that the #git channel on Freenode has been taken
over (presumably for violating their guideline that channels not mention
Libera in their description).

So using Libera seems like a good idea (although I agree that there is
no "official" place to go, and this is more about making people aware of
the new status-quo). In that case, here's a PR to update the "Community"
page on git-scm.com:

    https://github.com/git/git-scm.com/pull/1607

Thanks,
Taylor

[1]: https://twitter.com/nasamuffin/status/1397619871278530560
