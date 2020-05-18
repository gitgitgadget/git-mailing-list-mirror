Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC3CC433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 19:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED23C20758
	for <git@archiver.kernel.org>; Mon, 18 May 2020 19:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="RmV69lVz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbgERT5r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 15:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgERT5q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 15:57:46 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96375C061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 12:57:46 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id s20so4672310plp.6
        for <git@vger.kernel.org>; Mon, 18 May 2020 12:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u07zX7CUslIdDQwJHrk/tscY64udjdkWjE7oq3A/HWw=;
        b=RmV69lVzujuJ7p2qJGLL+nG6PfrTJ0ambZHPTjdqqoQxb6aerHagssRUYcIr/CuDu5
         0Jfiz8oN/qEnmTvnGVOjuGafnTpWvBaMYP5pKeoNYQFmZgB3OOgX8PLcBEmApIuu6cUI
         9yMYD7F4b78dX4ew9CupGVzX1Su+vyvZXhjeexq9VTOXLOnfUmjl0+UTbSolai5O3TSL
         QynsPFAQRhp4TutoG/xuoaKZqnKeeaISybEzbjPViS659U4TfxoRql8cG33IdnbW8r4x
         xcry2wRDICSs9lOlGClyNuBISGX9rwemMWY4NuOKd1dqBNt3wf+bazPmBWGbYhympXe9
         z1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u07zX7CUslIdDQwJHrk/tscY64udjdkWjE7oq3A/HWw=;
        b=mdzt+dt4X0VOGelf7/oLuQP6ZN9ZARtRDubopkXG6oRL5IMnhb/CiIy7cwPG/63xoj
         PdnvvAybsPkUDeeDHTtTfkoloHhN+bK647PhQK6Y7wvTP/FKYgJLxVVNxxB4wsuywsmC
         WdRIl9lUrr+J91O/oopi+kj8/r277/DIjsN3FAp/CFXYNyLYpwINKu8iToM/Wiv43wN2
         EKr91c7wg4Co7LjD8w+qjvC5O3z3e4cB/9hAviwjRMsZm4ifDM3O2ULlpa7YFqjKLIQB
         YynfbuqpY8tAP0QqDp03lYV2iLkVmDXIAqaMTmvJOfLShRfNwbJDjEbXk2ihW8pq/tME
         yzFQ==
X-Gm-Message-State: AOAM532l121+GPJLk3FemEP4JVFrdUzNzH+c0biek+tEapzfbHE4HYC8
        b8ziFHPQNVLwyl/8hSgVm0XxzFAG+Gw=
X-Google-Smtp-Source: ABdhPJyHKuF9CX/8LfpO2cTAILexRHfyq89UxsWQVGVRJCfzBtTgIaroKbx1FbHwXrcghNVsmCdpkA==
X-Received: by 2002:a17:902:ea8b:: with SMTP id x11mr17552206plb.205.1589831866003;
        Mon, 18 May 2020 12:57:46 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id f21sm9476773pfn.71.2020.05.18.12.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 12:57:45 -0700 (PDT)
Date:   Mon, 18 May 2020 13:57:43 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2020, #05; Thu, 14)
Message-ID: <20200518195743.GB3906@syl.local>
References: <xmqqpnb6nk7x.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpnb6nk7x.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, May 14, 2020 at 04:57:22PM -0700, Junio C Hamano wrote:
> * tb/commit-graph-no-check-oids (2020-05-14) 9 commits
>  - fixup! builtin/commit-graph.c: extract 'read_one_commit()'

I just sent one more fixup on top of this in [1], and otherwise the
series should be ready to go. Thanks.

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

Thanks,
Taylor

[1]: https://lore.kernel.org/git/20200518192709.GA3906@syl.local/
