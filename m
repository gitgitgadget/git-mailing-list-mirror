Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E3D21F42D
	for <e@80x24.org>; Thu, 31 May 2018 19:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754143AbeEaTHn (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 15:07:43 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:33459 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754021AbeEaTHm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 15:07:42 -0400
Received: by mail-yb0-f196.google.com with SMTP id x36-v6so7943123ybi.0
        for <git@vger.kernel.org>; Thu, 31 May 2018 12:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8tSH1S7Bwdl9Kq7xm0XM0mYf4UBTtTFO/+9c6PGllig=;
        b=WR5gIlzUEq21LizD+fc6MiiFI5HvrhEaRuOSh/JBFdt6E1mr/FBeExvjvYWzxoGQUT
         L/ScZmhO3Xh6mHAip8xzjjju2vw4gMZlzh6+HInIsgASA4TuzeuiXQoDAXqOkyEAkyEx
         3PA9QjrFWgQ0VpSZbrrIHMaw9moqDdBmBV6UjqaDsObzhIX3I6/0myiHT3Ygo1XnbQ1G
         ffb+wG+6Cl6jzjEk+XucbYnoLlLde7nZcgaNoujUCKypes/ebXN81lN3xmDyE/YeKGKE
         hJ3BRt15Z4Juycj5ILo0fB2bFICn3gsZPFHIAsK0g7kQ8Gsx2iXtgHxyfM58jZqgH/Xk
         532w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8tSH1S7Bwdl9Kq7xm0XM0mYf4UBTtTFO/+9c6PGllig=;
        b=X0fz9Q/b4jf+LOvFHYQ+EIIkEPyp466mPn/x9ThUM9kn871RJLaoS0+aQkQ6G6efgT
         HltfsdXP0qBXNL3eyr8fzUs8mVZIpnXk/whXpOhPWmi7W4KNOlCmYxYSwjlhmuslcfyN
         oDMpKXJTuiaOLSZybBzWYvQLuMDYJfxnIuGWxOuoJ2ch7LwWeHo0+xhyRuH9pZalUIgT
         VSES4mS8FVtNs2fVtUc5BqwIYWLETO7xZbE41pKcCVki2t+k71Isr5A2hDrJXcnYWrKT
         7ih23qB9TpsC4EwjHMv+STw2Brme4lvA8SI91FCYr5SEd0HDE00GrO+9hOuW/ZwyqAbA
         DhjQ==
X-Gm-Message-State: ALKqPwfrMgNd5NHx+QpG+2NQROzBO4qdctRYi6xwX5l+zFZASTQjhrEV
        UvLfX/MNOlnjmYocxLc2jt+v6unxinDIeO/l1uvnvV8c
X-Google-Smtp-Source: ADUXVKIANFOtT35w3Xlf1xhkyt/uSSqHdH+Nh9QNdOn4l93FTxr1fCxYmQ5YVfWqjGVe6csEgtlNTn4CNVCWbyZrpx0=
X-Received: by 2002:a25:6cc2:: with SMTP id h185-v6mr4653320ybc.307.1527793661597;
 Thu, 31 May 2018 12:07:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Thu, 31 May 2018 12:07:41 -0700 (PDT)
In-Reply-To: <20180531174024.124488-5-dstolee@microsoft.com>
References: <20180531174024.124488-1-dstolee@microsoft.com> <20180531174024.124488-5-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 31 May 2018 12:07:41 -0700
Message-ID: <CAGZ79kYcrTHzj_6S5gV2e72DhZf_LTAKHiwX+HZY2Tskk0eqYw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/6] commit-graph: avoid writing when repo is shallow
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 31, 2018 at 10:41 AM, Derrick Stolee <dstolee@microsoft.com> wrote:
> Shallow clones do not interact well with the commit-graph feature for
> several reasons. Instead of doing the hard thing to fix those
> interactions, instead prevent reading or writing a commit-graph file for
> shallow repositories.

Makes sense.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 95af4ed519..80e377b90f 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -208,6 +208,9 @@ static void prepare_commit_graph(void)
>                 return;
>         prepare_commit_graph_run_once = 1;
>
> +       if (is_repository_shallow())
> +               return;
> +
>         obj_dir = get_object_directory();
>         prepare_commit_graph_one(obj_dir);
>         prepare_alt_odb();
> @@ -711,6 +714,15 @@ void write_commit_graph(const char *obj_dir,
>         int num_extra_edges;
>         struct commit_list *parent;
>
> +       /*
> +        * Shallow clones are not supproted, as they create bad

supported

> +        * generation skips as they are un-shallowed.
> +        */
> +       if (is_repository_shallow()) {
> +               warning("writing a commit-graph in a shallow repository is not supported");

_() ?
