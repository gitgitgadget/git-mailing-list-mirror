Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBB4C77B7C
	for <git@archiver.kernel.org>; Thu, 11 May 2023 18:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238266AbjEKSjQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 14:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238816AbjEKSjI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 14:39:08 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74523A82
        for <git@vger.kernel.org>; Thu, 11 May 2023 11:39:07 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1960e7fe45dso2588844fac.0
        for <git@vger.kernel.org>; Thu, 11 May 2023 11:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683830347; x=1686422347;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2iGGoMXat5jSdkq1Jw1jFtmqTCVw3QpCLL9qiJNobU=;
        b=JQH4T/uv2Y2cLQiGDfuGyLrrShZP56NMQkNoTqnVqWlNd3Fs6ylGBguDhq6Gb3fWZ2
         uqwz0s8JBuBI9q6FV+sfSDLvkXCPyJk7wf6QJk9MeaHtbZ1QF1FbH8jJHR2jvciXHRxi
         1TpRvEowQuE32WmodSAj1bPxe7gd/aX5H3uzwSaiky62IGTrMBr7YV52NiKkbI91tE+b
         TxeqeYtB1oZ4g51UyTCB4amK0IBTAgR/JyDshOaZHC+jHs5Ly0z32j0giC78n2j4MvdW
         fQPTBqJXzs91B6DlrPVsL+4czSyekpKqOns6HiRzqpKkRUm16toLjhXx4EJZNY0xerAE
         EkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683830347; x=1686422347;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C2iGGoMXat5jSdkq1Jw1jFtmqTCVw3QpCLL9qiJNobU=;
        b=J1L0YkIX/4LpkXYw5b17HzXaz3FINHQUFlY8irNJE/q2iIT/EnG7ebrB57KQC/frWU
         pkDybc0I/QiSmbJmhQdh7RlhuOBVuuovnYEr5y2Gcsdq+eHzSkl4cSiNadvSODGAw3Jn
         cE42cZE7fO0kyFeNE2N4j50jKOSlBHMJB1f8p8B4hS3AJCDQX/0Z+EmgPzLKzIh52sij
         F8Y+1Sy2vxVM2uXp2OfcAtfBkBB7FInKvf23VMHaYHSKFBYwqVGwrk+KZQApaWiOtsep
         IPujs6I7BAkrc6OOttOzFpkSEvGxOrIvQHAimN8RREh1y7sA/lMFbPKdK8AAs/qCyBVa
         ibYw==
X-Gm-Message-State: AC+VfDy8Wk9xC57zgRCY2uNjLzR1zwYOR9WhqXSE3hodof0kWmmYPkDl
        MftxIqXKeSED+jDhHeZl+S7HuMOvfIM=
X-Google-Smtp-Source: ACHHUZ7pBvA6X7b+noeHuXbB2XlzjU5Rj0gDb7nBylzTaul2d3b1GNhEtnIlLmdull6xr6WJ2ZItDQ==
X-Received: by 2002:a05:6870:d2a9:b0:187:8008:eb09 with SMTP id d41-20020a056870d2a900b001878008eb09mr11182348oae.58.1683830347042;
        Thu, 11 May 2023 11:39:07 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id f4-20020a056830204400b006a3f4c6f138sm51765otp.36.2023.05.11.11.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 11:39:06 -0700 (PDT)
Date:   Thu, 11 May 2023 12:39:05 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>, Calvin Wan <calvinwan@google.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Message-ID: <645d3649c6c7a_2606922942e@chronos.notmuch>
In-Reply-To: <20230511183143.GA1978320@coredump.intra.peff.net>
References: <44a4027b240289605f4c40b9121ee6615e9759f7.1683431153.git.gitgitgadget@gmail.com>
 <20230511172401.934633-1-calvinwan@google.com>
 <20230511183143.GA1978320@coredump.intra.peff.net>
Subject: Re: [PATCH 23/24] hash-ll, hashmap: move oidhash() to hash-ll
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

>   khash.h lets you instantiate custom hash types that map between two
>   types. These are defined as a struct, as you might expect, and khash
>   typedef's that to kh_foo_t. But it declares the struct anonymously,
>   which doesn't give a name to the struct type itself; there is no
>   "struct kh_foo". This has two small downsides:
> 
>     - when using khash, we declare "kh_foo_t *the_foo".  This is
>       unlike our usual naming style, which is "struct kh_foo *the_foo".
> 
>     - you can't forward-declare a typedef of an unnamed struct type in
>       C. So we might do something like this in a header file:
> 
>          struct kh_foo;
>          struct bar {
>                  struct kh_foo *the_foo;
> 	 };
> 
>       to avoid having to include the header that defines the real
>       kh_foo. But that doesn't work with the typedef'd name. Without the
>       "struct" keyword, the compiler doesn't know we mean that kh_foo is
>       a type.

One of the reasons why Linux doesn't do typedef.

-- 
Felipe Contreras
