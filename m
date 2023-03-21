Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B237DC6FD1D
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 16:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjCUQn4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 12:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjCUQnw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 12:43:52 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4011BFF02
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 09:43:33 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id kc4so2042892plb.10
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 09:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679417013;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vk4qgOCIk8ZvEAND6nvcdB/0ZNyNolN2hq4CXk/ucqE=;
        b=dfJD8yJmIWDLYm2hsMDumeXlNkcUDnB7mbEOjJAiVZGjq4bdbLbJGAKe+m+8Cv7Bnk
         xI0CvMGcI2ghePzjfcnlzv1oZoi8b5KAHfJW/2B57BoKo23sStgr9AQpOxK7N/SpdncX
         ibduRIGVymmlNvMkCCZJQVhq8eep3UXLfoVdofXN2Sahs4i3h2Kurx5bpsh2VQXKG1Al
         7AJ878oMrn+BYZ+pURmEhIIcRIPEA3bXB9LRPz+T+FymJZLZnGP848IsZjX9M1wfDL/1
         5ceiF0IkZpIeLFugscMvCAFtgYFa1AzhAH7Tfc0lA1k77TxJY/+f87nuc6oZJVYieLpW
         BH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679417013;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vk4qgOCIk8ZvEAND6nvcdB/0ZNyNolN2hq4CXk/ucqE=;
        b=Lzysi5qJo40qknIhAJzRO+jNq8dMPBcKpsvWMpve43bII1Qs1pyUBArufSjBdDbUs5
         peGX7Qo5OB7mH63Je8Wt0fLZCk2ixv2BOK+72GdaxeTA8GB4EXjGBjU5uYNJrM91gz84
         6hUu9zNbSsBT2GuA+ClrltHQbvSMvoDNs5+XMRMPrRCwEBrppnEZSxb67x7YJoKbN2TU
         VxBTHD8p/gSQmqgWDdMBmPqXsf0zS6aurJFfutitsqcAzWgef9F4Lhg3QbjtU3rhIl7b
         ZV3J1BVaZR9Claj8OLBiMn7zKupTi9eq7JKv3u3zFyojYwMD90NTclv31ri/50xRSMY4
         X41w==
X-Gm-Message-State: AO0yUKW2zPxGxemiCb9TInAbMUfnJmjHdWL1dNZCL1n3WmA885Zo1FWn
        jItBUT0Hu6ROElvBMB6qYz0=
X-Google-Smtp-Source: AK7set9d9fo8GT5N7UuVPZuYKR7faJV5aeOVZbz8Ndtb/CU5R4nGUimyAb5F1LuWnSiXoDP0SUU8CA==
X-Received: by 2002:a05:6a20:639f:b0:bf:4563:e647 with SMTP id m31-20020a056a20639f00b000bf4563e647mr2407464pzg.40.1679417012570;
        Tue, 21 Mar 2023 09:43:32 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id v7-20020aa78087000000b006254794d5b2sm8656702pff.94.2023.03.21.09.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 09:43:32 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Lundkvist Per <per.lundkvist@saabgroup.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Soundness of signature verification excluding unsigned empty
 merges
References: <27a7d2956ed94d7ea8eb6d17f1414525@saabgroup.com>
Date:   Tue, 21 Mar 2023 09:43:31 -0700
In-Reply-To: <27a7d2956ed94d7ea8eb6d17f1414525@saabgroup.com> (Lundkvist Per's
        message of "Tue, 21 Mar 2023 10:32:01 +0000")
Message-ID: <xmqqmt46jbrg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lundkvist Per <per.lundkvist@saabgroup.com> writes:

> But it seems like if we allow unsigned empty merge commits, i.e. those that
> themselves do not introduce any any other change than what its parents
> introduce, and require all other commits to be properly validated, then we can
> safely validate the whole repository?

Depends on what you are trying to protect against, I would think.

Two tl;dr of it are

 * a merge that does "not introduce any other change than what its
   parents introduce" can still cause harm to the codebase.

 * a merge that introduces other changes may very well be necessary
   to merge two histories.

Each commit signed by known/authorized people is simple.  But what
does it mean for them to sign an individual commit in the first
place?  "I wrote it" is too naive an answer ;-)

A commit that is perfectly good in one context may cause the
codebase to do a totally wrong thing in a different context, so your
sign on the commit itself may assure others that you as the area
expert vouches for the change in its original context, but will that
signature be good enough to hold you responsible for the catastrophe
it may cause by merging the history leading to the commit to a
history that has forked from the original one long ago?
