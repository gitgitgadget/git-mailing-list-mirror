Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD539C05027
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 20:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjATUrC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 15:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjATUrB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 15:47:01 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8558C94C98
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 12:47:00 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso2358162pju.0
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 12:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OE/ZK1dvRBakCDkPM6I32Hl4Uoy65v/hjV0gsiD5dRk=;
        b=p/RpK0oqwUweeI0Y4bdvpBT2z/YzfKpblMnm899M//ncdIWrbabS+LhmQtQTlVUW8W
         2c6xB9jLSsK2q6pZ7TbCmf4I2cD4enyOx11a1LApGzNcnX7jjr5NAnRte/LXmkVZMRa3
         iR1pPwBIlra/k8B04GxEg7yPLTUHxkZdeKFLU7Qvq9VCxSsIgSzD98qwC5O3wriILffg
         sbonVxHMt4YldSlSPhk0f+2qZSv2oZ5MejUcvlT4CXXNUqe6ZctY7xjPutCC4ohUfLDp
         rx1fvhWdGvObYFYFgWH/KcaEgLmDK73IYbNcm5CPOv2UIcJNmJgLK0nrLG8NPdXi1b18
         bu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OE/ZK1dvRBakCDkPM6I32Hl4Uoy65v/hjV0gsiD5dRk=;
        b=8El3UNHH9Y5aOHCIuu75aTnyo3c7sI8AS1rQKjR6OIRBcaCYWkIfkvFbKtUlraUPBv
         RYAS80D3mmfD0tY3AylXEDe8ZYPo2irowUHtk14iYH35u0cNd+1KiRs3Ftbr6xXQAbd4
         vwfhA0baEhx5WcIfsOkbhxwexGwD8Vm1AZ//p4suheBJoEeIntOxgfYmfnfv3CQlA7O/
         j0dJIBC7EryZ97AJDDCsRW5wk73JU8UsCHw4le8VpbwoNxj0SBxzLznFGEodZoIqkIA6
         DQxZj+RuZ5LppEpXyVXE5cOkc9hdaF4YKEXVnjNEC374y3doy/6EMSuJ33hmGDRUTEso
         w+QQ==
X-Gm-Message-State: AFqh2kobfq0Qc94w5vZePBm2X2DTeeLUSkrBhlVpZdmmjJd9/LH8PZoF
        ed0zrJ0zdN5PMP2LppslqtQ=
X-Google-Smtp-Source: AMrXdXuHifAOt7iaJo5dtTeRnpciqlnxYoJZpwPUJ1Fvu6VssrYiYypY/OyHolAGUBQ7EQdkO2UoJQ==
X-Received: by 2002:a17:902:c443:b0:189:129e:92af with SMTP id m3-20020a170902c44300b00189129e92afmr14055709plm.14.1674247619862;
        Fri, 20 Jan 2023 12:46:59 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902784200b0019309be03e7sm27339498pln.66.2023.01.20.12.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 12:46:59 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] Makefile: suppress annotated leaks with certain ASan
 options
References: <b1efe56ab5193d5505ccb9334f7d15e1795c27fb.1674240261.git.me@ttaylorr.com>
        <Y8r2Tn75g52YTIij@coredump.intra.peff.net>
Date:   Fri, 20 Jan 2023 12:46:59 -0800
In-Reply-To: <Y8r2Tn75g52YTIij@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 20 Jan 2023 15:15:10 -0500")
Message-ID: <xmqqmt6dvsqk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I do think there's some complexity here, though.
>
> One problem UNLEAK() is that compile-time switch, but whether ASan does
> leak detection is a run-time choice. So you are stuck with either:
>
>   - you always turn on UNLEAK() for ASan builds, in which case test runs
>     using the default ASAN_OPTIONS we set do the extra work even though
>     they are not doing any leak detection. I doubt it's very measurable,
>     though (it's just shoving a few bytes onto a linked list),
>     especially compared to the overall slowness of ASan.
>
>   - you predicate the build-time choice on ASAN_OPTIONS. But this means
>     that:
>
>       make SANITIZE=address
>       cd t
>       ASAN_OPTIONS=detect_leaks=1 ./t0000-*.sh
>
>     will confusingly fail to use UNLEAK().
>
> Your patch does the second one, but I think the first may be the
> least-bad option.

Thanks, I totally missed the fact that ASAN_OPTIONS was a runtime
thing.  If we were to pursue this topic of enabling UNLEAK() outside
LSan, I agree the first would be necessary.

> But for leak-checking, we've already seen real cases where using LSan
> with higher optimization levels can lead to false positives (because the
> optimizer drops a value that is still in scope but not used in a code
> path that leads to exit()).
> ...
> So it may be that we really do want to keep leak-checking to "-O0
> -fsanitize=leak", and reserve "-O2 -fsanitize=address" for finding
> address bugs.

Yup, we have been burned a few times with this, IIRC.
