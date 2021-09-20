Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30FCC433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4041611ED
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347697AbhIUCVi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236450AbhIUBuS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 21:50:18 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7601C06AB37
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 15:10:31 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id d18so11895066iof.13
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 15:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DMldFKTo/LehnGAJdUFUpe3sxvN0S6HTNJIEuuDR2hM=;
        b=Zg22o9l8cbV07HhU3rwjK0QsaNlVPUDZjK0c7BYsaZl8HHfmjN1qmYdIeu/IiyYras
         J56yUj480ABOzVkuyg9/DWalagtJQR9VBtbyxDKgb+e1/O5TN9W0EZoErz8ckXtt8fsD
         Q7mPF7cLDT1C9xhDJuzaNsOKc35e/Dmyr3TawPgwcH8sXThRt0ECg8oQ+0FQYn0PGWZ5
         hQgeR9LIHfzfCBhOLkdczIcPS/8ZwNhTdrwcZmmDR402DzAMcUeXNMtiE2JhqahDs1EF
         XMcDISJiRW9yQu2Sh23uaFIa3GIQROqDONpdr4xQe1gIycA6Jt9UWMJ35hrsANtBvU2M
         JyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DMldFKTo/LehnGAJdUFUpe3sxvN0S6HTNJIEuuDR2hM=;
        b=0lR/fn3mgwxT+GLyofnNwChWpYocfTZUYSwNyeiXZeD4qhtL3K8a7s11SGVGNFM1uS
         WOsXPdHQe9jkGz9E+7PaYyD0oZOKaS2Kfk9ZVlpQb9Lw21KCKrZGim9nlsW3I/zvMO5M
         H+TGf42qjZ5/UoWBicBEXnhQLTIh2khEtt0deNJjzq1FLH3KD5cqsHcLby3rqQS2jDjK
         cYHvBdBZFtEXOhUQ7Ha8D+FVXhMduCRTfT6yrYFJvmtlrOk7588tCDKf7RtkGOClpeLR
         6PEMJLu2rH5lS5kxRV4o2mzuhdYTYXGXGGPVFuLpFJI31O6DiKLC5h9QXhUFG3ioCCdk
         IE3A==
X-Gm-Message-State: AOAM533EFwM3rPYONatu8g+X7g4fT9JMjKcayrbMjz3t8jlctgoKgkAX
        ztDmAx7mJ/+shex5GZ6cVYlBww==
X-Google-Smtp-Source: ABdhPJylqlA1atcbDgKlhUH8JBTUwxb6toR2b2VaOJDSvB2YGm8UfZny+UZj2WxTh9fGgJn7RB3Ynw==
X-Received: by 2002:a5d:8b43:: with SMTP id c3mr20225959iot.30.1632175831206;
        Mon, 20 Sep 2021 15:10:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b12sm7921097ioj.55.2021.09.20.15.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 15:10:30 -0700 (PDT)
Date:   Mon, 20 Sep 2021 18:10:30 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/5] environment.c: remove test-specific
 "ignore_untracked..." variable
Message-ID: <YUkG1u7utvi6+VgS@nand.local>
References: <cover-v2-0.5-00000000000-20210916T182918Z-avarab@gmail.com>
 <cover-v3-0.5-00000000000-20210919T084703Z-avarab@gmail.com>
 <patch-v3-2.5-ece340af764-20210919T084703Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v3-2.5-ece340af764-20210919T084703Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 19, 2021 at 10:47:16AM +0200, Ævar Arnfjörð Bjarmason wrote:
> Instead of the global ignore_untracked_cache_config variable added in
> dae6c322fa1 (test-dump-untracked-cache: don't modify the untracked
> cache, 2016-01-27) we can make use of the new facility to set config
> via environment variables added in d8d77153eaf (config: allow
> specifying config entries via envvar pairs, 2021-01-12).
>
> It's arguably a bit hacky to use setenv() and getenv() to pass
> messages between the same program, but since the test helpers are not
> the main intended audience of repo-settings.c I think it's better than
> hardcoding the test-only special-case in prepare_repo_settings().

Hmm. I tend to agree that using (a wrapper over) setenv() to pass
messages between the test helper and the rest of Git is a little bit of
a hack.

Everything you wrote should work based on my understanding of the
config-over-environment-variable stuff added recently. But I wish that
it didn't involve losing some grep-ability between the test-helper and
library code.

So I wouldn't be sad to see this patch get dropped, and I also wouldn't
be overly sad to see it get picked up, either. But I don't think it's a
necessary step, and we may be slightly better without it.

Thanks,
Taylor
