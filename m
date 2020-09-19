Return-Path: <SRS0=5dtp=C4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10ABBC43463
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 20:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF41B21D42
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 20:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LIoijCjg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgISUD5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Sep 2020 16:03:57 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54059 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgISUD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Sep 2020 16:03:56 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BA11CE9FCB;
        Sat, 19 Sep 2020 16:03:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1axamRcSbm6HBytjN6b/1etofhc=; b=LIoijC
        jgQlbONQJ3UcbvFsG+s/Z4qajdJDfrmBZpji8tnGmW7ba4P5dvdd9Od8ajgl3mRZ
        OPaDx6Z375Tay9zIlZ+5Lzb+nfep9DsVRIx7bzIvzoy8YcXSf1R5Fd1jX3lbLeWU
        +llnBpixJJYKeQMBR4agQdbi1Islucge2uYew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WmO/ltDQggq0l36dqAIMrKabCBqV5QqD
        gELWC+Jx1z3+rl4n2m4yxHY2jina39H5gxFVJ3pxdk3/1C/O01p35ymFvT/489qp
        te83Iwp9dXUezxxthw5JsaFzhA8Awog19fpjX4dlrP9LW6KbszaPxb0a8b9HMSqa
        SyqqnljNQvg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B3027E9FCA;
        Sat, 19 Sep 2020 16:03:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 06A3CE9FC9;
        Sat, 19 Sep 2020 16:03:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 1/3] push: add reflog check for "--force-if-includes"
References: <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
        <20200919170316.5310-1-shrinidhi.kaushik@gmail.com>
        <20200919170316.5310-2-shrinidhi.kaushik@gmail.com>
Date:   Sat, 19 Sep 2020 13:03:47 -0700
In-Reply-To: <20200919170316.5310-2-shrinidhi.kaushik@gmail.com> (Srinidhi
        Kaushik's message of "Sat, 19 Sep 2020 22:33:14 +0530")
Message-ID: <xmqqft7djzz0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3B5F5A2A-FAB3-11EA-9345-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:

> Adds a check to verify if the remote-tracking ref of the local branch
> is reachable from one of its "reflog" entries.

s/Adds/Add/

> When "--force-with-includes" is used along with "--force-with-lease",

A misspelt name for the new option is found here.

> +/* Checks if the ref is reachable from the reflog entry. */
> +static int reflog_entry_reachable(struct object_id *o_oid,
> +			       struct object_id *n_oid,
> +			       const char *ident, timestamp_t timestamp,
> +			       int tz, const char *message, void *cb_data)
> +{
> +	struct commit *local_commit;
> +	struct commit *remote_commit = cb_data;
> +
> +	local_commit = lookup_commit_reference(the_repository, n_oid);
> +	if (local_commit)
> +		return in_merge_bases(remote_commit, local_commit);
> +
> +	return 0;
> +}

Makes me wonder, if in_merge_bases() is so expensive that it makes
sense to split the "were we exactly at the tip?" and "is one of the
commits we were at a descendant of the tip?" into separate phases,
if this part should be calling in_merge_bases() one by one.

Would it make more sense to iterate over reflog entries from newer
to older, collect them in an array of pointers to "struct commit" in
a batch of say 8 commits or less, and then ask in_merge_bases_many()
if the remote_commit is an ancestor of one of these local commits?

The traversal cost to start from one "local commit" to see if
remote_commit is an ancestor of it using in_merge_bases() and
in_merge_bases_many() should be the same and an additional traversal
cost to start from more local commits should be negligible compared
to the traversal itself, so making a call to in_merge_bases() for
each local_commit smells somewhat suboptimal.

If we were talking about older parts of the history, optional
generation numbers could change the equation somewhat, but the
common case for the workflow this series is trying to help is that
these local commits ane the remote tip are relatively new and it is
not unlikely that the generation numbers have not been computed for
them, which is why I suspect that in_merges_many may be a win.

> @@ -2301,6 +2380,15 @@ void apply_push_cas(struct push_cas_option *cas,
>  		    struct ref *remote_refs)
>  {
>  	struct ref *ref;
> -	for (ref = remote_refs; ref; ref = ref->next)
> +	for (ref = remote_refs; ref; ref = ref->next) {
>  		apply_cas(cas, remote, ref);
> +
> +		/*
> +		 * If "compare-and-swap" is in "use_tracking[_for_rest]"
> +		 * mode, and if "--foce-if-includes" was specified, run
> +		 * the check.
> +		 */
> +		if (ref->if_includes)
> +			check_if_includes_upstream(ref);

s/foce/force/; 

I can see that the code is checking "and if force-if-includes was
specified" part, but it is not immediately clear where the code
checks if "--force-with-lease" is used with "tracking" and not with
"the other side must be exactly this commit" mode here.

    ... goes and looks ...

Ah, ok, I found out. 

The field name "if_includes", and the comment for the field in
remote.h, are both misleading.  It gives an impression that the
field being true means "--force-if-included is in use", but in
reality the field means a lot more.  When it is true, it signals
that "--force-if-included" is in use *and* for this ref we were told
to use the "--force-with-lease" without an exact object name.  And
that logic is not here, but has already happened in apply_cas().

Which makes the above comment correct.  We however need a better
name for this field and/or an explanation for the field in the
header file, or both, to avoid misleading readers.

> diff --git a/remote.h b/remote.h
> index 5e3ea5a26d..38ab8539e2 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -104,7 +104,9 @@ struct ref {
>  		forced_update:1,
>  		expect_old_sha1:1,
>  		exact_oid:1,
> -		deletion:1;
> +		deletion:1,
> +		if_includes:1, /* If "--force-with-includes" was specified. */

The description needs to be tightened.

> +		unreachable:1; /* For "if_includes"; unreachable in reflog. */


Thanks.
