Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 489BE1F744
	for <e@80x24.org>; Wed, 20 Jul 2016 20:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754843AbcGTUqV (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 16:46:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63523 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753259AbcGTUqU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 16:46:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A9342D4D7;
	Wed, 20 Jul 2016 16:46:19 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JjMrTjh/8nDoX/bgYR70WVL3A4A=; b=JX3Ugs
	k2+N3XPLpLN8dN27H1KjHEywKN3EHY9n7lowRNYEnRCFZE5CHXGbMbqu7jLAlbI2
	1Iiy2GU0sSKfbSnm6vDRsSXggO8DzBx4Tu7Qrr0z8KWO1+WVHwj5ciJRQuQjqc3c
	RR6doQQcw8SdtVJjGnxLuEWB/j8l1QykNHUBU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kfnJdyedO7PO+6XT80wcKyGdctJegI1o
	LSwDQk7d5ZlTbbirMSQJv9eyAiypbBmMeyjw21kdGvqyPaw0eWRkBbp3RI33gkBO
	beSdee9m5PBW8BY8GkZbs0nEXMq/j/p9put3+0jQ6dqPCkQLFOXhUwC8GgNBjzEL
	/LPZIq8hTCM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 82E8F2D4D6;
	Wed, 20 Jul 2016 16:46:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F0DD92D4D4;
	Wed, 20 Jul 2016 16:46:18 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff Hostetler <jeffhost@microsoft.com>
Cc:	git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v1 1/6] Allow --porcelain[=<n>] in status and commit commands
References: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com>
	<1468966258-11191-2-git-send-email-jeffhost@microsoft.com>
Date:	Wed, 20 Jul 2016 13:46:16 -0700
In-Reply-To: <1468966258-11191-2-git-send-email-jeffhost@microsoft.com> (Jeff
	Hostetler's message of "Tue, 19 Jul 2016 18:10:53 -0400")
Message-ID: <xmqqshv4ca1z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 028CB5E2-4EBB-11E6-97B7-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff Hostetler <jeffhost@microsoft.com> writes:

> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index b0a294d..0791573 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -104,7 +104,7 @@ OPTIONS
>  --branch::
>  	Show the branch and tracking info even in short-format.
>  
> ---porcelain::
> +--porcelain[=<version>]::
>  	When doing a dry-run, give the output in a porcelain-ready
>  	format. See linkgit:git-status[1] for details. Implies
>  	`--dry-run`.

I suspect that it would be easier to implement to allow "commit --porcelain",
but I am not sure if it truly makes sense.  Not a new problem, though.

> diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
> index e1e8f57..de97729 100644
> --- a/Documentation/git-status.txt
> +++ b/Documentation/git-status.txt
> @@ -32,11 +32,14 @@ OPTIONS
>  --branch::
>  	Show the branch and tracking info even in short-format.
>  
> ---porcelain::
> +--porcelain[=<version>]::
>  	Give the output in an easy-to-parse format for scripts.
>  	This is similar to the short output, but will remain stable
>  	across Git versions and regardless of user configuration. See
>  	below for details.
> ++
> +The version parameter is used to specify the format version.
> +This is optional and defaults to the original version '1' format.

I agree with Peff that "v1" would be easier to read, and also his
comment on parsing using strcmp() to require exact matches and
resetting to NONE, not UNSPECIFIED.
