Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2504020899
	for <e@80x24.org>; Fri, 11 Aug 2017 21:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753713AbdHKVek (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 17:34:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61733 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753401AbdHKVek (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 17:34:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0F1FBAA756;
        Fri, 11 Aug 2017 17:34:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=n2fAcwG6wUN56s6QcW63NqTYesU=; b=oNHL7J
        kI6qF3ntB5+aoTT2J3zKunNdSJnfAOKB1yFD/YuBQVW19w9q8KaY+1sQ83W5CCNK
        lGzwvKVT5iUCUXjzdVlROX9mzj+kSyWR0mn4w+JnSy71p6SRcrA3OyX0p08XckPP
        H4olkhYMt6M+sHNeWuHq9U8GNWkBBjdeqLF8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eBRab5/RvL1C3N5SRV6d7xU6RjBTRIUe
        AoxwjGdehI//7st/NqnrcpsG7OC3ffvWXHbhkg7WZkN0b0OAo9YfFpl4/vh18G78
        sS92Z9lVGnr+XOzYsE3MLRMc7z9OJy2azNsmVQKRdj6wQcJ8nVbr8joHQTBn+MuF
        HpALfpOhdxM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 04D50AA755;
        Fri, 11 Aug 2017 17:34:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 54F8EAA753;
        Fri, 11 Aug 2017 17:34:28 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC PATCH 01/10] pack: move pack name-related functions
References: <cover.1502220307.git.jonathantanmy@google.com>
        <368a1095557aa5f68cebd4d4e08628351c03b843.1502220307.git.jonathantanmy@google.com>
        <CAGZ79kYQP74fTu1hFDLyKhS-2NTbUhtirWTxRMNavgO09SenYg@mail.gmail.com>
        <20170808135001.48f2440e@twelve2.svl.corp.google.com>
        <CAP8UFD20_Q7djbJfMmrGEnN3j2NasHyvuNAfZHMr_bNRjO0qpw@mail.gmail.com>
        <20170809101646.4bc67606@twelve2.svl.corp.google.com>
        <b65a5d52-490f-5ea6-aef5-8d2f6c916536@gmail.com>
Date:   Fri, 11 Aug 2017 14:34:27 -0700
In-Reply-To: <b65a5d52-490f-5ea6-aef5-8d2f6c916536@gmail.com> (Ben Peart's
        message of "Fri, 11 Aug 2017 15:38:31 -0400")
Message-ID: <xmqqinhtzt3w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DAA5B44A-7EDC-11E7-9199-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> On 8/9/2017 1:16 PM, Jonathan Tan wrote:
>
>> Ah, I forgot to mention this in the cover letter. I thought that one
>> header was sufficient to cover all pack-related things, so if we wanted
>> to know which files used pack-related things, we would only need to
>> search for one string instead of two. Also, the division between
>> "pack.h" and the hypothetical "packfile.h" was not so clear to me.
>
> I prefer having source and the header files that export the functions
> have matching names to make it easy to find them.  I would prefer
> packfile.h vs pack.h myself.

Meaning "If we have packfile.c, packfile.h is preferrable over pack.h"?
I tend to agree with that.
