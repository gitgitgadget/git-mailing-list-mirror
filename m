Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C701AC636CC
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 01:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjBNB7k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 20:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBNB7i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 20:59:38 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853C183F2
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 17:59:37 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id r9-20020a17090a2e8900b00233ba727724so295996pjd.1
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 17:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PwuaIY5IdR2EhufBr74cY2Ik5R8Hz8Pm6kG+Y7vAgwQ=;
        b=pZEX/N5xhmXrn2iXSdw+6Wxu7e3Gojm1YZW6W1wa/yWsSBFMkmOD0j5irSv5G5Wrdk
         0WZSQz8I4meGt50M018lpFHGcy99ArNl5rRY9UqdL9rwL8MeUUkyinbEvvJ56qlqvNWK
         oCxtn5GXttsTGnIUForje0LQXHj/RySlnc/aKPdW2n5NqAQkeYlcjpZPxtj418HIxn1p
         Lb/2G/FVO7iNIc+xY3L2G439Azk1JLyYiimiyJe5K+zNZGHrR9IrBeuRk7UGI2CfD65g
         cQdvvMgYhhQvtRdi/pnHogWZkHMROPRkI9zDYDzTOp0E5xMVMi7Tzn14rCX0PgcMwl1H
         VZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PwuaIY5IdR2EhufBr74cY2Ik5R8Hz8Pm6kG+Y7vAgwQ=;
        b=SSs9jD7YPo69jt/rqZwQKtRquTKOtILTHGtzXPByawiHw1oFBmDhO3Fm/Wr3qNKl/h
         YdJYqIbOFjpK5VaL7oqeCvLIu6m53ItJvvxziWICfqcwSYfk9HQsseTHgo4YAhhuCAAx
         RIgfiJ2qwAFmeXbB6zaeggA2N8Zq6FiX6YQmuIfjF/ymHmfWUcAdh0yWRtzZQ3unasbM
         vA26ZXOBb03pLjWEgy2yGesbbdr0WqN8u9F5uI8XTralWRqdGGfqg1NlFHi0XLNKVe6p
         k5ph+iiGmzQpT/r7AxF8IAteFCxxCXFMje071kWAGtgtNobuONWb0++0nLEhne0UgVTj
         i46Q==
X-Gm-Message-State: AO0yUKWdQb1h1a2FAZPptswLwDjiFYvtOQ3ZP273+KgLJSCkThXCyKZG
        zaNeg8XSbfQOgkNDP3IsLcY=
X-Google-Smtp-Source: AK7set9WnUakbl0xdo9ESuqLKjmIe7NFXkHbpvVWfQBDethb99FANziCdQCJTEQFFoHxUGzY9EHm3Q==
X-Received: by 2002:a17:903:1245:b0:19a:9dab:3434 with SMTP id u5-20020a170903124500b0019a9dab3434mr1109012plh.37.1676339976978;
        Mon, 13 Feb 2023 17:59:36 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id ji22-20020a170903325600b0019462aa090bsm5452780plb.284.2023.02.13.17.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 17:59:36 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>, Cheetham <mjcheetham@outlook.com>,
        Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH v3] credential: new attribute password_expiry_utc
References: <pull.1443.v2.git.git.1675244392025.gitgitgadget@gmail.com>
        <pull.1443.v3.git.git.1675545372271.gitgitgadget@gmail.com>
Date:   Mon, 13 Feb 2023 17:59:35 -0800
In-Reply-To: <pull.1443.v3.git.git.1675545372271.gitgitgadget@gmail.com>
        (M. Hickford via GitGitGadget's message of "Sat, 04 Feb 2023 21:16:12
        +0000")
Message-ID: <xmqqmt5h80s8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"M Hickford via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: M Hickford <mirth.hickford@gmail.com>
>
> Some passwords have an expiry date known at generation. This may be
> years away for a personal access token or hours for an OAuth access
> token.
> ...
>  t/t0300-credentials.sh             | 94 ++++++++++++++++++++++++++++++

https://github.com/git/git/actions/runs/4169057114/jobs/7217377625

Other platforms seem to be OK, but Windows test seems to be unhappy
with it when this topic gets merged to 'seen'.
