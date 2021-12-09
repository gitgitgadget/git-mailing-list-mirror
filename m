Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006A0C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 22:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbhLIWwy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 17:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbhLIWwx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 17:52:53 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A879EC061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 14:49:19 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso8129199pji.0
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 14:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=f/biRmsQNM5jZ6SAe5kWS+YSFXQVqSJeMqNpmppOaF0=;
        b=c04A/2ILU9hG4K7Ju5xj4dw9w/lNXvKW4yqh1GYTXQWiclDkQEuNabEWd8HV7rkpAa
         ZhXjVzaT352OZHgZz7aThriNq7bju1ieM7UXUNEOVAqyCyLHIvfTBUXUZE7zsgeL+7sH
         5GtEFCVpJt4K2gYkARfASRWhD9p3s5i3N+V7JIOj31B/B0oWJpfpnVXNnsj1/alND16k
         bGNm4U0y4C0t3Ai5N0cNzDt/w+BICrqYSecQntV2x/NGZTxrfM36T/SjkF8LPDak5z6z
         mvAv8z2pQRkN6CSGYjhqgA82DSgyLubtYmmOGplx2AsYCoHFzhhL9ylJipYTKUzA3foQ
         QO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=f/biRmsQNM5jZ6SAe5kWS+YSFXQVqSJeMqNpmppOaF0=;
        b=5xUlfNzPVmPhYAQZbtlqYBnOwAfFmHwg4fr74g/DgO+uOpTvSAJNQCX4yK8hVT5PQJ
         td+r5DCVrOhx28wGdDxF2fCmKasS8ru+Kd+sqUPMB/Nd+4kWbjIhQhBI4JxusnW73ZOY
         Wp+c/ODokOqPb3882+s2zA+fl0FhU45dN2mHYdS/6ZAoNUrxvT8ISUp2rH8oICrxPsJz
         1T2RtCoAafBusogzqf/XN+qiTrUPgIu14IJVMX/2xHOHhQsP7MpUaS9gBnJQeMKgcAIt
         Yo7DkF8YRLqtl3JNZI+eKq4i9N6UwKMx9xvnV58trKaQ4iA0MFxCcOhyBx92a4zF3Nlf
         8djg==
X-Gm-Message-State: AOAM531jGBoJnftdN1QJj1LRCEkS7NBUkVC88aZgH6gHCSU0B1/FIbIq
        oHPZfJBv6Hc6UuwDoueGXjVRLg==
X-Google-Smtp-Source: ABdhPJx/tqhL0TNqK6j5sX9xyM9TuPU/aLvY78G+io7xOzrJ8gsKdAzrJZnVYLlT8G21fN9XBkMFuA==
X-Received: by 2002:a17:90a:2e16:: with SMTP id q22mr19375241pjd.156.1639090158946;
        Thu, 09 Dec 2021 14:49:18 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:f4c9:bc3f:d5d6:ed2e])
        by smtp.gmail.com with ESMTPSA id t13sm703872pfl.98.2021.12.09.14.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 14:49:18 -0800 (PST)
Date:   Thu, 9 Dec 2021 14:49:12 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, emilyshaffer@google.com,
        avarab@gmail.com
Subject: Re: [PATCH v5 1/2] branch: accept multiple upstream branches for
 tracking
Message-ID: <YbKH6CSmfBOsTajW@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        gitster@pobox.com, emilyshaffer@google.com, avarab@gmail.com
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1638859949.git.steadmon@google.com>
 <ba7d557725e70f2ae8f10ae5992c8168eb97f2fc.1638859949.git.steadmon@google.com>
 <kl6lr1amac23.fsf@chooglen-macbookpro.roam.corp.google.com>
 <kl6lo85qabch.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <kl6lo85qabch.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.12.08 16:08, Glen Choo wrote:
> Glen Choo <chooglen@google.com> writes:
> 
> > We print ref_string, which is a strbuf. This causes t/t3200-branch.sh to
> > segfault on my mac + clang, but inconsistently! With -O2, it doesn't
> > always segfault, but the wrong memory is read:
> >
> >   Branch 'my3' set up to track remote branch local from 'Branch '%s' set up to track remote branch %s from '%s'.'.
> 
> I forgot to mention this earlier but in this example, the test *passes*
> even though the stderr message is obviously wrong. I don't see any
> coverage of the help message in t3200, which is a bit worrying to me.
> 
> After this series is done, is it worth adding test coverage of the help
> message?

Yeah, I caught this earlier while reworking this section based on Ævar's
review, but thank you for pointing it out. I'm unsure about checking
formatting of message strings in tests; it would certainly have caught
this bug but it seems that more often they're just "change detectors"
rather than good tests. But I could be swayed if you or others feel it's
important.
