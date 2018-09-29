Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D86AD1F453
	for <e@80x24.org>; Sat, 29 Sep 2018 20:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbeI3C4h (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 22:56:37 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55800 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeI3C4h (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 22:56:37 -0400
Received: by mail-wm1-f67.google.com with SMTP id 206-v6so5194839wmb.5
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 13:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wWDXXUmox0UIN9zsy0ImUb8RlO9l8vyZCFdW3jM/JJw=;
        b=q5CKmXL/S6pKi8tIMkzFDROgKDOjomLSCLQ07h697mpXl3csq/Bosw0ClC0U7edwJb
         ri+W5RNbsUsh9M7xMOhARL3vsfBtsbLqWtArPK2ilESBhyZYvXwupc0j40M+DAp7SwKV
         KZz7pI656ymRAy0M+ljMDePNx51q/LYu76K+OH04v9w1mdov9uYHBGQZpznSYXodFQOK
         PFDOSGIeUvSjYUg0/GF/4v43dD3ZyBPbhyiLYpwPEtsBo8CCp9spOMV62cTHP6G9F2Jw
         DYldPOr2+h3Myk0Zsc6tmzQyn02LwRSfcsqQ12a4Yp3pDwPxGrkkkEVpGLI7vtwOVZiy
         0ZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wWDXXUmox0UIN9zsy0ImUb8RlO9l8vyZCFdW3jM/JJw=;
        b=XE9kPSvgCZijoiB/rxbcXFQP4qWBp6YJSyEGxjQJmUZhGHdbiljkInsfI3/MpG/9xp
         jw4syAtUVcuxQXNaTVowl+RPYtk66CT72KVnN+Mf5v2N32Gvh7Zo/zvtf98kUjySw8M1
         7V7lBbpIA+AVTXHNmPaKs0bpkg1ZzLLCGkFEB4LI7fbWpfA7JPYleazutx6MBjKOz1QW
         7pyO0Qnt4XQJerPLftnoLhN+CE8LE1X6ftaQj9Br1HkM7z9IT5ttd3e628gArIm36UNN
         cc9EtqEAjkbuftx+S9vjs2nlJGSRGzwYIqpqjpCnvsJQy6clX61AdXvMqNz5Af4PTLSf
         xOzA==
X-Gm-Message-State: ABuFfohPr89onkOkoyinePXNm/8Qaz5vCynHq4Mwqv86BWDCfbj/a4D8
        /1+kyg9fPlHTGo0mGr5QNLQ=
X-Google-Smtp-Source: ACcGV60pwZB/fXnkf8cDLldkKYUQ+O8ENS5bpdtWLZPMmrndvNWfcgwKsXGqRvIeZPy7/1aylJHsKA==
X-Received: by 2002:a1c:a9d4:: with SMTP id s203-v6mr3217068wme.58.1538252807737;
        Sat, 29 Sep 2018 13:26:47 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k63-v6sm10729044wmd.46.2018.09.29.13.26.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Sep 2018 13:26:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: approximate no_dependents with filter
References: <20180924154516.48704-1-jonathantanmy@google.com>
Date:   Sat, 29 Sep 2018 13:26:46 -0700
In-Reply-To: <20180924154516.48704-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Mon, 24 Sep 2018 08:45:16 -0700")
Message-ID: <xmqqftxs82yh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> This was prompted by a user at $DAY_JOB who had a partial clone
> excluding trees, and had a workflow that only required tree objects (and
> not blobs).
>
> This will hopefully make partial clones excluding trees (with the
> "tree:0" filter) a bit better, in that if an operation requires only
> trees to be inspected, the required download is much smaller.

This seems to break 5520 and 5616 when merged to 'pu'.  

It seems that merging master to md/filter-trees and then applying
this is sufficient to break 5616.
