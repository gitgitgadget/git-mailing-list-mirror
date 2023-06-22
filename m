Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398A4EB64D8
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 12:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjFVMmc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jun 2023 08:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjFVMm3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 08:42:29 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5881F10F6
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 05:42:28 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5707b429540so8979087b3.1
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 05:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687437747; x=1690029747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WX1UP9Y6ft/kwuKxETV7Y1q4Nh2PKt3fvJ64OiofVoo=;
        b=YXIra791w+E/OZin+kvYY0M08vleE2oBfPXCfssj1LwBOJKbC0+I9cSDXnJMr/8djB
         Y8eIUUXi3LLNuOAeGQlHu4sHzfTDQdfL71AgpRLhjhERuLTgO6ZmSYgXL+OyNRz9SFZ0
         CYrFXtPLf7FTUamOds65LtwAWEJo65qjy21/9Ix963AkrS+rkP49KJBBfhQlUCs0cqD7
         yN22TAhJJC3TQ2rLWrnsTeL2RXhU2SfZoS8ZhSmWYZ4qQwsRJHXQ1ECF6BLjt1UQ+Vus
         II3/bPnGuW+Jvz/kFQlX7rU2FXF4dwYfV9gfNRrx7jC1GqQSXy6veLhZMf2+QG3XpUgC
         Fdtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687437747; x=1690029747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WX1UP9Y6ft/kwuKxETV7Y1q4Nh2PKt3fvJ64OiofVoo=;
        b=QcS2oE66IaseKbisUm5Im3Sa6e6zNNrhUma0AjmrW6WDzhzGxfJoJA/W7EAx+vM+c1
         1kGEhxwddjga6s6PUIoeH5F0N8DKJn5C7UDU7gzRv/OXvRVC9L1xZovFm5WI6X1zG9Rl
         DxIMpZ/Vov+9z3yQF1w3dswCS0Vbb6PVCUzII9/aZNckNAJP2wh7Gortrefr+izRPMMI
         d+KlXl610A+08gkLcTtvB3NTvVUXiZdt+mF50F+mty4lymisceqExoKx/Yu4a8Iq1eqE
         BzPyoo4IjdwJITd/iS7rOQew2aAVO1SqFX1TSs0IVVWIUcT9fdOnLRYz7p2dXaajR06f
         xMSQ==
X-Gm-Message-State: AC+VfDwwEVJe8sWWuTYaEZ9YP8mSG8Ti6YYzpleC2FGehQ7PvHQfrFql
        nMpZiAHrOQsSdPmUrYE1POzFjg==
X-Google-Smtp-Source: ACHHUZ4xF3rP4OMJugqaH77v2BOIqI6W7a3B1bgjnRJA38Fy7zy9ohvtfhzBsKAJZZNcdw/GlAJrWw==
X-Received: by 2002:a0d:d6c5:0:b0:56d:2d82:63de with SMTP id y188-20020a0dd6c5000000b0056d2d8263demr27932901ywd.3.1687437747483;
        Thu, 22 Jun 2023 05:42:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u184-20020a0dd2c1000000b0055a21492192sm1798379ywd.115.2023.06.22.05.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 05:42:27 -0700 (PDT)
Date:   Thu, 22 Jun 2023 08:42:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 0/3] revision: refactor ref_excludes to ref_visibility
Message-ID: <ZJRBsDq8NI9EInel@nand.local>
References: <pull.1515.git.git.1687376112.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1515.git.git.1687376112.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2023 at 07:35:09PM +0000, John Cai via GitGitGadget wrote:
> The ref_excludes API is used to tell which refs should be excluded. However,
> there are times when we would want to add refs to explicitly include as
> well. 4fe42f326e (pack-refs: teach pack-refs --include option, 2023-05-12)
> taught pack-refs how to include certain refs, but did it in a more manual
> way by keeping the ref patterns in a separate string list. Instead, we can
> easily extend the ref_excludes API to include refs as well, since this use
> case fits into the API nicely.

After reading this description, I am not sure why you can't "include" a
reference that would otherwise be excluded by passing the rules:

  - refs/heads/exclude/*
  - !refs/heads/exclude/but/include/me

(where the '!' prefix in the last rule is what brings back the included
reference).

But let's read on and see if there is something that I'm missing.

> Refactor the API by renaming it to ref_visibility, and add a ref_visible()
> helper that takes into account ref inclusion.

Hmm. Is this a replacement for ref_is_hidden(), which is already public?

Thanks,
Taylor
