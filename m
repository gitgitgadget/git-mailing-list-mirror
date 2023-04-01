Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E18CC76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 00:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjDAAGJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 20:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbjDAAFr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 20:05:47 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356D5B44E
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 17:05:45 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5445009c26bso444769587b3.8
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 17:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1680307544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDfRGxlcpcdehSfVe7+80OdejsPZHijhAZcU37Za6xQ=;
        b=pWXSvorMlOqtvoVKNOOx0P/4AV5uULhZnLPwkq8klLPPRqf5DApf1x1GpSV1RzoNCf
         u3pqiUW1MA6DLI7WRg4yFS5FVMncuFDQuV2pOU0OK8xD1HxJK8OGKgJFvj35gUQZZa71
         IRHbnRqkH67hwZFDuYlpPrTVqJ1KZP++d9jMNz3sPaScjX3rrsrOy+jWvsFFE0ui32EZ
         XyyJlTeTIdt6Cvj3SqXrOhGIzwp/rVmiQGtyb/RH+kkcJwfHDHqqou+tSn4lNl+YtgfK
         JxRso3cG1W7lJ6aY9HaOVMo1Z8oXyywQEQcocg5tMpK5s/ua1rTHcpfvaI5wuhnr/FgI
         ZVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680307544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDfRGxlcpcdehSfVe7+80OdejsPZHijhAZcU37Za6xQ=;
        b=yL5dkOg0E2pwFmiqUe2EaKEn8t7jgS5eX555mVGXAs8UHZvIdGfoPpCK8RXYcksmlg
         iJO1kIopQpZRZfeqMNFwpev8m68JacCrT1b9STfZwtbfAVjGPz0x4tBzsCrikRCUO9zp
         ItszLRUKiNuDKbMoGKeZfAbH002EWiHVB98dsgWXY9KHQ1aNWq8gRbplQrD6pfUeNNG7
         73lMk5Gv3oZWYNoztenTKdwEaVd2q584fHYs2ZUXBjUAze/h2xXHiRjrvLyD6wNrSPcM
         txNMs1IHFBZjJOdsSfb2bwG+TEqAKrQRUdCOD2QdY6aCtBo8/5wi32oioOSl7+rTH/aL
         L7BA==
X-Gm-Message-State: AAQBX9fTdnsGQuAw0enuMzNz3dK8fIUQUx0BvwzxCCDC8o/QcG6LJSHQ
        NLdlimpxkeil6SeHPYjZcBse/A==
X-Google-Smtp-Source: AKy350ZGJY4hkbEd76uNrMNv8R0gZDz3fog+HJ8+OCgTDqK9wFOq8+eUtb47E9esrl8VVFTuBX/HYA==
X-Received: by 2002:a81:df01:0:b0:535:44e1:73d7 with SMTP id c1-20020a81df01000000b0053544e173d7mr24908324ywn.3.1680307544370;
        Fri, 31 Mar 2023 17:05:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 186-20020a8117c3000000b00545a08184acsm837414ywx.60.2023.03.31.17.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 17:05:44 -0700 (PDT)
Date:   Fri, 31 Mar 2023 20:05:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/6] test: avoid `stat` variable
Message-ID: <ZCd1Vyr+l9w/NmZ+@nand.local>
References: <20230328173932.3614601-1-felipe.contreras@gmail.com>
 <20230328173932.3614601-3-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230328173932.3614601-3-felipe.contreras@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2023 at 11:39:28AM -0600, Felipe Contreras wrote:
> ---
>  t/t0001-init.sh                | 4 ++--
>  t/t3432-rebase-fast-forward.sh | 4 ++--
>  t/t4013-diff-various.sh        | 6 +++---
>  t/t5512-ls-remote.sh           | 4 ++--
>  t/t5516-fetch-push.sh          | 8 ++++----
>  t/test-lib.sh                  | 4 ++--
>  6 files changed, 15 insertions(+), 15 deletions(-)

Maybe I'm misreading your patch or its subject line, but all of these
hunks convert from something (usually "status") _to_ "stat". Is the
point to avoid "status", not "stat"? Or the other way around?

Thanks,
Taylor
