Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD08C7EE23
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 19:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjBXTQP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 14:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjBXTQO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 14:16:14 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415D15505F
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 11:16:13 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id q11so515055plx.5
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 11:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=quTy+HXzGnyWel4oIYD1Kr3iuzprShqNShy6On2Y2WE=;
        b=bmLTZCOi0Y7ggju8AyJuotDeLr+KpTek7rgevCc9YoMDeY7IBkrmyXMOQJh0xfQYy3
         cwOgubUkhI4rrY3sOmm8OPaWSjDIbOAZEkn40MrU/7Gz1RuRYvvEIFuC7DXpNz6S0xFl
         ipg0n4f1iHKS8Pod6cOENxCRPPeem7iUaDalFEZ+Zfx3OUJwE938FCkEJD7wgGMSujKi
         JiP7NKxr7zHWCB7prH/Ufh6LD64EpJtz1TsJJ78UvZ0z1ZwzHjSNT0O1q0+4iHSKrQvR
         iIHXVw2GT1H4/SiTNWhWxGNJf9I9cpjb7Itd57z2vUnuYfHIbBLRhOuwNXlWYtKY6yit
         96ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=quTy+HXzGnyWel4oIYD1Kr3iuzprShqNShy6On2Y2WE=;
        b=OydvMU3pa68QpOZZp1RXN3cgR6znoS68q3+b0M9hjUkYpJ1kZlVaO7L5k9h7n5ocYZ
         ByySDctqDTyrchJQ7wZZHhRy47oUvSmTH2uftYZo18V09UL2b6ehUn1HcY7svhDXdlE3
         JjtvZJS2AzYfLKsqbA4P20sYUiWePQMimkTT5xJ2ON4hZbltKY6VJ7fEecftv4DzXzH7
         kwlJe8BMqcf03yfBVkf5LsxWkf/XGZjMiO3aIkmXhlIi+PcTdmi7iUxHYLi+zqKkMVS8
         bF68kv5Yp4t8U4njCkFJHA0e67avpACGO+v1zP4qg1TxCNBIh4Ly07vx9Aoio52Rny7y
         LiOg==
X-Gm-Message-State: AO0yUKXRPD4Mt98H3GujL0WG5lqWSs3umIHSB9vke2Lsubwctanow62K
        Zuez1bkDpWel5hCeLSQC6jdcDvei4oE=
X-Google-Smtp-Source: AK7set8FucztjVOX39Jvpnr3NBm/+NgJiCgUZr90HX+ajOLHyiYi1FgjB7C8Cl+j0IFC+YosbgeKKQ==
X-Received: by 2002:a17:902:e842:b0:199:2a89:f912 with SMTP id t2-20020a170902e84200b001992a89f912mr22388376plg.20.1677266172557;
        Fri, 24 Feb 2023 11:16:12 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id y17-20020a170902b49100b0019acb14e4absm3913878plr.193.2023.02.24.11.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 11:16:11 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        tao@klerks.biz, newren@gmail.com, phillip.wood123@gmail.com,
        sorganov@gmail.com
Subject: Re: [PATCH v4 1/3] rebase: add documentation and test for
 --no-rebase-merges
References: <20230223053410.644503-1-alexhenrie24@gmail.com>
        <xmqqh6vc9tqy.fsf@gitster.g>
        <f1e8b718-c54e-b228-860c-54d7defd9e7d@gmx.de>
Date:   Fri, 24 Feb 2023 11:16:11 -0800
Message-ID: <xmqqh6vazxfo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 23 Feb 2023, Junio C Hamano wrote:
>
>> Alex Henrie <alexhenrie24@gmail.com> writes:
>>
>> > Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
>> > ---
>>
>> No cover letter to summarize the changes?
>
> A range-diff would have been nice, too, as well as replying-to the
> previous iteration so that they're all within the same email thread.

Yes, especially the threading would help both those who missed
previous iterations and those who reviewed them.  Range-diff is
often helpful when came with a good summary.  Just like a patch
alone without a good proposed log message is not a good way to help
reviewers understand the issue the patch tries to solve, a cover
with range-diff alone only shows what is different from the previous
iteration, but does not say why the changes were made, so it is not
a good substitute for an explanation by author's words.

I may have suggested GGG if the author appeared a total beginner
with the e-mail workflow (and especially if it were a single-patch
topic), but Alex seems to be doing fine otherwise, and also GGG has
its own learning curve (e.g. it is rare to see a good cover letter
with per-iteration summaries, unless the author is one of those
experienced list regulars), so I left it up to Alex to choose how to
reach the desired end result.

Thanks.
