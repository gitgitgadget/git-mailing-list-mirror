Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA4D61FF40
	for <e@80x24.org>; Wed, 29 Jun 2016 17:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbcF2Rps (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 13:45:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65466 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751718AbcF2Rps (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 13:45:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AE8A5261FD;
	Wed, 29 Jun 2016 13:45:46 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F2vmJzTxYOmvpKVXH942v0U3fwo=; b=kctoT5
	FazVQXQ+Inx8UUdudchybzMjulwoyZHxcdrX0FfczmfBbsiQExLrixIgatupDBdv
	DKv22gO/4mpv7QF6VWqClXyBjiG5QjPDdrptlj5tTJ9ZexMAVSKOi7Xvjs++2J7h
	/QgkKHvlkeHQDOGxcsTnLyimA3bKe0CyNrH4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SVw4eG/8TMSM9jq3tWamtOp6Hw8mMMtS
	eZxVAHChSOqoFGC7wmRU0Xh+aMoezpjDgBxUM08O7W4Sno4Acl8k+efgLkXln+Eo
	F10tFjwEShWyEYu4CCY/+jpXOk2xKaAGFuEQbyO4WVUS7/3PzCdmS4liuMlV/g25
	gkYDLiZYg4c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9CA00261FB;
	Wed, 29 Jun 2016 13:45:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 11F5A261FA;
	Wed, 29 Jun 2016 13:45:46 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 9/9] am: make a direct call to merge_recursive
References: <cover.1467199553.git.johannes.schindelin@gmx.de>
	<dc58115e23c8d942b3ff6270b43719bc841becbb.1467199553.git.johannes.schindelin@gmx.de>
Importance: low
Date:	Wed, 29 Jun 2016 10:45:43 -0700
In-Reply-To: <dc58115e23c8d942b3ff6270b43719bc841becbb.1467199553.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Wed, 29 Jun 2016 13:38:27 +0200
	(CEST)")
Message-ID: <xmqqpoqz51o8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4EF3EB4E-3E21-11E6-BF52-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> From: Junio C Hamano <gitster@pobox.com>

Did I write this thing?

Having two sets of numbers that illustrated that this is not really
a useful optimization in the bigger picture looks vaguely familiar
(e.g. $gmane/279417), but the numbers are different.

> 	It feels *slightly* wrong to submit your own patch to review,
> 	however, please keep in mind that
>
> 	1) I changed the patch (o.gently does not exist anymore, so I do
> 	   not set it), and
>
> 	2) I added my own timings performed on Windows.

It probably is much less confusing if you take the authorship,
possibly with a passing reference to whatever I wrote as the source
of inspiration in the log message, or something.  I do not think I
deserve a credit in this 9-patch series.

I haven't read the other 8 patches, so I cannot comment on it yet.

>  builtin/am.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/builtin/am.c b/builtin/am.c
> index 3dfe70b..dd41154 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1587,25 +1587,26 @@ static int run_fallback_merge_recursive(const struct am_state *state,
>  					unsigned char *our_tree,
>  					unsigned char *his_tree)
>  {
> -	struct child_process cp = CHILD_PROCESS_INIT;
> +	const unsigned char *bases[1] = {orig_tree};
> +	struct merge_options o;
> +	struct commit *result;
> +	char *his_tree_name;
>  	int status;
>  
> -	cp.git_cmd = 1;
> +	init_merge_options(&o);
> +
> +	o.branch1 = "HEAD";
> +	his_tree_name = xstrfmt("%.*s", linelen(state->msg), state->msg);
> +	o.branch2 = his_tree_name;
>  
> -	argv_array_pushf(&cp.env_array, "GITHEAD_%s=%.*s",
> -			 sha1_to_hex(his_tree), linelen(state->msg), state->msg);
>  	if (state->quiet)
> -		argv_array_push(&cp.env_array, "GIT_MERGE_VERBOSITY=0");
> +		o.verbosity = 0;
>  
> -	argv_array_push(&cp.args, "merge-recursive");
> -	argv_array_push(&cp.args, sha1_to_hex(orig_tree));
> -	argv_array_push(&cp.args, "--");
> -	argv_array_push(&cp.args, sha1_to_hex(our_tree));
> -	argv_array_push(&cp.args, sha1_to_hex(his_tree));
> +	status = merge_recursive_generic(&o, our_tree, his_tree, 1, bases, &result);
> +	if (status < 0)
> +		exit(128);
> +	free(his_tree_name);
>  
> -	status = run_command(&cp) ? (-1) : 0;
> -	discard_cache();
> -	read_cache();
>  	return status;
>  }
