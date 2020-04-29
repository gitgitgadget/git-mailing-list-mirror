Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A5EC83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 19:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 305E42064A
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 19:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="nsMRnzix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgD2TAR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 15:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2TAQ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 15:00:16 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDFAC03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 12:00:15 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id v2so1170726plp.9
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 12:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MmEfjkiTVR4RydkYuIPKeJKytqm0YZtDdCyL/0nSA04=;
        b=nsMRnzix26yPQHlX3SgPKg5Fo62ibi5/lp51YEaHq5GmxlCLKtHWC9BRICxWmn+Gk+
         Erv2j6iYv6KGn0TicJgCfRzQo/kR+BpohKL38K0C9lBLLRrXYlj6RIjmJ58zX7EkkRnW
         9M7agLUOMkNJXMvnzJuJ7I6E2ciA5tsTTmUXAtnYqapZj+qCHEVOc+0FpnAVeyarsX7E
         5AueLLqYVDtJXFZTCy5sC64IB9DyGZwHfDbmXf4yZcRlZGQMks5KBYjswYeQe7SDoMX0
         rc9AUu3gGrC6C6k1R69lVdyHG7x+tUwilgtMVoDg7HdLlFJIJw/I7JxmKuN3K408tur1
         oLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MmEfjkiTVR4RydkYuIPKeJKytqm0YZtDdCyL/0nSA04=;
        b=QRtPERcY4oTsEFc47PtyVHgbbeVLuNBac5pvLWcVVFtShfeSgrITpv5HPjPbBVFvKI
         vxC6UwqBe7a6SwH/yTXEmH4ouw0ooexzErMlFPjSAsg7FyVx1fTfew2LwyrrxjcDjZLs
         lHa+YFRyz1uptxigqUCXOWqSF34KEg0Le8Y8ddu1Y3c0WwUJnfNpqPjgTvvB4p0MY6X2
         kVeKBaxgh0sHo6LqZKuZXecy1B1vuPMmXqmhlXHM/E9+u1A/t4zw/AO7NDKA5bG8tra4
         Aq8EzqoeL/sTrUK78wIh3Lk75d17zqxtecvGAE3lKB2vmykChibEDUhIOXyNriFoPPTy
         rBnA==
X-Gm-Message-State: AGi0Pub3k39TiO+Vtq/Su/DiOHqZ4Un1Cj/elOA99vXXSRai07E9D2Wq
        donk9Gsi3BUOQ7ezb7NHXr6eFw==
X-Google-Smtp-Source: APiQypIvNE99o2C71+l4nivyAc3QPpLt/fIrba/QaKJXECKOTRusib/7U+axqUd6W6ubvFCGKXFRyg==
X-Received: by 2002:a17:902:dc84:: with SMTP id n4mr18964389pld.281.1588186815154;
        Wed, 29 Apr 2020 12:00:15 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id i25sm1541626pfo.196.2020.04.29.12.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 12:00:14 -0700 (PDT)
Date:   Wed, 29 Apr 2020 13:00:13 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Ivan Tham <pickfire@riseup.net>, git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] branch: add '-' to delete previous branch
Message-ID: <20200429190013.GG83442@syl.local>
References: <20200429130133.520981-1-pickfire@riseup.net>
 <877dxyo1k8.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877dxyo1k8.fsf@osv.gnss.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 29, 2020 at 04:37:27PM +0300, Sergey Organov wrote:
> Ivan Tham <pickfire@riseup.net> writes:
>
> > Add support to delete previous branch from git checkout/switch to have
> > feature parity with git switch -.
>
> Maybe I'm late on this, but to me, who leaves in the Linux world,
> "a_command -" strongly suggests a_command will read further input
> from stdin.
>
> [...]
>
> > +To delete the previous branch::
> > ++
> > +------------
> > +$ git branch -D -
>
> ... so this suggests that the command, when used like this:
>
> $ echo "branch_name" | git branch -D -
>
> will delete "branch_name" rather than some "previous" branch, whatever
> that means.
>
> Is this short-cut /that/ important to create yet another confusion?

I think that it may be causing more confusion now than it would be after
Ivan's patch. 'git checkout', for example, also treats '-' as a synonym
for '@{-1}'.

In my opinion, it is fairly clear that 'git branch -D -' means "delete
the last branch", and not "delete a list of branches from stdin.

> -- Sergey

Thanks,
Taylor
