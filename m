Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2445820899
	for <e@80x24.org>; Thu, 17 Aug 2017 17:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753372AbdHQRkH (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 13:40:07 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:38899 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752664AbdHQRkH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 13:40:07 -0400
Received: by mail-pg0-f45.google.com with SMTP id t80so19746547pgb.5
        for <git@vger.kernel.org>; Thu, 17 Aug 2017 10:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netskope.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6+rnkV9jfvAwGIT18YNuJRxouAybQv3pdqif6xTtsJ8=;
        b=IG9ETUAH0AFoxGmth04sjT7jmM116vipPzzYM4lGRucPz/u8Ao4FkPgGGjjLqHH8DC
         Wr1IuLTa7sDOeQxr0bxSvTec6FG4+g8lT4hhkh1aZ6T+IegMxCNHFTxGYri3EyhOlq/+
         ARLUVcC5in47D2LbLBTO1XVLhSxBLBHZhd3bI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6+rnkV9jfvAwGIT18YNuJRxouAybQv3pdqif6xTtsJ8=;
        b=cfE0FKkUBnOvu7nUcEqcxFsM/gRlXgRpvD+P3FU1M5HL3zzEJQWJwVQNAqHhraRsWI
         cjy++CDji1xciAIzBVwiNHIJPoHPR/TT4M9E44tkn62DRpA9icTSgHIWmo60uqAS9Baf
         c/fjAI6mRZwxHc5GyqELZW9pLwqOZweMQsxrFoevr2Y+M7EbhFNuINx4oTrJ4wUbF1fj
         tdosAWu9LwawACy7mITMs9Vp3NGmya+5x9vP9guWJr0Tt+AqH9J8mYzQjnWAfZZdtw2Y
         sKplAeh124ojlxjSbzdKdModDGUOLMlmht62FJfn1d0iN2E84TU2g1/yjwKYnAZQ+Yor
         G7hA==
X-Gm-Message-State: AHYfb5gvk4mLV2iWIKmz4/s82G/Uhu9V2S+z6k3SYq7gUa3WEdODDlG8
        VSLqgGfGL3e/2xz3
X-Received: by 10.84.143.129 with SMTP id 1mr6508250plz.88.1502991606659;
        Thu, 17 Aug 2017 10:40:06 -0700 (PDT)
Received: from [192.168.65.161] ([216.38.152.90])
        by smtp.gmail.com with ESMTPSA id o18sm2343837pfe.90.2017.08.17.10.40.05
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Aug 2017 10:40:06 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Question about git gc on large text files
From:   Kai Zhang <kai@netskope.com>
In-Reply-To: <20170817173314.qjzii4e4rybqqn34@sigill.intra.peff.net>
Date:   Thu, 17 Aug 2017 10:40:04 -0700
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <9D8F1E07-747B-49CF-B644-B8BDB63E94CE@netskope.com>
References: <60A624DB-CFD1-4A62-A58B-80176F96BA30@netskope.com> <20170817173314.qjzii4e4rybqqn34@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On Aug 17, 2017, at 10:33 AM, Jeff King <peff@peff.net> wrote:
> 
> On Thu, Aug 17, 2017 at 10:28:00AM -0700, Kai Zhang wrote:
> 
>> I have a git repository maintaining one large json file (along with
>> several other small files). With commits for large json file, the
>> repository become bigger and bigger, so I tried to run command "git gc
>> --prune=now --aggressive" to reduce disk usage, then I found .git
>> folder size did not change. I had wonderful experience with git gc
>> against files around 10M to 20M, and I am wondering if there is any
>> configuration need to tweak for large text files?
>> 
>> Here I have more details:
>> 1. Json file size: 1G
> 
> Git won't try to delta-compress anything over 500MB by default. Try:
> 
>  git config core.bigfilethreshold 2G
>  git gc --aggressive
> 
> -Peff

It works! Thank you so much!

Kai
