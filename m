Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1ECC433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 20:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4778961439
	for <git@archiver.kernel.org>; Thu, 13 May 2021 20:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbhEMUvL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 16:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbhEMUvK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 16:51:10 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9488AC061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 13:50:00 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 76so26847058qkn.13
        for <git@vger.kernel.org>; Thu, 13 May 2021 13:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ntMvQkQvXHmrWO7uU6x/ypOL/8VBnz8orFRI7hJFYEI=;
        b=QUeZImCrlUIMr+uLe3mZmmu6jSMC9s+Q17DacuawuQE0tfOV44cHmyd5SaG+1Uwo/j
         Hy8rcGvxQn5DT3TDdiwrwLg0WHHTaA1lO3DEpD81GYuJzzLPPXw6IjBQlwuYq0UvygPS
         PXmxfA1qg3f8LbBOYBlsk3HRKDYqeKKur5TBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ntMvQkQvXHmrWO7uU6x/ypOL/8VBnz8orFRI7hJFYEI=;
        b=X6kY6qNMQFb/r0KCMHNTsEkLyOTkEdGiCKt9j+nHZ6Vj67c5l5mxQbB/Li0juMkdXj
         HJ6CZluN1w2nVMG67RJKSLwUCSb0XlD9dAI/SSPd81uXPWPRwbFsGBMmMKG2b3GqNs9/
         A4AmJc1hR+u1qmzuKWBkwqmV8A9jPgIGz44wAAxLl7oTvDMd5XRVTRFNR9cJ3mRBXDJy
         PyY/qKdqpVm10CotEBnRP+CIDlW2cAjLjO5qBYh2gROLylSynEX4BupGaNY3o5ac/A5n
         cdHsaHxU9B9WMJOTISKsW2w/A8b1AUP0Q6t8cFovghF8SJrPnuYWrLIBxE9a1wfQFkvb
         lWjA==
X-Gm-Message-State: AOAM5304M1ZasAnJoE1GRQYLWNEUpkZmUPeUkIDOhI8Spy1EVqniIGRf
        wS+qu775LqIScVvMS9FCQ8ACGcrxoPkfCnBd
X-Google-Smtp-Source: ABdhPJzRAj9UJKUXixuBeUYebboDDumbuyHQWBlk8wnNHSlCLIfA3IqC4cwF+t1DcN7tZJFTNnQPfw==
X-Received: by 2002:a37:8c1:: with SMTP id 184mr40685656qki.345.1620938999737;
        Thu, 13 May 2021 13:49:59 -0700 (PDT)
Received: from meerkat.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id l10sm3549885qtn.28.2021.05.13.13.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 13:49:59 -0700 (PDT)
Date:   Thu, 13 May 2021 16:49:57 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     dwh@linuxprogrammer.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: Is the sha256 object format experimental or not?
Message-ID: <20210513204957.5g76czb5bk3thlep@meerkat.local>
References: <20210508022225.GH3986@localhost>
 <YJcqqYsOerijsxRQ@camp.crustytoothpaste.net>
 <87lf8mu642.fsf@evledraar.gmail.com>
 <YJm23HESQb1Z6h8y@camp.crustytoothpaste.net>
 <20210513202919.GE11882@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210513202919.GE11882@localhost>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 13, 2021 at 01:29:19PM -0700, dwh@linuxprogrammer.org wrote:
> 3. The key material used for identifying contributors needs to move into
>   the repos themselves for many reasons but the most important two
>   reasons are (1) the repo comes with all of the data necessary to
>   verify all of the digital signatures (i.e. solving the PKI problem
>   for a project) and (2) to track the provenance of the public keys and
>   other related data that each contributor uses. If Git repos contain
>   provenance logs that are controlled and maintained by each
>   contributor, those logs can also contain digital signatures over the
>   code of conduct and the developer certificate of origin and other
>   governing documents for a project that are legally binding (i.e.
>   follow eIDAS and other legal digital signature rules). Solving the
>   PKI problem alone makes digitally signing commits infinitely more
>   useful and will drive adoption. Solving the non-repudiable provenance
>   problem is the raison d'être of organizations like the Linux
>   Foundation. I think Git should align itself with where technology is
>   heading on that front.

Dave:

Check out what we're doing as part of patatt and b4:
https://pypi.org/project/patatt/

It takes your keyring-in-git idea and runs with it -- it would be good to have
your input while the project is still young and widely unknown. :)

-K
