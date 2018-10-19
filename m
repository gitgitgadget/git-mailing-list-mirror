Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCA681F453
	for <e@80x24.org>; Fri, 19 Oct 2018 20:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbeJTErV (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 00:47:21 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:36028 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbeJTErV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 00:47:21 -0400
Received: by mail-qt1-f201.google.com with SMTP id u28-v6so38652443qtu.3
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 13:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=H0T7YgG1xbt0gbX87gwl3asjhT+ji0QKyLQjoxroTlo=;
        b=nK9jSIUMs3hCGXDcbKKzk6mT9ysVONAMv+xRNtNf1tjes25eYnPxEiO+2NLp5rv+ST
         v7qcHq8Ctyle8myR2EudSCtxPBVwSGl0kpWM5BK5cmN+sHU8HoyiHlS65LreE0kyUs9H
         aSeRJYreLx/gacB03GsprI60oDY1mjxKx9iuZXyZgG82Zyigq4ZCaq57AMG8ZK2O17TA
         tZXjPJY6vF5z/kGzeENug8kPQPd7HamFJVmk6rUDCr/z2TVDXGU+d4DIZxvBDwUFlhUc
         XcWyD5E7ZWEsWuPEuZNgk+kiMbiHKtRpt2LIFlsudC+UMdgItmwBQvlOb+AenHmIXNLv
         SkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=H0T7YgG1xbt0gbX87gwl3asjhT+ji0QKyLQjoxroTlo=;
        b=S528eK6UBuCoZYsn9Cxw64OBmtdEfWZeSM50H7xsMYCTNdG/S20M3QENqcrtggpW8i
         QTBRJb5sqyr/+87a4aL64w6DbtfXMkiL9LWn5/EibbzKdvj97ompCa3/ADQerb84eJJ8
         pyNkr6WodtvOxCmXosIapLErV1ut9yAk72lKGDEfrPSF4Jr9FdF7l6lyZZPYwjyL09P+
         OG27WXbgd8KYh2pC0l8R1gKBpriMqgGsE9QdlBMcc6iXtpdq/pA8BaII2Rzk+c32bptG
         crZCX1qm+iKW1i8vQNzxBftfuw2bFXwsU60XIpgLZIXHC6Am4mYqB3adhvMxGaFZ8a1t
         8bCA==
X-Gm-Message-State: AGRZ1gLgE9r2f3Xe8U9BUq1bHUtYNsUhgViH6IZEoBgvx1NWFEpqoNMB
        o4NDO7Q8l+//Lf7BJvHCzQk4030VwL4ttb+7NWsl
X-Google-Smtp-Source: AJdET5ePo7z9lp+Ot8MQlsVmSJPIYLsHilaUN6+91w3UQLmAIJhJ3cmyU5MHnI6vlQTvxT8sL1cg+/hMrjxrZ2Qar4zb
X-Received: by 2002:a0c:b91f:: with SMTP id u31mr2729439qvf.9.1539981580515;
 Fri, 19 Oct 2018 13:39:40 -0700 (PDT)
Date:   Fri, 19 Oct 2018 13:39:37 -0700
In-Reply-To: <20181016233550.251311-20-sbeller@google.com>
Message-Id: <20181019203937.111225-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181016233550.251311-20-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 19/19] submodule: don't add submodule as odb for push
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> In push_submodule(), because we do not actually need access to objects
> in the submodule, do not invoke add_submodule_odb().
> (for_each_remote_ref_submodule() does not require access to those
> objects, and the actual push is done by spawning another process,
> which handles object access by itself.)

The code looks good - my analysis is the same as that in my review of
the previous version [1].

Can you mention, in the commit message, the tests that exercise the
functionality here (and say that they still pass)?

[1] https://public-inbox.org/git/20181011230028.200488-1-jonathantanmy@google.com/
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/submodule.c b/submodule.c
> index 7305ae2e10..e623e6bf7f 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1024,9 +1024,6 @@ static int push_submodule(const char *path,
>  			  const struct string_list *push_options,
>  			  int dry_run)
>  {
> -	if (add_submodule_odb(path))
> -		return 1;
> -
>  	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
>  		struct child_process cp = CHILD_PROCESS_INIT;
>  		argv_array_push(&cp.args, "push");
> -- 
> 2.19.0
> 
