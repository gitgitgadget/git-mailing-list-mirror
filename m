Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016EFC4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 21:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C554561019
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 21:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbhHKVxR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 17:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbhHKVxR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 17:53:17 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19660C061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 14:52:53 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id q2so4507448plr.11
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 14:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NVcY/qrTnIXVtKIrkIQUTdbpkMqLguQaL40itMfZgOM=;
        b=juiPnDNegmaEy4HIg6a8JQtJ6T3uMvyatuXGkE2m27BHUByMSOUQY+RFImVa2ghPkj
         aa8uXj3q59Oa9V5SZ4zLQ2YRPBUnyEt/1t7mYzRkTp53gnrPvWx+o4oqGh/E2/s4ZAkf
         WdZEUmjmp4kHa5LU06qUdcuQERIRKTldZcKAA1I/xQ8SbsKn5wS2DqEsYtgrudjFdhXE
         /PvBVAzRqJ83XtujIHieVjomIYEAu8OTk1YNi+pB6RlzR32SJpF8LdhMCiHigJ2Q/kuI
         LAsJNBSGExrG5dy7t6+XUvuPrj0VeTe1KtENCaAXILcKTmRi/pe9E6MM2JC1mq0u01Ui
         pDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NVcY/qrTnIXVtKIrkIQUTdbpkMqLguQaL40itMfZgOM=;
        b=aMezXKAfNyUs9pz+vdRPBUzLvsNcpx9jcrBm+pY5oOyBFwMjHTiBYSI9TTArNI2ZTa
         AJjUvkCQ3VezIPhwoB2f6pV7V/SbEwlX69fRpqEHDcwEhiDyVhZIGXIkSWBbZ26ZTREu
         vxw1MG8XD3kXDyJnxcsrVEizC5UXjSO0zAyudiLov9Wkb2QD7afgKYRcpZhxwXOvHUi5
         hN1uEm513UHEXVz5RuNmCXhYJg964AdfsLMcQvaGdAYe5easquZ1hwl3aEiofhOjt1J4
         TCybE4cYp+g+UTwL/Zqmc74qbqY0NETTUPwLcukJpuS+qlYTV9Fi1YnYiGFOBmt9sOoq
         6qxA==
X-Gm-Message-State: AOAM533Xniu4JclCcNDCKUIVbBFT9B6gG+biQ8t7DO0sZVm+Ye6p9R9a
        iagiEHyYBeFDcBVk/09/Fs/KoVtxA3u7vQ==
X-Google-Smtp-Source: ABdhPJxT+Ki05S3/F0Fa/y/AukahN3QJiWrZXVq/lHCVZp1xa1MNBIwkY6jHHjrFBUw+636/smhV2A==
X-Received: by 2002:a17:90b:3014:: with SMTP id hg20mr722850pjb.140.1628718772453;
        Wed, 11 Aug 2021 14:52:52 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:1377:1116:63ab:bf4b])
        by smtp.gmail.com with ESMTPSA id b28sm550677pff.155.2021.08.11.14.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 14:52:51 -0700 (PDT)
Date:   Wed, 11 Aug 2021 14:52:44 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/7] grep: add repository to OID grep sources
Message-ID: <YRRGrKztksYi8of2@google.com>
References: <cover.1628618950.git.jonathantanmy@google.com>
 <b2df2455871dc5c94ec804e9c0ce935c19da335f.1628618950.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2df2455871dc5c94ec804e9c0ce935c19da335f.1628618950.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 10, 2021 at 11:28:44AM -0700, Jonathan Tan wrote:
> 
> Record the repository whenever an OID grep source is created, and teach
> the worker threads to explicitly provide the repository when accessing
> objects.

Since this extra information is not used by this series at all, does it
make sense to only include this patch with the series covering the rest
of your partial-clone-with-submodules work?

 - Emily
