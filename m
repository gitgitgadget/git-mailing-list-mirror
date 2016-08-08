Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C92BA2018E
	for <e@80x24.org>; Mon,  8 Aug 2016 20:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045AbcHHUxZ (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 16:53:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50706 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750929AbcHHUxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 16:53:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7E8883314A;
	Mon,  8 Aug 2016 16:53:23 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KumS2J5ux6Eg1GOpHgStfKA6HPw=; b=LxY6ro
	hzuRBnjA2+e5uM9zK0ZUJ+xp0ks8uafhqY2Fx2jU34sncjNdl83B5Q3bnUIseTlC
	joeDR0xHv98uxeQg6Mr4Rq2ugY0GOWQxobJ5/P8O7d0cbjarlGHopdEC2uFAOTdx
	9UYqW1qy4UW3fQ3HTC3rqMlMl3BcTsRgBybsc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RJxHSTz5MaBO+dvjZ8QNB9yXKEie7jYu
	YIkBOuhPzZeAzZikyTU4agrvvA7mGG7bkkD9OwNQsdT/AzGY/zCefN0xCuPhreN+
	H7uw3swW3pi7fKg+kIf3Ao7a8MxjvUGD9Q64ACDHsr0jLWWjs2hwvaFjxMyeIQm0
	jbU/oSCldK8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 745AB33149;
	Mon,  8 Aug 2016 16:53:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DB3DD33147;
	Mon,  8 Aug 2016 16:53:22 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Kirill Smelkov <kirr@nexedi.com>
Cc:	Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>,
	=?utf-8?Q?J=C3=A9rome?= Perrin <jerome@nexedi.com>,
	Isabelle Vallet <isabelle.vallet@nexedi.com>,
	Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
	Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org
Subject: Re: [PATCH v5] pack-objects: teach it to use reachability bitmap index when generating non-stdout pack too
References: <20160808154054.GB3995@teco.navytux.spb.ru>
	<20160808185541.6433-1-kirr@nexedi.com>
Date:	Mon, 08 Aug 2016 13:53:20 -0700
In-Reply-To: <20160808185541.6433-1-kirr@nexedi.com> (Kirill Smelkov's message
	of "Mon, 8 Aug 2016 21:55:41 +0300")
Message-ID: <xmqqbn13dltr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 251B048A-5DAA-11E6-8040-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Kirill Smelkov <kirr@nexedi.com> writes:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index bc1c433..4ba0c4a 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2244,6 +2244,9 @@ pack.useBitmaps::
>  	to stdout (e.g., during the server side of a fetch). Defaults to
>  	true. You should not generally need to turn this off unless
>  	you are debugging pack bitmaps.
> ++
> +*NOTE*: when packing to file (e.g., on repack) the default is always not to use
> +	pack bitmaps.

This is a bit hard to read and understand.

The patched result starts with "When true, git will use bitmap when
packing to stdout", i.e. when packing to file, git will not.  So
this *NOTE* is repeating the same thing.  The reader is made to
wonder "Why does it need to repeat the same thing?  Does this mean
when the variable is set, a pack sent to a disk uses the bitmap?"

I think what you actually do in the code is to make the variable
affect _only_ the standard-output case, and users need a command
line option if they want to use bitmap when writing to a file (the
code to do so looks correctly done).

> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> index 3893afd..ffecc6a 100755
> --- a/t/t5310-pack-bitmaps.sh
> +++ b/t/t5310-pack-bitmaps.sh
> @@ -118,6 +118,18 @@ test_expect_success 'incremental repack can disable bitmaps' '
>  	git repack -d --no-write-bitmap-index
>  '
>  
> +test_expect_success 'pack-objects to file can use bitmap' '
> +	# make sure we still have 1 bitmap index from previous tests
> +	ls .git/objects/pack/ | grep bitmap >output &&
> +	test_line_count = 1 output &&
> +	# verify equivalent packs are generated with/without using bitmap index
> +	packasha1=$(git pack-objects --no-use-bitmap-index --all packa </dev/null) &&
> +	packbsha1=$(git pack-objects --use-bitmap-index --all packb </dev/null) &&
> +	git show-index <packa-$packasha1.idx | cut -d" " -f2 >packa.objects &&
> +	git show-index <packb-$packbsha1.idx | cut -d" " -f2 >packb.objects &&
> +	test_cmp packa.objects packb.objects
> +'

Looks good.
