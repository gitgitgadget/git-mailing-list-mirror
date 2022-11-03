Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355A0C433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 01:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiKCBbT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 21:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKCBbR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 21:31:17 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7576313D02
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 18:31:17 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id d123so248721iof.7
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 18:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qERhpbtL5thBTtVu/ou3DlGIZ18YFEJ6dCe/Cta65JM=;
        b=POQWS1yT4mUR7TOzg3kPnwhC/MZKJtH+F9S/nu5ZIRPz4aKricS04xQzuvehVexlfQ
         0edMAT7I7PF60yaat2trDaS3unWKsmecs7cMw9v5Jo/Sb1sogtgiBOGvje2d8S5VRX8d
         gX1kRspseWRhtGUGpuKHja/aCXV/KPygqgkW0xbnKJ2me2QD/BOcbHslx3pn7Ec7b7wT
         NBh/tWz/dmC5rS89kd5GAgkW2HfsbfMSkBoD7wz9T+RT209Z/VHBAe+UfjL2ctHPoGNs
         j3J1Da8ka5X1Ba3IwJi0t5twHlUoC9aB0vR4EmyUpCwLfnl71jQlCZECJMID/NxWHeO5
         fiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qERhpbtL5thBTtVu/ou3DlGIZ18YFEJ6dCe/Cta65JM=;
        b=Zf3tfELlCVC7gw+7AjNcbQOGp3FoXEY0aYelAFvN0CtSBMl4Seq+SqP5p4BTJedcBJ
         bwV0G30y8xBlH7oH7Hfr11/lA6APo1rBqcQtaCVC2fFz2lkStd8YQO8p0RcfFG+v6MRW
         90o9gKr/6vIlQxsDjXevqw4SP0JmDUHcHbh9tQpm5xHakqkaRxBthlJKPbsYBzUBjxHf
         oY8Xr9HXxSKlrKO4Tq7Pk5FBpRy7ZqTSHn62EThHs6bx+PzTXSmNvy7TaZev1RjCSRcE
         ZOldIxGAWrwpwJxuv+FoArFdehdtmMu7O2CzO/qrDzP7ueDvx+pPam15cdoFUVIXZ0GD
         aD+A==
X-Gm-Message-State: ACrzQf2qUW6djyPYBAYxTGGXUPB5s5JOtkY9alsoBHSzLpaSpKbfzXgP
        R8yv+ICTbBNQYB0pkRiHosot5hqQ8z9E9Tkn
X-Google-Smtp-Source: AMsMyM67OxgAEtZE+ObrX/4/OIDZLo/IZBoTWVfXsj0c1q6FXIsLOHJVuYOuVNcqMW80GUzO/p1xRw==
X-Received: by 2002:a02:cc88:0:b0:375:3f45:33ae with SMTP id s8-20020a02cc88000000b003753f4533aemr16863118jap.171.1667439076826;
        Wed, 02 Nov 2022 18:31:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f19-20020a02a113000000b003754033c6aesm5260041jag.155.2022.11.02.18.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 18:31:16 -0700 (PDT)
Date:   Wed, 2 Nov 2022 21:31:15 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 2/2] t5551: be less strict about the number of
 credential warnings
Message-ID: <Y2MZ46aE/P7jpabG@nand.local>
References: <pull.1399.git.1667245638.gitgitgadget@gmail.com>
 <RFC-patch-1.1-0266485bc6c-20221031T204149Z-avarab@gmail.com>
 <Y2CFRJLFRXvGwFBC@coredump.intra.peff.net>
 <221101.86a65b5q9q.gmgdl@evledraar.gmail.com>
 <Y2GHjnuyuwGpY3II@nand.local>
 <Y2ItZWx+kBmTreGQ@coredump.intra.peff.net>
 <Y2I15UY/a7OAZUtm@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2I15UY/a7OAZUtm@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 02, 2022 at 05:18:29AM -0400, Jeff King wrote:
> On Wed, Nov 02, 2022 at 04:42:13AM -0400, Jeff King wrote:
>
> > As I said, I had tried to mostly leave patch 2 alone to avoid derailing
> > Dscho's attempt to fix things. But somehow things got derailed anyway,
> > so maybe we can just all agree on this patch and move on with our lives?
>
> By the way, I think you (or somebody?) mentioned elsewhere in the thread
> that it's possible the first patch fixes things by itself. I would also
> be content to just apply the first one and see if CI improves.
>
> Of course, when I just pushed all this out to CI, it flaked
> independently on both osx (looks like racy p4 stuff) and fedora (network
> dropout failed to set up the container). Sigh.

Dreams are free, eh?

Thanks,
Taylor
