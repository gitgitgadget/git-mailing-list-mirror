Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BCCB20193
	for <e@80x24.org>; Tue,  9 Aug 2016 18:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbcHIS2F (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 14:28:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52354 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932267AbcHIS2C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 14:28:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B180E34CCF;
	Tue,  9 Aug 2016 14:28:00 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RXJAU1umRnMz1nO+cE/T45NkxJ0=; b=LQeEF7
	Td5EZPp4owbFNHmrSdOLqCNdsKj/Qs0arh9gupKRsgAMR8RjRXwkORemrOOjr+Mc
	0M/6BMF8v3MF5+//yN4buCppRtVBktubtTpxV7QjC8bD0zNk2T8K4uvSOwUj0A/D
	ZI/Tz4ZNV7Uj1W5pSUQIN+WGW8RE0LGL1ID6M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dcJD4TCb67iw5MXeLwQygHW16osjUZE6
	USmHgHrPObiNmdiC2LYGY5jNTC/ZIaB1Re5/cH7uQSGQ86rcUn0ISvVWaPri8i8N
	u1sJJLhaGwDiO+M7QzMjDJzDbln/DnluDxwu9M+1E09pmsVGQfkzq4Nk5u9Ikyp4
	o3qfDMVjHzk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9466534CCE;
	Tue,  9 Aug 2016 14:28:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D5D2134CCC;
	Tue,  9 Aug 2016 14:27:59 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Michael Stahl <mstahl@redhat.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] document git-repack interaction of pack.threads and pack.windowMemory
References: <db25fccf-ed85-3974-143d-2c50b3037642@redhat.com>
Date:	Tue, 09 Aug 2016 11:27:57 -0700
In-Reply-To: <db25fccf-ed85-3974-143d-2c50b3037642@redhat.com> (Michael
	Stahl's message of "Tue, 9 Aug 2016 13:53:21 +0200")
Message-ID: <xmqqlh05ajbm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0027CE00-5E5F-11E6-9086-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Michael Stahl <mstahl@redhat.com> writes:

> Signed-off-by: Michael Stahl <mstahl@redhat.com>
> ---
>  Documentation/git-pack-objects.txt | 2 +-
>  Documentation/git-repack.txt       | 6 +++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
> index 19cdcd0..0b655a5 100644
> --- a/Documentation/git-pack-objects.txt
> +++ b/Documentation/git-pack-objects.txt
> @@ -105,7 +105,7 @@ base-name::
>  	advantage of the large window for the smaller objects.  The
>  	size can be suffixed with "k", "m", or "g".
>  	`--window-memory=0` makes memory usage unlimited, which is the
> -	default.
> +	default, unless the config variable `pack.windowMemory` is set.

That does not go far enough as it does not say what happens when the
variable is set (i.e. "the variable serves as the default in that
case").

Perhaps "...makes memory usage unlimited.  The default is taken from
the `pack.windowMemory` configuration variable." would make it better,
as it is described that its default is "unlimited".

> diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
> index c597523..300455b 100644
> --- a/Documentation/git-repack.txt
> +++ b/Documentation/git-repack.txt
> @@ -101,7 +101,11 @@ other objects in that pack they already have locally.
>  	advantage of the large window for the smaller objects.  The
>  	size can be suffixed with "k", "m", or "g".
>  	`--window-memory=0` makes memory usage unlimited, which is the
> -	default.
> +	default, unless the config variable `pack.windowMemory` is set.
> +	Note that the actual memory usage will be multiplied
> +	by the number of threads used by linkgit:git-pack-objects[1],
> +	which is lacking a corresponding git-repack flag but can be
> +	set via the config variable `pack.threads`.

I think the same comment applies to the first line.  The next two
lines are definite improvement, but I do not think the last two
lines are necessary.
