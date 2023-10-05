Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17E2E9271C
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 17:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjJERp1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 13:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjJERow (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 13:44:52 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4590718F
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 10:44:26 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4180d962b68so7348071cf.1
        for <git@vger.kernel.org>; Thu, 05 Oct 2023 10:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696527865; x=1697132665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8QCKSMS/jUqPJHwVLil6M8fjQpDXlU71H+CR1tKUINc=;
        b=JK/8ZpPFapYsXeDLRFDtkNINHYtJRXcTNuRAi5rwi+f/u0o1b/whKfJ9CfOqKFtTnd
         dWvEqh2ka769jIRtN5FP/jh3EdKRwcaRctlwoem2sj7VZo9HXCWkAsp7LthOhbu81EeV
         IrgUoWuC2OV0qg0OILXOf61+SZ85Eh6S2mqITbl6C4HelzseTGZ8RmI8v63y7zf0zT6j
         xACxhMlgdUFEMVPvvpvXJvoFgQqGI/0N8ft+U5I29JriYtJ/2t2eKUfvA64+i7rHGt9y
         iB+ZT/bS3Gt9SBH0QYrrdYR68OpI8y+xBmyQAF8eGgPGffkI29W1DVok37gbCyya1uB+
         HN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696527865; x=1697132665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QCKSMS/jUqPJHwVLil6M8fjQpDXlU71H+CR1tKUINc=;
        b=p/nKumOwKKxiZj4WS8vo+FpGfUKEqp5KIWo8g656Bn2TPvTIbqTNhe3A3AdcwLrf9W
         +IBjOXIk2CiCC06rV0lxnaKaeLFGjhl0/KwRmGBMUGgCFEfYiA6+p3l1R8tLqL7/z1qJ
         TIj8QNrMSivck1VPOEh3+/KOpkiX54+Pari/+6ZKo56o0gCMdprBIT7mt7uUJe6hukdw
         6DB5J2zXx0Rs5bP4t5mtGbYi/LxDXlDK20WA0KivRNDUWdoGn05E/fj/o/asRZ3ZWN6M
         UvZP/7vNNzhKwbPqC1LUBegkMFmLu7YQ2xbaUVKc8stf8F0M4y8Ubr3Vj13jX7tUTw6F
         5c6g==
X-Gm-Message-State: AOJu0YwInqxL1ofI3BiXpBgs6DESKpgzrGlmlO4jlH3+E7hJb8Cfef3y
        /jLb7RsJl+3t31DYkk2aadtqXddIfADs2pSkIZbnpw==
X-Google-Smtp-Source: AGHT+IH/Z0kIa+RrWCxVqchfYmHZ7vzZduRWhLs66VBRw8T3bD+QssokCS6LI5KnW4DAUwbMjD8ffg==
X-Received: by 2002:ac8:584b:0:b0:412:21f4:6f9e with SMTP id h11-20020ac8584b000000b0041221f46f9emr5865777qth.40.1696527865257;
        Thu, 05 Oct 2023 10:44:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j12-20020ac84f8c000000b004181a8a3e2dsm633523qtw.41.2023.10.05.10.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 10:44:25 -0700 (PDT)
Date:   Thu, 5 Oct 2023 13:44:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 06/10] commit-graph: delay base_graph assignment in
 add_graph_to_chain()
Message-ID: <ZR71+Ht3G/xLqJ++@nand.local>
References: <20231003202504.GA7697@coredump.intra.peff.net>
 <20231003203004.GF7812@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231003203004.GF7812@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 03, 2023 at 04:30:04PM -0400, Jeff King wrote:
> When adding a graph to a chain, we do some consistency checks and then
> if everything looks good, set g->base_graph to add a link to the chain.
> But when we added a new consistency check in 209250ef38 (commit-graph.c:
> prevent overflow in add_graph_to_chain(), 2023-07-12), it comes _after_
> we've already set g->base_graph. So we might return failure, even though
> we actually added to the chain.
>
> This hasn't caused a bug yet, because after failing to add to the chain,
> we discard the failed graph struct completely, leaking it. But in order
> to fix that, it's important that the struct be in a consistent and
> predictable state after the failure.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  commit-graph.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 2f75ecd9ae..2c72a554c2 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -498,8 +498,6 @@ static int add_graph_to_chain(struct commit_graph *g,
>  		cur_g = cur_g->base_graph;
>  	}
>
> -	g->base_graph = chain;
> -
>  	if (chain) {
>  		if (unsigned_add_overflows(chain->num_commits,
>  					   chain->num_commits_in_base)) {
> @@ -510,6 +508,8 @@ static int add_graph_to_chain(struct commit_graph *g,
>  		g->num_commits_in_base = chain->num_commits + chain->num_commits_in_base;
>  	}
>
> +	g->base_graph = chain;
> +

Oops. That looks like my fault. Thanks for catching, this switch makes
sense to me.

Thanks,
Taylor
