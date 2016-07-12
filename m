Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A72111F744
	for <e@80x24.org>; Tue, 12 Jul 2016 01:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932694AbcGLB74 (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 21:59:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59320 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932129AbcGLB74 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 21:59:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D6ADE2C475;
	Mon, 11 Jul 2016 21:59:53 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nWv7pW28AzM79b1CDLnWcnFhWR0=; b=s16yCt
	goLkVx17BBLrZL7OnP1M1I3OxP9VQEQX7aphkh7RFl9iPxdhMEH+2GcsmbJMYGJ8
	qqr7VTOevF1LSwivtubRr28ddzlhTHqk7AX5808p58MXtPm0DeEhiHi9myMC51g4
	kadE2IyOqtchvT4jAKzc9ai6rtElW0R8wGVWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VPtxYdvHxS2Czcdr5Nh3kTWQP/7tkCQ+
	+qkH5VuF48T6vftV7sin76+rj3g+rhF5x2fr0SVle1/3MtvtfhQ/L5auo8DmxyDl
	vobrn4SNu7Iyd5l4J9nm6QOd0xdK1pCNXfBXMGdBy7pNL6LakOcJrjjbtadvW0a3
	Jd0g32pfz/4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CEBF72C474;
	Mon, 11 Jul 2016 21:59:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 574002C473;
	Mon, 11 Jul 2016 21:59:53 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.9.1
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com>
	<87lh17kgdy.fsf@linux-m68k.org>
	<20160711235417.GA26163@sigill.intra.peff.net>
Date:	Mon, 11 Jul 2016 18:59:51 -0700
In-Reply-To: <20160711235417.GA26163@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 11 Jul 2016 19:54:18 -0400")
Message-ID: <xmqqy4577h0o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 531197DC-47D4-11E6-8A6D-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Jul 11, 2016 at 11:35:05PM +0200, Andreas Schwab wrote:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> >       local_tzoffset: detect errors from tm_to_time_t
>> 
>> not ok 19 - show date (iso:5758122296 -0400)
>> #      
>> #                      echo "$time -> $expect" >expect &&
>> #                      test-date show:$format "$time" >actual &&
>> #                      test_cmp expect actual
>> #              
>> not ok 20 - show date (iso-local:5758122296 -0400)
>> #      
>> #                      echo "$time -> $expect" >expect &&
>> #                      test-date show:$format "$time" >actual &&
>> #                      test_cmp expect actual
>> 
>> This is outside the range of 32bit time_t.
>
> Yes, that's somewhat the point of the test.
>
> How does it fail for you (what does it look like with "-v")? We may be
> able to check for an outcome that matches both cases.
>
> Otherwise, we'll have to skip the test, perhaps with something like the
> patch below. I suspect the problem is actually the size of "unsigned
> long", not time_t, as we use that internally for a bunch of time
> computation.
>
> ---
> diff --git a/help.c b/help.c
> index 19328ea..0cea240 100644
> --- a/help.c
> +++ b/help.c
> @@ -419,6 +419,13 @@ int cmd_version(int argc, const char **argv, const char *prefix)
>  	 * with external projects that rely on the output of "git version".
>  	 */
>  	printf("git version %s\n", git_version_string);
> +	while (*++argv) {
> +		if (!strcmp(*argv, "--build-options")) {
> +			printf("sizeof-unsigned-long: %d",
> +			       (int)sizeof(unsigned long));
> +			/* maybe also save and output GIT-BUILD_OPTIONS? */
> +		}
> +	}
>  	return 0;
>  }

I had the same thought, except that I would have expected this to go
to one of these test-* helpers, and then a lazy prereq for 64-bit
time_t would be written on top of it to skip these new tests.

> +build_option () {
> +	git version --build-options |
> +	sed -ne "s/^$1: //p"
> +}
> +
> +test_lazy_prereq 64BIT '
> +	test 8 -le "$(build_option sizeof-unsigned-long)"
> +'

It is somewhat disturbing that nobody seems to be regularly building
on 32-bit platforms these days, which is the only reason I can think
of why this was never reported until it hit a maintenance track.
This should have been caught last week at f6a729f3 (Merge branch
'jk/tzoffset-fix', 2016-07-06) when the topic hit 'master' at the
latest, and more preferrably it should have already been caught last
month at 08ec8c5e (Merge branch 'jk/tzoffset-fix' into next,
2016-06-28).

Those who care about 32-bit builds need to start building and
testing 'next' and 'master' regularly, or similar breakages are
bound to continue happening X-<.

Volunteers?

Thanks.
