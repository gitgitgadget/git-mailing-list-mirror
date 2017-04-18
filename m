Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 227311FA26
	for <e@80x24.org>; Tue, 18 Apr 2017 04:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750759AbdDREvr (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 00:51:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58767 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750727AbdDREvq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 00:51:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 723E47660B;
        Tue, 18 Apr 2017 00:51:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1HFCnxnBAobugrjiXRUb+sFnI88=; b=TFHJZ+
        56wQl8yZpJ7zQN4EB3Cw7UHSiKt4q136gelv7ErfqA02Pe8q8q8LRvn5O856BPMg
        MBJIegvrxOhT9MtYtyXYi2wVCstZgAMIiFIgg17EJoPuZ1/YQ5XGwWDkqIj9aBRN
        cvwWQT6yfOMbBW78gKUhFRH+IXf7k0mV9CspA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=R9GfEOgErsLHboTRdRZ8iFC+H0sJLX5p
        ehpmm/ShlssPIN1DiYkc3J95yp5O9IONQICjOvsFZnie8+aEgRq5P4JSom2g9BAl
        zHYxUNKkQIge3BETGqrFp8piZN5oOE8cbBNZLXlNpfq2kz6JadFxYcrl8bG7/rji
        EeT6cWN25zk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6AF6E7660A;
        Tue, 18 Apr 2017 00:51:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CDAAF76609;
        Tue, 18 Apr 2017 00:51:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, bert.wesarg@googlemail.com
Subject: Re: [PATCH v2 1/3] config: prepare to pass more info in git_config_with_options()
References: <CACsJy8D-=3qPbEO-dq2+Mr-WZ+5RrivkSw9NX7_FhEJFy+59zA@mail.gmail.com>
        <20170417101002.18272-1-pclouds@gmail.com>
        <xmqqd1cah2m3.fsf@gitster.mtv.corp.google.com>
        <20170418035509.6zd4kxtfggei5yaj@sigill.intra.peff.net>
Date:   Mon, 17 Apr 2017 21:51:42 -0700
In-Reply-To: <20170418035509.6zd4kxtfggei5yaj@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 17 Apr 2017 23:55:10 -0400")
Message-ID: <xmqqr30qe2sh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B843BC5C-23F2-11E7-B576-C260AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Apr 17, 2017 at 07:27:16PM -0700, Junio C Hamano wrote:
>
>> > @@ -81,7 +82,7 @@ static struct option builtin_config_options[] = {
>> >  	OPT_GROUP(N_("Other")),
>> >  	OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),
>> >  	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
>> > -	OPT_BOOL(0, "includes", &respect_includes, N_("respect include directives on lookup")),
>> > +	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include directives on lookup")),
>> 
>> It would be more in line with what the log message advertised if you
>> did
>> 
>> 	static struct config_options config_options = {
>> 		-1, /* .respect_includes: unspecified */
>> 	};
>> 
>> 	OPT_BOOL(0, "includes", &config_options.respect_includes, N_("...")),
>> 
>> no?
>
> I think I like the split between the option-value here and the "final"
> value that goes into config_options.respect_includes. Because we
> actually munge it later based on the given-config value anyway.
>
> So I agree this makes the diff larger than it might need to be, but I
> think the end result is a bit nicer.

Yeah, I didn't see the end result was a single bit (unsigned :1).
This separation is OK.
