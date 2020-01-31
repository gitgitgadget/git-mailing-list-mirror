Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EEBC2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 18:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C59E0206F0
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 18:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vjOeTzPM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbgAaSW3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:22:29 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58639 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgAaSW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 13:22:29 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9BF6CABBA8;
        Fri, 31 Jan 2020 13:22:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FOK4u58lMi6s1UdAUYnisM73Hso=; b=vjOeTz
        PM+mEFOzLa9zfbdd1aNn0TT40ZS0nGKy2Jxo121E9JLjCYpFnAPyF77eEUhOhlnW
        5fstKy5Lqd6/VOlHjQ1Agm1g8IDsJdZrWgSq7wdVfC2U9GbWpW8utPoZvFbActiv
        4M5ygPgkRf0Je/VWLFeZmAEvQsVi7tfTDlePw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mgj+FQ5M1dbNwqO0cMy/5WqNbEPvlucb
        7P9WjmlOVtmYd1ABHTstJI/yV185Y+jbbqZ8pq8XkOKZ7kjV5wX400ApZiZqi7pE
        1Xh+cXARzYLq6hm3oJ3CONyVPH9Q+p+edU3ms2Rhslv+/6AQqEm9bARt2I8h+Fai
        FSO/F5gXZWo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 934B0ABBA6;
        Fri, 31 Jan 2020 13:22:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 710CCABBA3;
        Fri, 31 Jan 2020 13:22:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v2 06/11] bisect: libify `exit_if_skipped_commits` to `error_if_skipped*` and its dependents
References: <20200128144026.53128-1-mirucam@gmail.com>
        <20200128144026.53128-7-mirucam@gmail.com>
Date:   Fri, 31 Jan 2020 10:22:21 -0800
In-Reply-To: <20200128144026.53128-7-mirucam@gmail.com> (Miriam Rubio's
        message of "Tue, 28 Jan 2020 15:40:21 +0100")
Message-ID: <xmqq5zgrbi5e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A0DA7B64-4456-11EA-A26F-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miriam Rubio <mirucam@gmail.com> writes:

> From: Pranit Bauva <pranit.bauva@gmail.com>
>
> Since we want to get rid of git-bisect.sh it would be necessary to

Please add back the missing comma after ".sh" for readability.

> convert those exit() calls to return statements so that errors can be
> reported.
>
> Emulate try catch in C by converting `exit(<positive-value>)` to
> `return <negative-value>`. Follow POSIX conventions to return
> <negative-value> to indicate error.
>
> Handle this return in dependent function `bisect_next_all()`.

It makes it sound as if there were multiple callers and this change
converted only one of them---"Update all callers to handle the error
returns" would avoid such a misunderstanding.

> diff --git a/bisect.c b/bisect.c
> index 83cb5b3a98..a7a5d158e6 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -661,11 +661,11 @@ static void bisect_common(struct rev_info *revs)
>  		mark_edges_uninteresting(revs, NULL, 0);
>  }
>  
> -static void exit_if_skipped_commits(struct commit_list *tried,
> +static int error_if_skipped_commits(struct commit_list *tried,
>  				    const struct object_id *bad)
>  {
>  	if (!tried)
> -		return;
> +		return 0;
>  
>  	printf("There are only 'skip'ped commits left to test.\n"
>  	       "The first %s commit could be any of:\n", term_bad);
> @@ -676,7 +676,13 @@ static void exit_if_skipped_commits(struct commit_list *tried,
>  	if (bad)
>  		printf("%s\n", oid_to_hex(bad));
>  	printf(_("We cannot bisect more!\n"));
> -	exit(2);
> +
> +	/*
> +	 * We don't want to clean the bisection state
> +	 * as we need to get back to where we started
> +	 * by using `git bisect reset`.
> +	 */

What this comment says may be true, but does it belong here?  After
returning, the caller will exit(2) without cleaning anyway with or
without this patch, so I am a bit puzzled about the comment.

> +	return -2;
>  }
>  
>  static int is_expected_rev(const struct object_id *oid)
> @@ -949,7 +955,7 @@ int bisect_next_all(struct repository *r, const char *prefix, int no_checkout)
>  {
>  	struct rev_info revs;
>  	struct commit_list *tried;
> -	int reaches = 0, all = 0, nr, steps;
> +	int reaches = 0, all = 0, nr, steps, res;
>  	struct object_id *bisect_rev;
>  	char *steps_msg;
>  
> @@ -972,8 +978,9 @@ int bisect_next_all(struct repository *r, const char *prefix, int no_checkout)
>  		 * We should exit here only if the "bad"
>  		 * commit is also a "skip" commit.
>  		 */
> -		exit_if_skipped_commits(tried, NULL);
> -
> +		res = error_if_skipped_commits(tried, NULL);
> +		if (res < 0)
> +			exit(-res);
>  		printf(_("%s was both %s and %s\n"),
>  		       oid_to_hex(current_bad_oid),
>  		       term_good,
> @@ -990,7 +997,9 @@ int bisect_next_all(struct repository *r, const char *prefix, int no_checkout)
>  	bisect_rev = &revs.commits->item->object.oid;
>  
>  	if (oideq(bisect_rev, current_bad_oid)) {
> -		exit_if_skipped_commits(tried, current_bad_oid);
> +		res = error_if_skipped_commits(tried, current_bad_oid);
> +		if (res)
> +			exit(-res);
>  		printf("%s is the first %s commit\n", oid_to_hex(bisect_rev),
>  			term_bad);
>  		show_diff_tree(r, prefix, revs.commits->item);
