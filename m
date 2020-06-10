Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D19BC433DF
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 17:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47F842072E
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 17:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RHG8E2/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgFJRQL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:16:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51481 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbgFJRQL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 13:16:11 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 85D0A5AAC0;
        Wed, 10 Jun 2020 13:16:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6RQ7OFIPtQJ9nBUBtU7NgYYZN50=; b=RHG8E2
        /mcoVmZ0puqZbrJo8RIYSBulNXz07lekwju+T6HD4XdJWf80dZDbD87EpnG1iaGv
        TynU4OV43BkqBped2B1b8/5/JPkrEsRE4phG8I/ICy4JFhfc9e+FOQ1cFIJTBM4Y
        1Ygh6soyHd8ux8hR3HynqxF4lQ31WOhKiYA/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=V5GnlbOtDiBoglNqFZ9isY31EtRCitpy
        XJv0Hmz0xW2I7uR/xXKExZMfAW2exQzpifnC0M6T+TDu+2J/oaAxjuZFTD9s2+t8
        W55gR3WpCv9hiXrrqQJn5sTPHojQiVMJalGRMp4rBClPt5wtSq1mQ07qScYYyHTj
        D+efjn5VrU4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D2645AABF;
        Wed, 10 Jun 2020 13:16:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 100FF5AABE;
        Wed, 10 Jun 2020 13:16:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/8] Documentation: add Packfile URIs design doc
References: <xmqq5zcexoqi.fsf@gitster.c.googlers.com>
        <20200610011406.178334-1-jonathantanmy@google.com>
Date:   Wed, 10 Jun 2020 10:16:09 -0700
In-Reply-To: <20200610011406.178334-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 9 Jun 2020 18:14:06 -0700")
Message-ID: <xmqqeeqmg7ty.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 140AF4E4-AB3E-11EA-BF35-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> > @@ -349,6 +362,9 @@ header. Most sections are sent only when the packfile is sent.
>> >  		  *PKT-LINE(wanted-ref LF)
>> >      wanted-ref = obj-id SP refname
>> >  
>> > +    packfile-uris = PKT-LINE("packfile-uris" LF) *packfile-uri
>> > +    packfile-uri = PKT-LINE(40*(HEXDIGIT) SP *%x20-ff LF)
>> 
>> 40* 
>
> I'm almost ready to send out an updated version, but have one question:
> what do you mean by this? If you mean that I should use "obj-id"
> instead, I didn't want to because it's not the hash of an object, but
> the hash of a packfile.

It clearly is not an object name, but it is a run of hexdigits whose
length is the same as (hexadecimal representation of) the object name.

How is "obj-id" we see above in the precontext of that hunk defined?
Does it use 40*(HEXDIGIT), too?  Do we plan to support non SHA-1 hashes
in this design in the future, and if so how?

"We are only focused on SHA-1 hashes for now" is a perfectly
acceptable answer, and then 40* here makes 100% sense, but then we'd
need to say "for now this design only assumes SHA-1 hash" upfront, I
would think, to remind ourselves that we need to consider this part
of the system when we upgrade to SHA-256.

Thanks.
