Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5890C433ED
	for <git@archiver.kernel.org>; Mon, 17 May 2021 13:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4904610E9
	for <git@archiver.kernel.org>; Mon, 17 May 2021 13:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237372AbhEQNde (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 09:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236025AbhEQNde (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 09:33:34 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D2DC061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 06:32:17 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id o27so5652574qkj.9
        for <git@vger.kernel.org>; Mon, 17 May 2021 06:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0SXQZ4+x0ulkVLrb9kaIZQ1IkID6Wvo9olVbocr0P7M=;
        b=vFugkRVh6pXS3e7TEHvdI/zv5nThabVhEtnntMYTwKjifYJKL+KFZQjyJAdRuBgJS0
         sZ/dQOu7DAdyBJdWPofzISgKXA3biQ19ik65MPKi3RsTiFi3ziE6vS4LqFCd4nbAA5wp
         7NxjxzOEAUD3caqKwJzMhZaD9m8HU6N88rAPe+3XzT97jPQ5o1dJjG/4VojbjTgv1iHU
         Cs6RFTsoHMhyEGnUzm4h21Qy3bermNuPKUzCfj4pS8dnkEEp4Cvh+4kkXKSXNlVVIfiK
         hsotRy+aHQWBLKpHB6/x5XZETdxve7NZmkaZFXoJ5ENaJbXC24p+nijmgn3KsqzXPewB
         q9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0SXQZ4+x0ulkVLrb9kaIZQ1IkID6Wvo9olVbocr0P7M=;
        b=iHq7Q8+IjnHIudRKFh8I8T2key2un3Qo3sVVLN/b5d/o7K+gIFmdp6hWxGCEozoFTs
         cGTtUUzff7CpA0PvA7OtpOag484pCeLUDFCg0KMMzLbe0oJnTMyQ9BfULcarPDouYTor
         JXYmzwOflRZFx5TsS7VwQrXQauABJm/lYIoqzpg1qbWQGEgqV/4vTeDd8bCG0jjxYYJR
         WTXi5QN/d0ffSlriYVvl7KEBTWp0kpfWjfQSOUP7rBg/c+2PIB6TDnSemQfbMD8b8v9f
         dCbX/1rV6FPVPJ4KpmnoJf1AOEnI17NkiQpXlY6vGzoY0u5Li41Zs7EUkpP0x132k98S
         OIzg==
X-Gm-Message-State: AOAM5323BQnubqyyCRJgTj812UV+xFb42vU3Ep6zTY5ZvUumN9oRDibg
        36tELwI5RgeMbp/G1hul+po=
X-Google-Smtp-Source: ABdhPJzmg2B+cQSMX66eXStGjCIxMPW3x6W2UqnykulfwEpQ5Vmoddvf54LIE7zNjXwciZdTYjpkjQ==
X-Received: by 2002:a37:a301:: with SMTP id m1mr57389463qke.491.1621258336778;
        Mon, 17 May 2021 06:32:16 -0700 (PDT)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:4c59:3ee5:6b74:d819])
        by smtp.gmail.com with ESMTPSA id h10sm10515919qkh.47.2021.05.17.06.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 06:32:14 -0700 (PDT)
Subject: Re: [PATCH v2 04/13] fast-rebase: write conflict state to working
 tree, index, and HEAD
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
References: <pull.859.git.1616621553.gitgitgadget@gmail.com>
 <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
 <887b151c26ff0f175f2da431d77cd377bd066990.1620094339.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <30c23689-cdab-143e-159c-93e50c808430@gmail.com>
Date:   Mon, 17 May 2021 09:32:14 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <887b151c26ff0f175f2da431d77cd377bd066990.1620094339.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/3/21 10:12 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Previously, when fast-rebase hit a conflict, it simply aborted and left
> HEAD, the index, and the working tree where they were before the
> operation started.  While fast-rebase does not support restarting from a
> conflicted state, write the conflicted state out anyway as it gives us a
> way to see what the conflicts are and write tests that check for them.
> 
> This will be important in the upcoming commits, because sequencer.c is
> only superficially integrated with merge-ort.c; in particular, it calls
> merge_switch_to_result() after EACH merge instead of only calling it at
> the end of all the sequence of merges (or when a conflict is hit).  This
> not only causes needless updates to the working copy and index, but also
> causes all intermediate data to be freed and tossed, preventing caching
> information from one merge to the next.  However, integrating
> sequencer.c more deeply with merge-ort.c is a big task, and making this
> small extension to fast-rebase.c provides us with a simple way to test
> the edge and corner cases that we want to make sure continue working.

This seems a noble goal. I'm worried about the ramifications of such
a change, specifically about the state an automated process would be in
after hitting a conflict.

If I understand correctly, then the old code would abort the rebase and
go back to the previous HEAD location. The new code will pause the
rebase at the previous commit and leave the conflict markers in the
working directory.

The critical change is here:

> -	strbuf_addf(&reflog_msg, "finish rebase %s onto %s",
> -		    oid_to_hex(&last_picked_commit->object.oid),
> -		    oid_to_hex(&last_commit->object.oid));
> -	if (update_ref(reflog_msg.buf, branch_name.buf,
> -		       &last_commit->object.oid,
> -		       &last_picked_commit->object.oid,
> -		       REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR)) {
> -		error(_("could not update %s"), argv[4]);
> -		die("Failed to update %s", argv[4]);
> +	if (result.clean) {
> +		fprintf(stderr, "\nDone.\n");
> +		strbuf_addf(&reflog_msg, "finish rebase %s onto %s",
> +			    oid_to_hex(&last_picked_commit->object.oid),
> +			    oid_to_hex(&last_commit->object.oid));
> +		if (update_ref(reflog_msg.buf, branch_name.buf,
> +			       &last_commit->object.oid,
> +			       &last_picked_commit->object.oid,
> +			       REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR)) {
> +			error(_("could not update %s"), argv[4]);
> +			die("Failed to update %s", argv[4]);
> +		}
> +		if (create_symref("HEAD", branch_name.buf, reflog_msg.buf) < 0)
> +			die(_("unable to update HEAD"));
> +		strbuf_release(&reflog_msg);
> +		strbuf_release(&branch_name);
> +
> +		prime_cache_tree(the_repository, the_repository->index,
> +				 result.tree);
> +	} else {
> +		fprintf(stderr, "\nAborting: Hit a conflict.\n");
> +		strbuf_addf(&reflog_msg, "rebase progress up to %s",
> +			    oid_to_hex(&last_picked_commit->object.oid));
> +		if (update_ref(reflog_msg.buf, "HEAD",
> +			       &last_commit->object.oid,
> +			       &head,
> +			       REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR)) {
> +			error(_("could not update %s"), argv[4]);
> +			die("Failed to update %s", argv[4]);
> +		}
>  	}
> -	if (create_symref("HEAD", branch_name.buf, reflog_msg.buf) < 0)
> -		die(_("unable to update HEAD"));
> -	strbuf_release(&reflog_msg);
> -	strbuf_release(&branch_name);
> -
> -	prime_cache_tree(the_repository, the_repository->index, result.tree);

So perhaps this could use a test case to demonstrate the change in
behavior? Such a test would want to be created before this commit, then
the behavior change is provided as an edit to the test in this commit.

But maybe I'm misunderstanding the change here and such a test is
inappropriate.

Thanks,
-Stolee
