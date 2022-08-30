Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80324ECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 21:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiH3Vqa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 17:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbiH3Vq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 17:46:26 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A5E8C465
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 14:46:24 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id l3so12364109plb.10
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 14:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=BZBkiBFNHvW5+yOyVo66VYfyT6FbpkEwDTe49Ko/OIM=;
        b=GPenL4LaDzMz5EYMSHDaGZLiVdgHSh2ryxb+qirbuFUsl+A0f9HzsdN1Djg4hyRKP6
         SIMje0h+w4wS6SkFfpqjdMJ+XDwDlVdoXTUDtIohzcalgj0kD7MYXLaGLEyrkfe3fAnI
         QWBM4pp00AaU8RcHSJMWwL9YvQoMgoM67mgTICfE3xQaPBspkEy9zYa1rdvYTGXX3K7o
         4jWof3lQJWb4LSJVd/2L2OSbYmUxa8ZPV/I5idQQMMn6CWlCPGsxNGXQ2WTgzQ/3Leak
         o0vK22QPLBlPfeYg697NE6+j77DZAwx8O4HDtnMYsRrnrhJvwAlJywF9ce/w6yVK80hR
         XekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=BZBkiBFNHvW5+yOyVo66VYfyT6FbpkEwDTe49Ko/OIM=;
        b=2ktXnmu8ymo1YyQjBbFp4R9nnBb5nPIJ7qqw9GRFax3RQKB3AwHimiTfyDSrVoc4ry
         E7De6a5d8LfjqEeZM75HRawLaad7t4CeNxAxWuEWOgJjSdyZReiBk7fcyH2cnK/NcbdT
         u9ooxp8FYloCN7gMrKK4BbKIwnTqd1KvvEbrtwit84V0ijn01PBBG0kbXkdS0ythqBQB
         +svyfmsmtvzrufsHoygi+So6vyyR96scGqS71tJg/5+GbUtv78Vx3g57SSsKMKIY8Gge
         8Sxyjdi9N6l1n0/ZiK6BR/tl8XO9Q7vNb/6Ql1kqt5ekxwlDkIgF02B1U4r7GvtB4Kg8
         EOPA==
X-Gm-Message-State: ACgBeo14OeRqyAuIZGtcJpFdoAujnYs/Eo65XQiFq01BfnOmzUk5ioJG
        zmMyLGI/CJNbJxgyG+xIum3EySHG0U4=
X-Google-Smtp-Source: AA6agR6cEcCTSQNzkqr07IyzmBQG2kEBAEWG5b8/nXaG/CG2EKcOCDyJ43QlbC8b9/dXQEir60lUHA==
X-Received: by 2002:a17:90b:1c8e:b0:1f7:524f:bfcc with SMTP id oo14-20020a17090b1c8e00b001f7524fbfccmr57761pjb.132.1661895982748;
        Tue, 30 Aug 2022 14:46:22 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id p63-20020a634242000000b0042a6dde1d66sm2117710pga.43.2022.08.30.14.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 14:46:22 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     phillip.wood@dunelm.org.uk,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: validating signed/unsigned comparisons with Coccinelle, was Re:
 [PATCH 0/3] A couple of CI fixes regarding the built-in add --patch
References: <pull.1340.git.1661867664.gitgitgadget@gmail.com>
        <p9p431r8-nq64-02sq-3049-n10rrn1o89o7@tzk.qr>
        <dc48ce59-530e-da74-93ad-9eb4a17e391c@gmail.com>
        <73spp934-1q41-1123-41no-q2337954op92@tzk.qr>
        <xmqqbks1ifmw.fsf@gitster.g>
Date:   Tue, 30 Aug 2022 14:46:22 -0700
In-Reply-To: <xmqqbks1ifmw.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        30 Aug 2022 14:29:59 -0700")
Message-ID: <xmqqzgflh0b5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> Hi Phillip,
>>
>> On Tue, 30 Aug 2022, Phillip Wood wrote:
>>
>>> I wonder if they would be interested in fixing the parsing bug we found
>>> with Peff's UNUSED() series.
>>
>> Could you point me to the relevant mail? I am sure that I can come up with
>> an MCVE that will help them pinpoint the bug and fix it as quickly as they
>> did with this here bug.

I think the reference Peff posted is much closer to the description
of the "parsing bug".  Sorry for  the noise.

>> Still amazed at the turn-around time,
>> Dscho

Yes, indeed.

Thanks.
