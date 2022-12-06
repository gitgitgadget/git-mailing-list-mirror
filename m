Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7719AC3A5A7
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 23:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiLFXlY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 18:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLFXlX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 18:41:23 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD23A45A10
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 15:41:22 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so16308143pjo.3
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 15:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=afnz7SiChtQV2ZtQMhzUJcENqfEedBA3ypm3+j7MB2k=;
        b=EYP+/0lSPREL8kIYZhrbopHXjDiO4KdHM90r8QT7GlTywDhyrAhYkroT6Uz16w6AJs
         Psz5KGpZ9/fvcGfToavx+9wcbD+4OlvWA6VSccI6PagFNb06GCMjmQAx4dB0FHghybC8
         4DFRdrECjEwyYiKsPloZ6wfxxgeaT7lsAbJZw3D2lJOllcFu5Qcesm5mX1USOrMB8GJ1
         ocoZRLvMwuSpuaRGWyg9mqeQvMhH16WfwQScwiWHosqj/jPNoLk7GLnOGy1z9+J+KO/x
         I/bjMoOUtNGF4GCEvo2etDe680K12ZJXcCijApLZufEemuzmIQmyMmvC1xG9L9PXcGc7
         a2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=afnz7SiChtQV2ZtQMhzUJcENqfEedBA3ypm3+j7MB2k=;
        b=Vua9bWmPJlOwlo3rBl/tDTESe8klnninfKh4z72RFe+8tXTL9PQhOxYX2W12ejJxTn
         QFh/cV8HzQ91ZCeC5LnwSOGogjF2y0dVwS7ZFOqu3pDUyl3wKt/lQuNtQyoskrVcHPgN
         vKrFR/4Xad/dvght94wy8AC00bOAEGhLMSLlZXkMeSuDQ9+i5pYsLPKnT7WX2krPIfdZ
         43emYCMM0E3AkVzBKJBEbRlBwVSn/EMmUPQuRTCFaHQD7LTbsrQryfnYiZ0NFMU/3fsZ
         hh2oA9dYCFdVAyONwyrDwobC7vOIbjqL4EG2zWbnlb952Tk4oxCZ5P1V6XRn0LzNetnN
         o0uw==
X-Gm-Message-State: ANoB5pk+EdDH2FPj3M7/lpHUoonFDIYm1ZUuYYb55Olc0j12nXPMshaQ
        QY5tQ80gqEySY4pCFJQ8/Ig=
X-Google-Smtp-Source: AA0mqf6qGWoAfgFcSyJtwUAnc3v15gcUVNxlqd7xy/YmQu+uu+qMXX9AskPeUU9+5mzAlUPG7XDTgA==
X-Received: by 2002:a17:90b:33c8:b0:219:94b2:2004 with SMTP id lk8-20020a17090b33c800b0021994b22004mr21858335pjb.215.1670370082245;
        Tue, 06 Dec 2022 15:41:22 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709027ec900b00172973d3cd9sm13135111plb.55.2022.12.06.15.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 15:41:21 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Oscar Dominguez <dominguez.celada@gmail.com>
Subject: Re: [PATCH] ci: use actions/{upload,download}-artifact@v3
References: <pull.1354.git.git.1665388136.gitgitgadget@gmail.com>
        <pull.1354.v2.git.git.1670234474721.gitgitgadget@gmail.com>
        <xmqq1qpd9bys.fsf@gitster.g>
        <2s9ppo74-r654-231r-7ss7-o08464s2so6p@tzk.qr>
Date:   Wed, 07 Dec 2022 08:41:21 +0900
In-Reply-To: <2s9ppo74-r654-231r-7ss7-o08464s2so6p@tzk.qr> (Johannes
        Schindelin's message of "Tue, 6 Dec 2022 22:21:23 +0100 (CET)")
Message-ID: <xmqqmt8085i6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> @@ -210,7 +210,7 @@ jobs:
>>        run: ci/print-test-failures.sh
>>      - name: Upload failed tests' directories
>>        if: failure() && env.FAILED_TEST_ARTIFACTS != ''
>> -      uses: actions/upload-artifact@v2
>> +      uses: actions/upload-artifact@v3
>
> This is probably incorrect, but you wouldn't know until something failed
> in the `linux32` job.

Yeah, that was what I was afraid to see.

> I already have a correct fix in
> https://github.com/git-for-windows/git/pull/4112/commits/b59c1e33fa62029f8d5dca801a8afb480514140c
> and was only waiting for the patch at the root of this here mail thread to
> advance further so I could contribute that fix, along with other
> replacements for deprecated operations.

Wonderful.

> Maybe we can move these changes forward in a more orderly manner, with
> Oscar's patch advancing to `next` once it is done, and the other patches
> following after that?

That was what I was planning to do anyway.  Thanks.
