Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D20C83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 19:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30126206D6
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 19:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="0x8BxnQ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgD2Tuj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 15:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2Tuj (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 15:50:39 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F48BC03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 12:50:38 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z1so1590611pfn.3
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 12:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0uNuRGyfFZxEmq6Tk/ViMAYeXH86G0+desdDJaRXs6k=;
        b=0x8BxnQ9PrODb1Uz/E4Fr4gzKPUZpVm1/Ob+M9EDat3rT4jp2FWlG9TZ1193CDiK9h
         PAZLTgC93lEQdYx9CkhB+G9e+8TNeozcmjflfW4oMDvyTvozvK2Hr3JkuSCLnWnxAm9T
         ms+6Uv3vprTQvwd/aLB+MoJiPEGL4WJAM3wVNELp+6G/1pk31x/yBOsACpjMptA0wg/O
         kjIVKmb4xSkaFryWwSLMB/DZT6MSIOp1icGD5JIKgHaZf8bxu/lWeO6jU9/S5imw+vJZ
         Rcg4jQHekNZRBgZWIzcFUXjQ9gtuGimIoqSfuOAwT6eTgDPcy4BmDtIGDZpPlOebV278
         qVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0uNuRGyfFZxEmq6Tk/ViMAYeXH86G0+desdDJaRXs6k=;
        b=kFbqWcqGFjxXofibyCpMChsZ2U5VOvGfCvjNzZiqYEKIUdKTh0bQGjVTWrLqp4Y4T/
         C5QgWzoLzTHFbOm+isWx2YU/bxvhyXYhYKqlvTkG3C7oS6TGomA8W3xKHTQZPbNVCi9R
         U4FOwQxRSBCraPxwP8QtNG0jqUi3YVqRQcBSJRUpIoPLSOzdBofMsL4sQ8fwbINUhMZq
         817rpc2/sJ84ef57+nC5mKLpetXBG0qK4rmTCKWEGCSpuZue8AWo63WO3SqVmRpPsc3t
         eR/ylAMlan68ZnGAypMlKP1iB3qLpA1twBVI0/Zj9eCts8plJciu6QobkGNjFYykYeXV
         9WTw==
X-Gm-Message-State: AGi0PuYgCv5e20VdlRdsyWFeptfOBwg48+SDUyegqmQ6Lv5bLCVjZ2Yl
        COeVDWfsQhUf5z3CRZyYwuH6Bw==
X-Google-Smtp-Source: APiQypLdoKYX3IqDvp8yBL4j3iF3a2X4aNbioUvdLKzXHoT2CcSCcmshLzmHTzR5KvWz3oKReduTrw==
X-Received: by 2002:aa7:9246:: with SMTP id 6mr32714464pfp.131.1588189837588;
        Wed, 29 Apr 2020 12:50:37 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id t20sm95250pjo.13.2020.04.29.12.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 12:50:36 -0700 (PDT)
Date:   Wed, 29 Apr 2020 13:50:35 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/4] t: replace incorrect test_must_fail usage (part 5)
Message-ID: <20200429195035.GB3920@syl.local>
References: <cover.1588162842.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588162842.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 29, 2020 at 08:22:22AM -0400, Denton Liu wrote:
> The overall scope of these patches is to replace inappropriate uses of
> test_must_fail. IOW, we should only allow test_must_fail to run on `git`
> and `test-tool`. Ultimately, we will conclude by making test_must_fail
> error out on non-git commands. An advance view of the final series can
> be found here[1].

This comment has nothing to do with your series, but I am curious if you
are planning on touching 'test_might_fail' at all. These can be useful
for non-Git commands, too, such as 'test_might_fail umask 022' on
systems that may or may not do something sensible with umask.

Sorry for injecting myself into this thread on an otherwise unrelated
topic.

Thanks,
Taylor
