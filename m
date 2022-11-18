Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12046C4321E
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 23:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236945AbiKRXwh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 18:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236994AbiKRXwC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 18:52:02 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C582C7597
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 15:27:20 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so6452756pjk.1
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 15:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KMe/IAPw7iCAtbFGGptUUepLAud27PK2QeJBxNFjExw=;
        b=eRDDQITQsWjh06wnvxmbqsZfK5TTSCeA/yFUpmG4St3T5/ifwwu7LogPn2MiCB7apM
         BsuPy5eOoIB09aWxFnpF0dbnqPHlQUcaA0+sxSgaiY4TKmhk55b1U/529SHdSA8zwOLW
         4cQs+PT27DqUEJzK2z/R13vrxVMzTEmzc/vTI53vlTq/JxAZMOemF7oNER+2i9Zejoog
         ckTJ1SFMwUW5zMQl+UWMvAA76PEHeGhseUlpwUctg2rT21gzc077KmfxZEhBlyuNw1Fy
         baeDOQxSRdAY96hqpqvz0c8XbCVBYPcdip8XaTkqSyhhwYUhUpMdyLs4TgeCLROvwMZS
         CtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KMe/IAPw7iCAtbFGGptUUepLAud27PK2QeJBxNFjExw=;
        b=JkTrGGq/w2YBYayW0QWjiREdusHeeVZdMjI8dUMr2uztXAF4YOX64xCMMrntcHaHW4
         dl0rDSP7xVrjrg+Kv4egNPpDqJqmne6fu4k+nnnoTM0X3U09NvvlTMmZlqLBH9qe/J6c
         gTORbL0TGRIAUMjWfTCzeS1Ch8Z7+r40D8iDvgpwV1xCPNnLYFes2v0RL5WxlMnLT41K
         wyiTrz8OesRUDM3QHTQ5OzJwIc6LBNnLlgrNxdbgQs3C/4lsh+WFAENzgI5Ai4TEEU+x
         WARdq7qGB/zQo77bVEfEsbaeNSWTQrtEx1AiZ+MstTkrsBiGDzdcZoVAOdF6LWilGKIO
         Qbuw==
X-Gm-Message-State: ANoB5pldnQa0HjFjTSdpYga8dbhWnCTtXF0xEQMblmFq5IR9mxbnx3Ir
        6SDmK78a+9LK5CrBrPj51Tg=
X-Google-Smtp-Source: AA0mqf6g66VzLO3E3TTW62XwSLWTa60S7HTVEOMiemwe6ekJWLngSTz71NTwIdXrorDnoUsM7GXmbQ==
X-Received: by 2002:a17:90a:6904:b0:208:4bfa:51e1 with SMTP id r4-20020a17090a690400b002084bfa51e1mr15516802pjj.228.1668814039779;
        Fri, 18 Nov 2022 15:27:19 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id s5-20020a170903200500b00177c488fea5sm4287656pla.12.2022.11.18.15.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 15:27:19 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
        git@vger.kernel.org
Subject: Re: ps/receive-use-only-advertised
References: <Y3Mag8qG2D3qjlmg@nand.local> <Y3MxmzestKm9iMTU@ncase>
        <Y3M2Fq7pZk4lNY9G@nand.local>
        <Y3PMLFuvR6hlIzbq@coredump.intra.peff.net>
Date:   Fri, 18 Nov 2022 15:27:18 -0800
In-Reply-To: <Y3PMLFuvR6hlIzbq@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 15 Nov 2022 12:28:12 -0500")
Message-ID: <xmqqmt8nkfmx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> > >  "git receive-pack" used to use all the local refs as the boundary
>> > >  for checking connectivity of the data "git push" sent, but now it
>> > >  uses only the refs that it advertised to the pusher.  In a
>> > >  repository with the .hideRefs configuration, this reduces the
>> > >  resource needed to perform the check, and also forces the pusher to
>> > >  prove they have all objects that are necessary to complete the
>> > >  history on top of only the history available to them.
>> >
>> > We have at a later point established that this is not true: the pusher
>> > does not have to prove they have all objects. As the `--not --all` part
>> > in git-rev-list(1) is merely an optimization the semantics aren't
>> > changed at all
>> 
>> Thanks; this is Junio's description from when he picked up the topic
>> back in WC #08 from October. I'll need to update before graduating it
>> down.
>
> Yeah, I think you can probably just remove everything from "and also
> forces..." on.

Hmph, --not --all is a way to make the rev-list error out if the
proposed new tips are not connected with existing objects to the
"existing" refs, and I thought that removing "hidden" ones from
"--all" means that the pusher is now forced to push objects all
needed.  But you are right.  Excluding the hidden refs from "--all"
while doing the "rev-list new-tip --not --all" traversal does not
exclude pre-existing objects that are only reachable from these
hidden refs in the object store, so it does not help ensure that the
pusher has to prove they have these objects.
