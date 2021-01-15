Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31565C433E0
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 02:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7BF023AA7
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 02:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732089AbhAOCZD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 21:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732085AbhAOCZC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 21:25:02 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FD1C061757
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 18:24:20 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id f26so10437448qka.0
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 18:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AO+/+7uYI/FhcY+PLfaMCoxJiDiRQ6mJZD5BaxAGzmk=;
        b=1JkXcQYRagbWjkGSyY4HARtrO0+YL4uk2nbhZ+L9hnVU7LzCyscoUEBJMYmcU0dN3q
         qOkjnIo92u44sZCTnYf9h1ISkZRRkSJfBmuFrxg6mzTUT8DBBTrS76+O/bQ2CDJa6f0A
         /EwbCT5669UQ01nA2haoXrmrxB8NOuFM/75Pxg8zFVkzrWbkhOGVdCeGVScsUE4yVGHn
         EOeKaZaCvbsuSN9FlwoE6yXal7ml9TA+nbNSUW8WB5XeqdxUh97pNMzFzZXxkW8sLDoZ
         qk5TQ8SZfvBm6+VpDveOEQjzg463ODR/gxsnaBWQN7aHbcJbSm2eFBlZOx4h7f5fzZ+R
         FtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AO+/+7uYI/FhcY+PLfaMCoxJiDiRQ6mJZD5BaxAGzmk=;
        b=DAMLgI84uMJf0d++WnTV9Gshfg+pcGKG9RKCEl0ilkzbsfzpntad6as+7wU8sHW6L6
         2BROIk4eV0yNAzPlu9XPBg0z5iZpovY8bl+44JfT44erNy8/LwXgS++C0rjWbiNw4Q1X
         dit4w9JS0q715mIzmgCoMvGwPwn6MKs/+ZKcZ0N/w3M2+1oz4pZyfF6AfvKgPK4QRhJL
         C3GX98HUJMtSFxV9feG5i0KqaFv8G40hSpF9GYJRrq/YhkwqqHXnf6i4WEYiGugxCToB
         f7FDWLJKRMF0BFZBnlLK7h3XtiN+c090F2EAvdoh2ZNYPWBHxzdhFP0U1+2d0IJNeCiF
         +0QA==
X-Gm-Message-State: AOAM531M3eakaidY0x+SridyCNxM3zYPR8qjHvCjUV/PEPnq2Cid60jh
        rv6SoBa0sHRkbJyN9G7GR5g45w==
X-Google-Smtp-Source: ABdhPJwENNN3Yam2btc/sRfwa6Y4aZIzurCUjycixxIepOi6ySIzDzmxfGiDdOnzI1DNB2sdMcJiBA==
X-Received: by 2002:a37:50c:: with SMTP id 12mr10038940qkf.296.1610677459932;
        Thu, 14 Jan 2021 18:24:19 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:d2a9:3030:291b:4b4])
        by smtp.gmail.com with ESMTPSA id f10sm4098820qtg.27.2021.01.14.18.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 18:24:19 -0800 (PST)
Date:   Thu, 14 Jan 2021 21:24:17 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: What's cooking in git.git (Jan 2021, #02; Fri, 8)
Message-ID: <YAD80TFOn0EX24wb@nand.local>
References: <xmqqk0sni68g.fsf@gitster.c.googlers.com>
 <YADOf41CcaRuToD7@google.com>
 <xmqqsg73ufxr.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsg73ufxr.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 14, 2021 at 05:50:08PM -0800, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> >  	# start registers the repo
> > -	git config --get --global maintenance.repo "$(pwd)" &&
> > +	pwd >expect &&
> > +	git config --get --global maintenance.repo >actual &&
> > +	test_cmp expect actual &&
>
> > Before this patch, the test said "Is there something configured in
> > maintenance.repo that looks like $PWD?" and after this patch, the test
> > says, "Does the config in maintenance.repo look like $PWD?" - so it is
> > not quite semantically identical but I think may be clearer.
>
> Sounds sensible.  Derrick (CC'ed), thoughts?

I'm not Stolee, but isn't this what 'git config --fixed-value' is for?
ISTM that what is written here (writing the cwd into 'expect', and then
comparing it to the value of maintenance.repo) is correct, but I think
it may be unnecessarily verbose.

I.e., wouldn't the following do the trick?

-	git config --get --global maintenance.repo "$(pwd)" &&
+	git config --get --fixed-value --global maintenance.repo "$(pwd)" &&

Thanks,
Taylor
