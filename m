Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB7EC54FD0
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 07:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68EBB2072D
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 07:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2TcSa8W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgD0HT3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 03:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgD0HT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 03:19:29 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E46CC061A0F
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 00:19:27 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d24so6659892pll.8
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 00:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mqJgyB9GYrYjSvdt8n/Mu1PDd6WP78CI5/mWumdK2XY=;
        b=n2TcSa8Ww1+s3Khlswp52UTzVryyK4uMB1juNXKJuNWkUaVx/0lwPtiHEgYGdZm/hf
         2/G+1mDAwT+vCw6EFPTBalDjAMHKU6pAZ3FhbR/VqKxd3br1xKtTonI3drJiFjB8XbAN
         LAgZsGWTxQr/o0duKDHnbfZXIqczErxHRzpHCx5CHEMaI+WdUOdm05u26WKAJaY76TzN
         sjZxnLx9GSBOT4P74TEgoItn06QGzpN3DegY7n8wa1yZuqjpM+DMBFXkVXn9FSI+rbHD
         +421YMVME+HNH+jmiZdY68Q8nEVb8F9wqDtJVBqG+jCBQ3yPRCaZ+Q5mYniQ8FRxDKOq
         kZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mqJgyB9GYrYjSvdt8n/Mu1PDd6WP78CI5/mWumdK2XY=;
        b=e7HpsJM82u4pSYM8GQ2teNSi+1LFEYRk4lWUexOFaalzz4MViPD+IX+PoNMgZY5k/H
         EZhwiAXIZpsZd8qCn6zsynERKqRSN1zfUC0G+7EAKswADFtrtRRyFWbjaJXOrL9Igi/7
         UDaAybIfRRuNhUvG7+4M6DcgvmiRl5cdrODAn3w9Dumu+WW5HM6AK+bCgxEmMEjoGSt6
         wpZMEeJ+EK8eMj9jqcpVYBoRfLMR0pIUKXzRkHSIuryINKmthbAZAfGOkvdPrdIKv4VQ
         y8ERdN31/F9cftswjQ8Xw6UkGOD2rWwgQhpIvjk0OiwiPokyJFDPMrzb4o/xvO9OvDdo
         VICQ==
X-Gm-Message-State: AGi0PuYFheS8DbmfYJcumCR97/n5MP0MTX8wAc53OXuQglFppyRppGLV
        BMKcfvMh2Ep+pAVZ804wtA0=
X-Google-Smtp-Source: APiQypIMspBHmhvm6K+8B33Gb9M7pKsuPZISQpdeG2Phf+IlZkKWmvo6LBIx6k6uF8D7K7ff8Iki6A==
X-Received: by 2002:a17:90a:b104:: with SMTP id z4mr22547465pjq.115.1587971966651;
        Mon, 27 Apr 2020 00:19:26 -0700 (PDT)
Received: from konoha ([103.37.201.174])
        by smtp.gmail.com with ESMTPSA id b24sm10919251pfi.4.2020.04.27.00.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 00:19:25 -0700 (PDT)
Date:   Mon, 27 Apr 2020 12:49:20 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com
Subject: Re: [RFC][PATCH 0/2] submodule: port 'set-url' from shell to C
Message-ID: <20200427071920.GA23846@konoha>
References: <20200416210456.19122-1-shouryashukla.oo@gmail.com>
 <20200420081902.GA202848@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420081902.GA202848@generichostname>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/04 04:19, Denton Liu wrote:
> > 1. The patch fails test #2 in t7420, i.e., the test to verify the working of 'set-url'
> >    subcommand.
> 
> The 'set-url' command implicitly runs sync once it is changed. I would
> go further than what Christian suggests and just call sync_submodule()
> (in C) at the end of module_set_url().

I have implemented this, yet running the test still gives an error. The
function 'init_pathspec_item' in 'pathspec.c' tends to fail. Going
further deep, the function 'prefix_path_gently' fails. I think this is
happening because of the relative path outside the superproject for
'../newsubmodule' and hence it throws a problem with prefixing.

The exact function responsible here is 'normalize_path_copy' in
'path.c'.

On doing '-i -v' while running the test. The problem comes down to:

fatal: ../newsubmodule: '../newsubmodule' is outside repository at '<path>/git/t/trash directory.t7420-submodule-set-url/super'

What exactly is wrong here and how should this problem
and similar ones (if encountered) be approached? Do we follow
certain procedures when debugging problems at such an intricate level?

Regards,
Shourya Shukla
