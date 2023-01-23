Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC3EC25B50
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 18:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbjAWSD4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 13:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233559AbjAWSDy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 13:03:54 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BA4303D7
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 10:03:51 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id jm10so12185490plb.13
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 10:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EtJjdPwr3eeTFkvNEHjatz5cz+4Jwr2LISKv3D/N2Fo=;
        b=dnIYpYexxj/GoLMFNnBqNuriaTDFSxJWM1xfjvvdTZxG1HkPnV+Tpj5QezB+5ESNLe
         HRXIXAx2xrxLjMsAhH59j8h4Hpxsh9kZdr0yW+/oVX+NWNIEAQhvnFH11bvqe0Ew20rD
         DTWeHNKtmzpiN4z+1v+kJ5LdTlULJRjj+xKsae/hAcgK3l4P/NjG7wYh4xoFwEKt7TRi
         r9NynBoDDecz8pmgcpkQUGD9hOEqbQdH1X3E6CHwn6rJl5TVUFql4eNaILPop/hF2Qu6
         tKFNJghJ9GdD1A+QdB+dOiUX09wWRIuDMCZpKdHeLGunfOmmpEDUz3JG5ebNt55KRiFV
         cpbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EtJjdPwr3eeTFkvNEHjatz5cz+4Jwr2LISKv3D/N2Fo=;
        b=G75lvJCmUP0kFUc7BEeFUvpmNF1ed0PqvOTpQR4e45K7nrEAC6pTdiOPkfGqf7ha7K
         YiCei3XN5bkVcFyaMq0MNnxdRrztzjTJz1x+pdXd5rqRnPqZX1b2TDfO40ESte2VJa7+
         6lNIfjS7rq2LOmPLZ+syUE9RHWyTyO75TM07JP5jDTIL/5s1g9/kjUVdbABYLam++zSk
         qvArLEz8QOR/+QowyD5hANdGm3KGpjBLv10owg4FlrPGIfwVuYu+QpbzJX33u0FYfr2u
         Zz2uvexQTjvoMH+FKwf+7hJbroP9WnahGH3M4DYhTzAn1lnlVZdwtydjmrrVdcIWWa2e
         qgWg==
X-Gm-Message-State: AFqh2kr0iZWrCKR9EaCZ6buS1AnQETmhctu3KtZTfX5rsR4SJ6lG8bee
        c871fGc0ApinfsSZ0jAPFa4=
X-Google-Smtp-Source: AMrXdXvHgwR1rOy+jkSGARfkszo51JhW9Gju0C/VNbePCHu/MjbFBkKbv92Sadkgv3vSfDPB87HpDQ==
X-Received: by 2002:a17:902:8c94:b0:192:9d79:d3d6 with SMTP id t20-20020a1709028c9400b001929d79d3d6mr24356082plo.69.1674497030294;
        Mon, 23 Jan 2023 10:03:50 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902c94c00b00189a50d2a3esm19711501pla.241.2023.01.23.10.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 10:03:49 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        avarab@gmail.com, steadmon@google.com, chooglen@google.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 01/10] bundle: optionally skip reachability walk
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
        <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
        <b3828725bc8f8887b9b4777a0e3d84224a427f31.1674487310.git.gitgitgadget@gmail.com>
Date:   Mon, 23 Jan 2023 10:03:49 -0800
In-Reply-To: <b3828725bc8f8887b9b4777a0e3d84224a427f31.1674487310.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 23 Jan 2023
        15:21:41 +0000")
Message-ID: <xmqqsfg1m8l6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> When unbundling a bundle, the verify_bundle() method checks two things
> with regards to the prerequisite commits:
>
>  1. Those commits are in the object store, and
>  2. Those commits are reachable from refs.
>
> During testing of the bundle URI feature, where multiple bundles are
> unbundled in the same process, the ref store did not appear to be
> refreshing with the new refs/bundles/* references added within that
> process. This caused the second half -- the reachability walk -- report
> that some commits were not present, despite actually being present.
>
> One way to attempt to fix this would be to create a way to force-refresh
> the ref state. That would correct this for these cases where the
> refs/bundles/* references have been updated. However, this still is an
> expensive operation in a repository with many references.
>
> Instead, optionally allow callers to skip this portion by instead just
> checking for presence within the object store. Use this when unbundling
> in bundle-uri.c.

This step is new in this round.

I am assuming that this approach is to avoid repeated "now we
unbundled one, let's spend enormous cycles to update the in-core
view of the ref store before processing the next bundle"---instead
we unbundle all, assuming the prerequisites for each and every
bundle are satisfied.

I am OK as long as we check the assumption holds true at the end;
this looks like a good optimization.

