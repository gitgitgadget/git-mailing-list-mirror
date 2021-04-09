Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3030CC433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 22:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08DE361165
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 22:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbhDIWcl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 18:32:41 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60215 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbhDIWci (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 18:32:38 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AE5E3137E25;
        Fri,  9 Apr 2021 18:32:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RmROow9IvXRtOemANJeMowmhRD8=; b=UiWzW2
        al2gSqlGEphwRQQ3ysYwpp/QA+5eUhH+X+qFbx/hSVtc0MUn3Qp825zTpWLMGQa/
        OX5pLzI4wJGI3cTulyvIwdsoZajEIdCPIW7hQulL/eoR2hJySwddttAJHwPYtBmz
        JyjH8ojzfKr9mz/te5Tyq3PLI6hfDQVDv+JuM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xy6+faQbjm5Tg3JfUg3l0lAMOHsdQlXB
        ZiqKDpVBMg4Ca/ZmMDneZsraXVBk6CmWgPfjNBP99rRMAd0KpKZ1uhA7l1EAbs2L
        2+TZHVom6AFBC2fEUZdi/fnRuoK2ZM2dE64TRqE+i9Mu4EYHqJahgkk5CIBYKp0K
        6PFyLi7x1Vc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A6E93137E24;
        Fri,  9 Apr 2021 18:32:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F2104137E23;
        Fri,  9 Apr 2021 18:32:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] object.c: initialize automatic variable in
 lookup_object()
References: <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
        <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com>
        <patch-2.3-f1fcc31717-20210409T080534Z-avarab@gmail.com>
        <YHCUmM7CqJ83ZXrL@coredump.intra.peff.net>
Date:   Fri, 09 Apr 2021 15:32:20 -0700
In-Reply-To: <YHCUmM7CqJ83ZXrL@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 9 Apr 2021 13:53:28 -0400")
Message-ID: <xmqqa6q7m6mj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 735B04A0-9983-11EB-8793-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>>  struct object *lookup_object(struct repository *r, const struct object_id *oid)
>>  {
>>  	unsigned int i, first;
>> -	struct object *obj;
>> +	struct object *obj = NULL;
>>  
>>  	if (!r->parsed_objects->obj_hash)
>> -		return NULL;
>> +		return obj;
>
> I actually prefer the original style (where any "can we bail early"
> checks just explicitly return NULL, rather than making you check to see
> that obj is NULL).

Perhaps I should return "me too" here.



