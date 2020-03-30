Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB1AC43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 16:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0C32072E
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 16:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="I7SsRZso"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbgC3QtV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 12:49:21 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57274 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbgC3QtV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 12:49:21 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7305DCEEC7;
        Mon, 30 Mar 2020 12:49:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZiRFWsYOdWS81IN3iKUMPlfcW6E=; b=I7SsRZ
        soP4L/q95XZnPI2B7p+h6maU+qCDfv3+Ph8L0qt7sJOCSqhLIoqgKMXsOSUEsUwZ
        SWcpctbRnmef2A0j6tZ0NJOcYKJ6ZjGBy8oZVUzlM8MRMt6yvZdS6sLzkRG9Tkyy
        Ruv/ez82wCic/+UpyW3r5h2Mzf0W+JTUE4hL0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bZW9HsC7wuzdunW4FTCkew2Ys3kHQHlq
        iLq5tARZjxecC7tWLFfyogUP0hqiQb5k+Pll6gy3rfr5Wx43/jtLO+lMxk0w9GH4
        nDoeuzrSTQ84LY8jJzViZLRn23kCoa10ZIlFmMMkZA676Khv8I+fCGadoYDyeiQV
        mKhsDYX71VQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 58E86CEEC6;
        Mon, 30 Mar 2020 12:49:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 91ED0CEEC3;
        Mon, 30 Mar 2020 12:49:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        congdanhqx@gmail.com, newren@gmail.com
Subject: Re: [PATCH v3] rebase --merge: optionally skip upstreamed commits
References: <20200309205523.121319-1-jonathantanmy@google.com>
        <20200330040621.13701-1-jonathantanmy@google.com>
        <e917f451-c00a-c819-7f78-888ba6e8f5ea@gmail.com>
Date:   Mon, 30 Mar 2020 09:49:12 -0700
In-Reply-To: <e917f451-c00a-c819-7f78-888ba6e8f5ea@gmail.com> (Derrick
        Stolee's message of "Mon, 30 Mar 2020 08:13:32 -0400")
Message-ID: <xmqq1rp9aiuv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6367CD80-72A6-11EA-8EA3-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> +--keep-cherry-pick::
>> +--no-keep-cherry-pick::
>
> I noticed that this _could_ have been simplified to
>
> 	--[no-]keep-cherry-pick::
>
> but I also see several uses of either in our documentation. Do we
> have a preference? By inspecting the lines before a "no-" string,
> I see that some have these two lines, some use the [no-] pattern,
> and others highlight the --no-<option> flag completely separately.

"git log -S'--[no-]' Documentation/" (and its "-S'--no-'" variant)
tell us that many of our recent commits do prefer the single-line
form, but then in d333f672 (git-checkout.txt: spell out --no-option,
2019-03-29), we see we turned a handful of "--[no-]option" into
"--option" followed by "--no-option" deliberately  [*1*].

So, we do not seem to have a strong concensus.

I think all the new ones that spell --no-option:: out are the ones
when --option:: and --no-option:: have their own paragraph, e.g.
"--sign/--no-sign" of "git-tag".

As the differences do not matter all that much, I do not mind
declaring (and one of the tasks of the maintainer is to make a
declaration on such a choice that it matters more for us to pick
either one and we all sticking to it, rather than which choice we
make) that we'd prefer the expanded two-liner form (which when
formatted would become a single line with two things on it) and
mark the task to convert from '--[no-]option' as #leftoverbit.

Thanks for your attention to the details.


[Footnote]

*1* The justification given was that it makes is it is easier to
search that way and it is less cryptic.  Personally I do not think
it matters that much.  Even when trying to learn what the negated
form does, nobody would look for "--no-keep-ch" to find the above
paragraph.  "keep-cherry-pick" would be what they would look for,
with or without leading double-dashes.
