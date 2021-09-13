Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5820C433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 19:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98673610FE
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 19:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241752AbhIMTio (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 15:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241718AbhIMTio (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 15:38:44 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3677BC061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 12:37:28 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id a22so13645301iok.12
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 12:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZH3sHqPflx8RVdHuYIegDVr/JwtgAErIZn1jcmThby4=;
        b=u/g+nMQlA414DqHBu1DvV+DFkpqnKIKahDSbeNYlzNtBHj9TLMn3HekeyuuM3wjtZC
         DyJ5dAMBpFQYvJ+6wjMENongEgC31NYTZSyO0KojFFmilQcjHAMBAeu2tGc/pQM3VwP1
         x4LYBf/wZd3gk5DQFtUnWy4iEGL/Z2cB6nWTDSKC4Wvy4MzsCJJA+JUeJy9AAtJ9beeA
         Y7Xr7lYnMqKpPcKqrLCdeSbR475j0C8cMftd7h1n+IKWiZDsQlvUz7C9wdZjmDakM112
         sgsSvmkthP9c7ApCPzEjGvSfJNP+GpYfZoPP01m8CzVfZM+yiUXTS1l5EZMId0hgJ5sz
         H45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZH3sHqPflx8RVdHuYIegDVr/JwtgAErIZn1jcmThby4=;
        b=ER1oiZVSUZCsmZgaYTJAyi79AIpL4GtCLujUrmPyhOLz8sNI1LN0ts/z2mbE37PybE
         YAEpdo9ooL+h8MsGSaj1lO0lKdF1foeGp7s0TiU9ssAGko+ELY2BcWgaTUr7u6eVgnit
         Wis/ILJkldC4wpd2qwqegGEu9JkBWjLGdlaT6q241ZmqP3WYAcYQ+Vi7S1tIBBve11yH
         J0DOE/04puUXkUoHyACMLR+IsaNBzWY9xsS56AQBWlcGFXMBtK/U6g7FB263T7s0a/Uz
         5YS+erWgjvKTnbSOr+ynyznEJwkpieJLBzrKaTdWeO4CT7G+jfkkkOKAtmcFUwY2E3Y4
         BoSQ==
X-Gm-Message-State: AOAM532WfFOV/F6bav6LEamBN7Ig4tTZIdVQwAroFl8zwGQIreAJ/USc
        qasizQBIYvCKt2VIraM69rdF+FTS50YE7Blj
X-Google-Smtp-Source: ABdhPJw8jbceAzKJlF8cCv5YEOT/Wikk0Mkg/LZ+9mCZ3QvXtXdfe4miBNUaL4gW6wUVtaeKy8jCiw==
X-Received: by 2002:a6b:3b8c:: with SMTP id i134mr9951777ioa.29.1631561847599;
        Mon, 13 Sep 2021 12:37:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a20sm5543629ilt.8.2021.09.13.12.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 12:37:27 -0700 (PDT)
Date:   Mon, 13 Sep 2021 15:37:26 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com
Subject: Re: [PATCH 3/3] gc: perform incremental repack when implictly enabled
Message-ID: <YT+odsA17BqtD+WJ@nand.local>
References: <20210913181221.42635-1-chooglen@google.com>
 <20210913181221.42635-4-chooglen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210913181221.42635-4-chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 13, 2021 at 11:12:21AM -0700, Glen Choo wrote:
> builtin/gc.c has two ways of checking of multi-pack-index is enabled:
> - git_config_get_bool() in incremental_repack_auto_condition()
> - the_repository->settings.core_multi_pack_index in
>   maintenance_task_incremental_repack()

Is this hinting at why there are no new tests added here? If so, it may
need to be explained more clearly, since I was a tad confused after
reading it. But if not, this patch message deserves an extra sentence or
two saying why tests aren't necessary.

Or if none of that is the case, and tests *are* necessary, then they
should be added ;).

Thanks,
Taylor
