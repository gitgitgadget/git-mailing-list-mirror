Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4EA01F516
	for <e@80x24.org>; Fri, 29 Jun 2018 16:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936960AbeF2Q2S (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 12:28:18 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55668 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936957AbeF2Q2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 12:28:16 -0400
Received: by mail-wm0-f68.google.com with SMTP id v16-v6so2800784wmv.5
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 09:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DHbntlu5XF0mLj8hlJ1JH1SSyzWJkFXUE/CxUlbUOPY=;
        b=cNv6/3ZDehpKKO1TcJib6xKFVb82BQ4rqyuBMKA8xRH3jRgoDn4lXBacAo6A/wIJfo
         dsRn//A77sUiGZv8DElt7eCu2ZAe6ZsyP2P8avsmbVFE7eoZ9bO/m5UpgJdV2pSM2F9d
         iMt5/wRh3kMAuJpAXijhhYNAAkXzQuNhwm5ErvT0jpacrVVlT+D79Mi7yvJm2ZGeNDVT
         vh+87w3LagQ75Rt+zwIKVz2NTdH3Bv96w8PiaFNVwGqQ/lkfG/z3YkEM+drf5Ox5wjS7
         Aqm9FS/7uAzCPzCbTqxnrNqxTQi4FHXS1ntB3zwmQnzPbGQSuFi9Zicvq1yxDAm9VtQ8
         vcew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DHbntlu5XF0mLj8hlJ1JH1SSyzWJkFXUE/CxUlbUOPY=;
        b=MkiHgKRd0murx+cUI36Tux1JOUip5HZ/nRL1xU+3e9EFPaR6hj7cW5P29s6s2fE5wg
         TKPjc0meSyKRvJUYDFFFck9zIO/ZtMN7yVmb2pdAstcLiaCf6xDkz6n83R/fAiAOrf3P
         m17/gaOQ3E4PVfrW2o31wjw55dlXw0PyDDhr/5FBuBO1B120We5woTgU6XGnd/Llgxib
         8TfqwazL93u8l1EaWRejLCeFwzc+IDIosnBe/9kRhfSU0qQhDVm1APjzZM81ZKeCJEEJ
         cMO93A/NQrlDGOlsnmh9ZSAmcVQvSg4Shlb7Dif+UW5tIPI4QKyBiCrg6BAOwZrUUiAn
         hT6g==
X-Gm-Message-State: APt69E0X53rL8Wr/ms/7b+Adxvpp4NpbLHTm4uVLR0QTPMMIFojWrQ6s
        L6KCf0/48FHu35ymPCYRocs2KGE/
X-Google-Smtp-Source: AAOMgpfLM4cP4Q89LjBWrX/7N1khMyMQUOW24w61Tjgvnv9XDIH51U9QssV9gJS3CfJBDDi+z4h6PQ==
X-Received: by 2002:a1c:2396:: with SMTP id j144-v6mr1778648wmj.26.1530289695119;
        Fri, 29 Jun 2018 09:28:15 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z14-v6sm11624671wrm.49.2018.06.29.09.28.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 09:28:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com
Subject: Re: [PATCH v3] fetch-pack: support negotiation tip whitelist
References: <20180625193752.255319-1-jonathantanmy@google.com>
        <20180628221551.30406-1-jonathantanmy@google.com>
Date:   Fri, 29 Jun 2018 09:28:13 -0700
In-Reply-To: <20180628221551.30406-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Thu, 28 Jun 2018 15:15:51 -0700")
Message-ID: <xmqq4lhlwo9u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> fetch is a perfect example of supporting all three.  I can do
>>
>>   git fetch origin SHA1
>>   git fetch origin master
>>   git fetch origin refs/heads/*:refs/heads/*
>
> OK, Brandon managed to convince me that this is fine. I've included glob
> support, supporting the same globs that git notes supports.

"git notes"???

As this is to be used in the context of "git fetch", using glob
e.g. "refs/heads/*", is sensible and good enough.  I was actually
wondering if we want the head-match refs/heads/, but as "git fetch
origin refs/heads/" does not work that way, I think we shouldn't.

This is a tangent, but didn't ref-in-want wanted to use head-match
refs/heads/ to match everything under refs/heads/?  If the latest
incarnation wants to do so, we may want to fix that.

> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
> index 97d3217df..6e4db1738 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -42,6 +42,22 @@ the current repository has the same history as the source repository.
>  	.git/shallow. This option updates .git/shallow and accept such
>  	refs.
>  
> +--negotiation-tip=<commit|glob>::
> +	By default, Git will report, to the server, commits reachable
> +	from all local refs to find common commits in an attempt to
> +	reduce the size of the to-be-received packfile. If specified,
> +	Git will only report commits reachable from the given tips.
> +	This is useful to speed up fetches when the user knows which
> +	local ref is likely to have commits in common with the
> +	upstream ref being fetched.
> ++
> +This option may be specified more than once; if so, Git will report
> +commits reachable from any of the given commits.
> ++
> +The argument to this option may be a glob on ref names, a ref, or the (possibly
> +abbreviated SHA-1 of a commit. Specifying a glob is equivalent to specifying
> +this option multiple times, one for each matching ref name.
> +

> +static int add_oid(const char *refname, const struct object_id *oid, int flags,
> +		   void *cb_data)
> +{
> +	struct oid_array *oids = cb_data;
> +	oid_array_append(oids, oid);
> +	return 0;
> +}

This by itself is not worth a reason to reroll, but please make it a
habit to have a blank line after the run of decls before the first
statement, at least while we still forbid decl-after-stmt.  The
result is easier to read that way.

> +static void add_negotiation_tips(struct git_transport_options *smart_options)
> +{
> +	struct oid_array *oids = xcalloc(1, sizeof(*oids));
> +	int i;
> +	for (i = 0; i < negotiation_tip.nr; i++) {
> +		const char *s = negotiation_tip.items[i].string;
> +		int old_nr;
> +		if (!has_glob_specials(s)) {
> +			struct object_id oid;
> +			if (get_oid(s, &oid))
> +				die("%s is not a valid object", s);
> +			oid_array_append(oids, &oid);
> +			continue;
> +		}
> +		old_nr = oids->nr;
> +		for_each_glob_ref(add_oid, s, oids);
> +		if (old_nr == oids->nr)
> +			warning("Ignoring --negotiation-tip=%s because it does not match any refs",
> +				s);
> +	}
> +	smart_options->negotiation_tips = oids;
> +}

This may insert duplicate object ids if two refs point at the same
object, or nego globs match the same ref twice, but it is OK to have
duplicate object ids in the resulting oids array is OK, because
rev_list_insert_ref() at the end will dedup them anyway.

> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index e402aee6a..8532a6faf 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -865,4 +865,82 @@ test_expect_success C_LOCALE_OUTPUT 'fetch compact output' '
>  	test_cmp expect actual
>  '
>  
> +setup_negotiation_tip () {
> +	SERVER="$1"
> +	URL="$2"
> +	USE_PROTOCOL_V2="$3"
> +
> +	rm -rf "$SERVER" client trace &&
> +	git init "$SERVER" &&
> +	test_commit -C "$SERVER" alpha_1 &&
> +	test_commit -C "$SERVER" alpha_2 &&
> +	git -C "$SERVER" checkout --orphan beta &&
> +	test_commit -C "$SERVER" beta_1 &&
> +	test_commit -C "$SERVER" beta_2 &&
> +
> +	git clone "$URL" client &&
> +
> +	if [ "$USE_PROTOCOL_V2" -eq 1 ]

Style: "if test ..."

> +	then
> +		git -C "$SERVER" config protocol.version 2

broken &&-chaining?

> +		git -C client config protocol.version 2
> +	fi &&
> +
> +	test_commit -C "$SERVER" beta_s &&
> +	git -C "$SERVER" checkout master &&
> +	test_commit -C "$SERVER" alpha_s &&
> +	git -C "$SERVER" tag -d alpha_1 alpha_2 beta_1 beta_2
> +}
