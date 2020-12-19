Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F15FC3526C
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 13:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D9FD23B27
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 13:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgLSNhQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 08:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgLSNhP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 08:37:15 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAF7C061282
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 05:36:35 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id x13so6175875oic.5
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 05:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=EYW9Vwq9hVTBc1OR+VnQ8v9aY9in9qveTatVyWf7pQk=;
        b=bItZeYVTMWi3KtmVePF3Uh4tZIh8niyM9PejnU8jZUBRk7h8VHGpgR1PA1bgDLg21C
         gC5a+AIuMeztOwg+vjJqNYO3+k3tZpsckDLylv/lWDFK++8gIK6MKPFP3JFvXjNiTIX/
         51SQX+FYWL3MIh0I/gHSPr5pxGkzDFiFeY7cjreKeSalJ3Zs5U9I39P1EKfV1EUQE11O
         VVH7x9lprxuy+HhB4rqkiY28My2cc1/71KgBDSbDFXG79I6gy0jOYPls2L6jBam10T5E
         gRrdvn492GoLoO+j0o25NF5dLBai3SsMQ9lAwQrsG5enFqGSnCWnv7XIHQqfjlK55xle
         xVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=EYW9Vwq9hVTBc1OR+VnQ8v9aY9in9qveTatVyWf7pQk=;
        b=NFcQ8eL93X4aU0Zd5mVIn0X9fdSukrDLGXCPdwQ0tJsIiKa7hlrXEsc+vVrmJvx8hA
         7s3z5f8R40axx4cJTXTk82Hi4YPrfKDEe83bZz1PYRR+Yr2wKDnETmqpIRGPwTlFaXPb
         h6Zax3H57KF1nFdu2P5IBuH5Cv5p2NI1+KXf90PyJuLVPqC5UrR6XwM58KwSgu1gvfsJ
         +/404NSWzc6LvcF9BgzoHxhpgEWBts/mUx2cuLicnOIGQZQpAVBSxj0eOyLSgp8wrSRB
         y6nbJ6sQnx2BfqsPOB9uGuQpcdMXb9QJzTToLLWTVQzP5TUxIZDELYSi3ZkLxVxQRY4q
         VSIA==
X-Gm-Message-State: AOAM5326wW9So3W0E0dBW6W1LMzFttRW04MQfI3uQtOqi1/7NboHi5Fl
        BDHY8+kanrNYZKg5mJuAYIg=
X-Google-Smtp-Source: ABdhPJw5rQAv495XTPcB07/CVU8QuJuG4Z5VbHjf3mfJ9X/QYSdrwb4tbTNCOMSylL8gjojzEfzeEw==
X-Received: by 2002:aca:a952:: with SMTP id s79mr5824391oie.140.1608384994763;
        Sat, 19 Dec 2020 05:36:34 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id w138sm2390590oie.44.2020.12.19.05.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 05:36:34 -0800 (PST)
Date:   Sat, 19 Dec 2020 07:36:33 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Message-ID: <5fde01e133b93_1de0de20818@natae.notmuch>
In-Reply-To: <20201216184929.3924-27-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201216184929.3924-1-sorganov@gmail.com>
 <20201216184929.3924-27-sorganov@gmail.com>
Subject: RE: [PATCH v2 26/33] diff-merges: let new options enable diff without
 -p
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov wrote:
> diff --git a/log-tree.c b/log-tree.c
> index f9385b1dae6f..67060492ca0a 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -899,15 +899,21 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
>  	int showed_log;
>  	struct commit_list *parents;
>  	struct object_id *oid;
> +	int is_merge;
> +	int regulars_need_diff = opt->diff || opt->diffopt.flags.exit_with_status;
>  
> -	if (!opt->diff && !opt->diffopt.flags.exit_with_status)
> +	if (!regulars_need_diff && !opt->merges_need_diff)
>  		return 0;
>  
>  	parse_commit_or_die(commit);
>  	oid = get_commit_tree_oid(commit);
>  
> -	/* Root commit? */
>  	parents = get_saved_parents(opt, commit);
> +	is_merge = parents && parents->next;
> +	if(!is_merge && !regulars_need_diff)
> +		return 0;

Missed a space:

        if (!is_merge && !regulars_need_diff)

-- 
Felipe Contreras
