Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3C7B20193
	for <e@80x24.org>; Thu, 11 Aug 2016 17:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbcHKRxn (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 13:53:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58282 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751802AbcHKRxk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 13:53:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BD7863308A;
	Thu, 11 Aug 2016 13:53:38 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+eM76Xd4RC0ZUviw3QP/FY12erM=; b=lTMChS
	qUmODWfbTu/hK893d4PgbPt1q3UfhXpIR3RQvNSQFwTZb5xMkOq/VF08Yhrc85Qc
	Jz1rEPa1Sjpdr5rmqxj/gYwvqwSgtvoFijCX3U1FlrVd/tJ0gq37DcnmAxZEXt0y
	g9V+Vr5LPbyJG57a/JNLlM+8ZyBevRjGrLYVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uNegwXnzPlqrJ0R2nwqsKk7jpnQ2zhIa
	zXZQ8SvLG0sWms2pZS7XEVYRxyahCz56AGEHD80uG8mElyXpGpHOTlWVjFrjaNON
	nbXJeMMpTr08jX4/IFNpvBrB/0y58jolNmfNVX0dYpLnny6FZl2NcUS0f3kEAvNq
	9hehJtgY+S4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B648633088;
	Thu, 11 Aug 2016 13:53:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3B6F533086;
	Thu, 11 Aug 2016 13:53:38 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jacob Keller <jacob.e.keller@intel.com>
Cc:	git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v4 2/2] diff: add SUBMODULE_DIFF format to display submodule diff
References: <20160810231908.26330-1-jacob.e.keller@intel.com>
	<20160810231908.26330-2-jacob.e.keller@intel.com>
Date:	Thu, 11 Aug 2016 10:53:36 -0700
In-Reply-To: <20160810231908.26330-2-jacob.e.keller@intel.com> (Jacob Keller's
	message of "Wed, 10 Aug 2016 16:19:08 -0700")
Message-ID: <xmqqd1lf2nvj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 88269776-5FEC-11E6-A485-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> Teach git-diff and friends a new format for displaying the difference of
> a submodule using git-diff inside the submodule project. This allows
> users to easily see exactly what source changed in a given commit that
> updates the submodule pointer. To do this, remove DIFF_SUBMODULE_LOG bit
> from the diff options, and instead add a new enum type for these
> formats.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
>  Documentation/diff-config.txt  |  3 +-
>  Documentation/diff-options.txt |  6 ++--
>  diff.c                         | 41 ++++++++++++++++----------
>  diff.h                         |  9 +++++-
>  submodule.c                    | 67 ++++++++++++++++++++++++++++++++++++++++++
>  submodule.h                    |  6 ++++
>  6 files changed, 113 insertions(+), 19 deletions(-)

This looks good.

You'd want some tests to make sure that the "--submodule" and the
"--submodule=<format>" command line options and the diff.submodule
configuration variables are parsed correctly (and when combined, the
command line option overrides the configured default), and of course
the machinery does the right thing, with and without "--graph" when
used in "git log".

> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index e7b729f3644f..988068225463 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -215,8 +215,10 @@ any of those replacements occurred.
>  	the commits in the range like linkgit:git-submodule[1] `summary` does.
>  	Omitting the `--submodule` option or specifying `--submodule=short`,
>  	uses the 'short' format. This format just shows the names of the commits
> -	at the beginning and end of the range.  Can be tweaked via the
> -	`diff.submodule` configuration variable.
> +	at the beginning and end of the range. When `--submodule=diff` is
> +	given, the 'diff' format is used. This format shows the diff between
> +	the old and new submodule commmit from the perspective of the
> +	submodule.  Can be tweaked via the `diff.submodule` configuration variable.

This is carried over from the existing text, but "Can be tweaked
via" sounds a bit wasteful (and strange); "Defaults to" (or "The
default is taken from") is the phrase we seem to use more often.

Thanks.
