Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7A1C64EC4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 19:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjCFTIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 14:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjCFTIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 14:08:09 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D906305F0
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 11:08:08 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id x7so4554793pff.7
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 11:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678129687;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ZvKV2bWF4YmZMjvDnjGl5PSSml5vQmu45OqK85vffw=;
        b=Grkr4DSqtW68a66sDq6tD6t8aE+BwP5jcwVvKFn/VYz2EPggCQx/mQFZxgai0l1+Au
         arPBzu1u1kapTDQ/zPu4u8fJmwASZxsqympBW3JDOgzyyax99N/ou5jfKn0yTdEeCckT
         jOZ7vdwiARgey5EKlLSjipcBCM+/vUBZi+EeBtnFASfZaB43QtuhmJYWcUtsoZhQc9Ua
         fUMHJX/DBITb36EOHe+k+0g5wFrwZGZEhhaonQVrqDO7WEAgxVesRB5DL54Tb7QUOV3t
         dcWadhTxKH4VbkER/HKACxXVzlFhQacmFbSGTJxnwfIfdK/5lePsIEdXpuLpdNtU0MAi
         TmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678129687;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+ZvKV2bWF4YmZMjvDnjGl5PSSml5vQmu45OqK85vffw=;
        b=0Y1z0fACqwx5eoZzOW0YoFKcYU1DGzNtNy7tYjTJArIOFDZ0J0JnQWnasR10aBNGVw
         lJo8EnWPpapb2gqc2/JB8ZSCCOvdSBJu8nwpum9xR3Du4K3U3p8KAXczvzZ+C8NOGDLv
         N+GT04MXjahkB6p8HXlpdA2MKpz4WvqwirOCYI2IvIMrOEiOI3tGy5Z7xj1yRIL3xXPe
         mv4V0P6xjtyXzb4i4UyeTJeRbhkKKmEoUNNrc3AauBA5USYxsCbl7qfg+RtBPRGPUAdz
         CEmR+C79Ji03g5IC27VHJVFwQjZMTVd/imp08avwJbGOXo8Z63PEGljIyj6cQEuBLCPt
         Nreg==
X-Gm-Message-State: AO0yUKXvsrAkrqiwCMe0HbuPg6GgFWYHqRmSQ4kNpMrgd77Vsh/1pctn
        ZAgYZ62h48PWmWquRvxJlv9XPnuwbTY=
X-Google-Smtp-Source: AK7set8t3gIZ0WohYQQZj7Hm9UbMiOo9tlvC5NMyvaO1LacqauEd7l5exmbDw7aFn9tTNHIXvlVMCw==
X-Received: by 2002:a62:38ce:0:b0:5a8:a9bc:197 with SMTP id f197-20020a6238ce000000b005a8a9bc0197mr9518561pfa.11.1678129687506;
        Mon, 06 Mar 2023 11:08:07 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id k8-20020aa792c8000000b005a852875590sm6608660pfa.113.2023.03.06.11.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 11:08:06 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org,
        tao@klerks.biz, newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, chooglen@google.com,
        calvinwan@google.com, jonathantanmy@google.com
Subject: Re: [PATCH v6 0/3] rebase: document, clean up, and introduce a
 config option for --rebase-merges
References: <20230225180325.796624-1-alexhenrie24@gmail.com>
        <20230305050709.68736-1-alexhenrie24@gmail.com>
        <87ilff2xsl.fsf@osv.gnss.ru>
        <CAMMLpeSowxoJgPOt84Dos8BVKU=y=M+Ph0xaGe6UTxwwE5zsXQ@mail.gmail.com>
        <87ttyyn71f.fsf@osv.gnss.ru>
        <CAMMLpeTUykcgdijRPEiBJHH1xz50s=aPK_hi=FJv6C3=cj4XEg@mail.gmail.com>
Date:   Mon, 06 Mar 2023 11:08:06 -0800
In-Reply-To: <CAMMLpeTUykcgdijRPEiBJHH1xz50s=aPK_hi=FJv6C3=cj4XEg@mail.gmail.com>
        (Alex Henrie's message of "Sun, 5 Mar 2023 17:02:42 -0700")
Message-ID: <xmqqh6ux8zqh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> Interesting, thank you for clarifying. I just tried it and it appears
> that --rebase-merges requires an equals sign when it has an argument.
> For example:
>
> $ git rebase --rebase-merges=rebase-cousins
> Current branch master is up to date.
>
> $ git rebase --rebase-merges rebase-cousins
> fatal: invalid upstream 'rebase-cousins'
>
> So there is no ambiguity because if an argument to a flag is optional,
> an equals sign is required.

Exactly.

It is not a good excuse that users can express something
unambiguously to the machinery once they know they need to use '=',
when they are so accustomed to giving values to ordinary options
without.  This is why options with optional value is considered a
bad UI element, because the way "--opt val" is interpreted for them
is different from everybody else.  And it burdens the users by
forcing them to _know_ which ones are with optional value.

Since it is an existing UI breakage, as long as the series is not
making it worse or harder to fix in the future, it is fine, though.

