Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175DCC43219
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 19:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbiKOTkZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 14:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbiKOTkW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 14:40:22 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FF91134
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 11:40:21 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id h206so11490515iof.10
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 11:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GBCakPgEgdteE08dG2XrTn6zYyPwsJCTkH4Un3zpLyQ=;
        b=G/pQ0UjJKiZaJdNXOak4gT2E58BzWzC2lb/vYTk2PurmJ3pIokTx3UJpCXoCvZC8/M
         5eb4g+FsyD8gxCUHuKE6jI5ltCXO9L16UUBMRrH2NhwCKkYCxw8iWfVjDdF0hUbEzbcz
         PtVrFZGgxyKGr6D5274qOq3lHB79FLnn1KtZt19JUHaUXoA59RMCIzyEDj9MWaLEgozY
         r6gg3bFGkbrBPFmtU4g56/trJcU+IKd2NZWVkCtXwKvsbS1e5LRMYSiFAsuAS5mYyS6d
         VRhFRbd7kj3SMa9e0zBU82LcehDqHcucnqIBPiLZSHNF883CUK6VSYm0f0CrxhB2G7wm
         llDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBCakPgEgdteE08dG2XrTn6zYyPwsJCTkH4Un3zpLyQ=;
        b=gNms7YmNEvE3uo/b+vJi+TYFXlpoSWR6hjXvKoyRkDQ5lxZMEIu90CBjKfoMiR2IkB
         m7u6SfT1H4GyY5jTT4QMkuGmyH+WR4GEgj8DCyylWAJPKD6ndq/fgW2xUsd9RnYNAjqe
         ko+0GiXo+8wBonAoXZtESIu4zcej6RPeYd5cSH0jS3WssBzZ0nbmynh2VKkON6E7w2gC
         ed2LwUkloLryZvniHoTa6u+wN/M4ZXaeK3Sap1a3Wzyd7Rr07k99hY3EWml4I+tXfBda
         SIySv74MWvDn04c6E6Gz8/em/nUNBcb4O6mF7jn1Nu+Q6dCsiLJ29FnG38NZLTtJngfV
         +cfQ==
X-Gm-Message-State: ANoB5pl4WVqxp1LqUk08OlHKxcdAf9l57IXI9vpwGGu4xRzCRUGmu7Gr
        +kHehpPU3VpnkE2suuY6cyfjUg==
X-Google-Smtp-Source: AA0mqf7Y8gJb5gjR66QS44jPEbkW+6Jty20mqGoLpRKbJqJdUqgBfOYl9D7p665V3/ocT6bQyO5/7A==
X-Received: by 2002:a6b:c88f:0:b0:6bb:e329:fcd7 with SMTP id y137-20020a6bc88f000000b006bbe329fcd7mr8355078iof.206.1668541220706;
        Tue, 15 Nov 2022 11:40:20 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v18-20020a92c812000000b002eb5eb4f8f9sm5328588iln.77.2022.11.15.11.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 11:40:20 -0800 (PST)
Date:   Tue, 15 Nov 2022 14:40:18 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Christian Couder <chriscool@tuxfamily.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 00/11] Turn git-bisect to be builtin
Message-ID: <Y3PrIgynUYFtrqnB@nand.local>
References: <cover.1668097286.git.congdanhqx@gmail.com>
 <cover.1668097962.git.congdanhqx@gmail.com>
 <Y27Hrkruh6++7NkO@nand.local>
 <Y3PmAP24GPAhXPOm@nand.local>
 <Y3PqLMzC8DBPjp10@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3PqLMzC8DBPjp10@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2022 at 02:36:12PM -0500, Jeff King wrote:
> On Tue, Nov 15, 2022 at 02:18:24PM -0500, Taylor Blau wrote:
>
> > Hmm. Looks like there is a small breakage in the last commit "Turn `git
> > bisect` into a full built-in":
> >
> >     $ make check-builtins
> >     ./check-builtins.sh
> >     bisect is builtin but git-bisect.sh still exists
> >     make: *** [Makefile:3561: check-builtins] Error 1
> >
> > Seeing that this is on 'next', it would be nice to see a fix in the near
> > future, certainly before we graduate this down to 'master'. Am I correct
> > in assuming that there is no reason to keep git-bisect.sh around after
> > that commit?
>
> Yeah, see:
>
>   https://lore.kernel.org/git/patch-1.1-7be23b6faa0-20221115T093130Z-avarab@gmail.com/

Ack, thanks.

Thanks,
Taylor
