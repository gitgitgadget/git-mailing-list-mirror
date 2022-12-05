Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E869DC4708D
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 09:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbiLEJcX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 04:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiLEJcP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 04:32:15 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5206D15800
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 01:32:14 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 82so10034106pgc.0
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 01:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAuqaIA5HyBvLUVKf+cxHw72EjEUlwaWzlydPFvLHPU=;
        b=bXwKNLgATzdnYnzSL553+gAeMpp1r1hVsdLYWCeCzdjNuoaZ1/Es1zgW1wqEmiLxyu
         Mi5xxgRLr1fsxdlNUg/Mxa9ocWXzvujjzNASlJQl2R2J1AbjE7j/GG7A6V9UwcCCQXZl
         ICRdSsHwVs+RKVA1eZVkNN/ufQ0OiLwOr5VrslTANEeRpz/BYQdao9NAqoQalZvuKSoj
         fTb2nqxe0EesbRr7W63pNSJfWczb4EsPY1Dvw9/uTGv5/OJa/Dw3TwNiWDrR2jaYHRQt
         G/KYsE/6jXCfSGebanZk2l6cG0rvpAic+wc1+Gi12q/gLBua5A8Lja36J6c9DDdBpxUv
         zFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bAuqaIA5HyBvLUVKf+cxHw72EjEUlwaWzlydPFvLHPU=;
        b=fTr+xyZ/ArAc09suf2Ueis1NhiKPNsp84VI6Eav0LgHw+ceOeh6S/erfPRZ0tGUWe9
         l7Ik/DYgf5AlF9gSL38wDTcNPXmz1wjO35dwDhQV1CDh7ahLEJt5qPiRBpRdZiNM2y/n
         cujVz83inmYa/CBKvtxQeLLju58J4+6AKXHILOPNaK+i7InfIVeTIOSuLngtjdWAtXRN
         88i0q8ONX+eJ4WUdzDp8RWrxWJnpAOwGPB5VU24xJdos/oHm3oYJfud1WI9wtIio//Mm
         qJBeQxt28Kfk8kTm0+2Q9quDd2uba0BLuF/gnmxmXh27cOCnWwUN5rLDcmD3OSFZOBCl
         J4vQ==
X-Gm-Message-State: ANoB5pl2Xzs5CADHKB+aH3PBIgayTfCkRs8Af6T6hcOSYxKKNuS1u3O5
        SFmXXN4gy7PZEb13kqlPU+oeSHafHaGkSw==
X-Google-Smtp-Source: AA0mqf71R9XOlx6YJ0TUJkyretOLF1zzgt2l0NY0WWJ62m8Tx7xHR/t+CCijadduqSXqAWSdtkWoaQ==
X-Received: by 2002:a63:1f65:0:b0:470:8e8d:44ae with SMTP id q37-20020a631f65000000b004708e8d44aemr56800511pgm.382.1670232733543;
        Mon, 05 Dec 2022 01:32:13 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id w131-20020a628289000000b0056d2317455bsm9443396pfd.7.2022.12.05.01.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 01:32:13 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/1] t3920: support CR-eating grep
References: <febcfb0a-c410-fb71-cff9-92acfcb269e2@kdbg.org>
        <cbe88abc-c1fb-cb50-6057-47ff27f7a12d@web.de>
        <xmqqo7sisllv.fsf@gitster.g>
        <569714f6-a913-5f7f-855a-b303adbde3ee@web.de>
Date:   Mon, 05 Dec 2022 18:32:12 +0900
In-Reply-To: <569714f6-a913-5f7f-855a-b303adbde3ee@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Mon, 5 Dec 2022 09:28:45 +0100")
Message-ID: <xmqqwn76p55v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Depends on the meaning of "fixed".  If it stops removing CRs then this
> line is unaffected -- .crlf-orig-$branch.txt contains no CRs.

OK, that "fix" was what I was worried about and if there is no
problem with the input we use, that is good ;-)

> If it
> starts adding CRs then we'd have a problem with all grep invocations,
> which was addressed by 4d715ac05c (Windows: a test_cmp that is agnostic
> to random LF <> CRLF conversions, 2013-10-26).

Yeah, but I thought that the unspoken motivation behind recent
changes are so that we do not have to rely on "the differences
between CRLF and LF do not matter" version of test_cmp?

Thanks.
