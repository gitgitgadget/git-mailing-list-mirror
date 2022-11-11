Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A78C4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 22:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbiKKWTG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 17:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbiKKWSu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 17:18:50 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E624D70
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 14:18:25 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id p184so4524754iof.11
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 14:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qwt4P4necDFyg57e4IBOsPknZqB/tLTlUgnqhAo/9HI=;
        b=e5LDhxIVSSZXxNMqfuivXnCqz1b+87A27s1fFcTfR0jZEWu6MxF5ny0a7uXIKrdKjk
         4pHJ1XRfgCEeq76fOZAB3Sm31KKGD0wvB6vl5Q1D3BgVhN0uFqhGBcfAbjyyF590b59g
         YkoVVDIEiFAZyt1ScM5o3VF8ZC9hgFEPZa2GUjg94a0u7yze0APDW2KkKJkT1yC/dMg5
         ESQMLBYfyd5tQLL4uAJDklbIZAqF1O/uB4zqjnp6qHTE1wPW4XomfFVKfM1jJSjCXRII
         axfOLYIgAJBLUx4wfmepoI/xvWAnY/7ZCl+/weBDkPQd1b2Yq+Tqa41TLJ1T5Ofa5NJL
         7z/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwt4P4necDFyg57e4IBOsPknZqB/tLTlUgnqhAo/9HI=;
        b=IUhKm2P5VgMpxqdaxkwFba5CkLRAoJ67zG02MXCA/5gZIXL7Owae/5yyNAP8WLNqNk
         LI70zfwNhPvlJAkZVsf5htX5OOfMDiqq/OJMjZNAmXANw8Ft3Uva4otbGuynmcx4DVtM
         h0mUd4zkTI96J+sMgTfWOoUGtM5NFwiA3uOrX7EPqvpKYdRqUF9rGU/0yWej7tdBYxLx
         xqnz9BWhHfuOOt7jEb/T/WtEgQ0sWJAHfPgdY68p373UeHm5TY+R6ggLi74H4Gb9aEZl
         hybJxn8ieHxGOVx6MKtjeKkb8IAMbjLy2wMPVurUdbHTl5JxKKB/Zw8VogJSYGFmJiIa
         Wmfw==
X-Gm-Message-State: ANoB5pnkVSRf8qoYPfqE1rLtFp2vBZPwpURc8GEPXL89wIqcFzDs4sQ0
        DB7tVobJehGhdF1cUt4bnzvLZw==
X-Google-Smtp-Source: AA0mqf57RhQFe5h0wZGIVVjdpNUOEJMDH8VHjctmmg+KK1adB2olTJxSdJUPTZmhxCXAshdhFFfUlg==
X-Received: by 2002:a02:5483:0:b0:369:c51c:991c with SMTP id t125-20020a025483000000b00369c51c991cmr1685938jaa.139.1668205104634;
        Fri, 11 Nov 2022 14:18:24 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h10-20020a02c72a000000b0036332a07adcsm1166763jao.173.2022.11.11.14.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 14:18:24 -0800 (PST)
Date:   Fri, 11 Nov 2022 17:18:23 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 0/7] receive-pack: only use visible refs for
 connectivity check
Message-ID: <Y27KL0Yg7nzdQ+HC@nand.local>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1668149149.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1668149149.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 11, 2022 at 07:49:49AM +0100, Patrick Steinhardt wrote:
> Patrick Steinhardt (7):
>   refs: fix memory leak when parsing hideRefs config
>   refs: get rid of global list of hidden refs
>   revision: move together exclusion-related functions
>   revision: introduce struct to handle exclusions
>   revision: add new parameter to exclude hidden refs
>   rev-parse: add `--exclude-hidden=` option
>   receive-pack: only use visible refs for connectivity check

The new version is looking pretty good to my eyes, though I would like
to hear from Peff, too, since he caught a few things that I missed in
the previous rounds.

I have to say, the final patch is *really* nice ;-).

Thanks,
Taylor
