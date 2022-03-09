Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE27C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 21:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbiCIVd5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 16:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbiCIVd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 16:33:56 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E10F3700B
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 13:32:55 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id e22so4300337ioe.11
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 13:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iFuLnJQTfXSxvFbzCILbdQpK4JtH+LMBjQcQbCjTfNw=;
        b=r5wU1OBkI57Uz9RaNGVwOOzNjEp42lzVrGmAnw35iujjqj8RMG7HeZ1XU0r9MWuDOf
         8NTDguspI5AKxkmTAww8jL9wUgAlzE8vGLRO+W0lh7jAThe5jJyZttKUm1F6/8XS4p60
         phc3DVt4Vr9lkHZ15oPZpWET/kAei0wVScanSRlvLJemx68kZuLmI1fkYdSgH+K8tEhe
         fTx3GGHISMUkovJTPXsz71gwAK+/Y2NlZNlEQ2vKc876Ob4jfJbWYXaKM+NLX7zSW1XU
         6QmAknIM4kn2NCTFOpZqri+Mc/SEx6Hq4WqXHymNlTPAlEwxe92rKiF7pjcgDk+y/Pi7
         BwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iFuLnJQTfXSxvFbzCILbdQpK4JtH+LMBjQcQbCjTfNw=;
        b=uf5LDFxVG/8YhWz8XJpAMCxs6GNnYi6B99ymG4vabrGOvjonoNzCVLjzIz1yn3Pu58
         kx+cQfnm5fT9B0gU15SvJjTpJfP/EfcpfHRLgVPzScqzBXrEZ3QtCBQ/xJyh1gpHu+Zv
         7IAK+8zZIi1MYVGcBLG4YMPVzpTEPf3OIZ+tKFII5UY+Utfp5UoXl1xVVQabkjKKzC7q
         O06zdW8cORGYY07YZw2xWlzGprPKSpAGOarLWhenTAljZoZsvu7XwXJ+/YbwHCCBqlwq
         DflllzTZu0uYoaLlLbJelXUXEE42hVvKrVdZp/rfVtEGM8LlH6RNwSWKOrwlVwudZfgW
         bb8w==
X-Gm-Message-State: AOAM532x2HhVlBKY9H8THkGCTNRwPQXUnGSKXDQfhQEu67AOKYLCZGNZ
        iLbfTWeglCQwspOpp2m1Y8ddA0G6IvYYsW+A
X-Google-Smtp-Source: ABdhPJw3LA/sWvle9OeF3KG8NznJJcX+6OnL0JLNMnW8j7Y5oHJJkJrnCkwmFMU+Avzp+jwd0c7c9g==
X-Received: by 2002:a05:6638:359:b0:317:c322:b012 with SMTP id x25-20020a056638035900b00317c322b012mr1253151jap.285.1646861574645;
        Wed, 09 Mar 2022 13:32:54 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a4-20020a056e02120400b002c638c50efesm1631438ilq.68.2022.03.09.13.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 13:32:54 -0800 (PST)
Date:   Wed, 9 Mar 2022 16:32:53 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 05/24] revision.[ch]: provide and start using a
 release_revisions()
Message-ID: <YikdBfMh++b8jPvu@nand.local>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
 <patch-05.24-b89dcadcc22-20220309T123321Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-05.24-b89dcadcc22-20220309T123321Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 09, 2022 at 02:16:35PM +0100, Ævar Arnfjörð Bjarmason wrote:
> Let's provide a release_revisions() function for these users, and
> start migrating them over per the plan outlined in [1]. Right now this
> only handles the "pending" member of the struct, but more will be
> added in subsequent commits.

I could not be more excited about this change! The lack of easy
mechanism to free everything in the rev_info structure has been a major
impediment for me to get much value out of the SANITIZE=leak builds, and
this is a huge step towards making those more useful.

This plan looks good to me, as does this first patch to introduce the
new API.

Should it be documented anywhere in e.g.,
Documentation/MyFirstObjectWalk.txt or elsewhere?

Thanks,
Taylor
