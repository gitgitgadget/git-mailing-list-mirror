Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73ABFC7EE29
	for <git@archiver.kernel.org>; Sat,  3 Jun 2023 01:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236923AbjFCBpC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 21:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjFCBpB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 21:45:01 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F285E42
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 18:45:00 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3980f2df1e7so2243464b6e.1
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 18:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685756699; x=1688348699;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qdXN/YI+pcW4bgWkG/vz/eY1UBYF2mpyPu8wc/D3Lsg=;
        b=CQxWWq3eZq9j3LaAqdUtwYwVak+eF/tnDf9OXdrxLo8RB3nVV5EgLbyWOCnks/GBXI
         imiSehNgkPsgs8jeQ5WmsCYCbRe4bn2abcvjcClDxgLodYQnQDoIZBwRSh+ftKxeYqpM
         TeSwNHNYf4XNLhLfKAQAkaJlf9TDXEhby3ZZgPt/lptNmx9EBEMDq7yyHJxkcr4hDh9U
         5prG3A5U9b9xRxzIugPUYdCf4wNrUycxIdQOtdXlocx1Win7j6MtxcV4HWqxYJKvrvIB
         q3LMC6Hsh7/liz3SVrDk5W/PrLv/+1E+WDolguG7l9wCbOukXFNR+SlvmLod8NsZ6xR4
         O/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685756699; x=1688348699;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qdXN/YI+pcW4bgWkG/vz/eY1UBYF2mpyPu8wc/D3Lsg=;
        b=HdWaq+owE6yCsLUNDwBPhg8E+mPdIUKcyaLhjBjpDWDGMxMdkz+ikL56J5X+ouh0Nr
         gGmhU649ahbR12QyYFVCfC/Yap7ANJvhmm0c5XX49odhk8tWnJdBsso3eQDvCjkAyVxt
         ZkjEt2eQDNb8o4fPxgX9fUBRYVXGspjNrI+dY9fHaMgABFAZyDOhFF6VYlnktSlvslKx
         gOoYeUmN0Mb1Rl6giOpvVmzdpdYYZQZRRS7trVtWXHr/kqrz4KnF004DDPI2MTHbbdHY
         xjZuxwEjjYJfuIIw3Q/Usgu0tvntZD7zS1EVcaSDxOwBf+PPY4NPRC1V7s76bG3w0Ee5
         kNpw==
X-Gm-Message-State: AC+VfDxkBUYIHdSWR4peb7ky09VGqHZ9SVLtAkshJDYoFwfEhgWYjtM9
        bSmS0FFKGt4sakSmloXQIlA=
X-Google-Smtp-Source: ACHHUZ6O7tBx9dH4t0DawD4EICdssqC6MlGsdPbbArlWvBZjEEli5BJ0L2rWV3M6c9kS7kGPv7QHBA==
X-Received: by 2002:a05:6808:428b:b0:398:6d:4900 with SMTP id dq11-20020a056808428b00b00398006d4900mr1685113oib.24.1685756699440;
        Fri, 02 Jun 2023 18:44:59 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001ac94b33ab1sm1944809pli.304.2023.06.02.18.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 18:44:59 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Toon Claes <toon@iotcl.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 0/5] cat-file: introduce NUL-terminated output format
References: <cover.1685710884.git.ps@pks.im>
Date:   Sat, 03 Jun 2023 10:44:58 +0900
In-Reply-To: <cover.1685710884.git.ps@pks.im> (Patrick Steinhardt's message of
        "Fri, 2 Jun 2023 15:02:26 +0200")
Message-ID: <xmqqmt1h7205.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> Note that Toon has sent a patch series for this issue to address the
> same issue, see the thread starting at [1]. I've collaborated with him
> internally at GitLab to arrive at this new patch series which thus
> effectively supersedes the patches he has sent. The approach is also
> different: while his patches start quoting the output, the approach
> chosen by my series only changes the lines to be NUL terminated. This
> should make it easier to use for scripted purposes compared to having to
> de-quote the input.

OK.  Will try to drop the other topic and queue this one instead.

Thanks.
