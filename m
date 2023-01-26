Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1F7C54EAA
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 22:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjAZWRe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Jan 2023 17:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjAZWRc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2023 17:17:32 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB0D3C2A3
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 14:17:31 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso3131680pjf.1
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 14:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XzIeNjoBr4GGz2V+VqcQ3OUyxzWVRmlzhra99fxA/ws=;
        b=ghR+Etj9vWR+KDTXYCZhEAE+TU3QhGG/h1co0MLB3QolUwCKYOogO44VMTTejKkRq4
         V+s6zqSO+Sa3OMRuwGnaFBLkVhxFdEpeAcaAO3qXrVfSQveGzoYE1rupijh/11NDNEKP
         5VVJ8h7YZnuvyghr6QaMM9euKbjzViuA7tahKh3Prcgr+5d3JZO1cQqDUPTZAO9gxe4N
         9v1hkkj1CkxuXaqAWxTdlxsPx4daOBudJbdfKR9lLF0882ENSeDXc4q0hdoO/3vGHu6i
         rz5n8kxSkHiOT3VYJyMqdiMI6LzPy+O9Z92kx04amTIt6wCRRnJBuWVYqX9ju5mlhLlp
         0Z0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XzIeNjoBr4GGz2V+VqcQ3OUyxzWVRmlzhra99fxA/ws=;
        b=M+5f2Btb7Rq/atwSd70ltWAoQ9Jr6e+k2+NCL8AvZrpLLGWbmghCvsaH61hOdFtaG+
         ma0hJy0V5ek3r4MZOjNZvJwyZshprhRmyq1G40LOvWUJk/bIfP+BvTSRTfmeFx9smX6r
         wHe2UjaR6KzkhCcITah5uOzdESujBxcm0EL1laa66qoQ0U0CpMgP1pHJ3rzo0b5T/OC/
         xILgu5ieRSskjrX+Jr1okQma/nnJX4momSrvbB4GzvyFd1zsqIqdaOikijUpg5CHB3Tm
         kfzcDfxkPHy5h2s8AdxKvCcTY3/zOU1S8DX+0mV/NBdaugBVHxxjFc7gTFU7Hf+ZHs7J
         J14Q==
X-Gm-Message-State: AO0yUKXVIrJbvsg8iHh+7XCQmyd5oUYeDJO6vEdIcCYAxzMIXj5xbt/5
        g4Mp8gQMVDJ5lhgKYbQVwzKjZqj2bn8=
X-Google-Smtp-Source: AK7set9yJ5y08E4synL7tWgYw+WlOA3LdDWZGRBhwG/VP9epBJr9+rg1QNTYmYK7rSBxOxe3anUGhQ==
X-Received: by 2002:a17:90b:3ec2:b0:22b:ed00:1771 with SMTP id rm2-20020a17090b3ec200b0022bed001771mr11950169pjb.35.1674771451361;
        Thu, 26 Jan 2023 14:17:31 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id k11-20020a17090aef0b00b0022bb3ee9b68sm1561032pjz.13.2023.01.26.14.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 14:17:30 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3] attr: fix instructions on how to check attrs
References: <pull.1441.v2.git.git.1674447742078.gitgitgadget@gmail.com>
        <pull.1441.v3.git.git.1674768107941.gitgitgadget@gmail.com>
Date:   Thu, 26 Jan 2023 14:17:30 -0800
In-Reply-To: <pull.1441.v3.git.git.1674768107941.gitgitgadget@gmail.com> (John
        Cai via GitGitGadget's message of "Thu, 26 Jan 2023 21:21:47 +0000")
Message-ID: <xmqq5yctaqkl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     Changes since V2:
>     
>      * updated with adding second argument after rebasing against master

Ahh, thanks for being so careful.  I forgot all about that other
topic changing the function signature.
