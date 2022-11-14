Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17324C4332F
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 21:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237514AbiKNV7x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 16:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237333AbiKNV7v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 16:59:51 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B271A19C37
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 13:59:50 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id bp12so6463742ilb.9
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 13:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zHy4TAybA+5VzvaZGTCbhaNkrm4GD4xyT4XCSA9iL6M=;
        b=QTNoR7kClqMPeQGLf4bkXDuvuSi7du2ThI5jZ7CcUU5iwK1twrUnSWlc2SsvuzSfSk
         W19nZfDa/GyzPGB6whAhRbf/7u5SkotEvjoI93o3YEmjnvh1/mnCc+3gU3EucqLbfzai
         cJpeAhal9dMxHz1kcrHfSQZzBAxdyqaH7VijpoI/AYi5tufYsmHS8yajiQf+htQ4L6+Y
         NaiEl+mixX8r00hTRLh7r1ElMLj4myNyJcn/jQFwMMgMElPDYSSKWJuvxhenl5BGRg18
         +ZsqbH+170cEyEjUlUOp3AUbKT1oGOxNTTMpvS1UMTXIc8bcwEXBUqIx3I4K2+omImjq
         Rt1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zHy4TAybA+5VzvaZGTCbhaNkrm4GD4xyT4XCSA9iL6M=;
        b=r7eF9NbCfN5P0eQoFr2cTBL4BJj4AUf/UTTH2SS2kWRkhcar3pkn2I3unPoBaD9aPM
         HLwsAEbh4Ey3HE1ZD2S9QqhN64ejZ/EhWu5cwFAksEIj+yAYBJriJUmLNt1orC5gGCX8
         XQOgVff3EV0t9ZLE+qcbQTsY902ffi035quwpr93mUQAkhhVlCMsKI6dEw6HWayxPXBo
         imdE4vlUGKqtB8EP8XukHpE1o+4tXyXTF7JzCwJeowAl2oFB9QhswFg8L/OV7//9iKUk
         X1SuVXc16GvC5FQGM+fX9pmyt/QUNTUPY9Kk7XurEKPhRBFYXxoj/uM0iMqGDc83iU/Z
         smqg==
X-Gm-Message-State: ANoB5pllb3zclV0wFTZFFbkbxDT/9WWwPYilR4N5CSLRmEwEYI6nPufO
        wLp8rVnUy+smu6G0bW2FOBV/fQ==
X-Google-Smtp-Source: AA0mqf7f7E32aEtkFr5MfG6UEl1oLGQqKh7W5Koo4sTxEjNsdPgj42wh1LhBkk9Dfm7ddK8nIVRz1g==
X-Received: by 2002:a92:d6c5:0:b0:302:58d0:2510 with SMTP id z5-20020a92d6c5000000b0030258d02510mr3376349ilp.27.1668463189752;
        Mon, 14 Nov 2022 13:59:49 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w3-20020a022a03000000b00363bd76184esm2302093jaw.162.2022.11.14.13.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 13:59:49 -0800 (PST)
Date:   Mon, 14 Nov 2022 16:59:48 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Taylor Blau <me@ttaylorr.com>, Robert Coup <robert@coup.net.nz>
Subject: Re: [PATCH v2 00/10] Get rid of "git --super-prefix"
Message-ID: <Y3K6VM4Ciwv7ytcw@nand.local>
References: <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
 <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 14, 2022 at 11:08:40AM +0100, Ævar Arnfjörð Bjarmason wrote:
> = Relation to other submissions
>
> This is a non-RFC version of my earlier RFC to get rid of
> "--super-prefix"[1], which itself was an alternate proposal to Glen's
> [2]. Per [3] he's agreed to go with this approach.

Thanks for working it out together, and for a clear summary of how this
series interacts with and depends on others in-flight.

Thanks,
Taylor
