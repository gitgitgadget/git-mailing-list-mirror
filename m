Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E49C47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 08:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4D8F610C8
	for <git@archiver.kernel.org>; Mon, 31 May 2021 08:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhEaIRx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 04:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhEaIRv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 04:17:51 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BDFC061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 01:16:11 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id c31-20020a056830349fb02903a5bfa6138bso3478310otu.7
        for <git@vger.kernel.org>; Mon, 31 May 2021 01:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=LcHtw5XMr28CkltdLIw9nQoPLxQ7jBztDfCdCu+7HkU=;
        b=WdPRsruWLgr6EU6sJvj20JiIZT5gKolnM0vdDKks6InaFbNcOZpNlmv6X9MHiC+N4o
         2KEExob7SVcpH5yz7IilqKXurnVwnHbaqcdloboqTZuZxMO+54QREkb5erVXtxlO/klZ
         S92QUMNmRvsPmpC7uCgRqYrv0HE4M7zw1NclUIZNFXO1Cou3ZxLWhpCT1kpVePox5ys6
         /iJJmJbw7n630+QUHwrnRLimrdlcGRKSExgvDrAqEQMmsaGeaXLjus1TbB3pBjxdgCNF
         qLS3nEleFsAwL2oYTBnFAck5LDOTrrdByilBsYFjVjM7nVawF5ghQ1uIOYcNpccOvBhM
         f25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=LcHtw5XMr28CkltdLIw9nQoPLxQ7jBztDfCdCu+7HkU=;
        b=uVNS5N2RMTvKsP18baioDz0DyrjsIwhtI1gpzdPxKIX6eo7rycGy7hTt2Ql/Y9kHd4
         UNrtFuwNibznKx7zrElzmQ2RI/yZyouc3QplJowRK03q24c5Z6YhdTu9cczef9oUe47q
         Gg7Uon1HjgVrG/gV50Y5QsiF3EB8FyzDbNatMgQK8AT0+IF3tq18ZI1RPlfwIE+jAdAy
         ui6dV4S93l9/+NFk/hAiiiUX6RjomoC6orwIdJmYYY9tKONDzSjBn3rS6N1uHE3BgnZT
         3gaRlzIZm2uuthWl0CNA+n2ot+YvLnjnc9ENVRhVolMBeM8s1KOvhNWZ368eUYf8N12w
         CjJg==
X-Gm-Message-State: AOAM5311b9sl6e8YpXvr+uzrCwS/gUuDaq/71d38KzNx7+eVvmHOuvQA
        5ylzGlMpp1jTce9zFprG+TlRji+w3Z6qNA==
X-Google-Smtp-Source: ABdhPJwEgLTNUfNsiinZRqYYQL/M8FgHm6jA2bg5Fx3YQ/urAfUjpp3YA4qH5vHzfkIc5BQ1247oqw==
X-Received: by 2002:a9d:1ca2:: with SMTP id l34mr6838108ota.250.1622448970516;
        Mon, 31 May 2021 01:16:10 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id k21sm2932899otr.3.2021.05.31.01.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 01:16:10 -0700 (PDT)
Date:   Mon, 31 May 2021 03:16:08 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Message-ID: <60b49b48de634_24d2820854@natae.notmuch>
In-Reply-To: <xmqq8s3vwgf0.fsf@gitster.g>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
 <20210529074458.1916817-6-felipe.contreras@gmail.com>
 <xmqq8s3vwgf0.fsf@gitster.g>
Subject: Re: [PATCH 05/15] push: only get the branch when needed
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  builtin/push.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> > diff --git a/builtin/push.c b/builtin/push.c
> > index a2abacf64d..4b3a14278a 100644
> > --- a/builtin/push.c
> > +++ b/builtin/push.c
> > @@ -243,7 +243,7 @@ static int is_workflow_triangular(struct remote *remote)
> >  
> >  static void setup_default_push_refspecs(struct remote *remote)
> >  {
> > -	struct branch *branch = branch_get(NULL);
> > +	struct branch *branch;
> >  	int triangular = is_workflow_triangular(remote);
> >  
> >  	switch (push_default) {
> > @@ -258,6 +258,7 @@ static void setup_default_push_refspecs(struct remote *remote)
> >  	default:
> 
> Not a fault of this step, but please make it a habit to have
> "break;" here.  case label with absolutely no body just looks
> strange and is distracting to the eyes.

All right.

> >  	}
> >  
> > +	branch = branch_get(NULL);
> >  	if (!branch)
> >  		die(_(message_detached_head_die), remote->name);
> 
> This step is the true justification for the splitting of a single
> switch into two switches done in [03/15].  Makes quite a lot of
> sense.

It is one, not the only one. But yeah, the most readily apparent.

-- 
Felipe Contreras
