Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B169C77B75
	for <git@archiver.kernel.org>; Mon,  8 May 2023 14:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbjEHO6Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 10:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjEHO6O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 10:58:14 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4296749F1
        for <git@vger.kernel.org>; Mon,  8 May 2023 07:58:13 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1aafa03f541so45606265ad.0
        for <git@vger.kernel.org>; Mon, 08 May 2023 07:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683557892; x=1686149892;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TdoMdbpp1bemqQMZNANnCAJ6TimT0blODZw2AUpRk/E=;
        b=LnxUi3NnbIe+2f/YBY/g++OmxyTKqzJBzLkF2kQPH9c7SRWfHNNpNsk3OL3GUyjsbn
         B+QeBnCyWTJ1FvB8Z1i1Mwjaql9m82zc1b7qdoT4SZnIkxphRxP6N6dROsn27ahudaCF
         Tly0MQoDvKVUZ7mQKGYf5Xg8lnf36B+kSWqIePNad9tCUA1uriSND8saRoTLS5NP2Sva
         MKxVWu6rjbJkBq1B7wicP3aiN1KP7wNX/MuvTLJ4EHVbnnucsg5CqA4h2MFoaVKyH496
         KfF1QIlCkKGlafgCI7UquaB6AQVNgxtOSVy/t11BDjG2DTXyqCPSdtpr5AI45U4CsIyX
         jMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683557892; x=1686149892;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TdoMdbpp1bemqQMZNANnCAJ6TimT0blODZw2AUpRk/E=;
        b=h/6POCVlcZt5w3Mn5MMuSdtvUeHwzeeyx4DCBDyn1I2DWMGq3q4X3r8DyBG6MetHqq
         B4javI8uGHvyptyicAxHlJMEOR9TuWyWQrlb4aCLN59uw5QGIHIJkBTLSgW0atW5Xwf6
         f+FdFVNjQwXdd/QWMqW82F2yaEVqA2KPpyrjjpXGmX4/lMpV1WWkKl6RV8pH6z7bUh35
         wN4U3DK66Oi8OMaHHY9r0L5LQQZfZjYEZsz6s1DUwco7livN5ZL+2nPzkVXh735Wqhy/
         evmjlSimksjf2LDl3qLI5Shaxt4QXieHbHR/z5vZXAAkafEx/vn2k39dPKX1GIfW4KAH
         P9lw==
X-Gm-Message-State: AC+VfDwtyqBEmuvs1T90yRVMpgCS64KQ6znEJnDpgVj9OXMP5X+ogeHI
        mSXlKViJNwJblLyhBHjAmzBwC84UfRY=
X-Google-Smtp-Source: ACHHUZ7ZVVG3OMSDpJ6Ual04xVgdv9WbUBdUZpr0GSYIRChN9RBNQYT7Mb4lim/KIKQTfmBsX6/bbw==
X-Received: by 2002:a17:902:6b49:b0:1aa:d235:6dce with SMTP id g9-20020a1709026b4900b001aad2356dcemr8828997plt.12.1683557892449;
        Mon, 08 May 2023 07:58:12 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902704800b001ab06958770sm3409049plt.161.2023.05.08.07.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 07:58:11 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Josh Soref <jsoref@gmail.com>
Subject: Re: [PATCH] subtree: support long global flags
References: <pull.1514.git.1683428988693.gitgitgadget@gmail.com>
Date:   Mon, 08 May 2023 07:58:11 -0700
In-Reply-To: <pull.1514.git.1683428988693.gitgitgadget@gmail.com> (Josh Soref
        via GitGitGadget's message of "Sun, 07 May 2023 03:09:48 +0000")
Message-ID: <xmqq4jomswe4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Josh Soref via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Josh Soref <jsoref@gmail.com>
>
> The documentation at e75d1da38a claimed support, but it was never present
>
> Signed-off-by: Josh Soref <jsoref@gmail.com>
> ---
>     subtree: support long global flags
>     
>     The documentation at e75d1da38a claimed support, but it was never
>     present

Sounds like a good thing to do.  Will queue.



>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1514%2Fjsoref%2Fsubtree-global-flags-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1514/jsoref/subtree-global-flags-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1514
>
>  contrib/subtree/git-subtree.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index 10c9c87839a..7db4c45676d 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -34,8 +34,8 @@ git subtree pull  --prefix=<prefix> <repository> <ref>
>  git subtree push  --prefix=<prefix> <repository> <refspec>
>  --
>  h,help        show the help
> -q             quiet
> -d             show debug messages
> +q,quiet       quiet
> +d,debug       show debug messages
>  P,prefix=     the name of the subdir to split out
>   options for 'split' (also: 'push')
>  annotate=     add a prefix to commit message of new commits
>
> base-commit: 9857273be005833c71e2d16ba48e193113e12276
