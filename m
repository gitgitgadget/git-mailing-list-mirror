Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAEBC77B7A
	for <git@archiver.kernel.org>; Tue, 16 May 2023 17:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjEPR57 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 13:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjEPR5y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 13:57:54 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952B3A26A
        for <git@vger.kernel.org>; Tue, 16 May 2023 10:57:52 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-559f1819c5dso209985207b3.0
        for <git@vger.kernel.org>; Tue, 16 May 2023 10:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1684259871; x=1686851871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2eU7EyaCPB8qUW6AgeipMpCSz+DcQ30lxKNx18Sl9yg=;
        b=LxPaeufu9BMVdIMizFvok7uWgt72bagNyGrSQPokKKhk/W0PDvqnsiFgPeoOCrZeWb
         sKXjef8LhJfhKAmi4b9yNSn3UKA4mj1ut2azqSO8MmZkIq2jPySPkFnvmpwXBCL/BeG2
         QsQi/5gHQtdfC8+YJ2uE7T0T9A6Yc7sU9gO8zVVvh1SPtugfytoZ6DWtl7xYHdbYvURM
         /FCNVnPfKufHvfWZ8MkgRCoJqx0ABRYLuId54mZ0+mkv9EnSXZ1tWolaAbmHCcswjtE0
         GByXioZRV8YsLxs9xud5YYnhTGXGLqChsEk4M6lbbQwela3nTrHzbTRP+9/M7tIuvlE3
         BEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684259871; x=1686851871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2eU7EyaCPB8qUW6AgeipMpCSz+DcQ30lxKNx18Sl9yg=;
        b=Wl7pi23fh1B3KQOGAOTCaWe1lGucRc7ZMZNvEVSOlNoTKJmYMMELb7pn78mzMKaHHQ
         gNbdCjFyFHbOVyhJ0/2ryE+g6UXch6XZecBkevCtCVJ0UJ7Gaesvioqu+lG4TqMkm5VK
         gncYhF404oo2NyYvHdmiQ/h1pDIws21QoORAJzPD5/R7tiFfGXXpwOm4ZSEn0D4USeDn
         VLs6vgX0vnIP/h8FYjn9s3E49DNBGGALkicywMj/m8hkHrdtUf58vsJqtLJXFbnWRje3
         SgStJx44LI2LDx9/B5jzVXYhG3lsiJeD102xbbKJvyHrQ2dbI5nkF6Enhkj/9HZ5/IpX
         lRWQ==
X-Gm-Message-State: AC+VfDygkiwZf647IDqiTNrOXWvej9iK+PyqvIOwihc0FiWB4jRvEam9
        sfi/yOW/wDiCIrDoU27OcGsKCtaTCpY3rokOXdSyGg==
X-Google-Smtp-Source: ACHHUZ471NSSEeapVoBBiHC5AZyO69b3bifqHC4Y5kgGn/K0QIMK9q4Uh44aYufpNvMUjgY7wrMjOw==
X-Received: by 2002:a0d:eb91:0:b0:561:902c:61d3 with SMTP id u139-20020a0deb91000000b00561902c61d3mr2260296ywe.40.1684259871635;
        Tue, 16 May 2023 10:57:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v132-20020a81618a000000b005619cfb1b88sm37433ywb.52.2023.05.16.10.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 10:57:50 -0700 (PDT)
Date:   Tue, 16 May 2023 13:57:50 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     rsbecker@nexbridge.com, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] run-command.c: need alloc.h for our own at-exit handler
 emulation
Message-ID: <ZGPEHu2pCYfdNI0h@nand.local>
References: <009501d98817$9eb44560$dc1cd020$@nexbridge.com>
 <ZGO4LesPe4A2ftdm@nand.local>
 <xmqqlehourbf.fsf@gitster.g>
 <xmqqh6scur3r.fsf_-_@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh6scur3r.fsf_-_@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2023 at 10:24:24AM -0700, Junio C Hamano wrote:
> Recent header file shuffling missed this old user of ALLOC_GROW()
> that was inside "#ifdef NO_PTHREADS' section and forgot to include
> the new file, alloc.h, that defines the macro.

Heh. I wrote an identical patch before lunch (which I just came back
from). Feel free to queue either, I honestly do not care which as long
as the bug is fixed :-).

  https://lore.kernel.org/git/db403de74da839084165f11dab05d71484457c6f.1684259780.git.me@ttaylorr.com/

Thanks,
Taylor
