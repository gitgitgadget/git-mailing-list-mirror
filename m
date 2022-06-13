Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03B9C43334
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 21:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352500AbiFMVdJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 17:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343543AbiFMVc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 17:32:58 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA7CDA7
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 14:32:24 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id j8so4823430qtn.13
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 14:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FH7LPPPMK+lD+ejEavgXg8gVyqPuc86f8XsYA5I1VXc=;
        b=ORUP3lVxiUa3E4jiO8YjAN4G4qKszXrMrr7iAh9OXPzgINRJo5YyONWaeWwVp5crwk
         LQ00i4NHzW6CfOWdUDUDOz5X9LZL0GVpopz6pI1XVhym5s4Y+tKQLBlRRgri0ioy6jt9
         cTSzBuSgDWiaJvR+u/eXqcOQ5gozA1akI44ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FH7LPPPMK+lD+ejEavgXg8gVyqPuc86f8XsYA5I1VXc=;
        b=q4wQ7BqqfUCDKxgLVwar1X28BWwy6mV+g1rYfF8up1uupBgeUIzri1RHOPFiRQL4+K
         0InTFi2REzEjBVsFqHVAIS6heM45UzXzIgMgYogpttIUDVZyGq2z15BMvqlUgpRj0PLw
         vJPyhDGK1HHccKG59jDFBr9w2MVszKVOQ2R56afRryo01N57HFGGjUlg8gCPgQ1OZfRp
         IbOPLvJYdMF2H6+9ilWb5r/jnsSirJUVxFOgDYT0hMMcEQojI8DhCi0ayHZrzcCcWrEq
         VjlwI1XSou+kcHw5JUGJArfOgM+u5+ULgQ9LxzRVrUJVbWh/zBR4xWENq7gBXqXFD8CZ
         v+Bw==
X-Gm-Message-State: AOAM531sx7Rjz149wQ/3zMmm9Aa/qjZ6HMStUgXoVXP8X3ouSNcAaoMW
        NVNkZVEi2yaz9u6VOyDCLLPFBFX5i2eSVA==
X-Google-Smtp-Source: ABdhPJyxtJFBCDae83gwRQ4JcV3FwZ6qi0FzPbItT6BnV2th7DBEuW8TGbjQhe9Er1nuf+m+Pfgsdg==
X-Received: by 2002:ac8:5f0e:0:b0:304:fe44:4800 with SMTP id x14-20020ac85f0e000000b00304fe444800mr1649786qta.599.1655155942898;
        Mon, 13 Jun 2022 14:32:22 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-245.dsl.bell.ca. [209.226.106.245])
        by smtp.gmail.com with ESMTPSA id d3-20020a379b03000000b006a37c908d33sm7380666qke.28.2022.06.13.14.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 14:32:22 -0700 (PDT)
Date:   Mon, 13 Jun 2022 17:32:21 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: Repository corruption if objects pushed in the middle of repack
Message-ID: <20220613213221.iekmfjihho5ujfq2@meerkat.local>
References: <20220613203145.wbpi2m3ys3hchw6c@meerkat.local>
 <YqepoUMb3rkKgWqB@nand.local>
 <YqerC883GiwHiiZU@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YqerC883GiwHiiZU@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 13, 2022 at 05:24:27PM -0400, Taylor Blau wrote:
> A much more likely explanation for what is going on has to do with the
> `--unpack-unreachable` option you're using.
> 
> In your example, any unreachable object written within the last day is
> written loose, and anything else older than that is simply discarded. If
> the following happens, in order:
> 
>   - an unreachable object is detected, and marked for deletion
>   - that object then becomes reachable via some ref-update
>   - then the object becomes an ancestor of some push which depends on it
>   - _then_ the object is deleted by repack
> 
> ...then the repository will be missing some objects which are in its
> reachable set, and thus corrupt. IOW, the `--unpack-unreachable` option
> (and its successor, cruft packs) are both racy with respect to
> ref-updates.
> 
> Are you able to find evidence of that race in your logging? I would bet
> that is likely what is going on here.

I'm not sure that's the case, because the object that is missing is the one
that didn't exist before the repack started. In the scenario you describe, the
pre-existing unreachable ancestor of it would be missing, not the newly
incoming object. Right?

-K
