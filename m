Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7686C61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 19:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjBWTje (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 14:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBWTjd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 14:39:33 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6FC1633A
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 11:39:27 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id n2so806675pfo.12
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 11:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uNcnHvtplhCuOhPqeph2IpkT92jFqmjvqvHXWTXTZIY=;
        b=ZSAYY7NgYEFoZKCNvN3BNcpGeldxsGwn992Pf3JmW3lUbsPoQnhBE2S+3PhgZPTDMN
         0CCQEed17KubaqBNWgMx6u4bXcejvh1FIKXsDpKcIyUI2y4vFWcaniqHcJ9ePfHhdmXH
         WErg2tuDhIahYDMYrvR42bgLnljtM+pIJXb/Nbu0dYiP8Hbi2f+15P/yhha8zs4P1zG0
         AwdAf04b73mjSFr9zDWHdtRsExqYex01fD3UUsjpvdN+rfnLoXuOpqWyE3hygnkZhvlp
         usfBVEP5uGYNDN0zxL3Kq/1pYmz7WIyvjq2WwkaVBBqvibGB0Fgt51JmmhnuBCL3L9U/
         rxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uNcnHvtplhCuOhPqeph2IpkT92jFqmjvqvHXWTXTZIY=;
        b=YW4Q3Uer45FBLpxCsbSDSRwvQYwPqSYf6PteJa3rfdA7sVv19CwDcY/ZDLV+OvS9/J
         1CBX8HHcbhOmGjI3PBjo8q74oR50b6ZXrLQUcaQ52N6MMItv3ES2b/5uBmKRWdy/SyzS
         JqpWXoaDoDLU/CIiA3r8EJ1wSEKlbpbEgWk29EBOCxw+PhjgvzOirto8zkrk+9qN1gaA
         7pggR4wb1ZRgum/mCpqSutqAS7DJWWE4X6Sw2JYQ1cj7oHptPmLEJuyS0DsFicMtvE+c
         nIt6LLwIN5fl0CvbwXEAVHmhfix6igyHD8eVelK5V6EYjlH9GLLLn7HxtSTV/8EwmIeI
         b7NA==
X-Gm-Message-State: AO0yUKViy86R/R80b9JRe89lIFlqloBFliLwGkcOl83/lccS+FQSR5Nt
        7eeC36r6PzoWNuV7r6xEwSg=
X-Google-Smtp-Source: AK7set98+paYurb+nTOZO1vrTt7Q1y0NnYWmD1iCZFwUhhSQIVWFdNIf3VnarVM36F0qtIdV64vvLg==
X-Received: by 2002:a62:7bd8:0:b0:5ab:c004:5fc9 with SMTP id w207-20020a627bd8000000b005abc0045fc9mr11597434pfc.17.1677181166674;
        Thu, 23 Feb 2023 11:39:26 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id q15-20020a62ae0f000000b005a9131b6668sm2446695pff.2.2023.02.23.11.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 11:39:26 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 05/16] alloc.h: move ALLOC_GROW() functions from cache.h
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
        <ec6f2518b9dddbaaaf101b0f87a2db377fef3c6b.1677139522.git.gitgitgadget@gmail.com>
Date:   Thu, 23 Feb 2023 11:39:25 -0800
In-Reply-To: <ec6f2518b9dddbaaaf101b0f87a2db377fef3c6b.1677139522.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Thu, 23 Feb 2023
        08:05:10 +0000")
Message-ID: <xmqqwn486uj6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> This allows us to replace includes of cache.h with includes
> of the much smaller alloc.h in many places.

Yes!  This is a very logical thing to do.  Allocation and
reallocation, especially in the modern world where "memory is tight,
let's unmap some packfiles" no longer happens, does not have to be
very "git" specific operation and should not have to depend on the
rest of "git".  Having to include "cache.h" is one trait I consider
anything is part of the implementation of "git" that has to be
intimate with its internal.
