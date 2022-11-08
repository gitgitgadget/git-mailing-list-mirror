Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA5EC433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 21:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiKHVsa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 16:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiKHVs3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 16:48:29 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B63205EC
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 13:48:26 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id d123so12557515iof.7
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 13:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n5HLTdef3h1zGNrm1tW4eS7E0hWe1GLAmU3NKljxXzw=;
        b=Wa4ts5cZCCMwowCsC2vpeKjm/Atm68IJ+PMeedocTYholaobc3+5Iey1fDxzG2lya1
         BZFcMvEQNZYceW/SaaOBesjihgrbJnSV6GEeq4ICbJY6HVYTthrS48wqria1C/6p8ZzL
         TcGgaIOCzTi/HG9TfWG6ogGjsgjP6ah6L6o2xbpXSVbFMdxdf8SV6ryHI4qGY7bNFFam
         yiE6j/Rgbmx+o5RloNhTYBoVYrluSE4CpYp6fPuCubjoi91iw0l1wN5wuoKuBNM6Pia+
         OAHahzrUT7Bg16zUNPfBlexZu9/u1fovvsIYeqZIsfOF8FGUWytu1kbLUWpWgwVecCvg
         rEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5HLTdef3h1zGNrm1tW4eS7E0hWe1GLAmU3NKljxXzw=;
        b=15ozlyPIrYcLhTA5jYn4l1SElhNwn3FVWYIADBHj8/0hpYBi4EbF1amRpjRSIM+SCD
         wgOcPjeQY744FVAMiUsvsTYSbZad9+20NLYwSD0gJxL8VAPSgjlLCt84j8qXLcaQ6Yez
         AEPei5XSBi8Lu8a2IMXF1cb9YIx8Q4nCuVfdcTbg2VPDIwuTtP5LDDzjb4XWy1eXpyaJ
         t47q5q9+VENuQheQwpT5zkwFDcwck60nSMUZ2G5zJeKDK5n1rzd9G3QtlHGrLpIBjKwF
         S4d+f8g0XnkqT3H4Lxm/4qkqXBOMR9HBId9A7p3sQ3GVUnGZ9EGSJ2Hh3GERqGtCZzIP
         srzQ==
X-Gm-Message-State: ACrzQf2xjMRptl1yHtviy8fqyC8RP8EwLltcKiYKyVynCUjtTAykBy8F
        /B47pws+nalE2OAI61m/xFnB7w==
X-Google-Smtp-Source: AMsMyM6vxas3xAVJjzZxL7WUsnCrA5Qv07ihuk/fluFcVgEElQfMVu6GEBtBWhJ45B0UuMEZo8k5YA==
X-Received: by 2002:a05:6602:2d04:b0:6d5:e06a:30e4 with SMTP id c4-20020a0566022d0400b006d5e06a30e4mr18415766iow.189.1667944106147;
        Tue, 08 Nov 2022 13:48:26 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id cl15-20020a0566383d0f00b00363da904602sm4170948jab.13.2022.11.08.13.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 13:48:25 -0800 (PST)
Date:   Tue, 8 Nov 2022 16:48:24 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>,
        M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH v3] Mention that password could be a personal access
 token.
Message-ID: <Y2rOqP9CxKqlo0dB@nand.local>
References: <pull.1396.v2.git.1667385022103.gitgitgadget@gmail.com>
 <pull.1396.v3.git.1667912487608.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1396.v3.git.1667912487608.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 08, 2022 at 01:01:27PM +0000, M Hickford via GitGitGadget wrote:
> From: M Hickford <mirth.hickford@gmail.com>
>
> Git asks for a "password", but the user might use a
> personal access token or OAuth access token instead.

Looks good to me. The only minor issue I noticed was that the commit
message should have been prefixed with an area but wasn't.

I changed it to the following when queueing:

    Documentation/gitcredentials.txt: mention password alternatives

Thank you for your work. Let's start merging this one down.

Thanks,
Taylor
