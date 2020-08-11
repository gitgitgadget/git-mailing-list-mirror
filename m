Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F189C433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 11:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9B882076C
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 11:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoiInS/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgHKLib (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 07:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728454AbgHKLib (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 07:38:31 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97133C06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 04:38:30 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d188so7477818pfd.2
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 04:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=wm+c+DpWO/ihXEsK3fNpadyZegRulokx/mqx6Ca2eKw=;
        b=IoiInS/D9StnF7tK++JIonnujII5XlO3atpNVEzAQfPmvceLG/Gy3zb/ujXG63yRLR
         zBdvWw/Idqrj+S/N6KKOK8Q2AN15wDUuVAmwFfhhdYx9r000NPN3ulDykskerMChK7ww
         Wd+pxTDa9GXtc6cYI6UU+a4fpNPhToJTgAKg3wqAFw+tPWR1BA+b7wtYa1xPpdyyT1t9
         bzSErr91gVEVYNG9LTgG6F2acPGNuhjF8sitVeI6viQPUd8lJ7pCSRopLEeyyWYCsYWk
         hMmo0nnwClwP36A96gJa5oR2zKvHphqUptJzkZOkp2mHC2It0jGfvHe3cteKDfqut6BN
         5O/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=wm+c+DpWO/ihXEsK3fNpadyZegRulokx/mqx6Ca2eKw=;
        b=R5yoo6g/Qi6Z9A8KzoruJMt5RUGBJLj+WVVx1uqQ7ak2yHpVoPiA01P5gdiQTBpHQJ
         3rcAM4YI8Ans2ABnjrlxRWo6pNtOXdjvlZ891wSG7Hp0N3ZToFQ3PsrEcZgTeYfJmGt3
         N72XLdqSIOCpMSg/JJlTBdWdDlm1PYDCi//EyUU14Cl7VQaQH0MjrAuEb06Gj807pPHi
         s0fz5vu6AiPTKdekO+I4snR+OmSlZVJtIH1QRavrrf43nKC/3BRq/4zM9LDK179d6/i+
         qOnorGqc2Frt9WEEimKrYeJtPLJzin8g4XEoDzqjibnZmsg9zQiQdAILI6KesonmTwjR
         eOhQ==
X-Gm-Message-State: AOAM531ZvGQRa1MrfF/I2TUOA82pF1/6npKe4i6C1+GIxVA/2cuBCc5x
        VbWGr7YEXLcklyQNLwp168A=
X-Google-Smtp-Source: ABdhPJz3CAdEdKCT+t6cIzNBFIpsSDHDRyyydaZHFtKIK+x3AsdM2QYalvk9VhXsBzGH2E/dOxAAeA==
X-Received: by 2002:a63:4726:: with SMTP id u38mr474039pga.246.1597145909914;
        Tue, 11 Aug 2020 04:38:29 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:609:de5a:309a:8147:c746:a173])
        by smtp.gmail.com with ESMTPSA id q33sm16662437pgb.2.2020.08.11.04.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 04:38:29 -0700 (PDT)
Date:   Tue, 11 Aug 2020 17:06:21 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org, me@ttaylorr.com,
        jnareb@gmail.com, gitgitgadget@gmail.com
Subject: Re: [PATCH v2 08/10] commit-graph: handle mixed generation commit
 chains
Message-ID: <20200811113621.GB3220@Abhishek-Arch>
Reply-To: 0d741fb2-e25a-be05-9f2b-81ba2b4ced3f@gmail.com
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
 <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
 <833779ad53eb4f57ae514f4e8964e397845f1ddd.1596941625.git.gitgitgadget@gmail.com>
 <0d741fb2-e25a-be05-9f2b-81ba2b4ced3f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d741fb2-e25a-be05-9f2b-81ba2b4ced3f@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 10, 2020 at 12:42:29PM -0400, Derrick Stolee wrote:
> On 8/8/2020 10:53 PM, Abhishek Kumar via GitGitGadget wrote:
> 
> ...
>
> Hm. So this scenario actually disables generation numbers completely
> in the event that anything in the chain disagrees. I think this is
> not the right way to approach the situation, as it will significantly
> punish users in this state with slow performance.
> 
> The patch I sent [1] is probably better: it uses generation number
> v1 if the tip of the chain does not have a GDAT chunk.
> 
> [1] https://lore.kernel.org/git/a3910f82-ab2e-bf35-ac43-c30d77f3c96b@gmail.com/
> 

Yes, the patch is an clear improvement over my (convoluted and incorrect)
logic. Will add.

>
> ...
> 
> Please make a point to move the line that checks GIT_TEST_COMMIT_GRAPH_NO_GDAT
> from its current location to after this line. We want to make sure that the
> environment variable is checked _last_. The best location is likely the start
> of the implementation of compute_generation_numbers(), or immediately before
> the call to the method.
> 

Sure, will do.

>
> ...
> 
> It would be valuable to double-check here that the values in the GDAT chunk
> are correct. I'm concerned about the possibility that the 'generation'
> member of struct commit_graph_data gets filled with topological level during
> parsing and then that is written as an offset into the CDAT chunk.
> 
> Perhaps this is best left for a follow-up series that updates the 'verify'
> subcommand to check the GDAT chunk.

If I can understand it correctly, one of ways to update 'verify'
subcommand to check the GDAT chunk as well would to be make use of the
flag variable introduced in your patch. We can isolate generation number
related checks and run checks once with flag = 1 (checking corrected
commit dates) and once with flag = 0 (checking topological levels).

This has the unfortunate effect of filling all commits twice, but as we
cannot change the commit_graph_data->generation any other way, I see no
alternatives without changing how commit_graph_generation() works.

Would it make more sense if we add the flag to struct commit_graph
instead of making it depend solely on g->chunk_generation_data and set
it within parse_commit_graph()?

We would be able to control the behavior of fill_commit_graph_info() and
we will not need to check g->chunk_generation_data before filling every
commit.

> 
> Thanks,
> -Stolee
> 

Thanks
- Abhishek
