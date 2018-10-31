Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 700291F453
	for <e@80x24.org>; Wed, 31 Oct 2018 17:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbeKACiH (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 22:38:07 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:55273 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729909AbeKACiG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 22:38:06 -0400
Received: by mail-it1-f196.google.com with SMTP id d6so13869320itl.4
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 10:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aKoCj39J6MjkHw+BN2uGSTlGcL6mGRC14CQ77UMvfCY=;
        b=lU3/yHACgcNOMiTfHVWPy4z+UUkl54KbVCjBzqXxeu75JjNgBEpjAsF4teHo/hc+Be
         Fsp8ppnA9detiZW7aWkLP/cNx/dHFYFLQjWc1N9fr4SvX/QUW7lDFxM3D96Xd0G2gL/h
         QX09bRwaqTut4In7sb8rI2ofyW0eBxwA6qDjeBRuzWv482g7RsDthWYhCrNSRBsP7/cq
         cq3UR/fANdhvbH2KcLnK9ITtUwSAlUH72jfDDefTwWsZ6UPpvpMsTKfh4WQZ8UYTgqb2
         2kvQapKHGRzKnVhB8Ea0NYOXsmXrnEgO+Zp1s9wXhIVI+OgXW1bgUTVSja1pT7plv6JG
         xlvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=aKoCj39J6MjkHw+BN2uGSTlGcL6mGRC14CQ77UMvfCY=;
        b=sGVdgu0GHllEZsev0ThiCWeVdM8dV5L8GfGPBmuURe/KJTp66WG0OgDtpoh/yWIJzX
         pSlk3tGmB2Qm8BA53B8fPwcZMI7ZGodng7kH4i47nJQ9Fc21aeSQXgxZ+TrucFvDO+Zk
         a9nnEqZVk69pmquw9vw3iW+u7v2KkCXpdVbuGlEEq92yuHE7ab7ujJqBOx9KoQ6TMSSy
         jz7oRb8jrQSj7BckT+9WXq0iWrROlcSTKa2pPW5FufGRVhNEwpzPmZYB3rklTeVqL10B
         UY3w8Pv7R3I0Gi4xaPAI81BZ5eytO/tW/GaTm4ekgTF9eakXfBSwRhZk71Zr07gJ4xC3
         /nDw==
X-Gm-Message-State: AGRZ1gK5hxQr5WRZkR8MbNswYgAGWHf7aAdYvd2Wxq6HcrwkNy29gPTa
        D83XXATyVnbnBgRk5RKXm/M=
X-Google-Smtp-Source: AJdET5fgxf67g15Sf+DINti22SXVErtGKkzUNQtLSjpD8L9fCQftarDDlNAwYrs4CZBEryxJSwmBKw==
X-Received: by 2002:a24:954:: with SMTP id 81-v6mr2920549itm.146.1541007546984;
        Wed, 31 Oct 2018 10:39:06 -0700 (PDT)
Received: from flurp.local (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id k15-v6sm9187501itk.8.2018.10.31.10.39.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 10:39:06 -0700 (PDT)
Date:   Wed, 31 Oct 2018 13:38:59 -0400
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        John Szakmeister <john@szakmeister.net>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH 3/3] cat-file: handle streaming failures consistently
Message-ID: <20181031173859.GA717@flurp.local>
References: <20181030231232.GA6141@sigill.intra.peff.net>
 <20181030232337.GC32038@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030232337.GC32038@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 30, 2018 at 07:23:38PM -0400, Jeff King wrote:
> There are three ways to convince cat-file to stream a blob:
> 
>   - cat-file -p $blob
> 
>   - cat-file blob $blob
> 
>   - echo $batch | cat-file --batch
> 
> In the first two, we simply exit with the error code of
> streaw_blob_to_fd(). That means that an error will cause us

Your "m" got confused and ended up upside-down.

> to exit with "-1" (which we try to avoid) without printing
> any kind of error message (which is confusing to the user).
> 
> Instead, let's match the third case, which calls die() on an
> error. Unfortunately we cannot be more specific, as
> stream_blob_to_fd() does not tell us whether the problem was
> on reading (e.g., a corrupt object) or on writing (e.g.,
> ENOSPC). That might be an opportunity for future work, but
> for now we will at least exit with a sane message and exit
> code.
> 
> Signed-off-by: Jeff King <peff@peff.net>
