Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA69AC433DF
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 19:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A50C6207D3
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 19:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cfcfAyuF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgFETMS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 15:12:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58130 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgFETMS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 15:12:18 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 73AC36932C;
        Fri,  5 Jun 2020 15:12:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aHkTW6XRtuVQlkP5WdJyhuhxjy8=; b=cfcfAy
        uFKzjY1NDQykM1vaTKy3n4TSAzn3NxVxwzVaqPvHC20zcFRHc7J6bT4vh6GSBqN1
        PWKedVsnLNo4o9vkCnICUu8KMVvrz9+SKg187LHRf8zHVF/JqSgMPBvCAa0Yym1C
        mrD/3DOSICBSEulpNEAhEi+riklToyU0TVCTA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LN7kMRsQ22EneEnGzfC898o+yOo2xd/z
        a28+HiXzK8CkEyJ6UyCjI5RcYq47x492G74IPs1jj7EhgP4TT+7FJ0sFk0N+88XD
        0EHg0MnREQev3ZEss7RlahLt5tiz1UUct0mIu/lQ8yhjEfde+VHK5QTh9dqXefYj
        i/cAcTg72tI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 688A06932B;
        Fri,  5 Jun 2020 15:12:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CD1C76932A;
        Fri,  5 Jun 2020 15:12:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Xin Li <delphij@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v6 1/4] repository: add a helper function to perform repository format upgrade
References: <20200528025359.20931-2-delphij@google.com>
        <xmqqsgfk3xtd.fsf@gitster.c.googlers.com>
        <20200528171924.GC58643@google.com>
        <CAOhzdugK7FQSnWruUrX8gQ98AF6kGvNWqPfHmE+qjGjBgzvmiQ@mail.gmail.com>
        <20200528191739.GA114915@google.com>
        <20200529000432.146618-1-delphij@google.com>
        <20200529010119.GE114915@google.com>
        <xmqqk10uzkcd.fsf@gitster.c.googlers.com>
        <20200605091004.208668-1-delphij@google.com>
        <20200605091004.208668-2-delphij@google.com>
Date:   Fri, 05 Jun 2020 12:12:12 -0700
In-Reply-To: <20200605091004.208668-2-delphij@google.com> (Xin Li's message of
        "Fri, 5 Jun 2020 02:10:01 -0700")
Message-ID: <xmqqy2p1minn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 761DC5A8-A760-11EA-952D-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Xin Li <delphij@google.com> writes:

> In version 1 of repository format, "extensions" gained special meaning
> and it is safer to avoid upgrading when there are pre-existing
> extensions.

I am tempted to suggest s/upgrading/& from version 0/ but if we
assume everybody knows there are only v0 and v1, that may be
unnecessary.  I dunno.

> Make list-objects-filter to use the helper function instead of setting
> repository version directly as a prerequisite of exposing the upgrade
> capability.
>
> Signed-off-by: Xin Li <delphij@google.com>
> ---
>  cache.h                       |  1 +
>  list-objects-filter-options.c |  3 ++-
>  repository.h                  |  6 ++++++
>  setup.c                       | 29 +++++++++++++++++++++++++++++
>  4 files changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/cache.h b/cache.h
> index 0f0485ecfe..e5885cc9ea 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1042,6 +1042,7 @@ struct repository_format {
>  	int worktree_config;
>  	int is_bare;
>  	int hash_algo;
> +	int has_extensions;
>  	char *work_tree;
>  	struct string_list unknown_extensions;
>  };
> diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
> index 256bcfbdfe..3553ad7b0a 100644
> --- a/list-objects-filter-options.c
> +++ b/list-objects-filter-options.c
> @@ -326,7 +326,8 @@ void partial_clone_register(
>  
>  	/* Check if it is already registered */
>  	if (!promisor_remote_find(remote)) {
> -		git_config_set("core.repositoryformatversion", "1");
> +		if (upgrade_repository_format(1) < 0)
> +			die(_("unable to upgrade repository format to support partial clone"));

The idea is that builtin/fetch.c calls this before the actual fetch
operation happens, which sounds sensible.


The other caller of this function is in builtin/clone.c; at that
point, we have set up our $GIT_DIR/config file enough to be able to
write the refspec into it, so we should be able to tell what version
number we wrote to the repository.  Could we have written version 0
there in today's code, though (just being curious, as we should be
able to upgrade it to version 1 with this code)?

> +int upgrade_repository_format(int target_version)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	struct strbuf err = STRBUF_INIT;
> +	struct strbuf repo_version = STRBUF_INIT;
> +	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
> +
> +	strbuf_git_common_path(&sb, the_repository, "config");
> +	read_repository_format(&repo_fmt, sb.buf);
> +	strbuf_release(&sb);
> +
> +	if (repo_fmt.version >= target_version)
> +		return 0;
> +
> +	if (verify_repository_format(&repo_fmt, &err) < 0 ||
> +	    (!repo_fmt.version && repo_fmt.has_extensions)) {

"If we do not understand the extensions, or if the original is v0
and has any extensions, we shouldn't be upgrading"---makes sense.

> +		warning("unable to upgrade repository format from %d to %d: %s",
> +			repo_fmt.version, target_version, err.buf);
> +		strbuf_release(&err);
> +		return -1;
> +	}
> +
> +	strbuf_addf(&repo_version, "%d", target_version);
> +	git_config_set("core.repositoryformatversion", repo_version.buf);
> +	strbuf_release(&repo_version);
> +	return 1;
> +}
> +
>  static void init_repository_format(struct repository_format *format)
>  {
>  	const struct repository_format fresh = REPOSITORY_FORMAT_INIT;
