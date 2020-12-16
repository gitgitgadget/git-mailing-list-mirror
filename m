Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93772C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 20:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6211A2370D
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 20:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbgLPUTw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 15:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbgLPUTw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 15:19:52 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A93C06179C
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 12:19:12 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id iq13so2117000pjb.3
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 12:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=arK79jdoghoAOfJQ/SM9E4/xFx43Pp/K99HZZnDVvVE=;
        b=SLs+HDx9B9ZqKwRm4azgl1mGjRU7J/Nj1+sC20Se21m3s1EATK2jdM1nK9WIdjOpm4
         RVWoTM3Tk0gmfLVUpel3qjEM849kq+reWTkmQhmJD5yqVywO9zt7OluOMxC0YdGsKLeG
         CnL8jTpwl4PWvyfcuqQlxLlUvmSIqVhfi+Wh6lfgiv3gf5HFIPutCjfgXgdfj7Y1QC4z
         +3tSnjckqQfjZUGEx83E70c84EvbuBgJT5/i/1hcEAhWjXfv++IOphbAglqhVgB/pSmv
         otOdDwiLiNGCufcpx8LIIs/PmgXhOdH0zWBXCG7OQZiXpzZXvzAJYZshy8EX2K08NLSc
         7eQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=arK79jdoghoAOfJQ/SM9E4/xFx43Pp/K99HZZnDVvVE=;
        b=tSJWnZ68tOHY2I3dIaceHRIRyOc8rw3Bhr3Z9Qn3Iflpvypg3DTiN2MIc2Z9/PhKQP
         2ONnp60c3x30cIVpc6nQCkvNkUiLg5COqdG/o4NFNfWieHFJSyJxL2L81EH8vo2vs7gT
         02Obftm2sOTRl1RiH9DlqrUyRkSOrr6yJu8FOjarDHWoe7GFvtFdkX69g3x55OqR7hwK
         Ahrwa5WqYJ8J+TKHkykxPPobjKAuMUgnOfxDKSZEwV+xe1QybUP4aJM3lJ1PEMp1nPgN
         H+BwSzYHltnRO062DSbeA/nJvembtDFX4fBGUKa3E/g9nPi6NrwV9aYxgHDt+LNq0NQn
         m19Q==
X-Gm-Message-State: AOAM532y6cxTowDpLVdyUtJ0yUi7bJ9AVvDiB83vZJrlJlzgibXaIFIR
        JoGx8GHQTPk/QuUdWHUCJ1lCtYgKShHoiw==
X-Google-Smtp-Source: ABdhPJy2KGe+SxwwEzDQ2g0q1vkUdxWsBVfozai5et55q1cQfm7JaBw+x/YDA2SHwUdVeLeQmfnlQw==
X-Received: by 2002:a17:90a:a24:: with SMTP id o33mr4488153pjo.191.1608149951548;
        Wed, 16 Dec 2020 12:19:11 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id p187sm3200380pfp.60.2020.12.16.12.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 12:19:10 -0800 (PST)
Date:   Wed, 16 Dec 2020 12:19:06 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 08/17] git-p4: use 'git hook' to run hooks
Message-ID: <20201216201906.GG3783238@google.com>
References: <20201205014945.1502660-1-emilyshaffer@google.com>
 <20201205014945.1502660-9-emilyshaffer@google.com>
 <20201216002712.GP36751@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216002712.GP36751@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 15, 2020 at 04:27:12PM -0800, Josh Steadmon wrote:
> 
> On 2020.12.04 17:49, Emily Shaffer wrote:
> > +    print('ESS: entering run_git_hook')
> 
> Looks like a stray debug message here?
> 
...
> > +    print ('ESS: args:')
> 
> Here as well.


:X Have fixed locally and will include with a new reroll this week.
Oops. :)

 - Emily
