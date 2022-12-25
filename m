Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3CAC4332F
	for <git@archiver.kernel.org>; Sun, 25 Dec 2022 12:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiLYMks (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Dec 2022 07:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLYMkq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Dec 2022 07:40:46 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD55FF3
        for <git@vger.kernel.org>; Sun, 25 Dec 2022 04:40:41 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id 17so8860937pll.0
        for <git@vger.kernel.org>; Sun, 25 Dec 2022 04:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ACcjJx2yXBJ85D2PResjMwuQYK9i4I7zdITz6o0gIOY=;
        b=TmkzSi2S/XOTds8EThT7cVXLPI6zqLotyCoUEZgIKu8uR+EanGQn025fxzOfGNxj/F
         9U7URai0eS5wnTxfTPAyrig8MJoJNdMGABOV2yDKFVUFNvBWvxYfuanESfPdbCgo0pRL
         geS+w1iT4Mp+q9ITNqsxI0F2yyssrqP6k+3eD9juvFEi27t4cZIt9gxVlRuFsk6ry4EI
         IouMnOvDbcWnI1FqDPuniZQuvdJg3qIHmkpPHBhpHz3qe7WRjGzLQfKq+y0+4d/hGZhv
         LyKsRlk2rI44dpBgGFhq8557BxKIWOc0R2iIuWVjba3HY+MAWR+0aME1/fQfOjKWKG/p
         YHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ACcjJx2yXBJ85D2PResjMwuQYK9i4I7zdITz6o0gIOY=;
        b=ewP7IsC77oal0YoT6u75oCff9KYDzvtwDh87NlZzR/r7Qp1rLT2ufXRMpc23jLS60/
         5G5ArhYIatWtH8zLjYyM/aY9H6gCWH0Gs3dPqHF4qDYYAADAjJwsmkPee3m1aolwo7M+
         0BBQz8ZGqYY4DzqGLcSZJIPR9YuJWALliDtOoKgIxeKpvtCUzjDTA9jr5XNa2MCshjDF
         v3KLGIHt45czBelyJA4sW0DP73gOxbxYhcey+JcNy2kf27fkHEnO2tLJ31dymzsgIroR
         c/4po7Dfg9qBFd5CyeydqCtinN9XYt304RZo6lzitzlTs0xUJJ6IcGhmrFH6Qaelx/I6
         5aDg==
X-Gm-Message-State: AFqh2kqc0PtyYMomBPhzvSbCzubLhblg/pv3R/G6D0+fN+W8zBW3WSnm
        zyNYLQaIPoD8wUqjY15bSg8=
X-Google-Smtp-Source: AMrXdXsQMLjn/nko/48fypLKYujcRHzguyJLU6J5UEQdBtgxp/Y48EXWXGSG+lgjlK9n7Layz3Q95w==
X-Received: by 2002:a17:903:ca:b0:188:da5c:152b with SMTP id x10-20020a17090300ca00b00188da5c152bmr15687621plc.9.1671972040916;
        Sun, 25 Dec 2022 04:40:40 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f55100b00186cd4a8aedsm5296301plf.252.2022.12.25.04.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 04:40:40 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Rose via GitGitGadget <gitgitgadget@gmail.com>,
        Seija Kijin <doremylover123@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] win32: use _endthreadex to terminate threads, not
 ExitThread
References: <pull.1414.git.git.1671742750504.gitgitgadget@gmail.com>
        <pull.1414.v2.git.git.1671932510529.gitgitgadget@gmail.com>
        <983ce25f-82e1-e20d-ffb5-fd04fa9a9231@kdbg.org>
Date:   Sun, 25 Dec 2022 21:40:40 +0900
In-Reply-To: <983ce25f-82e1-e20d-ffb5-fd04fa9a9231@kdbg.org> (Johannes Sixt's
        message of "Sun, 25 Dec 2022 09:54:22 +0100")
Message-ID: <xmqqedsnodvb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 25.12.22 um 02:41 schrieb Rose via GitGitGadget:
>> From: Seija Kijin <doremylover123@gmail.com>
>>  ...
> Thank you! This patch is now
>
> Acked-by: Johannes Sixt <j6t@kdbg.org>

Thanks.  Will queue.
