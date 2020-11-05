Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856CDC388F7
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 19:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 199862078E
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 19:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tvinnzyB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgKETV3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 14:21:29 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55170 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgKETV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 14:21:29 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B8FE0905E4;
        Thu,  5 Nov 2020 14:21:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t3Lovi7r3Uf9ohkn9RCs1JHNECI=; b=tvinnz
        yBCKMvWp0yC6CwpQsC7wv8D6Ba63+DwdaQuCvGI8WFAuEedNk0scrxJCUTXnZnAS
        OBvb+CHfvfXlb3xGgfqrCUFk5QRr4gJLR+KtjOtjqXBv4H+eTvjgwxRm9KVHQZus
        52ggznSZP5zFWcEztUq5ow9ZqwLIf4T5zGn+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=itvDxEba/eeZ6GIod3z8VxWrh5n6eyXK
        GKb7Eq/9ZKpfI3/WMw89DJPsNUs8CNzFoaqi0noXc+KhbcnzBxISfe6VOB+7CGCW
        0tEoIHhFy89PySWtu8ZFDM4O0GZvFxph+Ti9Z3wpojgUrhYh+qzkETCYUyxtBvwu
        SvHI81nHY4s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B04AB905E3;
        Thu,  5 Nov 2020 14:21:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3B159905E1;
        Thu,  5 Nov 2020 14:21:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 08/11] fetch-pack: advertise trace2 SID in capabilities
References: <cover.1604006121.git.steadmon@google.com>
        <cover.1604355792.git.steadmon@google.com>
        <11b5b1b54f14354f08c9eb230d5b4e6a3de1996b.1604355792.git.steadmon@google.com>
        <xmqqimaklsvg.fsf@gitster.c.googlers.com>
        <20201105185855.GB36751@google.com>
Date:   Thu, 05 Nov 2020 11:21:25 -0800
In-Reply-To: <20201105185855.GB36751@google.com> (Josh Steadmon's message of
        "Thu, 5 Nov 2020 10:58:55 -0800")
Message-ID: <xmqqd00rk3t6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 192B6346-1F9C-11EB-9746-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

>> The same comment as 05/11 and 06/11 applies to this repeated
>> appearance of this boolean expression:
>> 
>> 	advertise_trace2_sid && trace2_is_enabled()
>> 
>> If we are committed to stick to the "even if we were told to
>> advertise, do not alllocate a session ID" design, perhaps it is
>> cleaner to clear advertise_trace2_sid at the very beginning,
>> immediately after we learn that the tracing is disabled and the
>> advertiseSID configuration is read.  That way, everybody needs to
>> only care about advertise_trace2_sid variable.
>> 
>> Incidentally, if we decide to change the semantics to auto allocate
>> the session ID if advertiseSID configuration asks us to advertise
>> (it is OK if we do not enable the full trace2 suite), we can still
>> make the code only check advertise_trace2_sid variable, without
>> adding repeated check of trace2_is_enabled() everywhere at all.
>
> Good point. Once we settle on whether or not to advertise when tracing
> is enabled, I'll update these conditionals in V3.

Well, we can update these conditionals _before_ deciding that, and
that is the whole point of the part of my message you are responding
to.

Whether the advertise_trace2_sid means 

 (1) config asked and tracing enabled, or

 (2) config asked and we do not care whether tracing is enabled or not

it makes it easier to flip between (1) and (2) later if you clean up
the conditional first.

Thanks.

