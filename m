Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46583C28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 17:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DA8D20B1F
	for <git@archiver.kernel.org>; Wed,  6 May 2020 17:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="ztiGjTZx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgEFRSP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 13:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgEFRSP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 13:18:15 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3A6C061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 10:18:14 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id m7so769711plt.5
        for <git@vger.kernel.org>; Wed, 06 May 2020 10:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xfqEoL9S9cPvCWMeXgfy1679XJReuE4hfeTiCzoDYsU=;
        b=ztiGjTZx5LQY75KGaU1HG9eK3plWe++horBkd7sLe0LHeciMlFMsEzr9pqZBIchV6E
         OtGbSU+malkFnhiBk+9dAEQKPMklxRD7O3p4wJxOQ+JUw51YUJiCiINB2Px9VcL2lQcH
         IfjqYisByKdnMWboxNdt/lFMT8zfzDWtWNgbR+KWs2iW3HxGDAhv6zys2kKejSUzuv5i
         o38qEr1vjE5IRgirPHq8Weadro424PyseF0JdAmTw7zWnDkVNo9gBYr6n0nsIGPqq7R7
         l1PsI6RMPdWtOkQNyvR7paYW6YNCjLg2fORv0b1+zQVQ07gbyYd+df4QkY+o3m5rE0A1
         gQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xfqEoL9S9cPvCWMeXgfy1679XJReuE4hfeTiCzoDYsU=;
        b=LXFbu5UYzVZZEuE0506h+RWsZXm45ayg2KcWIHhIXMLyhBI3vic5U8HaK/+3iLfdWH
         J0dPvvV+ZF/d6KijUPYWnFT45DjaXLE7v+KyWJcIZRCs7dxwe2M98PvkM4n6xHpFwRl1
         FFTIRZ8HKZzEjzJDd5ftXNBw57DsCG9mjaPlh7w2lDIid+QKHDaVXZo+sIRDudyHbbQ8
         8pWxJ3sqT/UgmVItyUY9nyLhI+s9E0xIlMLHWHTmnl7ICAnLwhtoLwA+nhx7TtXkoK44
         NUEZ9ETl20iTVRsghpmTaG2tSgpj4pTjQGBbkQaqbT7reWmwSHdgG9GBMI3Rzpg94xUD
         qhAw==
X-Gm-Message-State: AGi0PuYVq7M3aary5ygU618xZRgjHNUPl6bvzSXda78BT9OCNy18E+yy
        g+3QVfnFh/ERxkBGzT6lEbClXQ==
X-Google-Smtp-Source: APiQypJu6zwmP+14hZrNmQJns26hHV3KXHI7k07ZUVv4CJwSNzb28vW0tUMdqqfCOpBCqUoeD5+gvQ==
X-Received: by 2002:a17:90b:692:: with SMTP id m18mr10712429pjz.39.1588785493944;
        Wed, 06 May 2020 10:18:13 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id 10sm2350514pfn.204.2020.05.06.10.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 10:18:13 -0700 (PDT)
Date:   Wed, 6 May 2020 11:18:11 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2020, #02; Tue, 5)
Message-ID: <20200506171811.GA6078@syl.local>
References: <xmqq8si69fda.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8si69fda.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Thanks for an update. I couldn't find anything in my list of active
topics that you're not already tracking below, so I'll just respond to
the topics I authored:

On Tue, May 05, 2020 at 03:38:41PM -0700, Junio C Hamano wrote:
> * tb/bitmap-walk-with-tree-zero-filter (2020-05-04) 4 commits
>  - pack-bitmap: pass object filter to fill-in traversal
>  - pack-bitmap.c: support 'tree:0' filtering
>  - pack-bitmap.c: make object filtering functions generic
>  - list-objects-filter: treat NULL filter_options as "disabled"
>
>  The object walk with object filter "--filter=tree:0" can now take
>  advantage of the pack bitmap when available.
>
>  Will merge to 'next'.

Thanks very much!

> * tb/commit-graph-no-check-oids (2020-05-04) 8 commits
>  - commit-graph: drop COMMIT_GRAPH_WRITE_CHECK_OIDS flag
>  - t5318: reorder test below 'graph_read_expect'
>  - commit-graph.c: simplify 'fill_oids_from_commits'
>  - builtin/commit-graph.c: dereference tags in builtin
>  - builtin/commit-graph.c: extract 'read_one_commit()'
>  - commit-graph.c: peel refs in 'add_ref_to_set'
>  - commit-graph.c: show progress of finding reachable commits
>  - commit-graph.c: extract 'refs_cb_data'
>
>  Clean-up the commit-graph codepath.
>
>  Expecting a reroll
>  cf. <20200505161649.GG69300@syl.local>

Sent: https://lore.kernel.org/git/cover.1588723543.git.me@ttaylorr.com/.

Thanks,
Taylor
