Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A738CC3F68F
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 12:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF0521D7D
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 12:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkiV1+Qw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbfLKMUm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 07:20:42 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45955 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729220AbfLKMUl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 07:20:41 -0500
Received: by mail-pg1-f196.google.com with SMTP id b9so10299300pgk.12
        for <git@vger.kernel.org>; Wed, 11 Dec 2019 04:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4+YwfUHHPRwpOIsCLuI1+JKMhf2UjfIdu4ZHJnACmDw=;
        b=hkiV1+QwKrY6Jw63POXqFVINZq+tDqWz/C/Kb/PsQAtJ8P/PLVXbqFnUja9DxbTOgl
         YLstIKC7DsAxAwxuP2ZwnKzrcdmnOAUHbAPqXhP+ye5s5DUJecjUYb2qCyUK4qNyQRJF
         Aj9WKBsQhean8SZGnGjgRmHfBzfklow/d4/7wBXQMUDxj4LhlxGkvEvBoUQmItxOLwpR
         BXQLKQ1RFYvtzQv9VNvTkPl6Oy66BwtFnYBRAouFWUeF9d3eZSS7Geq8C2On8f6uhIhg
         eEIsZIH10xMAXtBALobRcOmRPzl4flnPDSq0Q05V6Y+UqTBQdR13Plo8ceOqTr/7bIWP
         W0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4+YwfUHHPRwpOIsCLuI1+JKMhf2UjfIdu4ZHJnACmDw=;
        b=S86//onk82ab0UDKixEK7AOTG5IwMrIRDJCwNjhw2ECopFh9fCkBRC8rbDY/H78/3q
         Fvo3JPBEjsON6RZkip8BWiQpZzzv6JgV9B9LXrFoVloyq+AIPsi8+xC+EGMzfJH0xMUE
         Irbj2a2E//xCsZJ7bJDYE7vO2QXDxHIwtHnMV9SuRx6iHxSRbKQQ7WrUaKcN3i8M+mOI
         npWSy5Qo3bdJesEkdqKm9u3tIyy4gOk+xu2gRx0Zvxx0zISM2YvRPM5OixJPStGxPAJs
         pT05Dl3VQ8PXvfCrjLAapkeCCk3oW7YUMHIN09JY1WUqM8lrmps0fHuv/2kHvqsrLQ54
         03ZQ==
X-Gm-Message-State: APjAAAVsC8HPDehX/CnD6IRoT1PADhEAxXwG5J4lDrwKTmly1zxWUiIb
        4v7UTQe7EzBX99a4ek+5wQ8=
X-Google-Smtp-Source: APXvYqxB6G7OwhILRxf0pf/w3sjEjsoV6QBIGdH8tLW5AJZtvNNHmKijwWKMwzjviGb0ZHwDQhKzJA==
X-Received: by 2002:aa7:9313:: with SMTP id 19mr3308801pfj.160.1576066840192;
        Wed, 11 Dec 2019 04:20:40 -0800 (PST)
Received: from generichostname (c-73-15-240-142.hsd1.ca.comcast.net. [73.15.240.142])
        by smtp.gmail.com with ESMTPSA id u67sm2899142pfu.28.2019.12.11.04.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 04:20:39 -0800 (PST)
Date:   Wed, 11 Dec 2019 04:21:36 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alex Torok <alext9@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/1] rebase: fix --fork-point with short refname
Message-ID: <20191211122136.GA46399@generichostname>
References: <20191205235704.31385-1-alext9@gmail.com>
 <20191209145312.3251-1-alext9@gmail.com>
 <20191209145312.3251-2-alext9@gmail.com>
 <xmqq36dtwcvw.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq36dtwcvw.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex,

There are a couple of small issues with the patch below. If you iterate
on it, here are some small suggestions:

On Mon, Dec 09, 2019 at 10:51:47AM -0800, Junio C Hamano wrote:
> Subject: rebase: --fork-point regression fix
> 
> "git rebase --fork-point master" used to work OK, as it internally
> called "git merge-base --fork-point" that knew how to handle short
> refname and dwim it to the full refname before calling the
> underlying get_fork_point() function.
> 
> This is no longer true after the command was rewritten in C, as its
> internall call made directly to get_fork_point() does not dwim a
> short ref.
> 
> Move the "dwim the refname argument to the full refname" logic that
> is used in "git merge-base" to the underlying get_fork_point()
> function, so that the other caller of the function in the
> implementation of "git rebase" behaves the same way to fix this
> regression.
> 
> ---
>  builtin/merge-base.c         | 12 +-----------
>  commit.c                     | 15 +++++++++++++--
>  t/t3431-rebase-fork-point.sh | 20 ++++++++++++++++++++
>  3 files changed, 34 insertions(+), 13 deletions(-)
> 
> diff --git a/builtin/merge-base.c b/builtin/merge-base.c
> index e3f8da13b6..6719ac198d 100644
> --- a/builtin/merge-base.c
> +++ b/builtin/merge-base.c
> @@ -114,26 +114,16 @@ static int handle_is_ancestor(int argc, const char **argv)
>  static int handle_fork_point(int argc, const char **argv)
>  {
>  	struct object_id oid;
> -	char *refname;
>  	struct commit *derived, *fork_point;
>  	const char *commitname;
>  
> -	switch (dwim_ref(argv[0], strlen(argv[0]), &oid, &refname)) {
> -	case 0:
> -		die("No such ref: '%s'", argv[0]);
> -	case 1:
> -		break; /* good */
> -	default:
> -		die("Ambiguous refname: '%s'", argv[0]);
> -	}
> -

In the unabridged v3, you cleaned this up by marking it for translation
and also lowercasing the first letter of the sentence. That was good.

If you iterate on this, could you create a preparatory patch before this
one that gives the same treatment to the other strings in merge-base? I
count 8 instances of die() being called in merge-base so I think that
the cleanup shouldn't be too arduous.

If we have a preparatory patch before this one, this patch will mostly
be pure code movement which would be nice.

>  	commitname = (argc == 2) ? argv[1] : "HEAD";
>  	if (get_oid(commitname, &oid))
>  		die("Not a valid object name: '%s'", commitname);
>  
>  	derived = lookup_commit_reference(the_repository, &oid);
>  
> -	fork_point = get_fork_point(refname, derived);
> +	fork_point = get_fork_point(argv[0], derived);
>  
>  	if (!fork_point)
>  		return 1;
> diff --git a/commit.c b/commit.c
> index 40890ae7ce..016f14fe95 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -903,12 +903,22 @@ struct commit *get_fork_point(const char *refname, struct commit *commit)
>  	struct commit_list *bases;
>  	int i;
>  	struct commit *ret = NULL;
> +	char *full_refname;
> +
> +	switch (dwim_ref(refname, strlen(refname), &oid, &full_refname)) {
> +	case 0:
> +		die("No such ref: '%s'", refname);
> +	case 1:
> +		break; /* good */
> +	default:
> +		die("Ambiguous refname: '%s'", refname);
> +	}

Yeah, we should fix these strings in the next iteration.

>  
>  	memset(&revs, 0, sizeof(revs));
>  	revs.initial = 1;
> -	for_each_reflog_ent(refname, collect_one_reflog_ent, &revs);
> +	for_each_reflog_ent(full_refname, collect_one_reflog_ent, &revs);
>  
> -	if (!revs.nr && !get_oid(refname, &oid))
> +	if (!revs.nr)
>  		add_one_commit(&oid, &revs);
>  
>  	for (i = 0; i < revs.nr; i++)
> @@ -934,6 +944,7 @@ struct commit *get_fork_point(const char *refname, struct commit *commit)
>  
>  cleanup_return:
>  	free_commit_list(bases);
> +	free(full_refname);
>  	return ret;
>  }
>  
> diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
> index 78851b9a2a..5b09aecd13 100755
> --- a/t/t3431-rebase-fork-point.sh
> +++ b/t/t3431-rebase-fork-point.sh
> @@ -47,11 +47,31 @@ test_rebase 'G F B A' --keep-base
>  test_rebase 'G F C E D B A' --no-fork-point
>  test_rebase 'G F C D B A' --no-fork-point --onto D
>  test_rebase 'G F C B A' --no-fork-point --keep-base
> +
>  test_rebase 'G F E D B A' --fork-point refs/heads/master
> +test_rebase 'G F E D B A' --fork-point master
> +
>  test_rebase 'G F D B A' --fork-point --onto D refs/heads/master
> +test_rebase 'G F D B A' --fork-point --onto D master
> +
>  test_rebase 'G F B A' --fork-point --keep-base refs/heads/master
> +test_rebase 'G F B A' --fork-point --keep-base master
> +
>  test_rebase 'G F C E D B A' refs/heads/master
> +test_rebase 'G F C E D B A' master
> +
>  test_rebase 'G F C D B A' --onto D refs/heads/master
> +test_rebase 'G F C D B A' --onto D master
> +
>  test_rebase 'G F C B A' --keep-base refs/heads/master
> +test_rebase 'G F C B A' --keep-base master
> +
> +test_expect_success "git rebase --fork-point with ambigous refname" "
> +	git checkout master &&
> +	git checkout -b one &&
> +	git checkout side &&
> +	git tag one &&
> +	test_must_fail git rebase --fork-point --onto D one
> +"

nit: use double-quotes instead of single-quotes to surround both the
test case name and the actual code itself.

Thanks,

Denton

>  
>  test_done
