Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA8DC433C1
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 21:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F11D561A12
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 21:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbhCXVyq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 17:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbhCXVy2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 17:54:28 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6014C06174A
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 14:54:28 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id v2so15689238pgk.11
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 14:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ORD9S0heHFl1uQy027i1cEK5Nl9w8ek4XLC3SLFX5yo=;
        b=SyvSDjz6CzL54ZOHhA3euchSZhbZqUTxkJqjwKA7i4sNROiPy5COYMYlE5ioFCIac0
         mNH5XzpqGT38RMkRKg8HeXpWqzC61bhpvISZD6jOSEteVot8j62VBeLZbdQEhm8fiSW3
         zB/TQl2ZJZ3B+YiShfFPtv+vpv0GJ1OJ23BZN9Co73j79sNgVMX2NNcjZlPtixE23NgK
         D/AuG5FnpKnZdNHaApQ+v1Ase2fSZfjswoi4CArf5yerAqiLJqcwhXyoh4L87c90EZWy
         g5nahJ+y7gmLHeKioPiydYcT3cv6M5gHKvJqyQEn0KZej0fLBr+zg6Ze0VTuOhXNzLHg
         Qz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ORD9S0heHFl1uQy027i1cEK5Nl9w8ek4XLC3SLFX5yo=;
        b=B1XBvcToT6EwFyySPumaO8czhN2EydOx/twNil7D98jdzq3YX8bh5HxkUTAgEIPaFi
         NuGJbcXrHbqCDWiiyON+hWdnhzKbxP4HJhtcNLKodfnrLbhXPn6vM0eVvvLjOKGfprYH
         o7PCOfM+GtrwJKCWKkwGvF7oT38RxtQHcVrLV/CkonHhzUFU3VPVAYGZBMygGlNbmW8H
         Ec7X1OR4WSQwXYNNMvn+fNkxIOBMMfD4V8aKWnVV/G/MRelpCpc4hR+WQpDPAc4wJvpk
         bcS5WY2neVZpchk65/on3EUUMSnl+xecVTZjdWaXeAPnsl26ZJpKaWgIkEfEpMJ1UXpk
         cQzg==
X-Gm-Message-State: AOAM5303H5tBbpZv8eolxdsX+9DAF11LhlZHZpX/ckUncqxCZ+KNb2DP
        7hy6RI3aUQKAyDW/M5Mti1PQuA==
X-Google-Smtp-Source: ABdhPJwmW3atAgQ7c/a9h4BIjcEgdZ/1Z7PcNJth50fONq5Mo+G4DPuXgc5Si4WZthqWkN94KAOpCw==
X-Received: by 2002:aa7:9293:0:b029:1df:4e2:c981 with SMTP id j19-20020aa792930000b02901df04e2c981mr4968116pfa.41.1616622868176;
        Wed, 24 Mar 2021 14:54:28 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:d027:9201:1f66:e720])
        by smtp.gmail.com with ESMTPSA id mz11sm3501358pjb.6.2021.03.24.14.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 14:54:27 -0700 (PDT)
Date:   Wed, 24 Mar 2021 14:54:21 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 17/37] hooks: allow callers to capture output
Message-ID: <YFu1DeF5PSiY8XR1@google.com>
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <20210311021037.3001235-18-emilyshaffer@google.com>
 <874khghh8r.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874khghh8r.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 12, 2021 at 10:08:04AM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Thu, Mar 11 2021, Emily Shaffer wrote:
> 
> > Some server-side hooks will require capturing output to send over
> > sideband instead of printing directly to stderr. Expose that capability.
> 
> So added here in 17/37 and not used until 30/37. As a point on
> readability (this isn't the first such patch) I think it would be better
> to just squash those together with some "since we now need access to
> consume_sideband in hooks, do that ...".

Yeah. When I was putting together the series I had two thoughts on how
best to organize it:

1. Adding functionality just-in-time for the hook that needs it (like
you describe)
or
2. Implementing the whole utility, then doing hook conversions in a
separate chunk or series (what I went with).

I chose 2 for a couple reasons: that it would be easier for people who
just care "did a hook I use start working differently?" to review only
the second chunk of the change, and that it would be easier if we wanted
to adopt the library part into the codebase without converting the hooks
to use it (this was listed as a step in the design doc, but I think we
ended up abandoning it). The differentiation was certainly easier when I
had the two "chunks" separated into a part I and part II series, but
Junio asked me to combine them starting with this revision so it would
be easier to merge to 'seen' (as I understood it).

At this point, I'd prefer not to rearrange the series, though.

 - Emily
