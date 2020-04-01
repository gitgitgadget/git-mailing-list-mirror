Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D189C43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 22:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44DF52063A
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 22:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uns0o4tv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388953AbgDAWtR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 18:49:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54171 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388947AbgDAWtR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 18:49:17 -0400
Received: by mail-wm1-f67.google.com with SMTP id d77so1462069wmd.3
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 15:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xyy9ZGpuogYYPvEFZzaLL1f7QA1ZtGsdD7Fq/wkpUoM=;
        b=uns0o4tv6o7d0rqdnOdwrQqAKqHSnj4+ljqDcXdPKp+vgVE1MyrrfO3cutt/wN7rPO
         I5QfXg9pkw2BNA1tIvjqDVsBL2lnLD0pCy+u7ujsijAuoybjhDa8gnzFfmXn2dobUFmE
         skVEYbPpZQUg19MGPsOPGlX9YpDDUwCf9WvaeTDK/+5hPA1MEq5+zOftIxk3cQdn8mLf
         ssUY2qnizNuiuNkWNlw7xtOhBcTaDfvJftEKFYS6KXkXkVBL8qAvOIpvewth1XDRbWU2
         tPvBJw4eYukhujIZ8DloD5ePvke+BTTdKt9eQUJLDTGOzx1v+kSVO783XBCrh/t/5iAb
         F+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xyy9ZGpuogYYPvEFZzaLL1f7QA1ZtGsdD7Fq/wkpUoM=;
        b=iTEgWl7rF9pu7ExaqE9GYO8V4WEW3TxDNUpG7hEX1xLLgBosMLfj0eyLMf5Kb0WTUg
         sF5W8/ARpf59Qgsz2USU+oIHTViau2yKD046SddfsJwiWZwIq/0/jkhSzqH0p6a6N/UJ
         V8JiLjIv04bj2kSUewvurdK6rz6K2MMnb23eZf3QwrU4/N4TPcGHotIH8Sl8d0f9xgS+
         yQ36riI7ic5o3vuYxrCuep5TgUdob1y+bi12x3VmnvohvzByR9kYzfbJMCaRr63UwVr1
         3+QcKNJVo6Umv+3m0yO+3VZl28Zol+4nNPg2GArzJ8gbPjWy+4VbnfMd+QU8u9a04iLR
         hGDA==
X-Gm-Message-State: AGi0PuZs24EIxQivjss3ryZtBeXGtXaL/opeUpLFY8Z+D58QgKd4iGUy
        WenHluKBVmpnJdi0Pj65stgBm139
X-Google-Smtp-Source: APiQypL8Oj/Qy+i1B8qfXzMkOy+SRLKCKpFtEpHG4VFfSD1uDym2CDbNz8PHCKP5FWfJoekIuT65Wg==
X-Received: by 2002:a7b:c050:: with SMTP id u16mr304739wmc.68.1585781355300;
        Wed, 01 Apr 2020 15:49:15 -0700 (PDT)
Received: from szeder.dev (78-131-17-192.pool.digikabel.hu. [78.131.17.192])
        by smtp.gmail.com with ESMTPSA id i1sm4595242wrq.89.2020.04.01.15.49.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2020 15:49:14 -0700 (PDT)
Date:   Thu, 2 Apr 2020 00:49:12 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        martin.agren@gmail.com, peff@peff.net
Subject: Re: [PATCH v4] builtin/commit-graph.c: support '--input=graphed'
Message-ID: <20200401224912.GI2224@szeder.dev>
References: <7c47f37122ff2b03f0bccc48cb6ca022904f6353.1583278022.git.me@ttaylorr.com>
 <e0f42a2f3c0162a5d43bb2bce0f69264b59f92e9.1584994172.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e0f42a2f3c0162a5d43bb2bce0f69264b59f92e9.1584994172.git.me@ttaylorr.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 23, 2020 at 02:12:19PM -0600, Taylor Blau wrote:
> Hi,
> 
> In response to some discussion in [1], here is another idea instead of
> '--input=none' that may make things a little clearer. Since it had been
> a long time, I reminded myself that '--input=none' means
> "--input=append, but don't look at packs as is usually the default".
> 
> In [1], Gabor suggested that we could call this '--input=exists' or
> '--input=existing', but I think that 'graphed' may be clearer, since
> it is closer to "only _graphed_ commits".
> 
> Another option would be to call this '--input=only-graphed', but I think
> that may be overly verbose for what we're going for here.
> 
> Let me know what you think.
> 
> [1]: https://lore.kernel.org/git/20200322110424.GC2224@szeder.dev/
> 
> --- 8< ---
> 
> In the previous commit, we introduced '--split=<no-merge|merge-all>',
> and alluded to the fact that '--split=merge-all' would be useful for
> callers who wish to always trigger a merge of an incremental chain.
> 
> There is a problem with the above approach, which is that there is no
> way to specify to the commit-graph builtin that a caller only wants to
> include commits already in the graph. One can specify '--input=append'
> to include all commits in the existing graphs, but the absence of
> '--input=stdin-{commits,packs}' causes the builtin to call
> 'fill_oids_from_all_packs()'.
> 
> Passing '--input=reachable' (as in 'git commit-graph write
> --split=merge-all --input=reachable --input=append') works around this
> issue by making '--input=reachable' effectively a no-op, but this can be
> prohibitively expensive in large repositories, making it an undesirable
> choice for some users.
> 
> Teach '--input=graphed' as an option to behave as if '--input=append' were
> given, but to consider no other sources in addition.
> 
> This, in conjunction with the option introduced in the previous patch
> offers the convenient way to force the commit-graph machinery to
> condense a chain of incrementals without requiring any new commits:
> 
>   $ git commit-graph write --split=merge-all --input=graphed
> 
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  Documentation/git-commit-graph.txt |  8 +++++++-
>  builtin/commit-graph.c             | 11 ++++++++---
>  commit-graph.c                     |  6 ++++--
>  commit-graph.h                     |  3 ++-
>  t/t5324-split-commit-graph.sh      | 26 ++++++++++++++++++++++++++
>  5 files changed, 47 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
> index 0a320cccdd..4d8fbbe8ff 100644
> --- a/Documentation/git-commit-graph.txt
> +++ b/Documentation/git-commit-graph.txt
> @@ -39,7 +39,7 @@ COMMANDS
>  --------
>  'write'::
> 
> -Write a commit-graph file based on the commits found in packfiles.
> +Write a commit-graph file based on the specified sources of input:
>  +
>  With the `--input=stdin-packs` option, generate the new commit graph by
>  walking objects only in the specified pack-indexes. (Cannot be combined
> @@ -57,6 +57,12 @@ walking commits starting at all refs. (Cannot be combined with
>  With the `--input=append` option, include all commits that are present
>  in the existing commit-graph file.
>  +
> +With the `--input=graphed` option, behave as if `--input=append` were
> +given, but do not walk other packs to find additional commits.

s/walk/scan/ would be more fitting, I think.

In an earlier version of these patches I asked for clarification about
what happens with expired commits that are still included in the
commit-graph... and I do remember that you replied to that, but,
unfortunately, not what your reply was.  And after reading this log
message and the documentation update it's still not clear to me.

> ++
> +If none of the above options are given, then generate the new
> +commit-graph by walking over all pack-indexes.

s/walking/scanning/

> ++
>  With the `--split[=<strategy>]` option, write the commit-graph as a
>  chain of multiple commit-graph files stored in
>  `<dir>/info/commit-graphs`. Commit-graph layers are merged based on the
