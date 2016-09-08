Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 759D020705
	for <e@80x24.org>; Thu,  8 Sep 2016 18:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759372AbcIHSei (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 14:34:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59267 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1759323AbcIHSeh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 14:34:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C80FD3C18F;
        Thu,  8 Sep 2016 14:34:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y9MLY2bHWUQZJV27kGWBwy0ms9o=; b=Ud9Xac
        ESSD0Tsr+fHtq8Q3qCJim92QjRa43aK7bpfqKjGj5z7Oav1FaSfvYARu71I9VAnX
        E73whDVwGWX83hD91ny5ALWqMyYnXS8EF2nP91+anw14tQ4Q2irskHm+fQpFrZ9W
        Ho9aUTjwVboMGviNiJTHQ9X3yVWNqrO1M/j8I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wXEe51vjdHy2vwWKEY03Iu+PF3BKblf3
        Xh2nplbsmDysZLcj74pDmwDAkkyPau+TKTsVSXk5KNe+NOdrbhNKF+SjCmWn20UY
        6nRIo47aJgUTwfB3y7+OHUanCTIq+5I2KNnbXBbI/jjsixon2YixkXcj8my6JwE1
        56x9xNS/Fp4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C058F3C18E;
        Thu,  8 Sep 2016 14:34:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4A06D3C189;
        Thu,  8 Sep 2016 14:34:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Move format-patch base commit and prerequisites before email signature
References: <20160908011200.qzvbdt4wjwiji4h5@x>
Date:   Thu, 08 Sep 2016 11:34:15 -0700
In-Reply-To: <20160908011200.qzvbdt4wjwiji4h5@x> (Josh Triplett's message of
        "Wed, 7 Sep 2016 18:12:01 -0700")
Message-ID: <xmqqshtags0o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DA1C004A-75F2-11E6-A5EC-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Triplett <josh@joshtriplett.org> writes:

> Any text below the "-- " for the email signature gets treated as part of
> the signature, and many mail clients will trim it from the quoted text
> for a reply.  Move it above the signature, so people can reply to it
> more easily.
>
> Add tests for the exact format of the email signature, and add tests to
> ensure the email signature appears last.
>
> (Patch by Junio Hamano; tests by Josh Triplett.)
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> ---
>
> Does the above seem reasonable, for a patch that incorporates the
> proposed patch from Message-Id
> xmqqh99rpud4.fsf@gitster.mtv.corp.google.com and adds tests?

Other than that I'd probably retitle it, your problem description
looks perfect.  I am still not sure if the code does a reasonable
thing in MIME case, though.

Thanks for tying the loose ends anyway.

> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index b0579dd..a4af275 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -754,9 +754,22 @@ test_expect_success 'format-patch --ignore-if-in-upstream HEAD' '
>  	git format-patch --ignore-if-in-upstream HEAD
>  '
>  
> +git_version="$(git --version | sed "s/.* //")"
> +
> +signature() {
> +	printf "%s\n%s\n\n" "-- " "${1:-$git_version}"
> +}

Hmph.  I would actually have expected that you would force a fixed
and an easily noticeable string via format.signature for the purpose
of the test, but I guess this test covers a lot more than what the
purpose of the main part of the patch does (i.e. enforces that the
default signature must be made from the version string of Git).  It
is not a bad thing to test, but it probably does not belong to this
change.  If you _were_ to split the patch in two, that is where I
probably would split, i.e. "we didn't test what the default signature
looks like, or we didn't make sure --signature option overrides the
default signature, so let's test it" as the preliminary preparation,
followed by "having base info after sig is inconvenient, let's move
it and make sure base info stays before sig with additional test" as
the second (and primary) patch.

But a single patch is fine.

Thanks.
