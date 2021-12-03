Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE816C433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 14:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381300AbhLCODc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 09:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352843AbhLCODc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 09:03:32 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0941CC06173E
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 06:00:08 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id e3so11992683edu.4
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 06:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=V/WYWkGLoHZGhnZB5TNbdM66QZgzBzej/Rja8oVTdxg=;
        b=O3ABhe3Fj91l5FvxotrHb6vxLAFzHpWR9Zzufexlvgbx9p9OUjHq5YR4bwz4E4nanS
         QepXtkGHW/X0pfcXvUAkDhMduyGxSUGkYN69otK/nvxSQCDf8MrH76F6fmf8kFq5v920
         wYEzmzKbY/Mq8CI4TDv/J5333pb8KtlVe+qTGJz4ZJSQBfkrFvG3iU9w2uOZwLGCS6M6
         UfBZHHuoAurgLWAU2MKEhH4iKgbI7XA5E6nKY2Nuh1cJXihmKg1UNqM/LkW9vzZpk9TC
         9sQF1+7d9WIQM7lyMMEsUPOb1g/dHWlgMXpbN7ol2t/WYpXJngeXFzuVbwSjhCTTRGYu
         Ciuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=V/WYWkGLoHZGhnZB5TNbdM66QZgzBzej/Rja8oVTdxg=;
        b=nTcJzliE9HujFgVNDe1oEbI1+TY06YREwnMczkW0D2Qmp+mAy6wUFam2SA2NHRzcm4
         lD3aUSz53LAtqfQV6ByWCyywoHlEKjo9rnELgZcTinoUZ22QRbxlBInSdGnpyStubEce
         f99g0oBGv9PfvNlPli7nat8rO6WJVrmLTwIDLuC722bpC1jLpHSuyyUkGKRbB6362AlS
         iVYI3rrK/ZPPPsTT0e766U0bx5WoJiSjNJB68ZRz3GYLaApUOucLofoxM2ADhYlHeZah
         dqMt7q5Fbmy/IyBvMSnzfbNkJNewMsoGFqVyQDT8zloJkLTen7XbAiXjuHpUhYoIo7UH
         WPJg==
X-Gm-Message-State: AOAM531WXlb9GdCcyil/0TEN8hMCcntmSNUhoe5mSx5IMZKnG1B3hiaz
        GzsdlY4aToUNTUyU1dSpoLQ=
X-Google-Smtp-Source: ABdhPJzBt6cJpM0dInFyGbPbEnOjb0SfmAAgqWlyewip0QUKIOrwGVdVM0YUcGXaILCSdu6+VHKjaw==
X-Received: by 2002:aa7:cb48:: with SMTP id w8mr27557232edt.402.1638540003602;
        Fri, 03 Dec 2021 06:00:03 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q7sm1974689edr.9.2021.12.03.06.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 06:00:03 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mt96Y-0009Xd-C5;
        Fri, 03 Dec 2021 15:00:02 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Subject: Re: [PATCH v4 4/5] unpack-objects.c: add dry_run mode for get_data()
Date:   Fri, 03 Dec 2021 14:59:29 +0100
References: <20211122033220.32883-1-chiyutianyi@gmail.com>
 <20211203093530.93589-5-chiyutianyi@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211203093530.93589-5-chiyutianyi@gmail.com>
Message-ID: <211203.86ee6tss9p.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 03 2021, Han Xin wrote:

> +	unsigned long bufsize = dry_run ? 4096 : size;
> +	void *buf = xmallocz(bufsize);

It's probably nothing, but in your CL you note that you changed another
hardcoding from 4k to 8k, should this one still be 4k?

It's probably fine, just wondering...
