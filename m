Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B921720899
	for <e@80x24.org>; Thu, 27 Jul 2017 16:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751850AbdG0QqC (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jul 2017 12:46:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57999 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751846AbdG0QqA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2017 12:46:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D48D9E04E;
        Thu, 27 Jul 2017 12:45:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b4z9rrmFG0x8P7m+fnjO6f7bNj8=; b=gV1T2Y
        bzp++m0xgKvdAiAlLw3GbhygOw1t/aKr9UdSrzbRy/fhsheuF+MNLGQqpzW0ka1z
        ofl7yXNl6rJVLPf663LvGazaz5ilxSzbz4SFJQRegKb9A6eIv6LH4DwdVeDsONx7
        igqhE3WcKhPs1tf3W03Q/L4Y+wkZ/2zvMBqRs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F7S4GeOcWuqe6EFlKdEWJ0tlk2U9O3lj
        KvnhZp8UJ+QF2yQU0LVZ5dng8lXTeU+UfxGzR90rK8BPkPeqjtBm7AGOXN5adApU
        T2fMY26JI5Ln30EJags+7UUjFK+v7UlaB+/WEokJ5Xxq23+S3Sy+uU8jsZCeUwrf
        rPwQDHO7pOE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 95B4D9E04D;
        Thu, 27 Jul 2017 12:45:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EAC2F9E04C;
        Thu, 27 Jul 2017 12:45:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Blake <eblake@redhat.com>, git@vger.kernel.org
Subject: Re: [PATCH] git-contacts: Add recognition of Reported-by
References: <20170721141530.25907-1-eblake@redhat.com>
        <xmqqbmodj1pa.fsf@gitster.mtv.corp.google.com>
        <a8b47a45-0100-dbef-0bff-fdfdb9cbccb4@redhat.com>
        <xmqqwp71hj5n.fsf@gitster.mtv.corp.google.com>
        <20170724183103.b4vbr5xkijj7s7z3@sigill.intra.peff.net>
        <xmqqzibtd473.fsf@gitster.mtv.corp.google.com>
        <20170724193651.ocup4b6cs5hqmstx@sigill.intra.peff.net>
Date:   Thu, 27 Jul 2017 09:45:57 -0700
In-Reply-To: <20170724193651.ocup4b6cs5hqmstx@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 24 Jul 2017 15:36:51 -0400")
Message-ID: <xmqqh8xxomka.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 113648E2-72EB-11E7-8FCE-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yeah, I don't think interpret-trailers is currently a useful tool for
> looking at an extra config key like that. I'd expect it would need to be
> extended, or a new tool added, or perhaps existing tools would need to
> learn more about how trailers work (e.g., it would be nice if git-log
> could do matching or even print them via %(trailer:reported-by)
> placeholders or something). I think there's a lot of potential work in
> that area.
>
> Of course git-contacts (or send-email) _can_ just look look at all of
> the trailer.*.autocc config and try to match those manually. But the
> point of having trailer config, I think, is that we should stop doing
> ad-hoc parsing and have a tool for manipulating and querying trailers.
> If interpret-trailers isn't up to the task yet, I'd rather see work go
> there.
>
> But that (manual parsing) is basically how the current cc and s-o-b
> trailers implemented inside of git-send-email, so I don't think it would
> be the end of the world as a quick hack that could later be expanded to
> use the trailer infrastructure.

OK.

In any case, I think not CC'ing the reporter would be a bug, and an
update to the "contacts" script (in contrib/) to use an improved
convention and interpret-trailers tool can be built on top of the
version Eric posted, so let's take the patch anyway for now.

Thanks.
