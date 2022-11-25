Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B051EC4332F
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 06:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiKYGvH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 01:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiKYGvG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 01:51:06 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38022A971
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 22:51:05 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 136so3228967pga.1
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 22:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0r9xyh1YloJWBQFyYUNv75S9S6trBLCUuFsj6//IGc=;
        b=bv+L90YooG9ak7jfTLI26/HyZ1OM1gVA5wJibLdSVFf23bTpp1e19KuzICICPaJEf+
         7kne9wSpZq9MolCUbr+/J1NJ09mMEn7eEm3Cpsaxj71oRC6gkn9ELXpIi525r1h3sHGj
         xepF97jtASDs6cu++ZdC1SSld+4INE+aH6OEUAkxstxDjHVUOZKc6dyLsYUlvxF6nDjE
         n6Tjg3I7BKnl+AOWHWe7PYG1JSEowFkBj54e7T7n0eGj/bsDVAUn/z6QK9d2/HHlbGeQ
         FZIigE24rbXHReg39Cl89vy+KjAZlKR1vLHXBdsbqXuqBfYm0CE2aAOZrJvBClYS/Xlr
         /M1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0r9xyh1YloJWBQFyYUNv75S9S6trBLCUuFsj6//IGc=;
        b=PCMQmR6dLnfbihn73jU9MIXgEpHbJ+kFQeZWq7ZSSQA/SVZgd/lNcFjfNVoRoyV5Zi
         WUlgyUJo5aZoTfacSXT5fQrFDx4u+CcsWWTrEkDbtlpYlnvGR2tDi4Rhxdz3fS/c1RVr
         abXt17LUlGEgAmmPAGSKW2OFdqc6WT9tgEzYsBhlN1tYKWh4ucgjqOnaQnNLfkMkNWnB
         Su3GQwDcKMWZVMm3BS5ZIPAjzlx27GAlP0SSta11uUeoeyABa1ppbgf23iIEBSsmrZ2a
         NAPW/ky9TLVK/dZpd5GS2M8YNKL8egvxBJhPeOX2CkAtF/oifVaKFXKy5GHIOngDA6AF
         RLYw==
X-Gm-Message-State: ANoB5pmhA32P1ow2R1tXvPYBjrnu4Df3ZJLc2bdUJeZ1FBCnyMFayDyd
        4BQnaAkr6MSwM2wq48sqWcU=
X-Google-Smtp-Source: AA0mqf7Q8iYPoi+IIh1XfR5uJalrjEz2w9u3/d5nRBODEaShE+m0u0h9Gta81EU1blm7dVpj84m3Zw==
X-Received: by 2002:a63:d712:0:b0:470:4522:f317 with SMTP id d18-20020a63d712000000b004704522f317mr22724531pgg.129.1669359065409;
        Thu, 24 Nov 2022 22:51:05 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id k6-20020a17090a404600b0021282014066sm4253494pjg.9.2022.11.24.22.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 22:51:04 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v3] object-file: use real paths when adding alternates
References: <pull.1382.v2.git.git.1669074557348.gitgitgadget@gmail.com>
        <pull.1382.v3.git.git.1669251331340.gitgitgadget@gmail.com>
        <Y37EEiJembUN9PmL@coredump.intra.peff.net>
Date:   Fri, 25 Nov 2022 15:51:04 +0900
Message-ID: <xmqqcz9bedd3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Nov 24, 2022 at 12:55:31AM +0000, Glen Choo via GitGitGadget wrote:
>
>>     object-file: use real paths when adding alternates
>>     
>>     Thanks all for the feedback on v2. Once again, this version takes nearly
>>     all of Ævar's fixup patches [1] :)
>
> This looks fine to me. I'd probably have done the strbuf_realpath()
> change I suggested, but I don't mind if you want to punt on it for now.

Thanks, both.

When we designed the alternates long time ago, the "avoid placing
duplicate directories on list" was done merely as an optimization
and not as a correctness measure, as there was no plan to add
anything destructive like "delete all non-local objects".  But now
this seems to matter X-<.

