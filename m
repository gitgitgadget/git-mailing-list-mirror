Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E96C6FA8F
	for <git@archiver.kernel.org>; Thu, 24 Aug 2023 18:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243101AbjHXSs6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Aug 2023 14:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243102AbjHXSsd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2023 14:48:33 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A571BCD
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 11:48:30 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8EA8130803;
        Thu, 24 Aug 2023 14:48:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FoPcf0CGn/tHoB2+ZGwpJ670uD4lSDoZwGHEzd
        SOudw=; b=WgvZqMpxOn0XAhuYhlsvCilUO3+GNbb1D+R/lRJwxqCn5A6WhBc1/4
        KL2YLVU9irD/hkydItVs3EKetVQ8fOClgxbQQOOB1Y6A8MZAMIZQOVVrEhXQACqX
        2IIJlLj5d2S2xNb1amYUslAGiFti4yirBuekOElSKv1YMkVmcFSyA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8687A30802;
        Thu, 24 Aug 2023 14:48:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 78B8330801;
        Thu, 24 Aug 2023 14:48:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        calvinwan@google.com, glencbz@gmail.com
Subject: Re: [PATCH v2 2/4] config: report config parse errors using cb
References: <20230824173136.2252024-1-jonathantanmy@google.com>
Date:   Thu, 24 Aug 2023 11:48:24 -0700
In-Reply-To: <20230824173136.2252024-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Thu, 24 Aug 2023 10:31:36 -0700")
Message-ID: <xmqqfs48b7k7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CEBA2FD4-42AE-11EE-9628-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>> > @@ -1035,8 +1088,6 @@ static int git_parse_source(struct config_source *cs, config_fn_t fn,
>> >  	int comment = 0;
>> >  	size_t baselen = 0;
>> >  	struct strbuf *var = &cs->var;
>> > ...
>> > +	/*
>> > +	 * FIXME for whatever reason, do_event passes the _previous_ event, so
>> > +	 * in order for our callback to receive the error event, we have to call
>> > +	 * do_event twice
>> > +	 */
>> > +	do_event(cs, CONFIG_EVENT_ERROR, &event_data);
>> > +	do_event(cs, CONFIG_EVENT_ERROR, &event_data);
>> > +	return -1;
>> >  }
>> 
>> This indeed is very curious and needs to be looked into before we
>> proceed further.  How does the current control flow cope with the
>> behaviour?
>
> I plan to look at this more fully later, but about this, I wrote about
> this in a reply to the previous version:
> https://lore.kernel.org/git/20230804213457.1174493-1-jonathantanmy@google.com/

Thanks.

Also if you have time, can you comment on the latest round of the
fix to the Bloom filter hash functions that Taylor sent the latest
iteration for, either to give it a "looks perfect" to nudge it to
merge it down, to give it a further polishing, or whatever.  Thanks.


