Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC5CC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 23:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A75A61185
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 23:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbhFQXqy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 19:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbhFQXqx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 19:46:53 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53796C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 16:44:44 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id x16so6236842pfa.13
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 16:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Do1lfAHtjSR5ppc1bRrGYjONBY1wIzhUPqOR2UMtwQc=;
        b=SiY37y+DurzAXezEyTssXX+vfyYbTLJhN2qsYROqxMSdvlKmsCMa3pWSDg/tI8iSYc
         bOUwJaov7gB+Yp/FJBUAG00x65qT1yYc8CZNYhBwoRp8rhpw93z6/y3hwJueGtG923Fh
         KFAuXsAcJ0RG/k+upxu5Qa9DOQQ/8d/SOC/sLg1hN4B0MIes3+1tDsflI+RVOKrrjN+6
         7zIdsu7iFEaNKlbUMl+UUidjv0i4Q6NNvS6AUZ+zk2QdDWOjBRQwKhvkrCN261NpS5vg
         TzHbudwV1uqkJmwCBExvqIPRAL50/yoNNlojjhDMQhh5L3Qgs7UdPBuUi802dXJ8xStE
         Q2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Do1lfAHtjSR5ppc1bRrGYjONBY1wIzhUPqOR2UMtwQc=;
        b=pp/i3OWIzzPonDRLBYJczUueioZZ3yeeWGcIDM0avDlO3AO2nF/hZB67HVCeX8UOdj
         vWaoz4PWz8c+MX3z8Nwf9hYuQzs10NMQTOtNCR3bxwjqVEB5sVmFycpiJB8EGH6GAVl0
         OMttzr35LNhPfI/ut8x9ZsHzwYegrI3UoER3bmc/oP+qvXLvlPG+g8u6gG7C7AqPTKuA
         SnqmzbxYuN6ovW0djw9sYIJxKe8WcZIl8+bkt/azEE6qyhkMcxyVSsZ8XdgqgcUgreLQ
         HOPTVz6L3qfRIKc3FM/0hyzl0y352WtH5WE0mopVWjErbKFsV9/gsO9FynQy6anTUt4z
         bxbg==
X-Gm-Message-State: AOAM5310fsficvym3HIFjL+G1SjTUXOOX8gALCVQSCZKlZmIa9Sl9LcG
        es5INpX2VmlrVJNLb0QwZ0hoJg==
X-Google-Smtp-Source: ABdhPJxz/Ase6DQtC51DGsBHsFHDhdMMMXsP4lHakiNJt8JLxnKpPqF7jUOilluFGnwtDMC8XGkjPA==
X-Received: by 2002:aa7:9983:0:b029:2ea:2408:386d with SMTP id k3-20020aa799830000b02902ea2408386dmr2098505pfh.13.1623973483651;
        Thu, 17 Jun 2021 16:44:43 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:30e4:83fc:53b6:fa47])
        by smtp.gmail.com with ESMTPSA id q12sm6916432pgc.25.2021.06.17.16.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 16:44:42 -0700 (PDT)
Date:   Thu, 17 Jun 2021 16:44:37 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v2 2/4] revision.h: unify "disable_stdin" and
 "read_from_stdin"
Message-ID: <YMveZXZRM5vHYRx5@google.com>
References: <cover-0.4-0000000000-20210608T121008Z-avarab@gmail.com>
 <cover-0.4-0000000000-20210617T105537Z-avarab@gmail.com>
 <patch-2.4-d88b2c0410-20210617T105537Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-2.4-d88b2c0410-20210617T105537Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 17, 2021 at 12:57:35PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> In 8b3dce56508 (Teach --stdin option to "log" family, 2009-11-03) we
> added the "disable_stdin" flag, and then much later in
> a12cbe23ef7 (rev-list: make empty --stdin not an error, 2018-08-22) we
> gained a "read_from_stdin" flag.
> 
> The interaction between these is more subtle than they might appear at
> first sight, as noted in a12cbe23ef7. "read_stdin" is not the inverse
> of "disable_stdin", rather we read stdin if we see the "--stdin"
> option.
> 
> The "read" is intended to understood as "I read it", not "you should
> read it". Let's avoid this confusion by using "consume" and "consumed"
> instead, i.e. a word whose present and past tense isn't the same.

Unfortunately, I still find your disambiguation text to be ambiguous...

> diff --git a/revision.c b/revision.c
> index 8140561b6c..69b3812093 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2741,11 +2741,11 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>  			}
>  
>  			if (!strcmp(arg, "--stdin")) {
> -				if (revs->disable_stdin) {
> +				if (revs->stdin_handling == REV_INFO_STDIN_IGNORE) {
>  					argv[left++] = arg;
>  					continue;
>  				}
> -				if (revs->read_from_stdin++)
> +				if (revs->consumed_stdin_per_option++)
>  					die("--stdin given twice?");
>  				read_revisions_from_stdin(revs, &prune_data);
>  				continue;

Eeh. I know this is not logic introduced by your patch, BUT your patch
does change the semantics of the replacement to ->disable_stdin from a
bool to an enum. There is an implicit assumption here - "if
stdin_handling isn't REV_INFO_STDIN_IGNORE, then it must be
REV_INFO_CONSUME_ON_OPTION." That's true during this patch, but becomes
false in the next patch in this series, and it didn't look to me like
this section of code was changed accordingly.
[snip]
> +	/*
> +	 * Did we read from stdin due to stdin_handling ==
> +	 * REV_INFO_STDIN_CONSUME_ON_OPTION and seeing the --stdin
> +	 * option?
>  	 */
> -	int read_from_stdin;
> +	int consumed_stdin_per_option;

And indeed, the comment here confirms the implicit assumption made in
the code. Based on this comment, I'd expect the implementation to
explicitly check that stdin_handling == CONSUME_ON_OPTION.

 - Emily
