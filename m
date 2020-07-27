Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAE5C433DF
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 20:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C7B020729
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 20:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YxGAS8gG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgG0UL1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 16:11:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53476 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgG0UL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 16:11:26 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 88926790F7;
        Mon, 27 Jul 2020 16:11:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lnAbfIHV+AuqT+Ya9tby6Z5kD0o=; b=YxGAS8
        gG8KZn72w05CKdsNei+aLbAug48Vi2DGgE/1Q6JuIYS6j2v2M8QoVkACBXUxfAw8
        0Atew4+I22f6NiyaNzVLys8y5WUuZKyXqYy3wsFCGuj3l0E9430Ojp+AzutmZvYO
        z+xgUDW8tVBXTEhpYTA4afEVuldeb1Cg8Sebc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ao8Ue8RtApLHIeuOAQkVIvzl2ptAVD1W
        RQVkhj/QEeektRMMOLrVfKonS3atIdLiHZ6sDMeamOR1QAVgDAuOGhpvMgGpEfFw
        iHlxKNgHz88SAcFdGrTlfjRJOFycA1bMeEvU0DxqtGAcqo75j6Xqr8fn3mjNGbnh
        T8xM/RM8ATs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7F15F790F6;
        Mon, 27 Jul 2020 16:11:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0968D790F5;
        Mon, 27 Jul 2020 16:11:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Anders Waldenborg <anders@0x63.nu>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Questions about trailer configuration semantics
References: <87blk0rjob.fsf@0x63.nu> <xmqqr1swg9lc.fsf@gitster.c.googlers.com>
        <CAP8UFD1XV_jN10yOc2o4=5PtPcvT-RbxhY1H3swZz2r4g-Uzkw@mail.gmail.com>
Date:   Mon, 27 Jul 2020 13:11:23 -0700
In-Reply-To: <CAP8UFD1XV_jN10yOc2o4=5PtPcvT-RbxhY1H3swZz2r4g-Uzkw@mail.gmail.com>
        (Christian Couder's message of "Mon, 27 Jul 2020 20:37:26 +0200")
Message-ID: <xmqqk0yog1lg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 58469E70-D045-11EA-9A1D-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>> >  $ printf '\naCKed: Zz\n' | \
>> >    git -c 'trailer.Acked.key=Acked' interpret-trailers --parse
>> >  will emit: "Acked: Zz"
>
> Yeah, I think that's nice, as it can make sure that the key appears in
> the same way. It's true that it would be better if it would be
> documented.
>
>> > but only if "key" is used, other config options doesn't cause it to be
>> > normalized.
>> > E.g:
>> >  $ printf '\naCKed: Zz\n' | \
>> >    git -c 'trailer.Acked.ifmissing=doNothing' interpret-trailers --parse
>> >  will emit: "aCKed: Zz" (still lowercase a and uppercase CK)
>
> Yeah, in this case we are not sure if "Acked" or "aCKed" is the right
> way to spell it.

OK, so in short, the trailer subsystem matches the second level of
the configuration variable name (e.g. "Acked") in a case insensitive
way, and it does *not* normalize the case in the output.  The .key 
request is a mechanism to replace the matched key with the specified
string, so there is *NO* case normalization in what Anders observed.

In other words,

  $ printf '\naCKed: Zz\n' | \
    git -c 'trailer.Acked.key=Rejected' interpret-trailers --parse

would have emitted "Rejected: Zz".
