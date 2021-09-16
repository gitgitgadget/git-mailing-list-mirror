Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B13C433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 18:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48C9061139
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 18:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346887AbhIPShP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 14:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346002AbhIPSg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 14:36:59 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B3FC051776
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 09:53:44 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id v16so7316363ilg.3
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 09:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kr/tNQ2SS/vjII1xR3uBYrLsAGdrKKKfJWvk6X1nms8=;
        b=F7oVfBAFNbiRHE/5PCn9629KQ5SVFgtytEPI15E4jnM9ZiT9vJY9V7lO7P1uD8M4/Y
         gPpQVo1RcfzbC3WI49IR060jv1BXJagZePUqJK7vxyx0Uf441NMVFT4C1zJpYJhBFc0E
         a5SO9CsRqco4K9N6NvXXuQeMPtcduPYSJM0zCknT2Esed5Mo2EeO9DAoqVOXwjme3FCa
         pJFruqD9UkaQwUUoZvsuojVRrlnLeAfNA8rjVU38CslKA1BdVESD4pADx1WLtwooMYUF
         YhiCki3Y4I92c4xxw90ozfD6TeWgHlx+RVCitsmCpLohfF+26DDn12Zr5MlVrNSxherA
         uH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kr/tNQ2SS/vjII1xR3uBYrLsAGdrKKKfJWvk6X1nms8=;
        b=K24uBmZMWhptfrgmTDZigsrskWpYnCgBMVDFoZxSleTXBSmTnp0gghYTeG8ATDg8lM
         ZGbgwpOlpvsZqfZ6Qa6cP51Mz3vaox/9cwD2bAigDzHJAne9Y9WFcmqsl5oUHRf4I47A
         OX/1SOUIoNKBEtVBaFuNzdFl7FVcocldC63k/rILecovrLODGTiX0eg3lHBjlRGAdwem
         GE0x8wPzhPIkVpdDWYBC6442HsSB7JAPh+R8a2yzrYqtDl2kWnjGNwDH2dlQgaHCNicM
         9a8jULkT24wZBu5tg5gXsOSs1e7xtEXF9kRVwcNuQ8aVTWZYUH5lTz8/trGJVY4xc3bB
         526w==
X-Gm-Message-State: AOAM533DvViCYPgxaOsLVo+GZPU+9xI7shekI5+EmjWKAyzTEbWUyuhQ
        nNcln3SXC4M1mTEBP/NvqNs7UFlNYU9pKEyW
X-Google-Smtp-Source: ABdhPJykvH1a68iZkzVjFvfLq4cEWnFANjF4anrGgEvacR98JeNM+dqAZvYFSGPzt5obFOfwvB0OJg==
X-Received: by 2002:a05:6e02:1c81:: with SMTP id w1mr4627993ill.112.1631811224265;
        Thu, 16 Sep 2021 09:53:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s5sm1959323iol.33.2021.09.16.09.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 09:53:44 -0700 (PDT)
Date:   Thu, 16 Sep 2021 12:53:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 0/2] reroll for cb/plug-leaks-in-alloca-emu-users
Message-ID: <YUN2lwA3w8zAoYhS@nand.local>
References: <20210916023706.55760-1-carenas@gmail.com>
 <20210916085523.68581-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210916085523.68581-1-carenas@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 16, 2021 at 01:55:21AM -0700, Carlo Marcelo Arenas Belón wrote:
> v2 includes all suggestions and feedback, and tries probably too hard
> to modify the last test in a way that wouldn't require long lines.

Thanks, this version looks good to me. I suspect the "tries probably too
hard" is referring to putting the sed expressions into a file and then
loading them from that file with `-f`.

I wouldn't mind the long line, or splitting it across multiple lines
with `\`. But what you wrote is fine, too.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor

BTW: no need to put "reroll for" in the subject line for this series.
The [PATCH v2] indicates that it is a reroll.
