Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C65C01F453
	for <e@80x24.org>; Wed, 17 Oct 2018 21:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbeJRFnQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 01:43:16 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:34945 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbeJRFnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 01:43:16 -0400
Received: by mail-qk1-f201.google.com with SMTP id p73-v6so29565796qkp.2
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 14:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JPyp441Cx+8/5msR4E8udBKj7L8k71KXK7/mJpOhOd0=;
        b=j6WCGCsgFpaMDJHBdJXYNftBUgIBOV/69f6M0W/ti4P0QS2O8v6wcDrntGCe+eoRz0
         ak12cyaHwdYXui+ih+Z4hAp5OFYISHkDJfcmG88MrWmSFjjsyDZBFAARwFn0UTRfZr07
         dIjGyMSRkelnZt9R4LlyFS/sjfnORzxtcAmekZOhIgOGTKRybXvyygTPoawK0isux1Ip
         FycCTFJ4tp8h6pBL5g9lzobR5rLLP5Gn3gmi1mZQOQZpR9pkqoRQmnvykrXQ5zX7VK/K
         +Fd0tOHjcOGy/62mfDrnqMYFEBa24zfcXyEcjYXUUrB3QsSsv0+5Pna5REhdMwgsLgzZ
         uQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JPyp441Cx+8/5msR4E8udBKj7L8k71KXK7/mJpOhOd0=;
        b=f3hHlAdNPEJBrh3ctZZuwNIksi8MCnuUSrZnOw5STJIPo2ZZ1rgMGtfyNz2fxVfkdk
         dk6uOkd2uXny0FIi3sg7wtqibCisDtebvVTzajToeMgZIzEVRL39hASgJCXbYr9CaF83
         HgClAnGUMfRWmJzp6jkcXHyANzgCsjXjjPEvWH4NIreCoXHle97vUat+MgXQojj7uJC3
         22k4lh4ATrkNK0Z5rsVOObFI2aBH44IEvWIA611JkQcjRfLbrxFm81q3JEgJKrQCUkL3
         5LwFUUZ1eIMF02tBDn2OoketvKImLcMbVfueDjqS1Rl8UZZhoQ0Jq0bwHUFfjgrkzUQp
         uJyQ==
X-Gm-Message-State: ABuFfohK6bKUiN0L+e12YCwfJymuimot70krjrB2bFm8GULagmr3F2EZ
        8hIk6PqjUAemqPhkPr9wq2P1jsSpyEGWAlJr4Siz
X-Google-Smtp-Source: ACcGV61mDfMS4gUubkuYBkCEPoZug9mdUVDhJNFojJNy/XmSACxNQg7+rYok5ntO0p+mvQ6TvFFZURUrFsv9rIPGyWyn
X-Received: by 2002:a37:a955:: with SMTP id s82-v6mr22914947qke.9.1539812738189;
 Wed, 17 Oct 2018 14:45:38 -0700 (PDT)
Date:   Wed, 17 Oct 2018 14:45:34 -0700
In-Reply-To: <20181016181327.107186-6-sbeller@google.com>
Message-Id: <20181017214534.199890-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181016181327.107186-6-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 5/9] submodule.c: do not copy around submodule list
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     gitster@pobox.com, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> By doing so we'll have access to the util pointer for longer that
> contains the commits that we need to fetch, which will be
> useful in a later patch.

It seems that the main point of this patch is so that the OIDs be stored
in changed_submodule_names, because you need them in a later patch. If
so, I would have expected a commit title like "submodule: store OIDs in
changed_submodule_names".

> @@ -1142,8 +1142,7 @@ static void calculate_changed_submodule_paths(
>  	struct submodule_parallel_fetch *spf)
>  {
>  	struct argv_array argv = ARGV_ARRAY_INIT;
> -	struct string_list changed_submodules = STRING_LIST_INIT_DUP;
> -	const struct string_list_item *name;
> +	struct string_list_item *name;

Prior to this patch, changed_submodules is here just so that we know
what to add to changed_submodule_names (it will be cleared at the end of
the function). So removing it is fine.

> -	collect_changed_submodules(&changed_submodules, &argv);
> +	collect_changed_submodules(&spf->changed_submodule_names, &argv);
>  
> -	for_each_string_list_item(name, &changed_submodules) {
> +	for_each_string_list_item(name, &spf->changed_submodule_names) {

We add all the changed submodules directly to changed_submodule_names,
and iterate over it. So we use changed_submodule_names as a
scratchpad...

> -		if (!submodule_has_commits(path, commits))
> -			string_list_append(&spf->changed_submodule_names,
> -					   name->string);
> +		if (submodule_has_commits(path, commits)) {
> +			oid_array_clear(commits);
> +			*name->string = '\0';
> +		}

...but this is fine because previously, we appended the name->string to
changed_submodule_names (with no util) whereas now, we make the
name->string empty in the opposite condition.

Before this patch, at the end of the loop, we had all the wanted
submodule names with no util in changed_submodule_names. With this
patch, at the end of the loop, we have all the wanted submodule names
with util pointing to an OID array, and also some blanks with util
pointing to a cleared OID array.

> -	free_submodules_oids(&changed_submodules);
> +	string_list_remove_empty_items(&spf->changed_submodule_names, 1);

The local variable changed_submodules no longer exists, so removing that
line is fine.

And we remove all the blanks from changed_submodule_names.

> @@ -1377,7 +1378,7 @@ int fetch_populated_submodules(struct repository *r,
>  
>  	argv_array_clear(&spf.args);
>  out:
> -	string_list_clear(&spf.changed_submodule_names, 1);
> +	free_submodules_oids(&spf.changed_submodule_names);

And because changed_submodule_names now has a non-trivial util pointer,
we need to free it properly.

This patch looks good, except that the commit title and message could
perhaps be clearer.
