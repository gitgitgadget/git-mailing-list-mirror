Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6C4C433E0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 15:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 671C120671
	for <git@archiver.kernel.org>; Fri, 15 May 2020 15:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cTfUkj1y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgEOP1r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 11:27:47 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61383 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgEOP1r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 11:27:47 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 98C78CC8CF;
        Fri, 15 May 2020 11:27:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+MJAJln3ZqNYcdzfNP+7GcWSTpI=; b=cTfUkj
        1yn9fj0Mu0HBvRMeKtD2ZyRm5Kg0yGaTY8m+6qGw+zaG9HeHOPXkoy/aT/FI2fvS
        DbWZ8tnDGTMHCpICiovXUYaOZIcJAMyruIYQc+V/ww6hwyHpVH5QhINFfBu1ksJ9
        SDaX6vAMjofEXEdRgk0vJrcKTYntMgVUsLKjE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O5AVNUFfwSyIDp1BaDCRR59s9FdoC/rF
        8ETs70gyZn5XCtE8b9Y7oFZdWErB0qt6olwAsd84Gy/cOz8AMBiF6/Xqqv1RhfyT
        hQoeFfoog0U53ME7f3OZ2Vjr75y1yJsGor7K+GBZzrIRr7Jt/17KIlEw9mpOMzxa
        Q/PkrPxr4JM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 91285CC8CE;
        Fri, 15 May 2020 11:27:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D49D2CC8CB;
        Fri, 15 May 2020 11:27:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH] trace2: log progress time and throughput
References: <20200512214420.36329-1-emilyshaffer@google.com>
        <8f159f13-ed61-61ea-8e9a-c1ffbc5fddb3@gmail.com>
Date:   Fri, 15 May 2020 08:27:42 -0700
In-Reply-To: <8f159f13-ed61-61ea-8e9a-c1ffbc5fddb3@gmail.com> (Derrick
        Stolee's message of "Fri, 15 May 2020 06:59:33 -0400")
Message-ID: <xmqqzha9md5d.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9F4F2C9C-96C0-11EA-8F96-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> +	if (p_progress && *p_progress) {
>> +		trace2_data_intmax("progress", the_repository, "total_objects",
>> +				   (*p_progress)->total);
>
> Should this be "total_objects"? Progress can iterate over lots of things,
> such as cache entries. Perhaps leave it as "total"?

Good point.  

I think the literal strings like "total_objects" we see in this
patch can later be customized in the same future change that lets us
give a more useful output than "Receiving objects" by having a
handful of customizable strings in the progress struct as hinted by
Emily under the three-dash line.  So I do not mind leaving it as-is.
If a reroll has to come without making these strings customizable,
it may be an improvement to change it to "total" if we do not forget,
but as long as we know where we are going in the longer term, I do
not think it is a big deal.

>> +
>> +		if ((*p_progress)->throughput)
>> +			trace2_data_intmax("progress", the_repository,
>> +					   "total_bytes",
>> +					   (*p_progress)->throughput->curr_total);
>
> I like the extra detail here for the specific kind of progress used in
> network transfer.

The curr_total field must be counted in bytes, by the fact that
strbuf_humanise_bytes() is called by throughput_string() to show it,
so "total_bytes" does make perfect sense.  The field might want to
get renamed to reflect this but obviously that's the kind of change
that we would not want in the middle of a more meaningful change
like this one.

>> +	}
>> +
>> +	trace2_region_leave("progress",
>> +			    p_progress && *p_progress
>> +				? (*p_progress)->title
>> +				: NULL,
>> +			    the_repository);
>> +
>>  	stop_progress_msg(p_progress, _("done"));
>>  }
>
> This trace2_region_leave() needs to be conditional on the progress
> being non-null. The pattern used by consumers of the progress API is:
>
> 	if (my_progress_condition)
> 		start_progress(&progress);
>
> 	do {
> 		display_progress(&progress, count);
> 	} while (condition);
>
> 	stop_progress(&progress);
>
> The condition to show progress or not is conditional on an option that
> is external to the progress API.
>
> The fix for this patch is simple: make the trace2_region_leave() be
> conditional on "p_progress && *p_progress".

Makes sense.

> This leads to an extra problem: if a user uses an option such as "--quiet",
> then the trace2 regions won't appear at all. This becomes even more important
> when thinking about scripts or tools that have stderr as a non-TTY, which
> disables progress most of the time.
>
> It's best to have trace2 data be consistent across commands. I think this can
> be accomplished, but it is a more invasive change to the rest of the codebase.

True, because "--quiet" means we cannot piggyback on the progress code.

> It requires invoking the progress API in all cases, and having the progress
> API conditionally initialize the progress struct. The new pattern would look
> like this:
>
> 	start_progress(&progress, my_progress_condition);
>
> 	do {
> 		display_progress(&progress, count);
> 	} while (condition);
>
> 	stop_progress(&progress);
>
> Then, start_progress() (and variants) could always start the trace2 region,
> and stop_progress() could always end the trace2 region.

OK.  Good analysis.

Thanks.

