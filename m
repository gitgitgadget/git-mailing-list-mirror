Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD330C07E9D
	for <git@archiver.kernel.org>; Sat, 24 Sep 2022 04:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbiIXEih (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Sep 2022 00:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbiIXEie (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2022 00:38:34 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA186153A69
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 21:38:33 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id go6so1756643pjb.2
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 21:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=fcxZx7bMFrtMfQQfoRRNEi7zzANgLdv+f6c24ajLdj0=;
        b=LDTXDvzXBQw1yM6CrPAi9i05t4FQmMUBXtMTSM0YQXxe2k0w/2bIAaGQEW/0XRswhf
         b2h21YhwmM2tSgMWrlwppJBg95HYB49iV2z+9b43YNdX6FDazEHVIGeQYlzqaMLEZzHL
         /ZPtrxCk4EGvCi/lo0zYLBHMj0wskuNqJ5iDOeEoKjissJJrXUm+8UfZQnPkHkxruabc
         hDfPqEpYMozl6BAj18MFFSspefmYhwqMFXRXU4uAP6I1dVMMX1UbX84lljq+uLcepfEb
         NY2tMv20F8MBXQ6aPfsr1w5astF9FYMbLExOsQ8kz5v/490m3XMxjHLmJvtslV06z9va
         lbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=fcxZx7bMFrtMfQQfoRRNEi7zzANgLdv+f6c24ajLdj0=;
        b=j/3S1qtB90+z6VAuXzKBt+R4jjXE/6KV5F5LuBsPy676a4F8X52rvXOC/bvQEYCBTW
         5+UjaO7J6U2MYw3M3cddVLCWLUtdj1qNPxl4gIwj9OfEFpBJC5QBf5H2x/1Etqiz7a08
         d7/2Vp77DhoIYqfAhVyBq5bYi+rxtb+7/xHUjJz7+ocvSX0x6e5xYsv2J78R19QZyqAa
         +oucGjuOmaZ22Gkl9LTxBiIAM9YZf6coDVPAfKPtLxzuqNTD5xHfBs68tnHjnRbABNZ1
         BUxF0KC09rABvZgeghgpnquK7v43T/XtIx2kMqThYXz3br3SGlXgArDpbL4iz/HhLOKx
         ZV8A==
X-Gm-Message-State: ACrzQf2+eeMSeNeQs+pykPWMzwdfWKO/DbEyZ7HcBBwbhDRmBnnufcHj
        djOaE87P+FOPJrz7KTAONSj0Jg==
X-Google-Smtp-Source: AMsMyM7Ub/H59tE/0EH0gViHly9tDhB4Z/XBsWbIcDq7irYTn3osAQYWGws96eblfyu6XB7f2BxIPw==
X-Received: by 2002:a17:90b:3752:b0:200:b29b:f592 with SMTP id ne18-20020a17090b375200b00200b29bf592mr13119949pjb.81.1663994313205;
        Fri, 23 Sep 2022 21:38:33 -0700 (PDT)
Received: from initialcommit.io ([2600:8801:9c0a:f300:c0d2:33ae:9510:106d])
        by smtp.gmail.com with ESMTPSA id lw4-20020a17090b180400b001df264610c4sm13285788pjb.0.2022.09.23.21.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 21:38:32 -0700 (PDT)
Date:   Fri, 23 Sep 2022 21:38:29 -0700
From:   Jacob Stopak <jacob@initialcommit.io>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        martin.agren@gmail.com
Subject: Re: [RFC PATCH v2] shortlog: add group-by options for year and month
Message-ID: <Yy6JxQz4ZxghQnG1.jacob@initialcommit.io>
References: <20220922061824.16988-1-jacob@initialcommit.io>
 <20220922232536.40807-1-jacob@initialcommit.io>
 <xmqqillevzeh.fsf@gitster.g>
 <Yy4sIAHdvp6yRql+@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yy4sIAHdvp6yRql+@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 23, 2022 at 05:58:56PM -0400, Jeff King wrote:
> I don't think you even really need the regexp. If we respect --date,
> then you should be able to ask for --date=format:%Y-%m.

Hmm I tried passing in --date=format:... to my patched shortlog command
along with setting some date placeholder like "... %cd ..." in the code,
but it's not picking up on the format. Do you know how the date format
can be wedged into the format_commit_message(...) "format" argument?

> Unfortunately there's no way to specify the format as part of the
> placeholder. The for-each-ref formatter understands this, like:
> 
>   %(authordate:format:%Y-%m)
>
> I wouldn't be opposed to teaching the git-log formatter something
> similar.

Oh that would solve my problem... Would it be a hefty effort to teach
this to the git-log formatter?

> But there's something else interesting going on in Jack's patch, which
> is that he's not just introducing the date-sorting, but also that it's
> used in conjunction with other sorting. So really the intended use is
> something like:
> 
>   git shortlog --group:author --group:%Y-%m

Yes I sort of stumbled on this and realized that this way I wouldn't have
to touch the actual sorting or grouping functionality at all, which was
already working properly. I just needed to reformat the shortlog message to
include the year and/or month in a way that kept things consistent.

> I think we'd want to allow the general form to be a series of groupings.
> In the output from his patch it looks like:
> 
>   2022-09 Jeff King
>      some commit message
>      another commit message
> 
> I.e., the groups are collapsed into a single string, and unique strings
> become their own groups (and are sorted in the usual way).
> 
> If you give up the regex thing, then that naturally falls out as
> (imagining we learn about authordate as a placeholder):
> 
>   git shortlog --group='%(authordate:format=%Y-%n) %an'
> 
> without having to implement multiple groupings as a specific feature
> (which is both more code, but also has user-facing confusion about when
> --group overrides versus appends). That also skips the question of which
> --group-by-regex applies to which --group-by-value.
> 
> I do agree the regex thing is more flexible, but if we can't come up
> with a case more compelling than subsystem matching, I'd just as soon
> add %(subject:subsystem) or similar. :)
> 
> -Peff

I like this idea too. Since it requires a larger re-implementation,
maybe I can pursue this going forward. I assume if we did this we would
keep the existing group options like "--group=author" as shortcuts, and
refactor them behind the scenes to use the new method. If so it may be
useful to add my originally suggested options of "--group=year" and
"--group=month" as well for convenient default time-based groupings.

How do you feel about me submitting a v3 patch of my initial suggested
implementation of new group options for year and month? Then going forward
I can work on generalizing the grouping feature the way Peff suggested.

-Jack
