Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1B5C433F5
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 15:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 236F260F58
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 15:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242119AbhITPy0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 11:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbhITPyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 11:54:25 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F573C061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 08:52:58 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id y18so22814011ioc.1
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 08:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FgGHeyOaV2H54sv/o+eZB7wW+fHtrhCg8ybF6phI5uA=;
        b=ywAOkPWZ4y1W5Qz1bwtUczBKbUorJ7mjetIMZOUPkjt5kgchbUoB+WC5XLOUeu60Zk
         NU5f0GYr9c8v8wN8wUSogDgqgA/PCVLTHx+iYOwWt6lzDOhjnJXXaAFM3AKkJqw7ZoRq
         Tr1iMPvL0W4ot8r+ba9NeOEd3BF8egvfzgwA3nHE2lNhB8eZN3GQYX5TAIFwUEkFIGxU
         PhoKlAv69JowlYDN+rsYnQ8Qak1AQuP0HDXjXVpy1yonz2j/EWSsdihAgtSlUF3Ha1YG
         B53BNcnz+nr3ycfPFr9eoHG5T5OqZPLsxaLmCGS1Ite+OOeTm+mNzkBnRDCnGfGQkIgS
         mEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FgGHeyOaV2H54sv/o+eZB7wW+fHtrhCg8ybF6phI5uA=;
        b=eIVT9E7+N2OalR3osouyXqffyBVNJPkiKUaXOUrZUsiXayD+ZphzQxpN2ho7GNHJpt
         oNH96Qk3361O7HczITO/6tx/wa/NmyfhKMpC4pKLvvcrxFsDWFPEJDT7JB7SmqelcA/y
         4ZOHWCjYYR74YNhrJ2HPiiMksB8KjKnoTqGXQZK4R5KFyxEQJp5Cyd15dSCQTF65wBgf
         X9XC1P3lb2PWY36kg6e5fzspto+iGeemCjSwjyuU853RugvRtTUGlX3MZmWTG94eAYMV
         OCvrxN3Ntt4GfC15278HdyDtyNKv5QQeIGa5CNXhj5cKdCuoNyraJ42GUq/jU5WPGUKc
         h2QA==
X-Gm-Message-State: AOAM5326Un9h9Txio53/FZ5sh/RgIIi0asUbgrUE3S1TC9AUDHd9+kth
        7ZQxBXQ7fDNyaeJ5TMpQY2p+YE+4FHPjDQ==
X-Google-Smtp-Source: ABdhPJxKd4Dj7/Gf1scQDpG2HFAq5QWXNNUBLEdCY6lZ6cPlBa/4tT9yjpmyRpEEaXGl4nCFxc9H/g==
X-Received: by 2002:a05:6638:339e:: with SMTP id h30mr13598171jav.148.1632153178063;
        Mon, 20 Sep 2021 08:52:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m5sm9182599ila.10.2021.09.20.08.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 08:52:57 -0700 (PDT)
Date:   Mon, 20 Sep 2021 11:52:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Calbabreaker <calbabreaker@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Memory leak with sparse-checkout
Message-ID: <YUiuWSXO1P3JwerH@nand.local>
References: <CAKRwm5a9PyqffEC5N__urSpNcZ-d5vz9GBM2Ei16eGS25B=-FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKRwm5a9PyqffEC5N__urSpNcZ-d5vz9GBM2Ei16eGS25B=-FQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 20, 2021 at 09:45:14PM +0930, Calbabreaker wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
>
> This was ran:
>
> git clone https://github.com/Calbabreaker/piano --sparse
> cd piano
> git sparse-checkout add any_text
> git checkout deploy-frontend
> git sparse-checkout init --cone
> git sparse-checkout add any_text

Thanks for the reproduction. An even simpler one may be (inside of any
repository):

    git sparse-checkout init
    git sparse-checkout add dir
    git sparse-checkout init --cone
    git sparse-checkout add dir

The problem occurs because we keep existing entries when adding to the
sparse-checkout list, and cone-mode patterns do not mix with
non cone-mode patterns.

So after the first init and "add dir", your sparse-checkout file looks
like:

  /*
  !/*/
  dir

but then when we convert to cone-mode and try and add "dir" (which in
cone-mode we'll convert to "/dir/"), we run into trouble when adding the
existing "dir" entry. That's because add_patterns_cone_mode() calls
insert_recursive_pattern() on every entry in the existing list,
including "dir".

So when we call insert_recursive_pattern() with any pattern list and
path containing "dir", we first insert "dir" into the list, and then:

  char *slash = strrchr(e->pattern, '/');
  char *oldpattern = e->pattern;

  if (slash == e->pattern)
    break;
  // trim off a slash, repeat

except slash is NULL because "dir" doesn't contain a slash. And that
explains the problem you're seeing, because (a) we'll stay in that while
loop forever, and (b) because each iteration allocates memory to
accommodate the new pattern, so we'll eventually run out of memory.

The wrong thing to do would be to handle this case by changing the
conditional to "if (!slash || slash == e->pattern)", because we can't
blindly carry forward some patterns which look like cone-mode patterns,
since together the list of sparse-checkout entries may not represent a
cone.

(An example here is if we added /foo/bar/baz/* without the corresponding
/foo/, !/foo/*, and so on).

So I think the problem really is that we need to drop existing patterns
when re-initializing the sparse-checkout in cone mode. We could try to
recognize that existing patterns may already constitute a cone (and/or
create a cone that covers the existing patterns).

But I think the easiest thing (if a little unfriendly) would be to just
drop them and start afresh when re-initializing the sparse-checkout in
cone mode.

I'm adding Stolee to the CC to see if he thinks that would be sensible
behavior or not.

Thanks,
Taylor
