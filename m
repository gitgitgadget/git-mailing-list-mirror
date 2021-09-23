Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED0AC433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 17:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1289A610C9
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 17:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242612AbhIWRkN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 13:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242402AbhIWRkK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 13:40:10 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00892C061574
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 10:38:35 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id e82so8996881iof.5
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 10:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=S9e7vnGHtY3q+Gbrn9GPC7NmxFGe3Q4bvUzRYZAlJtQ=;
        b=dYF7hzDS4eD5YDEtgQhE//YemcFB4fU0zwtYOJeDKUjRFMTIGQHdLn4jguzKiSSUTG
         2WJxju+VWwqQUEOcwU3thDH4EPw6iZVGq9jun/ScrKdL8shT4k5HHDOnxLHJokoSCJJ+
         kw2p8xfB97SDFq/B5dB2E8tvSUuaJlCtqXEY58pY5qRsmQO4Z7/Xahjz8B6L3gYp8nue
         g1VZ7Hsgv6CVLNFGXJ33QY8N7fHXuHHq/B1vW2Zw3kJpaAMPEmqMdJ1WUo+VSlMuIZBh
         UbaBUUEw0DTEGjubHEYX/PUNqzRQ0NZh2EJVhZIwlzwRThklHkW/PkmJMBju69JfM9j2
         Ayng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=S9e7vnGHtY3q+Gbrn9GPC7NmxFGe3Q4bvUzRYZAlJtQ=;
        b=uPmI1SwZMduSzMofrHgfejgjFIbnBw5MgQRjQru/QnLOPPxWYFF5V5RBTjKq2v8ccw
         sPqAaDkWjmUNm1cuQ/5hFUZni9AaRI5H3fW8zErfo2dQgnTdTskG7lqyYbFSIKfKfWxN
         t9ptJIWPbmYmlvHRBPpVNHwkdBpFXZ57zpsw0muEZ+lz2meBsMVVMsNV31w+3HBQZEXx
         EeElVLyLmhwZ4iOpgqzcAvn16Z4ETZ5BX1shaW0LsXGr0UenTOCy3B02AS2ydEnjThar
         3ffVF69ReLLOO8snAiTQaFivgLxA7sCrPDkXMi9jSS9k/f8FcWH8uyWUgnJ5EZhKAvzV
         FJng==
X-Gm-Message-State: AOAM53026o5MBiBjZD9gOzMWJ/tAdhhAIW1xEV99/tELZnPML/vDFaM9
        4xunOvki9+mUwIxSKBHTMckIEg==
X-Google-Smtp-Source: ABdhPJwuZjxBMiQ8PvFlhGRpB0l08rAItyIobbDJv+3Lh/9B+Jz3zA0e6Y0SztuWlnjuZmmEXPrGow==
X-Received: by 2002:a05:6602:214f:: with SMTP id y15mr5125187ioy.127.1632418715390;
        Thu, 23 Sep 2021 10:38:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v8sm2796163ilg.25.2021.09.23.10.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 10:38:34 -0700 (PDT)
Date:   Thu, 23 Sep 2021 13:38:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        "Robin H . Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH] bundle: remove ignored & undocumented "--verbose" flag
Message-ID: <YUy7mkaRCLKrMJBw@nand.local>
References: <patch-1.1-d61f4b28dfd-20210923T164636Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-d61f4b28dfd-20210923T164636Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 23, 2021 at 06:48:22PM +0200, Ævar Arnfjörð Bjarmason wrote:
> In 73c3253d75e (bundle: framework for options before bundle file,
> 2019-11-10) the "git bundle" command was refactored to use
> parse_options(). In that refactoring it started understanding the
> "--verbose" flag before the subcommand, e.g.:
>
>     git bundle --verbose verify --quiet
>
> However, nothing ever did anything with this "verbose" variable, and
> the change wasn't documented. It appears to have been something that
> escaped the lab, and wasn't flagged by reviewers at the time. Let's
> just remove it.

Thanks; this looks good to me. We never use the `verbose` variable for
anything, and it isn't documented. So I agree that it can be removed.

Thanks for cleaning this up:

    Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
