Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3051BC433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 22:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbiEXWZa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 18:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiEXWZ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 18:25:27 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA625A16F
        for <git@vger.kernel.org>; Tue, 24 May 2022 15:25:25 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id p12-20020a9d4e0c000000b00606b40860a3so13191645otf.11
        for <git@vger.kernel.org>; Tue, 24 May 2022 15:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r9Geg8k1zDGVKhLVp1s5jFDIxfGUN6Y8Rcp4jPji0j8=;
        b=s1PyYKnXwINA3Qe8HkkKbifBausfNf2nLIEWZtNhqTqbtBFcsAbRcNiq22EzdgEDY4
         YhXzNtQGo9RI9sFkelISNiolSkjVAtvhFg5bPGTfjMBAg7oS4XTIXR2tIK7Cf87jnzZM
         plitaeNKGHWrZO3sZGG91pPGzaN0rKHEOYzHIpQdG7R7TjlGPQZyxHXvfnkE8HKfObz0
         P5BJoZ+nWQ72pFPvgz+5PvlvsMTGwPXpr3J6JHwEDSaFS2L33TquUmxY54Vozgba82FZ
         yLIFsmnFfOS11D51W7jqqX6LS4g75zPnEV2ntE1c/Ben7tgPjUqYKYfI+02CmGtKAcGh
         8eEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r9Geg8k1zDGVKhLVp1s5jFDIxfGUN6Y8Rcp4jPji0j8=;
        b=0GtRVyIUE2GoSQ1H4lvoVVVtosU+ng+BK8lgdHwnXAO8VLIbggfjz8Q682W/DCUCqr
         d1QwSXMLpvS+tH0Y7GtxEcrbFkfgEKVPNpLgl+GptTL04vzFLY8afel8zPwt/d2JBETi
         Ag6LA/GHvawGcxY6IVsrpMohvhLA0gBY6x9Ld0mwLGEMfwIqWUk7Uolq6gwYKyntBUcD
         yjR3WyLh7M5sgJoyjgettmg+ccU7XUCUbM7D99oXN6bEqx5V0PyAn+gw9u+XOhPA322q
         RYXaK2fRnx2Fxdx5Y4gBNugl6FofjtbB6Ewh70T21e0WFUcUEiUMYajfqqc+HziRjoVf
         PT8w==
X-Gm-Message-State: AOAM530uY2PZ/dCpcaCK/72V0mklizAV8v0RYQjRdTv0CQYPyXVzo1iO
        Jb8tHzOEsC3XUtPFDlzh9j5G62ncAGwcZg==
X-Google-Smtp-Source: ABdhPJxJtbuK187xfTEbJ7LCQ1KB4SunnKDqNrHuoRZUxf/CJnWbq0FpNu0Cd+AaDGbxhTa6fzjkRA==
X-Received: by 2002:a9d:7501:0:b0:60b:169c:a174 with SMTP id r1-20020a9d7501000000b0060b169ca174mr4604660otk.271.1653431123536;
        Tue, 24 May 2022 15:25:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o9-20020a4ad149000000b0035eb4e5a6b2sm5851857oor.8.2022.05.24.15.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 15:25:23 -0700 (PDT)
Date:   Tue, 24 May 2022 18:25:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     rsbecker@nexbridge.com
Cc:     'Jonathan Nieder' <jrnieder@gmail.com>,
        'Taylor Blau' <me@ttaylorr.com>, git@vger.kernel.org,
        avarab@gmail.com, derrickstolee@github.com, gitster@pobox.com,
        larsxschneider@gmail.com, tytso@mit.edu
Subject: Re: [PATCH v5 02/17] pack-mtimes: support reading .mtimes files
Message-ID: <Yo1bUbys+Fz7g+6h@nand.local>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1653088640.git.me@ttaylorr.com>
 <91a9d21b0b7d99023083c0bbb6f91ccdc1782736.1653088640.git.me@ttaylorr.com>
 <Yo0ysWZKFJoiCSqv@google.com>
 <015d01d86fa6$a10519f0$e30f4dd0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <015d01d86fa6$a10519f0$e30f4dd0$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 24, 2022 at 03:44:00PM -0400, rsbecker@nexbridge.com wrote:
> I am again concerned about 32-bit time_t assumptions. time_t is 32-bit on
> some platforms, signed/unsigned, and sometimes 64-bit. We are talking about
> potentially long-persistent files, as I understand this series, so we should
> not be limiting times to end at 2038. That's only 16 years off and I would
> wager that many clones that exist today will exist then.

Note that we're using unsigned fields here, so we have until 2106 (see
my earlier response on this in
https://lore.kernel.org/git/YdiXecK6fAKl8++G@nand.local/).

Thanks,
Taylor
