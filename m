Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4BFC76196
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 18:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239704AbjDFSHT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 14:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjDFSHS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 14:07:18 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33ED22D43
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 11:07:14 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ml21so16036804pjb.4
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 11:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680804433; x=1683396433;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4JQsKk0LIo5Xs8thIzzkQgY4gL//P3W7jdCwoFhofc=;
        b=HxVbLOtBEqYFXIfN4LUE0JKs6I6q6KLRNELltmjiXdZ4yqUAnxBIjKUiQAYDkYhCmO
         LXjAN+IEpUwbmEhJCEbxLUanbjDH6hVsk5o9fUFdloYdIn7P1gab+D0W+lHiPxOp7aFS
         peqx8GlgkfqL3SN06BJ7cCkL7Ee2EtfSOMIXg4Ppyu9FGz2shCShNMVdHBjPjsQVmbAb
         KdITXSVQ9qzod6loBrPPO+5wXK5hsULGLH9tNdY3WMwjs/z8m5hJc/OhlKzGQFxcTyzN
         VzhZ5uvmJu9rtMzqIwDXdHPV9P4gsOhYs7rpI1RYGhqe73P/aARZsiQF4K+W8KE1j18U
         cV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680804433; x=1683396433;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4JQsKk0LIo5Xs8thIzzkQgY4gL//P3W7jdCwoFhofc=;
        b=UTuHwklnF3C3BuymdGfhqMkTup6doFGqKx35RJ7Majhlj4xIyLh90J135yj8/7jfyt
         qaru29gIzd+gFss+1ZJQZfr4gWXjT+ZaQ2i4gENUgEK/Cf+wf7M4ATpkNw5Z93ZGiSNO
         lqrht6vFpG2G1luZIauw6oo1/KVSXKjypdp8GPRjjL2LLYzkDYfRwBBP2iCkqwyr1ByC
         MT5I9Aw0q9TOyYmBH0nzQGFW+pxZeldFjUQLm0pGWm7SG2Ldloc3XMzZuCFvxQjeKtlI
         IL8Sv+flEVM3L7PL+t6+2lG0WsmS6Dg+ZrUF44hIxCDyUyRW9JkRAYPb5E+QAHwTc0VW
         KSpQ==
X-Gm-Message-State: AAQBX9cofDkUWb+9fash0+bBTlapJ4DppfoeF4dA/upeRDdgkErBAsI0
        RFSoEaMiuzCZV27Jzp/4TYw=
X-Google-Smtp-Source: AKy350awldSFsqVwsbufj6iBk3aEFexXo7WGVJOOyAKE+7w+8Pgwx+8/7LpwVJOiCigwKI1gq0s5Nw==
X-Received: by 2002:a17:902:ec84:b0:1a2:8924:225d with SMTP id x4-20020a170902ec8400b001a28924225dmr8125plg.47.1680804433383;
        Thu, 06 Apr 2023 11:07:13 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id v8-20020a1709028d8800b001a217a7a11csm1667440plo.131.2023.04.06.11.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 11:07:12 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] branch, for-each-ref: add option to omit empty lines
References: <20230330112133.4437-1-oystwa@gmail.com>
        <20230330112133.4437-3-oystwa@gmail.com>
        <44e7ac0f-2fd9-fd01-89da-a8d036d2e400@dunelm.org.uk>
        <xmqqjzywg7sg.fsf@gitster.g>
        <CAFaJEqtxNa+fuuKzkKPLkF3qdYwZUj+tMKXB3u2ok6H008vjHA@mail.gmail.com>
Date:   Thu, 06 Apr 2023 11:07:12 -0700
In-Reply-To: <CAFaJEqtxNa+fuuKzkKPLkF3qdYwZUj+tMKXB3u2ok6H008vjHA@mail.gmail.com>
        (=?utf-8?Q?=22=C3=98ystein?= Walle"'s message of "Thu, 6 Apr 2023 18:55:52
 +0200")
Message-ID: <xmqqv8i8q3zj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Øystein Walle <oystwa@gmail.com> writes:

>> It however theoretically can break an existing use case where the
>> user correlates the output with a list of refs they externally
>> prepared (e.g. "for-each-ref --format... a b c" shows "A", "", and
>> "C", and the user knows "b" produced "").  I do not know how likely
>> such users complain, though, and if there is nobody who relies on
>> the current behaviour, surely "unconditionally omit" is a very
>> tempting approach to take.
>>
>> Thanks.
>
> I actually instinctively expected for-each-ref to suppress empty lines, at
> least by default. I don't see a good reason for them, except for something
> along the lines of what you said.

That makes two of us ;-)

> We can of course make it a config option along with the flag, then after some
> time flip the default, and perhaps ultimately remove the config option again.

Yeah, but this v2 is not starting with purely a new feature without
breaking anybody, so we can stop here for now, and once there is
enough interest to go through the deprecation dance, we can do that
as a separate series later.

Thanks.
