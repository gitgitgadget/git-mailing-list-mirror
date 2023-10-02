Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31FBE776CB
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 22:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjJBWzx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Oct 2023 18:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjJBWzw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2023 18:55:52 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECA5A6
        for <git@vger.kernel.org>; Mon,  2 Oct 2023 15:55:49 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a22029070bso7689457b3.3
        for <git@vger.kernel.org>; Mon, 02 Oct 2023 15:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696287348; x=1696892148; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZCA/wgz55AeBJIfGzJrvdxM2kFbgzMr7O94RlsAwkVs=;
        b=1u5wh6m1q5nUJT4aZHCA3cB7U2pP5e37caZvdazGOKeAgjH47pW5mzS2x6RZ9OwONo
         nHMLTkicdY2gO31ajdamSWALbA0J3/eY+qiVUJ04/hGIabIycYRUKFvQ+gw3OaPI4EqJ
         QmB9kwWOsvX8x1b0cWQ9k6MjulJ6U3VuUdsS22ZUNMj1FzUIJbJIbxqqq1DlvpHW4+/T
         w7C2S6DCnsNpuLdCxzpQX77y9Abu6WLxMYRh3QV4irafI7hu2lCMK/mJMMK0S3/pLXsS
         mlIKN4bSGT/4773E/a3D57PY/ZrQPwFQ6Wu86UAZJCqysDCUjskJKmH4TLIMm9yU7zHH
         XuTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696287348; x=1696892148;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCA/wgz55AeBJIfGzJrvdxM2kFbgzMr7O94RlsAwkVs=;
        b=uDcR7EX8xiOfa6nbvsxaW1nak4S53xszNrjViiWlKqCqhqpe9Zo58KvixL2yvr/5lA
         /CUYmUYMK0xR7b0Hfc1JBXly8/WsveEaexd6CCnkmj3Q73d/lr8WiITPXcIAL/WgzaK7
         Us5U58QiiguixqAHHhtqI9bVmsE/lPVcPQQXMGPer57rHF71RjMzCmqzTXkC2VfR/kK/
         vU2CHGpF+bR0VVxwpinqylTLIBWVqNV4564fb7kYdNj0U62nkidSS+BApXJsHS09EbDJ
         8L9waM1AW/gG7cejmlu8riJ6OOiu2Ucd7UrFDdlEL4sTj/oUidheg4W3BsAyKURJdbSP
         s/Tw==
X-Gm-Message-State: AOJu0Yz+a3+kTech3zLrRewvAT5HvCNNsbHnBLF80ocQ5dRpU+rBt/pQ
        WEMbqGucSQXMdcnBdTQ/J8fMgKjYw+oC1GtaQSzI
X-Google-Smtp-Source: AGHT+IEKhhhq1mBVV60t9y78QP+YBofSNS9G+kkJCVoj+fJqV9HNioEBnNGS6mLNuCF7za1TfJm5iP11NHBtNxEEw6Pq
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:650e:bad8:6cb:f9db])
 (user=jonathantanmy job=sendgmr) by 2002:a81:4102:0:b0:59b:f863:6f60 with
 SMTP id o2-20020a814102000000b0059bf8636f60mr217825ywa.4.1696287348242; Mon,
 02 Oct 2023 15:55:48 -0700 (PDT)
Date:   Mon,  2 Oct 2023 15:55:46 -0700
In-Reply-To: <ZQnmTXUO94/Qy8mq@nand.local>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231002225546.409837-1-jonathantanmy@google.com>
Subject: Re: [RFC PATCH] Not computing changed path filter for root commits
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        "=?UTF-8?q?SZEDER=20G=C3=A1bor?=" <szeder.dev@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:
> diff --git a/revision.c b/revision.c
> index 2f4c53ea20..1d36df49e2 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -837,14 +837,24 @@ static int rev_compare_tree(struct rev_info *revs,
>  static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit)
>  {
>  	struct tree *t1 = repo_get_commit_tree(the_repository, commit);
> +	int bloom_ret = 1;
> 
>  	if (!t1)
>  		return 0;
> 
> +	if (revs->bloom_keys_nr) {
> +		bloom_ret = check_maybe_different_in_bloom_filter(revs, commit);
> +		if (!bloom_ret)
> +			return 1;
> +	}
> +
>  	tree_difference = REV_TREE_SAME;
>  	revs->pruning.flags.has_changes = 0;
>  	diff_tree_oid(NULL, &t1->object.oid, "", &revs->pruning);
> 
> +	if (bloom_ret == 1 && tree_difference == REV_TREE_SAME)
> +		count_bloom_filter_false_positive++;
> +
>  	return tree_difference == REV_TREE_SAME;
>  }

I'll concentrate on getting this patch in, and will look at (and
discuss) the other Bloom filter-related emails later.

This looks good, possibly except a code path in try_to_simplify_commit()
that calls this rev_same_tree_as_empty() function when
rev_compare_tree() between a commit and its parent returns REV_TREE_NEW.
So there are 2 issues: How can rev_compare_tree() ever return
REV_TREE_NEW? And it doesn't seem right to check Bloom filters in this
code path, since rev_same_tree_as_empty() was invoked here while we are
enumerating through a commit's parents, which necessarily implies that
the commit has parents, but here we're using the Bloom filter as if the
commit is known to have no parents.

As for the first issue, rev_compare_tree() returns REV_TREE_NEW when the
parent's tree is NULL. I'm not sure how this can happen - the tree can
be NULL if the parent commit is not parsed, but at this point I think
that it has been parsed. And I think every commit has a tree. This goes
back all the way to 3a5e860815 (revision: make tree comparison functions
take commits rather than trees, 2008-11-03) and even beyond that (I
didn't dig further).

As for the second issue, we can probably solve this by being defensive
in rev_same_tree_as_empty() by only using the Bloom filter when the
commit has no parents. Not sure if this is being overly defensive,
though.

There is also the issue that count_bloom_filter_false_positive is
incremented even when no Bloom filters are present, but I think this is
fine (it matches the behavior of rev_compare_tree()).

