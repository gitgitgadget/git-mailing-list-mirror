Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FFAC77B7A
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 05:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjFAFXG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 01:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjFAFXF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 01:23:05 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD1D185
        for <git@vger.kernel.org>; Wed, 31 May 2023 22:23:02 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-53f70f5ef60so362563a12.1
        for <git@vger.kernel.org>; Wed, 31 May 2023 22:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685596982; x=1688188982;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EXSvySnrdy6YZ9YmLm8Z4pi/hHxMv1ObDFRGePty81k=;
        b=i26lCpLUI0/0nOX48trH7c6R18KK+fGjRhEuOBOaJrU/I1ghQs4leEhE9LNeUnhxmr
         qc9kTNpeoaZOsnbxtFUC1YfjLdBTAB6/6YFsDGjTyvZIHfnHLWzXdX46pLC81C9lDcVt
         2qZzvVmL2lE/784g+vMLlD5Af+UpNgzCB3tErKF/fYZCIXOSAEexF/Z+MmA5vFcRKV+E
         oKBTXGv1A1JOAREygC84JY7F1vLqxvXJ7fZ0O3j8vKkw1g7WOo+KAe0sMWL11rkTdL2+
         NKKKytJyQi3V9mWLlSX8poq7phBGvHoQIyEV9poABgTBN5jUVsHp6ZYTW9Arf5aCq3Aa
         iJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685596982; x=1688188982;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EXSvySnrdy6YZ9YmLm8Z4pi/hHxMv1ObDFRGePty81k=;
        b=FGixj5/v86+wgZozpdcPx8KX2GPZnTEuO2MvbayUq9+cqbOkjdqQERWPVz8lBkI4+4
         qJxVv354dvLGHauhjcsEr/GOo1NUZo0CvrdVjsezwtQ37uMUOhp/AsNtoFsnbBZV4nxe
         YlAEsn4qd7YvPjcIPpB8s8gjQ/A5Fao5vgXpmpRDFzUN6woFMpv8zaRUX/81tNqbEMUJ
         tkcsntDn3jLSnp9+Mkc83th9myPnwePWTk58bo2TOaOjbBSVx+kQqIbFL5PO1ZSe3/cH
         WeaFwWo7VnpqHBhYmgKP1PkpurgBaZGIXqexi+zvNVIdBny8z8QGCsyOjNyd6o+LqJYU
         p73A==
X-Gm-Message-State: AC+VfDwTuaPyJyylxDqIaXWK5bZfqvBsBmZGNQXtMyK2akLmXcoxLEKC
        8D8eTjjpjNIw5XPGgQK5O0w=
X-Google-Smtp-Source: ACHHUZ7O9ldY9fY4YCE8Yfpsm7zTkbVCh6bqkeLpmI3/nf7qpeP1v/8KiS8sXBg1OVSS2pKfApTKKg==
X-Received: by 2002:a05:6a20:6a29:b0:101:3c60:6794 with SMTP id p41-20020a056a206a2900b001013c606794mr929880pzk.2.1685596981725;
        Wed, 31 May 2023 22:23:01 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id h24-20020a656398000000b005142206430fsm2057026pgv.36.2023.05.31.22.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 22:23:01 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, me@ttaylorr.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/3] repository: create disable_replace_refs()
References: <pull.1537.git.1685126617.gitgitgadget@gmail.com>
        <56544abc15d1fce6fb4a0946e709470af9225395.1685126618.git.gitgitgadget@gmail.com>
Date:   Thu, 01 Jun 2023 14:23:00 +0900
In-Reply-To: <56544abc15d1fce6fb4a0946e709470af9225395.1685126618.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Fri, 26 May 2023
        18:43:35 +0000")
Message-ID: <xmqq1qiveoy3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> Several builtins depend on being able to disable the replace references
> so we actually operate on each object individually. These currently do
> so by directly mutating the 'read_replace_refs' global.
>
> A future change will move this global into a different place, so it will
> be necessary to change all of these lines. However, we can simplify that
> transition by abstracting the purpose of these global assignments with a
> method call.
>
> We will never scope this to an in-memory repository as we want to make
> sure that we never use replace refs throughout the life of the process
> if this method is called.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---

It will naturally be outside the scope of the series, but this
change will allow us to add a sanity check to make sure that nobody
has read objects that would have been affected by these replace refs
before the disable call was made, which is another reason to welcome
this change.

