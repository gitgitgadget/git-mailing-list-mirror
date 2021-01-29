Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED52C433DB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 01:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0E3764DE2
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 01:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhA2BQR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 20:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbhA2BQD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 20:16:03 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD12C061756
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 17:15:23 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id l27so7348601qki.9
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 17:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p70Xg3mb5cDTq8WfGYzu1qP3CD//A0kSyL59+RAbub8=;
        b=EET6P6vCzqEWHeIM8j8N54jz7a35FdvCSkIAP/uva+toi9M0LZOJb6o/9ox+vWbHWb
         znrgodQRlFxVrqlVcerl+NmRpz8bwJqscu2up7Xj+pkoNdE1lAAUQxEmxVnKUwsy3Nb+
         fqK71o847K1EnZbbeYgOHiyZDcZ8L8ZnB6alV6YY33pRNBrUJPPMBwFm8wKl4FjrQG/D
         cmfQH53kf4CKHOA6oRKBQHQcq6sXl2LQEI9sLsAwmlb8tnmVNJck+yUjyUt0L6xjRmdX
         F4Zbrfei1GZIuSSQBt0UmaXsESdQ+AixGzJtH2axACa5PCQZtfrcdBo4yzHhB/ec/WLg
         TV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p70Xg3mb5cDTq8WfGYzu1qP3CD//A0kSyL59+RAbub8=;
        b=kIJQ7AFWngbi3CuarHchA8Ox4fphDz2/A1223dRAeGN7vqz1MIK7aIUVoyfH6Ik3FD
         Rqc7WiYKbsA0bPUyzrB8FQd95ERP2R09bJeJ+K2EpZK1mVUsODe0mTWWoA0FBYSMUjZ/
         b5F+A00IE1jS0LZKn0zSWMRk4gl5hGnByM8t7HEs/UfnkfSABiWfS34aG+EYqI9a1XAh
         KpO8iS9r0B4EjGDXQfeEkx7SMlEc5/hg5dZ+6+pKyP+0zzYDDKmYq1Gm2/NsCbrsNDbY
         6YYnSewHAXkeWHyqzXU1vlQfEsfkRqzK1bcrOxgu8+ODnJFl5eLLuRS11M0Mhr2b7YVP
         co9A==
X-Gm-Message-State: AOAM531cLPf4UNYUHHBNBqTKN5zIVvrnzonywgfL/mOQn0Ph/1WszK6j
        6o4+S05qmRCoS/u63hRjTASo1g==
X-Google-Smtp-Source: ABdhPJxtAbZN9f0516iyjHvMXNXFG9ptHYFXhhR8nKb14VR3WJCSnlXp7ieqeYjY/4ICBNcWxKOZUg==
X-Received: by 2002:a37:b07:: with SMTP id 7mr2238984qkl.164.1611882922782;
        Thu, 28 Jan 2021 17:15:22 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:5d6b:9c45:5e60:e7b4])
        by smtp.gmail.com with ESMTPSA id v12sm4695127qkg.63.2021.01.28.17.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 17:15:22 -0800 (PST)
Date:   Thu, 28 Jan 2021 20:15:20 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com
Subject: Re: [PATCH v3 03/10] builtin/index-pack.c: allow stripping arbitrary
 extensions
Message-ID: <YBNhqDTG5dEcIbWP@nand.local>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1611617819.git.me@ttaylorr.com>
 <8a3e70454b9bc64fc7a5ff07d47f7fde018e6a3d.1611617820.git.me@ttaylorr.com>
 <YBNWsJBDUpNiRXP4@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBNWsJBDUpNiRXP4@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 28, 2021 at 07:28:32PM -0500, Jeff King wrote:
> On Mon, Jan 25, 2021 at 06:37:22PM -0500, Taylor Blau wrote:
> > Prepare for stripping off suffixes other than '.pack' by making the
> > suffix to strip a parameter of derive_filename(). In order to make this
> > consistent with the "suffix" parameter which does not begin with a ".",
> > an additional check in derive_filename.
>
> Maybe "add" missing from the final line?

Oops, yeah. I'm happy to send a replacement to help with queuing, if the
maintainer thinks that would be helpful.

Thanks,
Taylor
