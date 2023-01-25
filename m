Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE7EC27C76
	for <git@archiver.kernel.org>; Wed, 25 Jan 2023 17:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236194AbjAYRRz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Jan 2023 12:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236191AbjAYRRx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2023 12:17:53 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89F4CC03
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 09:17:51 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso2747559pjj.1
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 09:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AAZAaTbNA2z+x2Pd7aPjFZWjNXKpuF3xgqY6Aca529M=;
        b=FeeG1h1T1hBocP2G70E/86BwO91vnl0B2f78koGINvQtISZ7HUoPEsye87PHHVhejM
         njKOwLTri7V/ePxKNebhoqSnCiVN8u19K2e4cFaiB8SDQoIU5aueINCuId5NdxQWl0uS
         QG8xy3Nc+0xuWzG2qghB9zvYT1UNXV6ndxySY0hhoICKb9xoWyDOXhdl9uOsxPGh0cyr
         nSVx0Spdm4LPAWfgM34HY1VlwyCAcUs6L9BQYCW+hUK//FJmEIlwbcP/kvytqQ2E6OHb
         vYthEnBb96xNxWQYrxFgDlMIum8VLAl/8ettk5J7YdLLb+1WJhdWrkDNbvsOLLxZfEbC
         KWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AAZAaTbNA2z+x2Pd7aPjFZWjNXKpuF3xgqY6Aca529M=;
        b=3s/sOt7lOcN5lD39ka8pILXvszwgWV+mO3FNVUMdzOp5SJBQ0Yr9ZMuJZwnU3ChBmo
         NyLzYdodls3XkFiNYU/5vzXydh0R21A1ch41WkGdjVzbqgpDTU4g3e4A7vIpRaL0oDVv
         lAF3CLriImr1cwHkdUzQLSZ08C4YBzVCto4F/F701RL5EDOG2CdVAcf4+/RPpLOKGj41
         9fBVwiMCGMfxQswWkOAUxab+HVnWkFaN3K6doOAksQe2Bvftg2I24ntlfD9dvVT6f3JZ
         givHctD2YCM9m3fgUt01qpcWyotid0mjknER85EV7cPz14cV03LQ+TOoSNSnO/FIzO4a
         nkOw==
X-Gm-Message-State: AFqh2kq8545ra/NpXZ5g3NlFsfg/f2vSTtGgIoPuQwN4eveCZvkBoI+z
        e+Qkejbf971CcrLoY3k6es0=
X-Google-Smtp-Source: AMrXdXu0jCcpZGHdGpHmcpF+vxpmGHww8zbtGiheVF035TrQlSu37X+CSXazdeq8+EL9WubkovVGdw==
X-Received: by 2002:a17:90b:91:b0:225:ce95:dc15 with SMTP id bb17-20020a17090b009100b00225ce95dc15mr32880869pjb.29.1674667071344;
        Wed, 25 Jan 2023 09:17:51 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090a474f00b00226eadf094dsm1918390pjg.30.2023.01.25.09.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 09:17:50 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Szkoda <adaszko@gmail.com>
Cc:     Adam Szkoda via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: Re: [PATCH v2] ssh signing: better error message when key not in agent
References: <pull.1270.git.git.1674029874363.gitgitgadget@gmail.com>
        <pull.1270.v2.git.git.1674573972087.gitgitgadget@gmail.com>
        <xmqq1qnjhlbf.fsf@gitster.g>
        <CAEroKagUY5PfuC2CDn=pTJ=brPsjPy6MVz54mH1tvN8E-Pvk7g@mail.gmail.com>
Date:   Wed, 25 Jan 2023 09:17:50 -0800
In-Reply-To: <CAEroKagUY5PfuC2CDn=pTJ=brPsjPy6MVz54mH1tvN8E-Pvk7g@mail.gmail.com>
        (Adam Szkoda's message of "Wed, 25 Jan 2023 13:46:36 +0100")
Message-ID: <xmqqsffyedoh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Szkoda <adaszko@gmail.com> writes:

>> We do
>> not pass filename yet with this pushl(), because ...
>>
>> > +     if (literal_ssh_key) {
>> > +             strvec_push(&signer.args, "-U");
>> > +     }
>>
>> ... when we give a literal key, we want to insert "-U" in front, and then
>>
>> > +     strvec_push(&signer.args, buffer_file->filename.buf);
>>
>> ... the filename.  Which makes sense.
>
> I'm not sure what you mean in this paragraph.   If there's something
> more that needs to be done, I'd appreciate it if you could rephrase
> it.

"Which makes sense." is the key conclusion.  Instead of saying "This
part of the patch looks good" without explaining why I say so (it
could be that I am saying so without really reading or understanding
the changes or thinking the ramifications of the change through),
the earlier parts that lead to the conclusion is a way to give
weight to the conclusion.

In other words, it is meant to show that the reviewer did read the
patch well enough to understand the reasoning behind it.

Thanks.
