Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2991EC433F5
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 21:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbiJFVxI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 17:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiJFVxG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 17:53:06 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445AAFFFAC
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 14:53:05 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 70so2833994pjo.4
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 14:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7I/H3H7m2ZxIw2nK6sqqT1mzrrH95MBDlrNc+wzNN5A=;
        b=B063V8AqxaBJbqKYTs0Yj20Hqp8gVYK6E0T/1cVWRr8Rj0uUqWzDL/dWcYSc8upbNX
         RwpEYNPo5+OR6XGZIwt/7Kk85N22UQyVCDfXu9kRcRe31v8HCLMFPrabfw1ciZg9mHwX
         Oi+wIcXmzvg3567BuYbUjQUfEcwGoZ3HIDQ+0kQZyGErHfhdI/L7xPNA9euTnHrbhevP
         ccwUWP6KbbBz8ep0DpldDabViCi8YXAwQaBRy+L1Ir2WGO/kclfl3v4p/z7XdFyM2VXU
         Ljn/qI/nNya3ctNJ5LMp2taAjHYf5dEPTcL4RnMfcpcPCZP7bMhbBvlB7y844BcHNlC/
         X4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7I/H3H7m2ZxIw2nK6sqqT1mzrrH95MBDlrNc+wzNN5A=;
        b=GKgfpAbQiVwBXvY2xCJlE98F1Q42moYUajWL2R1U16s93VwUEUyK5dimoSAuw4YIGP
         I5o94YgqB1WRT+Ugbq/O4uCTfo7WaxJczKZ06wSv9cWa6kGDRSk1BNQsfMbYK/8YES39
         pLMbsxn6jWHJumUVcVF+mKo65qCxMuSI5NTpafKdEwZ1FkUCDhSbK0RjSUdF7CVCZs9n
         +kX1TnpA6Cq1FL8cNrnOiTLA365KzJ99hfogfbLsv9081A/StGBeQRCppS4gbRDxD06P
         x24dHrepBVEfEneKUd4gQBMn4VbJ1i49YH8fqzFbI9WC4+3R6kOQRqGSS2DP9afESiXQ
         FWMQ==
X-Gm-Message-State: ACrzQf0T2AWmq9VPu0+JaGPEJiTRMXsbZATFsLP0BcFuPT34MiWdRhr1
        lwaThbFUKkOWvW0jJOLwfd4=
X-Google-Smtp-Source: AMsMyM6FufE7nyopsMp9JchsAGHfcRnK6PR+aYPiQmvKLakINwy4h8Xy8bGskReK+xa6SZnUXfVamA==
X-Received: by 2002:a17:90b:4a47:b0:20a:a066:9148 with SMTP id lb7-20020a17090b4a4700b0020aa0669148mr1741467pjb.137.1665093184613;
        Thu, 06 Oct 2022 14:53:04 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id f69-20020a623848000000b0053ae018a91esm85461pfa.173.2022.10.06.14.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 14:53:04 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: PATCH] bisect--helper: plug strvec leak in bisect_start()
References: <5c6a4c30-d454-51b6-ec57-9af036b9c4e0@web.de>
        <221005.8635c2u3k5.gmgdl@evledraar.gmail.com>
        <xmqqy1tunjgp.fsf@gitster.g>
        <221006.86a668r5mf.gmgdl@evledraar.gmail.com>
Date:   Thu, 06 Oct 2022 14:53:03 -0700
In-Reply-To: <221006.86a668r5mf.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 06 Oct 2022 23:35:19 +0200")
Message-ID: <xmqqk05cipq8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>>> The common pattern for run_command_v_opt() callers that don't need a
>>> dynamic list is exactly that.

So, scratching "that don't need a dynamic list", and with ...

> Other prior art, just taking the char[] ones (and not even all of them):
> ...
> 	builtin/merge-index.c:12:37: error: initializer element is not computable at load time [-Werror=pedantic]
> 	   12 |         const char *arguments[] = { pgm, "", "", "", path, "", "", "", NULL };
> 	builtin/remote.c:95:41: error: initializer element is not computable at load time [-Werror=pedantic]
> 	   95 |         const char *argv[] = { "fetch", name, NULL, NULL };
> 	archive.c:408:33: error: initializer element is not computable at load time [-Werror=pedantic]
> 	  408 |         const char *paths[] = { path, NULL };
> 	merge-ort.c:1699:45: error: initializer element is not computable at load time [-Werror=pedantic]
> 	 1699 |                                    "--all", merged_revision, NULL };

... these, I agree that we are not making anything worse.

Thanks.
