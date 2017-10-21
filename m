Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 471C9202A2
	for <e@80x24.org>; Sat, 21 Oct 2017 01:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753314AbdJUBwh (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 21:52:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62731 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753222AbdJUBwg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 21:52:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F1A2B2B23;
        Fri, 20 Oct 2017 21:52:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Fr96MsO1dnNAyZcPilphrcaiwlw=; b=O2Z3rq
        f1uNM/27lFYORScB9NWau23vrGTVPaMWCVk06HABo7VbslPWSEDMJmXH1nETbhrY
        2HIKmat9OtxklC1RA80cIi4wQR/1QrkGYnCI6if7gHXIyVJmiCMItZx2610wI3Eo
        Agegdtb34dNeYO6ap+3rUit+2zsAg/VIUlds0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NW63L/6EDQIOdoiqDCTEN09tpPATSGjI
        cA9LANK/34Tfo6wNkgDbwmAnzTwqmJ0OBdbwSNWM3BqPRXyMStDjXjenT4cUKB3i
        tWQgapT/0lP01vKcaxlVlgJyqxBgck4yHZg2qioovNbOZUdVlp0/YeKlOtiaeNwP
        R87vnzG6UZA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 64DEDB2B22;
        Fri, 20 Oct 2017 21:52:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CF44DB2B21;
        Fri, 20 Oct 2017 21:52:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Marius Paliga <marius.paliga@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, thais.dinizbraz@gmail.com
Subject: Re: [PATCH] builtin/push.c: add push.pushOption config
References: <xmqqmv4pl117.fsf@gitster.mtv.corp.google.com>
        <20171019174715.6577-1-marius.paliga@gmail.com>
        <CAGZ79kaSU+w0=zb61=5pEzhtd4U5Hzae4C2bUgpchNHAL_mzMA@mail.gmail.com>
        <xmqqbml2imrj.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbEmdJu9a-h07UvPaymMmLJ4Azm+iChSpCBwvvtOW8gog@mail.gmail.com>
Date:   Sat, 21 Oct 2017 10:52:33 +0900
In-Reply-To: <CAGZ79kbEmdJu9a-h07UvPaymMmLJ4Azm+iChSpCBwvvtOW8gog@mail.gmail.com>
        (Stefan Beller's message of "Fri, 20 Oct 2017 12:02:09 -0700")
Message-ID: <xmqqfuadgtcu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8232DB8C-B602-11E7-AEAC-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>>> So in the config, we have to explicitly give an empty option to
>>> clear the previous options, but on the command line we do not need
>>> that, but instead we'd have to repeat any push options that we desire
>>> that were configured?
>>
>> It is not wrong per-se to phrase it like so, but I think that is
>> making it unnecessarily confusing by conflating two things.  (1)
>> configured values are overridden from the command line, just like
>> any other --option/config.variable pair
>
> because they are single value options (usually).
>
>> and (2) unlike usual single
>> value variables where "last one wins" rule is simple enough to
>> explain,, multi-value variables need a way to "forget everything we
>> said so far and start from scratch" syntax, especially when multiple
>> input files are involved.
>
> ok, my view of how that should be done is clashing once again
> with the projects established standards. Sorry for the noise.

I do not think it is a noise.  I was primarily focusing on "have to
explicitly" part, making it sound as if it was a flaw.  I do think
it is a good idea to explain a variable and/or an option is
multi-valued and how multiple instances of them interact with each
other.  I think the status quo is:

	Both configuration and command line, these multi-valued
	things accumulate.  The "command line can be used to
	override things from the configuration" rule applies as any
	other config/option pair.

	In addition, in the configuration, there is a mechanism to
	clear the values read so far with the "an empty value
	clears" rule, because you may not have control over, or it
	may be cumbersome to modify, lower-priority configuration
	files.  There is no such thing for command line, as the
	entirety of the command line for each invocation is under
	your control.

If somebody has

	[alias] mypush = push -ofoo

then the command line argument for one invocation of "git mypush"
may *not* be under your control and it might be also convenient if
there were a mechanism to clear what has been accumulated from the
command line.  It may be worth considering, but if we were going in
that direction, I suspect that it is probably a good idea to first
step back a bit and introduce a mechanism to easily define pairs of
option/config in a more sysmtematic way [*1*].  Once we have such a
mechanism, the "clear the previous" syntax for the command line
would be implemented uniformly in there.


[Footnote]

*1* E.g. right now, the fact that "push --push-option" and
    "push.pushOption" are related, or that "status -u<mode>" and
    "status.showUntrackedFiles" are related, is only known to the
    code and the documentation; I am not sure if it is even a good
    idea to add config to each and every option that exists, but for
    the ones that do exist, it would be nicer if there were a more
    uniform and systematic way for parse-options.c and config.c APIs
    to help our code, instead of writing git_config() callback and
    options[] array to give to parse_options(), making sure they
    refer to the same internal variable, and the latter overrides
    the former.
