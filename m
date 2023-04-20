Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEC2C77B73
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 19:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjDTTnb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 15:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjDTTn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 15:43:27 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8885B83
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 12:43:10 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63b7096e2e4so1317342b3a.2
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 12:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682019790; x=1684611790;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yKw8o7CvH/0UTD/1/4JJOhiZoKpOZOf8Wtd9i5+p6Ro=;
        b=BDJE3qRvgCDn78Fywa4WQl4b8GlAHbjHbv6FcLAxqDuK/j0oxfdH6QcWp8wVSXuIaF
         m+aqEZz5FU8njcboz097HO7o2m93+xfen4DFdCpOBmkq3lDw2OZqXzHBigzffMpF8Nz1
         eCBfmJBriMt67xM7NTdS/dv6YcDJbiuZtQkjGIMzq2aO+4B/6ocCCTOQABE5HPsyXq9a
         Yczr8SnPPxLhCDhkZUSqnyusHYQYX3CgIFE7uQzLQB8AZJk0jBVTgUjtyE4n8h7g3i8l
         gv5QQmfDhHuacI6LkD7g9D1wjlZObd6nt2V2O1+5QyLIY4OOXQb8Er69j925epGfNiz3
         26Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682019790; x=1684611790;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yKw8o7CvH/0UTD/1/4JJOhiZoKpOZOf8Wtd9i5+p6Ro=;
        b=g7l2hRj5nLPuFWLSjNeaFe0V3lSG9pDiRZrHZFSfXpYkJcTgg7Bl4npZwoqRIp+GTM
         xhlDQP0a9xSlGG0mv+lPESC4T6Y9U19+ZLjeBipaz9qDax+BAqY8uxbQInav8vNe5Fiv
         E4xn1c90Qs4lTZiHQq/XdfE0GrYWivZ2M5mkUnbbsFbXHjhIhZyKI5ZET5O3YFOeqZy0
         7/cJYs8oZBjaWJtbvh/Jv3IW//+CcugRANHZm3/fZC/m10+cmFkRqAchw5WV7xAILU5c
         62u6sItH/dn4BcL///SbhKe/HmuyiChI8JM1UYZn1fX88fyAcW/PRsBF446k8CLZcZsf
         SxAQ==
X-Gm-Message-State: AAQBX9cyPiXwzidY9bQ88EtSmrJ1sXo2s3b4iQcWHQjDt4G/SBhmCjzb
        kT1kj6PyWmq6Il5KhGg7Dd8=
X-Google-Smtp-Source: AKy350ZpV4plF1DYQmTMnLH5Xn6LLE2ZCZR6n3sEdiuCc2EUVDSYqlHU1ehasFhrcWO8+iRbRn55Zg==
X-Received: by 2002:a17:90b:fd5:b0:23f:6d4e:72b3 with SMTP id gd21-20020a17090b0fd500b0023f6d4e72b3mr2437846pjb.25.1682019786729;
        Thu, 20 Apr 2023 12:43:06 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id n2-20020a17090a4e0200b00246774a9addsm3225771pjh.48.2023.04.20.12.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 12:43:06 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ricky Davidson via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ricky Davidson <Ricky.Davidson@hii-tsd.com>
Subject: Re: [PATCH v2] http: document sslcert and sslkey types and extend
 to proxy
References: <pull.1520.git.1682013104508.gitgitgadget@gmail.com>
        <pull.1520.v2.git.1682014322604.gitgitgadget@gmail.com>
Date:   Thu, 20 Apr 2023 12:43:06 -0700
In-Reply-To: <pull.1520.v2.git.1682014322604.gitgitgadget@gmail.com> (Ricky
        Davidson via GitGitGadget's message of "Thu, 20 Apr 2023 18:12:02
        +0000")
Message-ID: <xmqq7cu6z6et.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ricky Davidson via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Ricky Davidson <Ricky.Davidson@hii-tsd.com>

I think it is the first time we see your patches around here.
Welcome to Git developer community.

> 0a01d41 added http.sslCertType and http.sslKeyType, but:
>
> 1. does not document the feature.
> 2. does not apply to SSL proxy equivalents.

The above description would read better to have "it" to serve as the
subject for the two sentences that point out rooms for improvement
of what the earlier commit did somewhere.  Perhaps between "but" and
the colon after it, e.g. "X did Y, but it: (1) did not do W, and (2)
did not do Z."  Alternatively, "X did Y, but: (1) it did not do
W. (2) it did not do Z." would also work.

The way we refer to an existing commit is:

	0a01d41e (http: add support for different sslcert and sslkey
	types., 2023-03-20) added ...

Running "git show --pretty=reference -s $commit" would give you a
properly formatted reference.

> Documents http.sslCertType and http.sslKeyType. Implements
> http.proxySSLCertType. Same for http.sslKeyType and
> http.proxySSLKeyType equivalents and related environment
> variables.

After explaining the status quo and talking about what we want to
improve, we write what we wanted the code to become with this patch
in imperative mood, as if we are giving an order to "become like
so", instead of third-person present tense.

I.e. something like "Document X and Y, and implement W and Z for
completeness.  Do the same for A and B."

Other than that, well-written in an understandable way.  Very nice.

>  Documentation/config/http.txt | 24 ++++++++++++++++++++++++
>  http.c                        | 12 ++++++++++++
>  2 files changed, 36 insertions(+)

I wonder if we can add some tests for the feature, though.

Thanks.
