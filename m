Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521B6C4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 21:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiKDV4h (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 17:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiKDV4f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 17:56:35 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AD051C37
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 14:56:33 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id p184so4837735iof.11
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 14:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+4EnGU9okw4XVA5dve/NGBeGjSdjGzxlvnauruXjND0=;
        b=D3exxI7xpZcwhMsBhFiPyExu670ndgwZsrPOE0BXbpgiaNAhe2LRjIhMwfFtqWg2NO
         tyBFGWgIleWpjb2HAo5uHzlOCXj5Bnfij/rBlMlWYSn4QHlzIj1UuvU+Lr8aQl1tKwIO
         fLP2YLrorLUk0Ych4ziCC8D+0yc3X4819XgNAjsuJsGMLo8ysvezMcLFNrDUOWDRW5gj
         EbQdPE8pUR8Sy8hzBdn3mJAqhOq8OMImWRGLcMBDqXySxgvPSDe3+HHchi9xP9Wdao+v
         OZhbUqsmhOWzAg9tAZeIx9YlHlFf++TgDHYls3Mdj0MyE88TCrQxYncbb/4CKDC3vkLV
         22mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4EnGU9okw4XVA5dve/NGBeGjSdjGzxlvnauruXjND0=;
        b=KzWwTgpkEVQPmt8JOzpcsO3Lpu6PqroUz4VXfeJ9BYC319hOq9+iQT89K3zs3M4NeL
         3q+l6SZwrPy1/9QIJNtlpGbma7vKL8+SrLmcdYwNbc2DJHiiODImAr4x0Q2L7xK64b3b
         o+iT/WMLk2NoBRu3L5IOBEFDM97aOCo3szZCrE1v8Dvt7pVAYJFmsg9pshD161zaFxXK
         /jQUNgRFwRMjQlwm/zyt/GAh09B5qWWGVTLB8WCb6tJSFmhAqhVGtVU047AZ77J51jUM
         iD5U0o5jx8ufxo+7zShF2nQBpU8JaAXsFIjcWtvXlpxqLZeDOak9f5xzjogbPxluaH0D
         ZoWg==
X-Gm-Message-State: ACrzQf0UaMjQ2CmXhniZ7D1WPPXRlWh8lysc2kQImDuuGiWpkoK6C3dc
        XT5TGbURsccxIaXwInfmPK8eFafARLujDirg
X-Google-Smtp-Source: AMsMyM7jGvnkf011zy5gIWYqm3mreZ+PZik7VC2BFN9H4P8XdesdGyRY8bi5zGjkZFj/rYkDq6aTAw==
X-Received: by 2002:a05:6638:e8a:b0:374:f6c5:cff6 with SMTP id p10-20020a0566380e8a00b00374f6c5cff6mr23404151jas.187.1667598993149;
        Fri, 04 Nov 2022 14:56:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c4-20020a023304000000b003495b85a3b9sm38049jae.178.2022.11.04.14.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 14:56:32 -0700 (PDT)
Date:   Fri, 4 Nov 2022 17:56:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/2] sequencer: stop exporting GIT_REFLOG_ACTION
Message-ID: <Y2WKjyksxc8/WySs@nand.local>
References: <pull.1405.git.1667575142.gitgitgadget@gmail.com>
 <e9c3f5ac5c6b7a01ee9e43730889d8066a270271.1667575142.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e9c3f5ac5c6b7a01ee9e43730889d8066a270271.1667575142.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 04, 2022 at 03:19:01PM +0000, Phillip Wood via GitGitGadget wrote:
> ---
>  sequencer.c | 45 +++++++++++++++++++++++++--------------------
>  sequencer.h |  6 ++++++
>  2 files changed, 31 insertions(+), 20 deletions(-)

The end result is much cleaner, thanks. Are there any spots left in the
code that still expect to read GIT_REFLOG_ACTION from their environment?

I did a quick look around and based on my understanding of the sequencer
code this should all be OK. But some analysis in the patch message is
appreciated.

Thanks,
Taylor
