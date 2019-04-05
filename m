Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8930A20248
	for <e@80x24.org>; Fri,  5 Apr 2019 05:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfDEF3Q (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 01:29:16 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43634 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfDEF3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 01:29:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id k17so6371424wrx.10
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 22:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hdcrX6rt3OGVQApE+iyfftH1GLjfq+QHqCviXWN6P7k=;
        b=jQp3LcYjbLtPJPGMYMYLDXLHZsdnP8ahY2vyi7fpl7DUJVcwqqdoRnLk9jwvSrz9gA
         lo2Q58IB0iIAepV88doIGg4g5Fb5Fr2J/N+ICHmFOeojGpAaDlYirCx3uRp8CYbuLKGb
         AsznlTnga+iNOVgUmUuPkX3fqMuSjzPp0YlfzINMaLSNJWHKvLpXIzwa9wqaQ4N7PtVu
         qJVddl+UV6Ywq+AT9tjQtEhAD49jFJKDURHFautOlr04KpBhO772SnLp8IfN4HzGsiuG
         trqWH5KlpumQ8NxZfXD5DKbuDVFwG0GA+Lphmu1Xc0XzMtS8mc0qkvn4lLMpg9H8CAfi
         rG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hdcrX6rt3OGVQApE+iyfftH1GLjfq+QHqCviXWN6P7k=;
        b=SMCVnjrRscU3qDOGQeMJ+jvoM2jyY3K4RCfi9936OG2cQcbSAj7vc/qKFU5fox1i0H
         YJ858p1ThwbL8hNsA7g9s0qV1USR+Je1kddTIYgfqOGbXfl2474Y9jrXH90gLWFpNMc2
         p82g8TkjeQMoJ/C9K21nfhaykZbWnPmw/8S+/OUyFdYxjPf5Eny0RbDAjTjW1kXANVe8
         TzcG9+k8FbJaNvj5UnlMC0Pz9+7bblUb/wl1THj4yTPnVlPxSggvrFCNf9eKUXhYpWJQ
         A0UCobHl6pkF0H9B2EMCm6h4Z2gEvoouVHvjq/VztilV1fm3NmSw9KYMiU2lIaJrzLF+
         tRjQ==
X-Gm-Message-State: APjAAAWVDmqW6lsRBTAiOu67sSB8kNlDVPjl3SsvnCXOtJf/OFuRvnII
        2BcPxP0rDIdjSHhIi7SC4nE=
X-Google-Smtp-Source: APXvYqz2QpTmzidRSVGpXeu58wytQbSs3ocfPKxL/1y5I2fsJnbUl+/NHejXydzKxaivthdXJxL8GA==
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr6610953wro.232.1554442154122;
        Thu, 04 Apr 2019 22:29:14 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id v1sm28176220wrd.47.2019.04.04.22.29.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 22:29:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff King <peff@peff.net>, Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Robert Dailey <rcdailey.lists@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2.5 2/2] tag: prevent nested tags
References: <1bd9ee28bc8726490ec0a93286056beeb147fc49.1554183429.git.liu.denton@gmail.com>
        <20190402230345.GA5004@dev-l>
        <xmqqzhp7sfw4.fsf@gitster-ct.c.googlers.com>
        <20190403213318.GA14137@dev-l>
        <20190404020226.GG4409@sigill.intra.peff.net>
        <xmqqftqyf76a.fsf@gitster-ct.c.googlers.com>
        <CABPp-BHBq64-4jO4=rxUsA2WV5keh86wrai87i=oLTzXdcTb=w@mail.gmail.com>
Date:   Fri, 05 Apr 2019 14:29:12 +0900
In-Reply-To: <CABPp-BHBq64-4jO4=rxUsA2WV5keh86wrai87i=oLTzXdcTb=w@mail.gmail.com>
        (Elijah Newren's message of "Thu, 4 Apr 2019 17:36:48 -0700")
Message-ID: <xmqq36mxdnpz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> I'm slightly in favor of the tag.forbidTaggingAnythingButCommits
> route.  Two reasons:
>
>   * Even core git commands can't handle these properly after more than
> a decade, making me suspect that tools in the greater git ecosystem
> are going to fail to handle them too.  In more detail...  Some
> examples: fast-export with --tag-of-filtered-object=rewrite fails on
> tags of tags and tags of blobs.  Without that flag, I think ...

Fair enough.

Personally, I've never considered import/export tools as part of the
git core proper, and it is time like this that I am reminded that I
have been right all along---they just do not get attention to the
same degree as the truly core tools.

But as we ship them together with the core part of the system, the
users may have been trained to think that tags to tags are not
something they want due to the limitation of these fringe tools.
