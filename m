Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F122C4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 22:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BD3820874
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 22:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YN4ECcGW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392223AbgJZWKt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 18:10:49 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64802 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392164AbgJZWKs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 18:10:48 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DF46A10E082;
        Mon, 26 Oct 2020 18:10:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VyunnMGyFNg/LAjTyHm0n+P68RA=; b=YN4ECc
        GWGs2UZ4jgJzzRwN3N5UVuqo3OdGpEKNHQPne5RBPPY5y+GuEFRE8WedU54NKoPb
        5A3UEU0QQMxRXVfYoPpPW/DUUe9K1gRI8uDheRfE8Nps0vEdZsrJaFOsvICcM4UU
        EAXA7aqfuPfLw8Zueo/kkgd3/cGiyjYLHpHfk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CATbnrnXzWO6kc7Wwt/JAEiR1m5F7X3d
        IJL56q35PEoD7vDv+GFI8kDZpJXNcA7mgKIgKDHmLdzOLwkhfc96xAy91Z58F+qd
        /2h/CIdKbqiRWhq/I203I9X2oL3X/zY5Z6V+yNy24khc6UV+t6Ngxb6JHlAkwMno
        ZHFx8L37dJ4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D79EC10E081;
        Mon, 26 Oct 2020 18:10:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1F32910E07F;
        Mon, 26 Oct 2020 18:10:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Peter Baumann <peter.baumann@gmail.com>
Subject: Re: [PATCH v2 1/4] merge-ort: barebones API of new merge strategy
 with empty implementation
References: <pull.895.git.git.1603286555.gitgitgadget@gmail.com>
        <pull.895.v2.git.git.1603731448.gitgitgadget@gmail.com>
        <b9e73975eab1f349be678779ff57155feb4c3501.1603731448.git.gitgitgadget@gmail.com>
        <xmqqa6w8emxn.fsf@gitster.c.googlers.com>
        <CABPp-BFtzeOHS=ptgzkrpOL3gwvE6bSaRgxLO1QJ284J08i-mA@mail.gmail.com>
Date:   Mon, 26 Oct 2020 15:10:42 -0700
In-Reply-To: <CABPp-BFtzeOHS=ptgzkrpOL3gwvE6bSaRgxLO1QJ284J08i-mA@mail.gmail.com>
        (Elijah Newren's message of "Mon, 26 Oct 2020 14:18:46 -0700")
Message-ID: <xmqqsga0d4f1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 179C3FC6-17D8-11EB-8AB3-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> > +     /*
>> > +      * Additional metadata used by merge_switch_to_result() or future calls
>> > +      * to merge_inmemory_*().  Not for external use.
>> > +      */
>> > +     void *priv;
>> > +     unsigned ate;
>>
>> I'd prefer to see this named not so cute.  Will we hang random
>> variations of things, or would this be better to be made into a
>> pointer to union, with an enum that tells us which kind it is in
>> use?
>
> I don't understand the union suggestion.  Both fields are used.

I thought "priv" shouldn't be "anything goes, so it is 'void *'" but
is probably a "union { ... } priv;" with associated enum next to it
that tells which one of the possibilities in the union is in effect.

> Would you object if 'ate' was named '_'?

Either is horrible name.

>> > +/* rename-detecting three-way merge with recursive ancestor consolidation. */
>> > +void merge_inmemory_recursive(struct merge_options *opt,
>> > +                           struct commit_list *merge_bases,
>> > +                           struct commit *side1,
>> > +                           struct commit *side2,
>> > +                           struct merge_result *result);
>>
>> I've seen "incore" spelled as a squashed-into-a-single-word, but not
>> "in_memory".
>
> I can add an underscore.  Or switch to incore.  Preference?

Anything shorter would get my vote.

> Yes, your reading is correct.  We don't touch the index (or any index,
> or any cache_entry) at all.  Among other things, data that can be used
> to update the index are in the "priv" field.
>
> I'll try to add some notes to the file.

Sounds good.
