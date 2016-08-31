Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 453A21F859
	for <e@80x24.org>; Wed, 31 Aug 2016 18:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760221AbcHaSLU (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 14:11:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55343 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758839AbcHaSLR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 14:11:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2360239967;
        Wed, 31 Aug 2016 14:11:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2NrqwVWUtezhHsJf6F4w1Mv9wE0=; b=R5dM8I
        trs8eVmQn7lkdZaWPRu4fSfa21hlqV8yCdlLczDIRg44UQq4k6GL0i2Ze140Dfrs
        +TfZ9m+DhUl3fVE1TpnJF2VhXaHddbyHFqneTFSPOB0q3zraGNFPhiEd9fzdZ72f
        7I5c1OH6KhgqV1gYm6eEzzjQrUEy/V/EYphRY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VtxYlW6E+HN0ITO6AVNK2ll7LXFinchR
        uia9HlEN9vliYoYQbc4eEz7MvgVxp08gQP3Z745FPgKWgnwDourr/7nasb+Wkci+
        01ZtFfuT/HhHxB7169Hx69SRmWiorkYTgkxTi6qdHds/I0WR6OGXlN5bG9jJe/Xa
        aA0LSXiZqIA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1C6B639966;
        Wed, 31 Aug 2016 14:11:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A190239965;
        Wed, 31 Aug 2016 14:11:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joe Perches <joe@perches.com>
Cc:     git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] git-send-email: Add ability to cc: any "trailers" from commit message
References: <b2aa91d59a6cdd468bcbe85b45807cc1b82b23ed.1472588158.git.joe@perches.com>
        <xmqqpooo259c.fsf@gitster.mtv.corp.google.com>
        <1472666194.4176.17.camel@perches.com>
Date:   Wed, 31 Aug 2016 11:11:13 -0700
In-Reply-To: <1472666194.4176.17.camel@perches.com> (Joe Perches's message of
        "Wed, 31 Aug 2016 10:56:34 -0700")
Message-ID: <xmqqlgzc24hq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4EAF3F24-6FA6-11E6-BEFE-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joe Perches <joe@perches.com> writes:

> On Wed, 2016-08-31 at 10:54 -0700, Junio C Hamano wrote:
>> Joe Perches <joe@perches.com> writes:
>> 
>> > 
>> > Many commits have various forms of trailers similar to
>> >      "Acked-by: Name <address>" and "Reported-by: Name <address>"
>> > 
>> > Add the ability to cc these trailers when using git send-email.
>> I thought you were asking what we call these "<token> followed by
>> <colon>" at the end of the log message, and "footers or trailers"
>> was the answer.
>> 
>> I do not have a strong objection against limiting to "-by:" lines;
>> for one thing, it would automatically avoid having to worry about
>> "Bug-ID:" and other trailers that won't have e-mail address at all.
>> 
>> But if you are _only_ picking up "-by:" lines, then calling this
>> option "trailers" is way too wide and confusing.  I do not think
>> there is any specific name for "-by:" lines, though.  Perhaps you
>> would need to invent some name that has "-by" as a substring.
>> 
>> "any-by"?  or just "by"?  I dunno.
>
> Signatures?

Helped-by: and Reported-by: are often written by the author of the
patch and not by those who helped or reported, so calling them signatures
imply the author is forging them, too ;-)

I dunno.

Any name that hints that this applies only to the trailers that ends
with "-by" is fine but "Signatures-by" does not sound very
grammatical.
