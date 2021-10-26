Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EA6C433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 22:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C38A60F92
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 22:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239918AbhJZWYO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 18:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbhJZWYN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 18:24:13 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CDBC061570
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 15:21:49 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id f8so546760plo.12
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 15:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+tg0j8IRJ7NXH4yzkIWGmlaYsiHVECVNDw3hO+2aEfk=;
        b=jKlUHDCqkRdyaWVIg1Vex3iMO0Mulh8U0NwfpCBaTejYpukZh26Kkuv0Osh17yJQh3
         26FLnQQo9VzD4bi7G0XIp88uQmLoID9RSnezUqaTM31M6m7WglAZMNDBTx+L8PILr/67
         v/1vf1+yupKxUafHLCF6meq+XIGP8E1m9hnrKQSnrn3vwJ9EN+6HM879wAuUwkya4RnF
         +4LC5IxrKSntuUDn7q64AbmTvBWldyPgVmxSsXKHUj9Xo+jgsqJEMMMCY+NWi3OU5G8K
         +7JOdUvUDOsP6VwHIfW0vUbrb5Kc4hkRbwNa2EvdqxH1jk9N6LeLYKe5KNsWn3F4nNrJ
         gTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+tg0j8IRJ7NXH4yzkIWGmlaYsiHVECVNDw3hO+2aEfk=;
        b=GqmHJO5c2u5OmeWPXRzXENY1Hpm/P6dylFSZmxeEZ7J+EXPY5v5lTN2vSMnwwuN7P0
         K5MmKsdIir7KmlRcqpN1dQf3fMu1gknCdaX+DrzKfLgAv2uh77gdixwcksucOyTx1mjv
         kdl6U8vXV0qP+W9/IalYtlAkCT9vn5qj8K1Dcm6AOnmlvdSEMJLeB/7pBem9dZe46tX+
         PA07e/KedDEkWU6SZ9bmvERYdQwAc1wv+SZhyKFzL1R2bQ4geVGdEp7aAwQDUFQeoOUA
         XDimL7hYqguIoVtRI0bgyCiO2zz0yjVMQSBavTMcsCEet93fkgFu/qNQTwRbEqii+ZpS
         wmEg==
X-Gm-Message-State: AOAM530a4hKdSQyScly9CgnDUe+G52hFwhtVqgdpiN8fLeeZm+kvYcA9
        30bXvApilppupH1dGr15s7V0lrRdtdw=
X-Google-Smtp-Source: ABdhPJxkpRsek+PVatCw/1tsXmr6FzeJcpuheOo1cOk2UhV0anFbTCFZ9l+C1AKTAKNQlTPdJmv8QA==
X-Received: by 2002:a17:90b:1e05:: with SMTP id pg5mr1678651pjb.173.1635286908458;
        Tue, 26 Oct 2021 15:21:48 -0700 (PDT)
Received: from neerajsi-x1.localdomain (c-24-56-226-231.customer.broadstripe.net. [24.56.226.231])
        by smtp.gmail.com with ESMTPSA id np18sm1863614pjb.40.2021.10.26.15.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 15:21:48 -0700 (PDT)
Date:   Tue, 26 Oct 2021 15:21:46 -0700
From:   Neeraj Singh <nksingh85@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: regression in ns/tmp-objdir and ns/batched-fsync
Message-ID: <20211026222146.GA16928@neerajsi-x1.localdomain>
References: <xmqq5ytkzbt7.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5ytkzbt7.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 25, 2021 at 08:48:04PM -0700, Junio C Hamano wrote:
> * ns/tmp-objdir (2021-10-04) 2 commits
>   (merged to 'next' on 2021-10-23 at 358d376f61)
>  + tmp-objdir: disable ref updates when replacing the primary odb
>  + tmp-objdir: new API for creating temporary writable databases
>  (this branch is used by ns/batched-fsync and ns/remerge-diff.)
> 
>  New interface into the tmp-objdir API to help in-core use of the
>  quarantine feature.
> 
>  Will merge to 'master'.
> 

--snip--

> * ns/batched-fsync (2021-10-08) 8 commits
>   (merged to 'next' on 2021-10-25 at e45c907d41)
>  + core.fsyncobjectfiles: performance tests for add and stash
>  + core.fsyncobjectfiles: tests for batch mode
>  + unpack-objects: use the bulk-checkin infrastructure
>  + update-index: use the bulk-checkin infrastructure
>  + core.fsyncobjectfiles: add windows support for batch mode
>  + core.fsyncobjectfiles: batched disk flushes
>  + bulk-checkin: rename 'state' variable and separate 'plugged' boolean
>  + Merge branch 'ns/tmp-objdir' into ns/batched-fsync
>  (this branch uses ns/tmp-objdir.)
> 
>  The "core.fsyncobjectfiles" configuration variable can now be set
>  to "batch" for improved performance.
> 
>  Will merge to 'master'.
> 

Hi Junio,
When DScho enabled batch fsync by default (for all platforms) in the git-for-windows tree, CI caught a regression. It came up through the heavy refactoring to use the tmp-objdir code.

The problem is related to setup_work_tree erasing the tmp_objdir "primary" odb.  Please expect a incremental patch from me shortly against ns/tmp-objdir. It will need to be merged into ns/batched-fsync.

Thanks,
Neeraj
