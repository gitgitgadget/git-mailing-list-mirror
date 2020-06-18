Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78CEC433DF
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 08:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2278208DB
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 08:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7wYNHMA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgFRISf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 04:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbgFRIS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 04:18:26 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF816C06174E
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 01:18:24 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id o26so4204891edq.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 01:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vh9z5aO/AkeaQzYrOZ+wJuGztpD7Vf2ol+3Q5uQ/wdE=;
        b=K7wYNHMAqOl83L+v1+LEJPAYU3iaDQmd5YNWgdrK/1ke5nL6QqXOB79J1EQPXkwyjd
         Eu4qtahwhoh5DdERlytBvUeeZ1HUCTaNsFlNaKXBplKhb10BrzJWy6+m918l80R7opSS
         q+KkKECgPVim+KZcHWdUlhjJvley9sjS8Fzc5tmtg2WAF1mEp1RZlXaxzRNXESadSZh5
         3nv9qjxL6WslkB1GKzrONwxGtidEbqSvjnqr3HsDcniOBiAcP63ASUFMJfL8c5SA6xp2
         P/L/47OAs1pHnC9wDxOSH4pXvpDzTJWx1kIz3Pio3HJ73/bDOpsoD1Ca9NR4W8khF4tf
         hq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vh9z5aO/AkeaQzYrOZ+wJuGztpD7Vf2ol+3Q5uQ/wdE=;
        b=azfPfjLSf2dts7PBFqYsWSAf6GQxOnSPcic2wQmNXBlloxS9CarUf6XEcn/XDRXyVr
         ZJ0mYK70s3nfxJUbFERsRYi2fM1dp/wq1eJzFaQF3zwLVAs/v8TRhPOdctimz/NRc/pq
         D6Tx152JdKB8J913tIDhdZbAjW6Q6NI1n/+MiT/qnxYH5X/YX73IoI/J32oBqtR+DoiT
         BFaDRK1qqdz3ueon2ZdPBjI+TTwWYaTi7aw6CmfrFKdV9UGbbWUR9ekpKcryAVKD21p3
         5pugRgmCyy6TkULJoF/XyIayh8OKa8ZLbfGe7TF8/MCrzOpff/PUk2sKG2F5Lo2Opsyd
         FxDw==
X-Gm-Message-State: AOAM532BehuXGraXiZkX7sPJmGr5OAP5lsMa5Bk1hHzqsKkfqea1q1V7
        483ZF/cZu2mEh8BuLQd6q3Y=
X-Google-Smtp-Source: ABdhPJyRVTkQG18bebRIBJcRV3IIhdOm0sjE6OOvSeUGKeTif+SPqM6xsc47LPG/hVWhoDo1pEMSiQ==
X-Received: by 2002:a05:6402:699:: with SMTP id f25mr2915258edy.281.1592468303457;
        Thu, 18 Jun 2020 01:18:23 -0700 (PDT)
Received: from C02YX140LVDN.corpad.adbkng.com ([2a02:a210:ca2:9c00:943f:ccc6:42a6:c769])
        by smtp.gmail.com with ESMTPSA id p25sm1726299ejf.79.2020.06.18.01.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 01:18:22 -0700 (PDT)
Date:   Thu, 18 Jun 2020 10:18:20 +0200
From:   Son Luong Ngoc <sluongng@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, newren@gmaill.com,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 04/10] sparse-checkout: allow in-tree definitions
Message-ID: <20200618081820.GA97642@C02YX140LVDN.corpad.adbkng.com>
References: <pull.627.git.1588857462.gitgitgadget@gmail.com>
 <2188577cd848d7cee77f06f1ad2b181864e5e36d.1588857462.git.gitgitgadget@gmail.com>
 <xmqqeerv2w01.fsf@gitster.c.googlers.com>
 <6d354901-9361-d8d1-539d-3b6c3edb2d9f@gmail.com>
 <CABPp-BH5p1VPXfMOyN_0SLnsFKkRU9R-ZpiAe4k5r=ZUbHeibQ@mail.gmail.com>
 <CABPp-BEzz2MF72jZeJP6=9vJqcoJV15LN-O8umDDfWwQXLjZRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BEzz2MF72jZeJP6=9vJqcoJV15LN-O8umDDfWwQXLjZRA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, Jun 17, 2020 at 04:07:01PM -0700, Elijah Newren wrote:
> 
> Son pointed out that mercurial has a 'sparse' extension that has some
> possible ideas of things we could do here; see
> https://lore.kernel.org/git/CABPp-BGLBmWXrmPsTogyBFMgwYbHjN39oWbU=qDWroU1_fJaoQ@mail.gmail.com/
> for some further discussion.

I just want to note that you can find the latest version of FB's 'sparse'
extension here[1] and the tests for 'profile' feature could be found here[2].

Another relevant source of reading could be Google's Narrow extension for
Mercurial[3].

Cheers,
Son Luong.

[1]: https://github.com/facebookexperimental/eden/blob/master/eden/scm/edenscm/hgext/sparse.py
[2]: https://github.com/facebookexperimental/eden/blob/master/eden/scm/tests/test-sparse-profiles.t
[3]: https://bitbucket.org/Google/narrowhg/src/cb51d673e9c5820fc3da86a67f7e74b789820b4f/tests/test-merge.t#lines-63
