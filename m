Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E448C433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 23:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbiKUXaD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 18:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiKUXaA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 18:30:00 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8E2D5A3C
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 15:29:59 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id q1so12528623pgl.11
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 15:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fw8JRZfLz26GYLVhUMrt9HTYhMYBXHoSqjS8TRhHaXw=;
        b=LoXXuaab21iqnZ/qJOSiLxzNOFTn3arIOXLTcAW1aDTiICHmkxyLPHizD/awELbS6J
         t1VNizaVK8VdnHp4Ui7gNwVe5nWXDejiOGEi/kLezzHcwAmwzNx9RG7KBp+aniLFqL3Y
         rQXqMWIV99YWw8Ok1txsWEhUIBBVK3ujlHga5NWpjXd6h29LB0rznLs9Adl36JYJFuoJ
         OoHyeg3M8C/eaMomOF7MrNepfjzOYUuNC/hqe/R4UnL+d+wz7rXog6DWHTPuZrXwRYDi
         ui1va8tFddDGmMaWGtgTY5C1ClYMCnwti1/lSXf1Uo/gCsSO0NXtqRmJ/dm7C5EgbT9f
         hZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fw8JRZfLz26GYLVhUMrt9HTYhMYBXHoSqjS8TRhHaXw=;
        b=VTl3kUbQoAjR3tyiLlcZod+E8V0NOZfnOsZDTt4j4zFUUqfMmj9PglsKZzsNvnjzX/
         cSsNScWKjJV3D9ZydbShLJNl59o41DcyXosK9DJIxvCNueNtYRAuSX2GrNDKDVTkyO8v
         QlbfzB+jvxC2VWYf9SF36cq820e7GbVKhJ3Ey6QpcxM0iVaF6/3fhVo13Css0robCfHt
         8SGcxvGeAy1GCbwEZQNfK/kKDrx4AXcyufl5K3tjf4D3a1qbbxxfNH1H74fgdnS34YPi
         ZDAvb4w5Xj9GAQkpQfhYIhvs7NhhjnTEBDtPSwEENMOA046WxYzQJLXXtJwkddnbWRtf
         VeDQ==
X-Gm-Message-State: ANoB5pkzZbY1U4C4RXdzZECbAGR/xoTJCdFj/Z2AFOU6CJzlsrUxOHgn
        YOPKrwwqaeBOdbngg5XxLFc=
X-Google-Smtp-Source: AA0mqf6SaJnkHwzxphZjaoFrTWFor5s9g+qjOYPoWg/7VHnoZf47ZTxMeIyk3fOBPWaPzmsmNFiHQg==
X-Received: by 2002:a05:6a00:17a3:b0:56b:b37d:9857 with SMTP id s35-20020a056a0017a300b0056bb37d9857mr2103660pfg.12.1669073399280;
        Mon, 21 Nov 2022 15:29:59 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id b1-20020a170903228100b00186b7443082sm10389297plh.195.2022.11.21.15.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 15:29:58 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Teng Long <dyroneteng@gmail.com>, avarab@gmail.com,
        derrickstolee@github.com, git@vger.kernel.org, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v4 4/4] pack-bitmap.c: trace bitmap ignore logs when
 midx-bitmap is found
References: <cover.1669032425.git.dyroneteng@gmail.com>
        <2acaa3f097e0ab08a63ae1719454f5e11bb15a44.1669032426.git.dyroneteng@gmail.com>
        <Y3vM3GZYFy+l006d@coredump.intra.peff.net>
Date:   Tue, 22 Nov 2022 08:29:58 +0900
In-Reply-To: <Y3vM3GZYFy+l006d@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 21 Nov 2022 14:09:16 -0500")
Message-ID: <xmqqbkozvqbt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ...
> It's not hurting anything functionally, but it makes the code slightly
> more confusing to read.

Thanks for all these good suggestions.

As you pointed out, the first two seems to be identical to what
Taylor queued in 'next' already (so they do not have to be re-sent
but it is not a huge deal if they did---it would be a huge deal if
they were rewritten, though), and both of the two follow-on patches
make sense with suggested (minor) updates.  I'll expect a reroll
before queuing these two and mark the topic in 'next' to be waiting
for them.

Thanks, both.
