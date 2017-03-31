Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA9F620969
	for <e@80x24.org>; Fri, 31 Mar 2017 18:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933339AbdCaSGd (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 14:06:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55791 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933205AbdCaSGc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 14:06:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D7DA7BF36;
        Fri, 31 Mar 2017 14:06:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UYztEjHFqcY/Fk72yNwGznNVyRs=; b=bKmqnk
        g8Fu9/4yp9LiZm91+ucE4gMpG/jlS6pqE+IIw+ryzLYMCZZuiRSZsdCM3iHk1rBx
        eMZk+jDDsVGNhAfgT8baHAID1fb+lkUmRmM0DyaC4HAeT+hEAQmiEeUz22oGl1NA
        UFdbOHZ+aQMCW5OkANXbFz0NGaCfUYKOfU4sU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lle/mRtGObvEuskvY0a+pTW9ds0H7c64
        t0nNjqP95q/Qv9bKdT/zeKR1lXdI33Hyljd1KB++o/u69jAREDY70M/vghreqOU4
        mKmZQK6DzghSDkGLB7Hh2knc/avhkeynJef/6zEvxCS0S5urqwmLAi7sFngfSR/P
        q7CBx7JVOf0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 362DD7BF35;
        Fri, 31 Mar 2017 14:06:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8DE6D7BF34;
        Fri, 31 Mar 2017 14:06:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v3 3/4] name-rev: provide debug output
References: <xmqqinmq65at.fsf@gitster.mtv.corp.google.com>
        <cover.1490967948.git.git@grubix.eu>
        <21cf9d6f55d17463ab6eccdd78d57cf4a1b8e9e1.1490967948.git.git@grubix.eu>
        <xmqqtw69z8vz.fsf@gitster.mtv.corp.google.com>
        <14D0E7F4-0DC7-42ED-8DEE-B0338ECBA80D@grubix.eu>
Date:   Fri, 31 Mar 2017 11:06:28 -0700
In-Reply-To: <14D0E7F4-0DC7-42ED-8DEE-B0338ECBA80D@grubix.eu> (Michael
        J. Gruber's message of "Fri, 31 Mar 2017 20:02:57 +0200")
Message-ID: <xmqqd1cxz5gb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C3BDBA9C-163C-11E7-B8DA-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@grubix.eu> writes:

>>The only case that this change may make a difference I can think of
>>is when you have a tag object pointed at from outside refs/tags
>>(e.g. refs/heads/foo is a tag object); if you are trying to change
>>the definition of "from_tag" from the current "Is the tip inside
>>refs/tags/?" to "Is the tip either inside refs/tags/ or is it a tag
>>object anywhere?", that may be a good change (I didn't think things
>>through, though), but that shouldn't be hidden inside a commit that
>>claims to only add support for debugging.
>>
>>What problem are you solving?  
>
> Sorry, I forgot about that change and failed to mention it.
>
> It makes no difference in the non-debug case which cares about the
> Boolean only. In the debug case, I want to distinguish between
> annotated and lightweight tags, just like describe --debug does. By
> adding 1 via deref and passing this down, I know that an annotated tag
> gets the value 2, a lightweight tag 1 and everything else 0, just like
> describe --tags.

So it sounds like you meant to do something else, and the
implementation is wrong for that something else (i.e. it wouldn't do
the right thing for a tag object outside refs/tags/, with or without
the "--debug" option passed).

>>> @@ -236,7 +273,6 @@ static int name_ref(const char *path, const
>>struct object_id *oid, int flags, vo
>>>  	}
>>>  
>>>  	add_to_tip_table(oid->hash, path, can_abbreviate_output);
>>> -
>>>  	while (o && o->type == OBJ_TAG) {
>>>  		struct tag *t = (struct tag *) o;
>>>  		if (!t->tagged)
>>
>>This is a patch noise we can do without.
>>
>>Thanks.
