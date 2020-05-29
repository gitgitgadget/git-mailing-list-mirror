Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D3BC433E0
	for <git@archiver.kernel.org>; Fri, 29 May 2020 00:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B96D22073B
	for <git@archiver.kernel.org>; Fri, 29 May 2020 00:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AUj4tWgL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438129AbgE2Ala (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 20:41:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61226 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388613AbgE2Al2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 20:41:28 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5CC927FB50;
        Thu, 28 May 2020 20:41:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zUSwhi7iryfEvCvsWqy6dA79bk0=; b=AUj4tW
        gLaEkaTpiErHZmvLlhDyh+7mEMCOz6m7HUaahmL/p58etX7vb7ZGPVYqhDzffNe1
        LxO4E3uklqSihMGqxm2jWnOmfw08Ak3QTAQXNc2PTmjVSoxtEcRAQkwS0eECeccm
        c57qG0Z3gCXMYqCWEBT6zJVGOCD7NpEj4hBTc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oLtXgsjxhvev+GWeDxeHRYlmJByEpQ6s
        O2evq6ZaHNemXZ5mouj92+gr46xi0Xtq+LZnAPDW+DAVMYGozumNzoZ7RHYkgRcv
        bz8Kz9Xr1QIXDRRcfFYc3QnVHzthk/j4vO3ULlAfRk96SLWKN9I1NHJkQGtgrnxq
        sT7C8cFhBpA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 549BC7FB4F;
        Thu, 28 May 2020 20:41:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D0AB17FB4E;
        Thu, 28 May 2020 20:41:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Xin Li <delphij@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com,
        sandals@crustytoothpaste.net, iankaz@google.com
Subject: Re: [PATCH v4] fetch: allow adding a filter after initial clone.
References: <20200528025359.20931-2-delphij@google.com>
        <xmqqsgfk3xtd.fsf@gitster.c.googlers.com>
        <20200528171924.GC58643@google.com>
        <CAOhzdugK7FQSnWruUrX8gQ98AF6kGvNWqPfHmE+qjGjBgzvmiQ@mail.gmail.com>
        <20200528191739.GA114915@google.com>
        <20200529000432.146618-1-delphij@google.com>
Date:   Thu, 28 May 2020 17:41:18 -0700
In-Reply-To: <20200529000432.146618-1-delphij@google.com> (Xin Li's message of
        "Thu, 28 May 2020 17:04:32 -0700")
Message-ID: <xmqqblm71sk1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C5B1FC8-A145-11EA-AB4D-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Xin Li <delphij@google.com> writes:

> Retroactively adding filter can be useful for existing shallow clones as
> they allow users to see earlier change histories without downloading all
> git objects in a regular --unshallow fetch.
>
> Without this patch, users can make a clone partial by editing the
> repository configuration to convert the remote into a promisor, like:
>
>   git config core.repositoryFormatVersion 1
>   git config extensions.partialClone origin
>   git fetch --unshallow --filter=blob:none origin
>
> Since the hard part of making this work is already in place and such
> edits can be error-prone, teach Git to perform the required configuration
> change automatically instead.
>
> Instead of bailing out immediately when no promisor is available, make
> the code perform a more precise check for any potential problems
> (extensions became special in repository version 1, while it can have
> any value in version 0, so upgrade should not happen if the repository
> have an unsupported configuration that would render it invalid if we
> upgraded).

Upgrade from v0 to v1 must follow the more strict "no extension" rule,
not "no unknown ones" rule, so the above description must be corrected.
Perhaps like this?

	... so upgrade from version 0 should not happen if the
	repository has ANY extension.  A repository version 1 and
	later make Git fail if there is any unknown extension, so we
	need to fail an upgrade only if there is any extension that
	is unknown to us).

You can drop the second paragraph about upgrading from version 1 to
a later version if you want, as the only interesting use cases in
practice at this point are upgrading from v0 to v1 and staying at v1.

> Signed-off-by: Xin Li <delphij@google.com>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

I think the updated design looks good.  Let's nitpick some styles ;-)

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index b5788c16bf..3347d578ea 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1790,9 +1790,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  	if (depth || deepen_since || deepen_not.nr)
>  		deepen = 1;
>  
> -	if (filter_options.choice && !has_promisor_remote())
> -		die("--filter can only be used when extensions.partialClone is set");
> -
>  	if (all) {
>  		if (argc == 1)
>  			die(_("fetch --all does not take a repository argument"));
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 95d0882417..95669815d4 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -249,6 +249,8 @@ static int set_config(enum sparse_checkout_mode mode)
>  {
>  	const char *config_path;
>  
> +	if (upgrade_repository_format(1) < 0)
> +		die(_("unable to upgrade repository format to enable worktreeConfig"));
>  	if (git_config_set_gently("extensions.worktreeConfig", "true")) {
>  		error(_("failed to set extensions.worktreeConfig setting"));
>  		return 1;

OK.


> diff --git a/cache.h b/cache.h
> index 0f0485ecfe..66dcd2f219 100644
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
> @@ -1056,6 +1057,7 @@ struct repository_format {
>  	.version = -1, \
>  	.is_bare = -1, \
>  	.hash_algo = GIT_HASH_SHA1, \
> +	.has_extensions = 0, \

I am on the fence between "explicitly initializing to zero value is
pointless, especially when we use .designated_initializer" and
"especially with .designated_initializer, it adds a documentation
value to explicitly initialize a field to its zero value".  Unless
other reviewers weigh in, I am OK to let this stand as-is. 

>  	.unknown_extensions = STRING_LIST_INIT_DUP, \
>  }
>  
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

OK.

> diff --git a/repository.h b/repository.h
> index 6534fbb7b3..40cc12c7cf 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -196,4 +196,10 @@ void repo_update_index_if_able(struct repository *, struct lock_file *);
>  
>  void prepare_repo_settings(struct repository *r);
>  
> +/*
> + * Return 1 if upgrade repository format to target_version succeeded,
> + * 0 if no upgrade is necessary; returns -1 when upgrade is not possible.
> + */

Do we want to start with "Return" but say "returns" later?  

	Return 1 if ..., 0 if ..., and -1 when upgrade is not possible.

> +int upgrade_repository_format(int target_version);
> +
>  #endif /* REPOSITORY_H */

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

OK.  That's "already up-to-date" case.

> +	if (verify_repository_format_eligibility(&repo_fmt, &err,
> +	    target_version) < 0) {

I do not think this _eligibility thing should be a separate helper
function.  One reason is that its name sounds nonsensical ("eligible
for what?  it deserives to be verified for its repo format?"), another
is it makes it unclear what "upgrade" requires by hiding the logic
inside that decides the eligibility for upgrading.  Besides, there
is only one callsite.

Open-coding the gist of the helper like this:

	if (verify_repository_format(&repo_fmt, &err) < 0 ||
	    (!repo_fmt.version && repo_fmt.has_extensions)) {

should make it a lot clearer to see.  If the repository is unusable
by the version of Git we are running already, or the repository is
v0 and has configuration variable(s) in "extensions.*" section, we
refuse to upgrade.

Which is slightly different from what you did with the three-way
split of verify_repository_format(), which made the "eligibility"
thing not to care about unknown extensions in a repository v1 and
higher.  I actually think we should refuse to update v1 or v2
repository to v3 with a running Git that knows only about v1
(i.e. the repository before upgrading may or may not be something we
understand, and if we do not understand it, we shouldn't touch it).

> +		warning("unable to upgrade repository format from %d to %d: %s",
> +		    repo_fmt.version, target_version, err.buf);
> +		strbuf_release(&err);
> +		return -1;
> +	}
> + ...

And with the suggested change to eliminate "eligibility" helper,
none of the changes below would become necessary, I would think,
so I won't say things like "we do not say 'if (result != 0)';
instead we just say 'if (result)'" ;-)

Thanks.
