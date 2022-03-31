Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C775AC433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 10:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbiCaKgd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 06:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbiCaKgb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 06:36:31 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADEA2042B9
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 03:34:44 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g20so27622124edw.6
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 03:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=N+whGJpLnSxFL5PqY6asjykbjJEZSVczS8vYdEmGDWI=;
        b=VhV0SXtUAsmKL2n2SUwNJQ4m2cHfGuiaKN5787Sc4pqknmnC2ZoMKg2gFGpUr1jkEc
         QTp/BpeGXduDf3X/QWjXwAWEyd9pO17AS+qZbKoaZc827wWNolJo7C/a3g/OFpjd2Wtc
         /ZH5kJnoDcIpkzRRW84xr37cgXVxfS6s/l4jQsS93FP+4uWaSKSAOcCXW688QZsZQqgg
         00c0bfsZhkyluJPYZ5DSiFjKoBDJbCpqoe6pHlOaExR0/elJlS0ygtAEgV3b+XY19pbA
         RjcRWWAvlpc+DREbuFphZAmHkAVPbrwDjDhjzV6QmPszbMkntkHoq/TsQv6KRL14Qij/
         uEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=N+whGJpLnSxFL5PqY6asjykbjJEZSVczS8vYdEmGDWI=;
        b=FnsLlO4rMLedLnJdi91lchJu2u/Zzt/+eA9HBjFeKvRn68S7SSUAtnwTkHcFL7q9xn
         cgR8QbgsfXHmntukPjeSJE/yGB3YW/IAyvb2JF0Ln7LNaHcElsQO2Ow7UgON/QPy2Gee
         ShIjyhHKsoLuYzp3fB2b0agCOD8i4n91GuaqLZZah3OzH8/VCnQwkE8GSdo7c71fWNFS
         0C9/PYmb89w9TX7elUMQXAe+/we0UGt+8gXpw57m6HwpIRU9s9YIT6/P51HIbGMxy/B1
         Wi0PDM/sUY32/iE1BBKevLiNTbt7etyAWwyfpjJjAQgOmi79/5LGEEeCNZ0TrRiPau+S
         yJ5g==
X-Gm-Message-State: AOAM532cLZczxNVL5nvNX4v9yR7MRC9w6tmnky4lpX1/r2QwQQXsgJ4l
        P3qGF9KlAflyeWoCJq61TKw=
X-Google-Smtp-Source: ABdhPJx3u+a2DglFnktYVBBDxfPLIlM8+xYJcf9zjUq+GHJWQFv/RIkpsmj/akN8X8LDj8GySgkZxg==
X-Received: by 2002:a05:6402:3489:b0:419:88f0:4bcd with SMTP id v9-20020a056402348900b0041988f04bcdmr15830588edc.401.1648722883050;
        Thu, 31 Mar 2022 03:34:43 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hs12-20020a1709073e8c00b006dfd8074d27sm9271347ejc.79.2022.03.31.03.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 03:34:42 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nZs8Y-000MUL-4B;
        Thu, 31 Mar 2022 12:34:42 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, derrickstolee@github.com,
        gitster@pobox.com
Subject: Re: [WIP v1 4/4] t7002: add tests for moving out-of-cone
 file/directory
Date:   Thu, 31 Mar 2022 12:33:29 +0200
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220331091755.385961-5-shaoxuan.yuan02@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220331091755.385961-5-shaoxuan.yuan02@gmail.com>
Message-ID: <220331.86ee2iqukd.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 31 2022, Shaoxuan Yuan wrote:

> +	echo "Please use \"git sparse-checkout reapply\" to reapply the sparsity."\
> +	>expect &&

style: space before that \ at the end, but I think it's much better to put this on one line.

This looks at a glance like it's creating an empty file, until you
notice the \ instead of && at the end..

> +	echo "Please use \"git sparse-checkout reapply\" to reapply the sparsity."\
> +	>expect &&

.. so if you want to keep it wrapped we usually tab-indent the +1th line
to make it clear that it's continuing the above command
