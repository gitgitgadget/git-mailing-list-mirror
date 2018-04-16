Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F325F1F404
	for <e@80x24.org>; Mon, 16 Apr 2018 00:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeDPAhJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 20:37:09 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:34746 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751919AbeDPAhI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 20:37:08 -0400
Received: by mail-wr0-f172.google.com with SMTP id d19so21284542wre.1
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 17:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+EHyx7ETuRQO09/cgRyk0L0nAhppsFNDH2ecvbOC5s4=;
        b=bhS4uMXTsATABJRs/4REMZd3/ChfSHCLa+bMDuOHvID6qLDs2cC29id4BI1RTIiYsN
         Ye/vAGev1Dlv8+v6wG4FKBViLLpSaYA6Zc8D4Wx+tB60EcrA72nYgarNOdrj8YNU0PWP
         6FotQFW7rtIbNC6ryE3nF1yAzCmQdKNm2Pr/x/lByeQhFeWQc/LFypgFj3xcGUKyB0cw
         vAimyJaxYu86Bmiql1vLYamxpSNLG5ffokH8eytwe2h2LqSQFGJLJ55vJNHhbHdd4L0P
         k9SfUuvodX7XCAh/ILPQ1GXayoizf7pdeFn/mUukn8Mw0x/651Riyg5uijXmF/DxV0IH
         avfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+EHyx7ETuRQO09/cgRyk0L0nAhppsFNDH2ecvbOC5s4=;
        b=Scx6DmYL+KVdblqcVD9N1UpbveoMhiPvgcn4P5+8vlD0lnLAyx1mOyY7/sv34THbjP
         lrVtxfIuyHQ7aQPIXOIhpcmy5j9MBZHhLwfn9JwTQzuf1C7pKyesD1Ks7SRnPoN20V61
         f8r3BsGmgdJviyMbaIWjRFKp3VzznaCAtsd8ge4chhwkhVuEWuu4Y7YTiTFNdHracMeI
         UOzB/EF7cS9IzLanv6lui95WoQ9/EGCkXIfntFIgMTOL0dskKRJq5Zzqx+rXecNa0gsa
         8va3ziDTJG2zuV8JJ6g9awR00pwzJxHMf/331DUUK/iEOa74zthWUR/ETw4m3RQc7MAi
         Kgug==
X-Gm-Message-State: ALQs6tA3jLb3npK+EGaEJTVU/hA2ikpZiL1YBlknL1klrVfWRmpTgW4w
        9OL9M/iOrJnZXiO2Gjxr4nA=
X-Google-Smtp-Source: AIpwx48q4PrAKHd1RPK3iOMWXCo6YvDMSwNeTKSNx/hhvGXIBcnR91OdyaQf7UbLHM9/9P+7AKtM/w==
X-Received: by 10.223.163.135 with SMTP id l7mr1641719wrb.133.1523839027192;
        Sun, 15 Apr 2018 17:37:07 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q81sm8774717wmg.8.2018.04.15.17.37.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Apr 2018 17:37:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, torvalds@linux-foundation.org,
        sbeller@google.com
Subject: Re: [PATCH v9 29.75/30] merge-recursive: Fix was_tracked() to quit lying with some renamed paths
References: <xmqqmuya43cs.fsf@gitster-ct.c.googlers.com>
        <20180413195607.18091-1-newren@gmail.com>
        <20180413195607.18091-4-newren@gmail.com>
Date:   Mon, 16 Apr 2018 09:37:04 +0900
In-Reply-To: <20180413195607.18091-4-newren@gmail.com> (Elijah Newren's
        message of "Fri, 13 Apr 2018 12:56:06 -0700")
Message-ID: <xmqqo9ikyojz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> @@ -362,13 +363,17 @@ static int git_merge_trees(struct merge_options *o,
>  	init_tree_desc_from_tree(t+2, merge);
>  
>  	rc = unpack_trees(3, t, &o->unpack_opts);
> +	cache_tree_free(&active_cache_tree);
> +
> +	o->orig_index = the_index;
> +	the_index = tmp_index;
> +
>  	/*
> -	 * unpack_trees NULLifies src_index, but it's used in verify_uptodate,
> -	 * so set to the new index which will usually have modification
> -	 * timestamp info copied over.
> +	 * src_index is used in verify_uptodate, but was NULLified in
> +	 * unpack_trees, so we need to set it back to the original index.
>  	 */

Was NULLified?  I thought that the point of src/dst distinction
Linus introduced long time ago at 34110cd4 ("Make 'unpack_trees()'
have a separate source and destination index", 2008-03-06) was that
we can then keep the source side of the traversal unmodified.

> -	o->unpack_opts.src_index = &the_index;
> -	cache_tree_free(&active_cache_tree);
> +	o->unpack_opts.src_index = &o->orig_index;

> -static int was_tracked(const char *path)
> +/*
> + * Returns whether path was tracked in the index before the merge started
> + */
> +static int was_tracked(struct merge_options *o, const char *path)
>  {
> -	int pos = cache_name_pos(path, strlen(path));
> +	int pos = index_name_pos(&o->orig_index, path, strlen(path));
>  
>  	if (0 <= pos)
> -		/* we have been tracking this path */
> +		/* we were tracking this path before the merge */
>  		return 1;
>  
> -	/*
> -	 * Look for an unmerged entry for the path,
> -	 * specifically stage #2, which would indicate
> -	 * that "our" side before the merge started
> -	 * had the path tracked (and resulted in a conflict).
> -	 */
> -	for (pos = -1 - pos;
> -	     pos < active_nr && !strcmp(path, active_cache[pos]->name);
> -	     pos++)
> -		if (ce_stage(active_cache[pos]) == 2)
> -			return 1;
>  	return 0;
>  }

I do agree with the simplicity of the new code that directly asks
exactly what we want to ask.  However, there is one thing that is
puzzling below...

>  static int would_lose_untracked(const char *path)
>  {
> -	return !was_tracked(path) && file_exists(path);
> +	/*
> +	 * This may look like it can be simplified to:
> +	 *   return !was_tracked(o, path) && file_exists(path)
> +	 * but it can't.  This function needs to know whether path was
> +	 * in the working tree due to EITHER having been tracked in the
> +	 * index before the merge OR having been put into the working copy
> +	 * and index by unpack_trees().  Due to that either-or requirement,
> +	 * we check the current index instead of the original one.
> +	 */

If this path was created by merge-recursive, not by unpack_trees(),
what does this function want to say?  Say, we are looking at path P,
the other branch we are merging moved some other path Q to P (while
our side modified contents at path Q).  Then path P we are looking
at has contents of Q at the merge base at stage #1, the contents of
Q from our HEAD at stage #2 and the contents of P from the other
branch at stage #3.  The code below says "path P is OK, we won't
lose it" in such a case, but it is unclear if the above comment
wants to also cover that case.

> +	int pos = cache_name_pos(path, strlen(path));
> +
> +	if (pos < 0)
> +		pos = -1 - pos;
> +	while (pos < active_nr &&
> +	       !strcmp(path, active_cache[pos]->name)) {
> +		/*
> +		 * If stage #0, it is definitely tracked.
> +		 * If it has stage #2 then it was tracked
> +		 * before this merge started.  All other
> +		 * cases the path was not tracked.
> +		 */
> +		switch (ce_stage(active_cache[pos])) {
> +		case 0:
> +		case 2:
> +			return 0;
> +		}
> +		pos++;
> +	}
> +	return file_exists(path);
>  }
>  
>  static int was_dirty(struct merge_options *o, const char *path)
