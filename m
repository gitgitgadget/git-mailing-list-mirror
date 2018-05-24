Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BB651F42D
	for <e@80x24.org>; Thu, 24 May 2018 14:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970314AbeEXOFB (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 10:05:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61773 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967626AbeEXOE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 10:04:57 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F58EE3207;
        Thu, 24 May 2018 10:04:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=gvJTAT87gQkxpbjdC0v7CofCTSg=; b=LdZ9mT2
        v8oT2JSHUysbpJSf/142OhMrmV2U009wNly+7WsTSAk4zFcje7VktCuPHNfdjghQ
        MEjfcWbaDTNxJpREqnduUl3z1F2DC3GkCyGzPN7MioTa2gKDzYvgBKpxssEOhDHW
        EnQ7AVYr5CYVXJl5EYVfc7iEgZNVnXcJuox8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=AUuzPPoNIqVrli+lnDN8Hkbhd+8cwuZv0
        O4VZ1OXfVEvMjiTIe/KiYkuNsUskt0TAk8O5UCv8vhP+7MinE1lnD6qiXXhFdJ5D
        JqmnBiCmLqvFSkzFjyD4Ct5LW1RlbMKN30nSPKXuqW2deAlG1W0wpqCUmo+9Up8u
        oED+vrTNzk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 97CC3E3205;
        Thu, 24 May 2018 10:04:56 -0400 (EDT)
Received: from zaya.teonanacatl.net (unknown [98.111.125.125])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 21D4BE3203;
        Thu, 24 May 2018 10:04:56 -0400 (EDT)
Date:   Thu, 24 May 2018 10:04:54 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com,
        B.Steinbrink@gmx.de, sbejar@gmail.com,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH v2] rev-parse: check lookup'ed commit references for NULL
Message-ID: <20180524140454.GC26695@zaya.teonanacatl.net>
References: <20180523220915.GB32171@sigill.intra.peff.net>
 <20180524062733.5412-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524062733.5412-1-newren@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Pobox-Relay-ID: 7017EF0C-5F5B-11E8-8764-44CE1968708C-09356542!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Added Florian to Cc]

Elijah Newren wrote:
> Commits 2122f8b963d4 ("rev-parse: Add support for the ^! and ^@ syntax",
> 2008-07-26) and 3dd4e7320d ("Teach rev-parse the ... syntax.", 2006-07-04)
> taught rev-parse new syntax, and used lookup_commit_reference() as part of
> their logic.  Neither usage checked the returned commit to see if it was
> non-NULL before using it.  Check for NULL and ensure an appropriate error
> is reported to the user.
> 
> Reported by Florian Weimer and Todd Zullinger.
> 
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---

The output is now much more consistent with other invalid
input.  The only (minor) difference I noticed was when using
the fff...fff form.  With exactly 40 chars, rev-parse prints
both refs separately and then the full input string before
the "fatal:" error.  I doubt it's terribly important.

# exactly 40 chars
$ ./git-rev-parse ffffffffffffffffffffffffffffffffffffffff...ffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffff...ffffffffffffffffffffffffffffffffffffffff
fatal: ambiguous argument 'ffffffffffffffffffffffffffffffffffffffff...ffffffffffffffffffffffffffffffffffffffff': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'

# not 40 chars
$ ./git-rev-parse fffffffffffffffffffffffffffffffffffffff...fffffffffffffffffffffffffffffffffffffff
fffffffffffffffffffffffffffffffffffffff...fffffffffffffffffffffffffffffffffffffff
fatal: ambiguous argument 'fffffffffffffffffffffffffffffffffffffff...fffffffffffffffffffffffffffffffffffffff': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'

> I would have used a Reported-by tag for Florian and Todd, but looking at
> the bugzilla.redhat.com bug report doesn't show me Florian's email
> address.  I grepped through git logs and found two associated with that
> name, but didn't know if they were still accurate, or were a different
> Florian.  So I just went with the sentence instead.

I added Florian to Cc, in case he wants to provide a
preferred address.  (The Red Hat Bugzilla only shows
email addresses if you're logged in.)

Thanks Elijah and Peff.

>  builtin/rev-parse.c          | 8 ++++++--
>  t/t6101-rev-parse-parents.sh | 8 ++++++++
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index a1e680b5e9..a0a0ace38d 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -282,6 +282,10 @@ static int try_difference(const char *arg)
>  			struct commit *a, *b;
>  			a = lookup_commit_reference(&start_oid);
>  			b = lookup_commit_reference(&end_oid);
> +			if (!a || !b) {
> +				*dotdot = '.';
> +				return 0;
> +			}
>  			exclude = get_merge_bases(a, b);
>  			while (exclude) {
>  				struct commit *commit = pop_commit(&exclude);
> @@ -328,12 +332,12 @@ static int try_parent_shorthands(const char *arg)
>  		return 0;
>  
>  	*dotdot = 0;
> -	if (get_oid_committish(arg, &oid)) {
> +	if (get_oid_committish(arg, &oid) ||
> +	    !(commit = lookup_commit_reference(&oid))) {
>  		*dotdot = '^';
>  		return 0;
>  	}
>  
> -	commit = lookup_commit_reference(&oid);
>  	if (exclude_parent &&
>  	    exclude_parent > commit_list_count(commit->parents)) {
>  		*dotdot = '^';
> diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
> index 8c617981a3..7683e4a114 100755
> --- a/t/t6101-rev-parse-parents.sh
> +++ b/t/t6101-rev-parse-parents.sh
> @@ -214,4 +214,12 @@ test_expect_success 'rev-list merge^-1x (garbage after ^-1)' '
>  	test_must_fail git rev-list merge^-1x
>  '
>  
> +test_expect_success 'rev-parse $garbage^@ does not segfault' '
> +	test_must_fail git rev-parse $EMPTY_TREE^@
> +'
> +
> +test_expect_success 'rev-parse $garbage...$garbage does not segfault' '
> +	test_must_fail git rev-parse $EMPTY_TREE...$EMPTY_BLOB
> +'
> +
>  test_done

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
If the triangles were to make a God they would give him three sides.
    -- Montesquieu

