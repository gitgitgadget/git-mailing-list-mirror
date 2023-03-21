Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A9FC6FD20
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 21:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjCUVJF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 17:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjCUVJE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 17:09:04 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABE41B2F6
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 14:09:04 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso17215866pjb.2
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 14:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679432943;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+wnY7fFoCJWkaMQrpEr0BFoQsAwMWYLx3BkLM9gGbMM=;
        b=bfz8m/YN2SJHwmc1p3JlQY9goNPWLEJBi6n90gtD9KQ+fVW2XVTCBLSc1JPrXW4MF8
         QiykltNDVweBaui8fxnORT4jSq0hxuwFTXGIBvSAcBh/YP6pMN/V/doJaSngImdncfSr
         XRtCN6igWaSuebuoJYHmxCTtzyl+H9a35uXL8v+yR0jX8g1mooPPFiADk0JQDEcO3iaT
         brR3CVIRLCp19zN5uBeYawCwOfC/hyDhGrNXcBgo5zap1k0Si87M0VN8raKfOP4AelD7
         sflzqRSFToFaMHTHY0SpdY+M+XQqFreND735OuIrSsymNvpds1CORJeTezeaa+m2wiP0
         PaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679432943;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+wnY7fFoCJWkaMQrpEr0BFoQsAwMWYLx3BkLM9gGbMM=;
        b=EhMM0diBAzfy7ko1RM5KqezrIxusWF2FSvUwEmXGTNPhmd9FWohxY6cYTcuh4pNi9g
         GX6R1BKhFPckHXyPj1j8fwev4EPYkmAK7iIKURvXHJHK+RinBb4RQJKDaIm1KszQcegc
         0ctg84J1KCGse9otxPLEZ2YIR2SZ4m52F2xGsFjm7yGzu0YL4oQ4LH6d1uoF+Kp66FPu
         N8j51nQjZG3rRaFNZLHUozR2IRDoBsn3GI/H53WWlJY5HbwiUkoW7WXhnCr6U5cr2C5P
         ztE8iKc2OFvlI40qLvpC0Id3qUDADQIGCvyI248B5FJfXyCaItWU3jQ68P1GjDiOUZ/J
         uT2A==
X-Gm-Message-State: AO0yUKVLEVOEfqDFt9ETRoDZrpBT5gYW7gIhaeGwqM05dNEvwTL5Lejv
        XmDvLMTQ7cUKA9YQi3h7aN0=
X-Google-Smtp-Source: AK7set8ZCzCuBDrbZMrxPNFGiaolghqX0WAbcWeV6bPhNpCgqaW9o74PVWncp0BsR2PqAduK03CyOA==
X-Received: by 2002:a17:902:f54c:b0:19c:be57:9c82 with SMTP id h12-20020a170902f54c00b0019cbe579c82mr472569plf.65.1679432943470;
        Tue, 21 Mar 2023 14:09:03 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902f7cd00b0019d1f42b00csm9165795plw.17.2023.03.21.14.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 14:09:03 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Ridil culous <reallyridilculous@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Feature Request: Allow to stash push and pop file modification
 times to avoid rebuilds
References: <CAEg4PiL+Y8yxCpWaQFUswTj1qegT084w9m0rc14Kf1dEWk5G-g@mail.gmail.com>
Date:   Tue, 21 Mar 2023 14:09:02 -0700
In-Reply-To: <CAEg4PiL+Y8yxCpWaQFUswTj1qegT084w9m0rc14Kf1dEWk5G-g@mail.gmail.com>
        (Ridil culous's message of "Tue, 21 Mar 2023 21:46:35 +0100")
Message-ID: <xmqq5yathkwh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ridil culous <reallyridilculous@gmail.com> writes:

> "git stash push"
> later followed by
> "git stash pop"
> does restore files but doesn't restore file modification times.

It is very consistent with everything Git (the version control
system) does to working tree files, e.g. "git restore -- file", "git
switch branch".  Like it or not, build systems that avoids
recomputation of material derived from source files (which are kept
in the version control systems, like Git) often work by comparing
file timestamps.  

Imagine that you had iffy changes in the working tree files, and
then did a build.  The build artifacts are based on the souce with
those iffy changes.  Then you do "stash push" to tentatively remove
the changes.  Perhaps you make a build again.  You want your new
build artifacts to reflect the fact that you no longer have those
iffy changes in the source, so "stash push" should update the file
timestamp when it removes the changes.  Now you would do "stash
pop", because you are convinced that those changes that you earlier
thought were iffy are indeed good ones.

Now what timestamp should "stash pop" give to the working tree files
in this case?  The contents of the file probably is identical to the
timestamp of the working tree files immediately before "stash push"
was run.  If we restore the original timestamp, because it is way
older than the build artifacts of your second build (which was done
after "stash push"), the build artifacts would not be recreated.
The source has those changes (that used to be deemed iffy but now
they are OK), the build artifact does not.

Unless your build system bases its rebuilding decisions on the
contents, not timestamps, it is very much essential not to
artificially muck with the file timestamp when your source control
system rewrites the files in your working tree to avoid broken
builds, I would have to say.
