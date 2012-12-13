From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] mailmap from blobs
Date: Thu, 13 Dec 2012 10:23:39 -0800
Message-ID: <7vfw39zu8k.fsf@alter.siamese.dyndns.org>
References: <20121212105822.GA15842@sigill.intra.peff.net>
 <7vhanr5f74.fsf@alter.siamese.dyndns.org>
 <20121212175900.GA32767@sigill.intra.peff.net>
 <20121213130447.GA4353@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 13 19:24:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjDRx-0002fd-0b
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 19:24:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755996Ab2LMSXn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2012 13:23:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44518 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755661Ab2LMSXm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2012 13:23:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5ADE4A5D5;
	Thu, 13 Dec 2012 13:23:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/jSF6pNjtT8jCQPggYbo3nYnw7o=; b=e2/Mpr
	+DCPeoMmAjvwqVDyZ9RJbuCI6It2m03Q5FSabc2taul/rVmV6e9LVWETgdvc6RYl
	yWFtVhhYllYsNX2x0YzpRqm0LhZ6ozZ7/LIQZ0SaQjrXHND1zn2xpjVr83OmziMA
	wHntppCQ1U0egtNZZKrmzD0wWjufEctDPRqGs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=civCw4eVazRXdSNBuwNLHATypY68jfH8
	N3jJzYvrDWM7s1FbNWxOIXaGNeDqUuZUUD+GGCwvUCyMaOzmLQiYS5dzhTCReH4V
	ioQ9Prx8KphDKnHxhWboNbrOdsS4vjLwO1Cf8xu2CY8Q1OqV7oT87eRZu7rSKsgK
	1ilakls1Vto=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 463FEA5D3;
	Thu, 13 Dec 2012 13:23:42 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7595CA5CD; Thu, 13 Dec 2012
 13:23:41 -0500 (EST)
In-Reply-To: <20121213130447.GA4353@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 13 Dec 2012 08:04:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 38AAD3B4-4552-11E2-8978-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211462>

Jeff King <peff@peff.net> writes:

> Subject: [PATCH] mailmap: default mailmap.blob in bare repositories
>
> The motivation for mailmap.blob is to let users of bare
> repositories use the mailmap feature, as they would not have
> a checkout containing the .mailmap file. We can make it even
> easier for them by just looking in HEAD:.mailmap by default.
>
> We can't know for sure that this is where they would keep a
> mailmap, of course, but it is the best guess (and it matches
> the non-bare behavior, which reads from HEAD:.mailmap in the
> working tree). If it's missing, git will silently ignore the
> setting.
>
> We do not do the same magic in the non-bare case, because:
>
>   1. In the common case, HEAD:.mailmap will be the same as
>      the .mailmap in the working tree, which is a no-op.
>
>   2. In the uncommon case, the user has modified .mailmap
>      but not yet committed it, and would expect the working
>      tree version to take precedence.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I went with defaulting mailmap.blob, because it provides an easy path
> for turning off the feature (you just override mailmap.blob).

Very sensibly explained.  I like it when people clearly explain the
thinking behind the change in the log message.

Thanks, will queue.


>  Documentation/config.txt |  8 +++++---
>  mailmap.c                |  5 +++++
>  t/t4203-mailmap.sh       | 25 +++++++++++++++++++++++++
>  3 files changed, 35 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 3760077..1a3c554 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1519,9 +1519,11 @@ mailmap.blob::
>  
>  mailmap.blob::
>  	Like `mailmap.file`, but consider the value as a reference to a
> -	blob in the repository (e.g., `HEAD:.mailmap`). If both
> -	`mailmap.file` and `mailmap.blob` are given, both are parsed,
> -	with entries from `mailmap.file` taking precedence.
> +	blob in the repository. If both `mailmap.file` and
> +	`mailmap.blob` are given, both are parsed, with entries from
> +	`mailmap.file` taking precedence. In a bare repository, this
> +	defaults to `HEAD:.mailmap`. In a non-bare repository, it
> +	defaults to empty.
>  
>  man.viewer::
>  	Specify the programs that may be used to display help in the
> diff --git a/mailmap.c b/mailmap.c
> index 5ffe48a..b16542f 100644
> --- a/mailmap.c
> +++ b/mailmap.c
> @@ -233,7 +233,12 @@ int read_mailmap(struct string_list *map, char **repo_abbrev)
>  int read_mailmap(struct string_list *map, char **repo_abbrev)
>  {
>  	int err = 0;
> +
>  	map->strdup_strings = 1;
> +
> +	if (!git_mailmap_blob && is_bare_repository())
> +		git_mailmap_blob = "HEAD:.mailmap";
> +
>  	err |= read_mailmap_file(map, ".mailmap", repo_abbrev);
>  	err |= read_mailmap_blob(map, git_mailmap_blob, repo_abbrev);
>  	err |= read_mailmap_file(map, git_mailmap_file, repo_abbrev);
> diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
> index e7ea40c..aae30d9 100755
> --- a/t/t4203-mailmap.sh
> +++ b/t/t4203-mailmap.sh
> @@ -218,6 +218,31 @@ test_expect_success 'mailmap.blob can be missing' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'mailmap.blob defaults to off in non-bare repo' '
> +	git init non-bare &&
> +	(
> +		cd non-bare &&
> +		test_commit one .mailmap "Fake Name <author@example.com>" &&
> +		echo "     1	Fake Name" >expect &&
> +		git shortlog -ns HEAD >actual &&
> +		test_cmp expect actual &&
> +		rm .mailmap &&
> +		echo "     1	A U Thor" >expect &&
> +		git shortlog -ns HEAD >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'mailmap.blob defaults to HEAD:.mailmap in bare repo' '
> +	git clone --bare non-bare bare &&
> +	(
> +		cd bare &&
> +		echo "     1	Fake Name" >expect &&
> +		git shortlog -ns HEAD >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
>  test_expect_success 'cleanup after mailmap.blob tests' '
>  	rm -f .mailmap
>  '
