Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B4141FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 16:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933323AbdCaQ4F (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 12:56:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56446 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933217AbdCaQ4E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 12:56:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 09D2A7AD73;
        Fri, 31 Mar 2017 12:55:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=V0QEKwG7pCat2cbewAbrLO/GXzs=; b=Lcqg9z
        jnOZg3bNTykBfJvs7EYTUilZcJRkSp7gLBY+j25KF+RV86qitC6WxHmee6ZALeY7
        PPJ28SSvssn29jL/mefYZSEAK0FjJDsW7ph93/qUvLmCtlaFzHlXTvhXCMjWTBBk
        v2cFoD5kNYWw4jbDNuvid906VHEAsiA0N4/sk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AvenlzB44Z+FEbfYCTKFvBQiPreG3YGV
        W8NrWQyQz/5H8s5ZMH4sP5e8iKY/050AveVFnOOBmiQFiO08G5d7tVRPCcUnTOMD
        GO2L4z1eIkiVtR/3vC3V+n1HnHO7QZEjU2Uomne5uusWiyPG5L1K/VIHJMCBt84B
        dvA5MzkvHs4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 014447AD71;
        Fri, 31 Mar 2017 12:55:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4EA387AD70;
        Fri, 31 Mar 2017 12:55:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v3 3/4] name-rev: provide debug output
References: <xmqqinmq65at.fsf@gitster.mtv.corp.google.com>
        <cover.1490967948.git.git@grubix.eu>
        <21cf9d6f55d17463ab6eccdd78d57cf4a1b8e9e1.1490967948.git.git@grubix.eu>
        <xmqqtw69z8vz.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 31 Mar 2017 09:55:56 -0700
In-Reply-To: <xmqqtw69z8vz.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 31 Mar 2017 09:52:16 -0700")
Message-ID: <xmqqpogxz8pv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E91E495A-1632-11E7-B895-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The only case that this change may make a difference I can think of
> is when you have a tag object pointed at from outside refs/tags
> (e.g. refs/heads/foo is a tag object); if you are trying to change
> the definition of "from_tag" from the current "Is the tip inside
> refs/tags/?" to "Is the tip either inside refs/tags/ or is it a tag
> object anywhere?", that may be a good change (I didn't think things
> through, though), but that shouldn't be hidden inside a commit that
> claims to only add support for debugging.

And if that "a tag object outside refs/tags/" is what you are
solving, I think a better place to do it is in name_ref().  

Instead of saying "from_tag is true iff it starts with refs/tags/",
you'd say "... or deref is set to true, because we know that the
original was a tag object in that case".


> What problem are you solving?  
>
>> @@ -236,7 +273,6 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
>>  	}
>>  
>>  	add_to_tip_table(oid->hash, path, can_abbreviate_output);
>> -
>>  	while (o && o->type == OBJ_TAG) {
>>  		struct tag *t = (struct tag *) o;
>>  		if (!t->tagged)
>
> This is a patch noise we can do without.
>
> Thanks.
