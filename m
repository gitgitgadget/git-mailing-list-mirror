Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A7DC352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 15:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiLGPCY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 10:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiLGPBn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 10:01:43 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9061A61B83
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 07:00:17 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id h16so16330213qtu.2
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 07:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=60rFRS0iz45Tj++3sJzHSRvRT5BcklIl7eR3QkdEp08=;
        b=NEIjwKro6eV0oeE6iY77O8NjEfjLdmPQxUNTJepnxin/izvwUUjcYtw5xpS8uFGejN
         n0YeIr7bLWm14IClSQSz9gJ3CJoEdCXZrJb0BCZMiT9FbSDN3Uwx0m5eKAEV4aAKa4UF
         8YjSkch2ZN3Sq+nhoevE1qxrKcw11P33T0yYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=60rFRS0iz45Tj++3sJzHSRvRT5BcklIl7eR3QkdEp08=;
        b=0Beb/hEXhEwRiRcht2rd0/Ge9y1OE0eBaw3bXmHP82plHPfVkB+/rUKgcdp2wkL9bv
         9Ummax4Lg5fkXMkM83OXIjSak0NZLM/tV9B9koh6CnxnanbptqIaG/A7AZW8BCqUej0u
         UIl5vlen6wOIu8ofPseaddHv12KRVLv4FtxPzb8YrEtZR+t3JXhHZnAmJNwD3FpLppUR
         4lMEtLcBSEzUmvFNVFJsXw812K/Wp9n/gTmD3rP9RhpdiSokWHVwLfnZYdy4E27DAeya
         oOJRXUAfcV4KcvmT6wvsDUCSsNFR7UMtBKDcXeUG1+W/3zMca/ePzTbXkCL3qUyu1ZhQ
         2o5g==
X-Gm-Message-State: ANoB5pkeJVFj/llITKWf96JqJjkoLWmAchX0EkD2ejtUew5y8wlwKv5m
        hzKzZ2llIYvXBF3gJSt0EkZDgF1KdRudhtf1
X-Google-Smtp-Source: AA0mqf6nDXKfiemlpuEeFTnV6mHP6Osqfjg+o1z1OwdhiTC1Fo7ZJJzhnpNZx+Xfu9I9KZn8qIdG5w==
X-Received: by 2002:ac8:4608:0:b0:3a7:e39c:e5c5 with SMTP id p8-20020ac84608000000b003a7e39ce5c5mr996147qtn.36.1670425216646;
        Wed, 07 Dec 2022 07:00:16 -0800 (PST)
Received: from nitro.local (bras-base-mtrlpq5031w-grc-33-142-113-79-147.dsl.bell.ca. [142.113.79.147])
        by smtp.gmail.com with ESMTPSA id c19-20020ac81113000000b003a57eb7f212sm13361944qtj.10.2022.12.07.07.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 07:00:15 -0800 (PST)
Date:   Wed, 7 Dec 2022 10:00:14 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, David Caro <dcaro@wikimedia.org>,
        git@vger.kernel.org
Subject: Re: Skipping adding Signed-off-by even if it's not the last on git
 commit
Message-ID: <20221207150014.zophrheptrz7456n@nitro.local>
References: <20221206170646.6lnpr6h7oprziy5b@vulcanus>
 <Y4/xSObs9QXvE+xR@nand.local>
 <221207.86y1rjako8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221207.86y1rjako8.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 07, 2022 at 05:31:18AM +0100, Ævar Arnfjörð Bjarmason wrote:
> The SOB is a proxy for passing the copyrightable work around, and to
> certify that you have permission to license the work per the DCO etc.
> 
> But it's also interesting in that context that we choose to omit this
> for re-rolls. I.e.:
> 
>  1. I write a patch, that has 10 lines of original work, add a SOB
>  2. You pick it up, add another 10 lines, add your SOB
>  3. I pick it up again, add another 10 lines, add my SOB
> 
> So at the end we have a SOB sequence of: Ævar, Taylor, Ævar, and 30
> copyrightable lines of code.
> 
> But if I submit three versions of my own patch with the same growth
> pattern over those three iterations shouldn't I have 3 of my own SOB
> lines: Ævar, Ævar, Ævar?

I'm not sure the trailer order matters much for the copyright info, because
after all this information is in the output of "git blame" and "git log". That
said, "trailer order" is a touchy subject with kernel developers, because
it means different things to pretty much every kernel maintainer. With b4, I'm
sticking to the "chain of custody" (COC) approach, which treats "S-o-b"
trailers as markers for where the chain of custody boundaries are.

For example, consider the following patch:

    | [PATCH] foo: implement libbar
    |
    | This patch implements libbar.
    |
	| Suggested-by: Reporter 1 <...>
    | Link: https://msgid.link/some-msgid
	| Signed-off-by: Developer 1 <...>     -- initial COC boundary
	| Reviewed-by: Reviewer 1 <...>
	| Tested-by: Tester 1 <...>
	| Signed-off-by: Submaintainer 1 <...> -- intermediate COC boundary
	| Acked-by: Submaintainer 2 <...>
	| Signed-off-by: Maintainer 1 <...>    -- final COC boundary

In terms of COC, this patch makes the following claims:

Developer 1:
 - I am responsible for this code
 - It was suggested by Reporter 1
 - You can read about it at this URL

Submaintainer 1:
 - I am signing off on this code
 - I am the one who added the trailers from Reviewer 1 and Tester 1

Maintainer 1:
 - I am signing off on this code
 - I am the one who added the trailer from Submaintainer 2

In the chain-of-custody scheme multiple identical trailers don't make sense,
as far as I can tell. If the patch doesn't pass review and someone returns it
back to the original developer, their "S-o-b: Developer 1" trailer simply
moves down to be the last entry in v2 of the patch, and the developer should
remove any code review trailers that were issued for the previous version of
the patch.

This is really the only order that makes sense to me. :)

-K
