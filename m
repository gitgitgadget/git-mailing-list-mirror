Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149CBC433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 20:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE48B61186
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 20:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhJUUm2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 16:42:28 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55875 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhJUUm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 16:42:28 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8B56C167EB6;
        Thu, 21 Oct 2021 16:40:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T2naj2M2rJd6CIHv9+N0gqXF+phCjTXAknDJXh
        GTb20=; b=ig9k7fNnzqo0u3mWRibx3714iaDUiujTB7APEpvdcSbFVGgbl/VO2T
        bwXgNmUpjYrXkdT5Z2TuR/gWqAhUwsqYMMNZdQtv48fsuDvlVMdDSoE+Zva4wT7b
        /mgW5zbVayJUemK1S2Ek5XpmJgYjzHCq37oDBZ+tIdCnHFziyhI2c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 83791167EB4;
        Thu, 21 Oct 2021 16:40:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E0422167EB3;
        Thu, 21 Oct 2021 16:40:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 01/29] fsmonitor: enhance existing comments
References: <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
        <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
        <ecc40795fa26ea86525421682303449f70132216.1634826309.git.gitgitgadget@gmail.com>
Date:   Thu, 21 Oct 2021 13:40:06 -0700
In-Reply-To: <ecc40795fa26ea86525421682303449f70132216.1634826309.git.gitgitgadget@gmail.com>
        (Jeff Hostetler via GitGitGadget's message of "Thu, 21 Oct 2021
        14:24:41 +0000")
Message-ID: <xmqq1r4ekt7d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1416862A-32AF-11EC-B67D-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  fsmonitor.c | 37 ++++++++++++++++++++++++++++++-------
>  1 file changed, 30 insertions(+), 7 deletions(-)
>
> diff --git a/fsmonitor.c b/fsmonitor.c
> index ab9bfc60b34..ec4c46407c5 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -301,9 +301,25 @@ void refresh_fsmonitor(struct index_state *istate)
>  			core_fsmonitor, query_success ? "success" : "failure");
>  	}
>  
> -	/* a fsmonitor process can return '/' to indicate all entries are invalid */
> +	/*
> +	 * The response from FSMonitor (excluding the header token) is
> +	 * either:
> +	 *
> +	 * [a] a (possibly empty) list of NUL delimited relative
> +	 *     pathnames of changed paths.  This list can contain
> +	 *     files and directories.  Directories have a trailing
> +	 *     slash.
> +	 *
> +	 * [b] a single '/' to indicate the provider had no
> +	 *     information and that we should consider everything
> +	 *     invalid.  We call this a trivial response.
> +	 */
>  	if (query_success && query_result.buf[bol] != '/') {
> -		/* Mark all entries returned by the monitor as dirty */
> +		/*
> +		 * Mark all pathnames returned by the monitor as dirty.
> +		 *
> +		 * This updates both the cache-entries and the untracked-cache.
> +		 */

Not a problem this patch introduces, but we only checked that the
query result begins with a slash, not "we did receive a trivial
response", but the "else" clause of this statement pretends as if we
did.

It is a shame that we do have fsmonitor_is_trivial_response()
function defined, but its interface is not capable of helping us
here.

Or is fsmonitor_is_trivial_response() already good to do this, and
reliance of [bol] this code has is the source of confusion?  I
notice that when we have last update token and makes a call to
query_fsmonitor() with HOOK_INTERFACE_VERSION1, nobody updates bol
(hence it stays 0), and with HOOK_INTERFACE_VERSION2, bol is at the
NUL that terminates the initial string of the query result, after
which presumably has either '/' NUL (trivial) or list of paths.

I am not sure about the VERSION1 case, but at least in the VERSION2
case, making sure that the last three bytes are NUL slash NUL like
fsmonitor_is_trivial_response() does and the half check the above is
doing (i.e. the byte after the NUL is slash, without making sure
about the length of the whole response or what follows the slash is
NUL), seems "close enough" (meaning: the check in this code is a
sloppy attempt to reinvent what _is_trivial_response() function
already does).

So, would it make sense to rewrite the condition to

	if (query_success &&
	    !fsmonitor_is_trivial_response(&query_result)) {

here?  Or perhaps

	if (query_success &&
	    !(query_result.len == bol + 3 &&
	      query_result[bol] == '/' && !query_result[bol+1])) {

which would be open coding the _is_trivial_response() function.

>  		buf = query_result.buf;
>  		for (i = bol; i < query_result.len; i++) {
>  			if (buf[i] != '\0')
> @@ -318,11 +334,15 @@ void refresh_fsmonitor(struct index_state *istate)
>  		if (istate->untracked)
>  			istate->untracked->use_fsmonitor = 1;
>  	} else {
> -
> -		/* We only want to run the post index changed hook if we've actually changed entries, so keep track
> -		 * if we actually changed entries or not */
> +		/*
> +		 * We received a trivial response, so invalidate everything.
> +		 *


> +		 * We only want to run the post index changed hook if
> +		 * we've actually changed entries, so keep track if we
> +		 * actually changed entries or not.
> +		 */
>  		int is_cache_changed = 0;
> -		/* Mark all entries invalid */
> +
>  		for (i = 0; i < istate->cache_nr; i++) {
>  			if (istate->cache[i]->ce_flags & CE_FSMONITOR_VALID) {
>  				is_cache_changed = 1;
> @@ -330,7 +350,10 @@ void refresh_fsmonitor(struct index_state *istate)
>  			}
>  		}
>  
> -		/* If we're going to check every file, ensure we save the results */
> +		/*
> +		 * If we're going to check every file, ensure we save
> +		 * the results.
> +		 */
>  		if (is_cache_changed)
>  			istate->cache_changed |= FSMONITOR_CHANGED;
