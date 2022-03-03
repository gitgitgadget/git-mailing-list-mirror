Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5279C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 19:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235269AbiCCT7R (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 14:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbiCCT7R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 14:59:17 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86954D048C
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 11:58:29 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id c23so7146061ioi.4
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 11:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+0i7DGc4zPT8xutA5bmsuu9cyK30v1FuHrcko0iPU7Y=;
        b=0IP4FnF09qTL5VfocYrn1K9pNe5qZCEaCBBxTxXBU28UprYnoXwrruXC7zuCA7WbA9
         VAAjJWl7lFqlFdEgyIkPoOwnaEU1456t1+103Mnsv+VcerC85lT30+vWTLKgFDK9x/IR
         92lP62nrKtWOj1x0R5Bgg43cJe72hh6ZhXqtbJmC2+k75q0LpKXb7QYdmHlJU/GeIAk6
         ndZtSlp4qArIPUrNbBOt/YNoJ8+TN6MomsZdxM+bYPkyPqPAxzSmMvtMmzI4S1Id8eHD
         nctOaoyP1DphTEypVnRx0xBRAf0+wkKMhYl+72HKRwDzvT4eD/uIt/p1FYDT8USOXi96
         z+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+0i7DGc4zPT8xutA5bmsuu9cyK30v1FuHrcko0iPU7Y=;
        b=nJqJ+ZW9AqlAmVXhlqNmnbAZnFanYoN5hjd5oFAymxxGtJdHw5i7pJC2lpP4rQfsnV
         cn08roF96gfDpUYqKiqeqd+s14YL4xQSBB42zSIt2mpCtCvpsQEgH/WrosnXIHduQrF5
         d9KC4kk2uJ3wED+bKW3N1KDShIKefrQvWFZBSb72S5kJmfBc77KE5JjDrAbTNwF5drsh
         FmcG+75chG+JfQfX/RIF7CCqbbfZbpg40jyalekrg3c+J76eZs9PH7lBCxjhtRiP6i90
         5Eg+MrWqC2lGn0I38TXOdRdbNUiYoW3TEGrf57E+m+HrMa40nAh0O6v4/7QWpr6afn7Q
         VDMA==
X-Gm-Message-State: AOAM531OyX6aTMvGl7lKWstc8MyFwKzLQcgxBEUPN/JV3qApWcgTHK3g
        nETcXhe+6AePbNwtjfS1Xwcu1g==
X-Google-Smtp-Source: ABdhPJyiI18dYOau8dFmHK4H1CizmE8IpgcZWCK9+esMQ7cGVuOXZj+1OcEjwRC3iQG+xSzUU050Pg==
X-Received: by 2002:a05:6602:2e11:b0:644:e203:c7fd with SMTP id o17-20020a0566022e1100b00644e203c7fdmr17266318iow.141.1646337508968;
        Thu, 03 Mar 2022 11:58:28 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g8-20020a056602248800b006409fb2cbccsm2645426ioe.32.2022.03.03.11.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 11:58:28 -0800 (PST)
Date:   Thu, 3 Mar 2022 14:58:27 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, gitster@pobox.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] builtin/remote.c: show progress when renaming remote
 references
Message-ID: <YiEd4zs9KhjhH9fp@nand.local>
References: <70a0325ca8ab0492a9b0873ee3fba576c5ab90b9.1646173186.git.me@ttaylorr.com>
 <Yh/t3HfKiEMx957i@camp.crustytoothpaste.net>
 <Yh/2Pkc493ABWv46@nand.local>
 <95207e46-defb-f36e-ea3c-a2454c15bd8e@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95207e46-defb-f36e-ea3c-a2454c15bd8e@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 03, 2022 at 11:09:20AM -0500, Derrick Stolee wrote:
> I guess one big reason for Ævar's suggestion about using --[no-]progress
> as the signal for progress is that we can make --progress the default
> when isatty(2) is true. We should not do the same for --verbose.

Yep, agreed.

> Looking at other examples, I see that 'fsck' has --verbose imply
> --no-progress, probably because the verbose output would write lines
> that become interleaved with the progress indicators (and those lines
> act as progress in themselves). Not sure if that's the right choice in
> this case, too.

I think for `git remote rename` it won't matter, since it doesn't do
anything with the `-v` option anyway (so there's no output to clobber in
the first place).

Thanks,
Taylor
