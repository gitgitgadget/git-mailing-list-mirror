Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D7271FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 17:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932163AbdC1Rcl (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 13:32:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53794 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932157AbdC1Rcl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 13:32:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B36C75BE1;
        Tue, 28 Mar 2017 13:32:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sL1imgDF/yrP6wtUzwm9dKwimsM=; b=fyFWjc
        5Ecn0kZxwpXTMwZ+tmOmLCLheMxub94Ykoa5vlAjBImK5scPfyjX1vLGiny+5Vih
        wv1701SAC7gu5lx0bNlIb56ozSdYkvZn30Lg7suK1QbwUSL02+0ROZuqbblqleSj
        lgq1w/qoGg65PschXSQMlyAhf+T3FI8uXW3QM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QcH/btnH6kIdfs6Ck8Ezg5Y0ZpdrokOx
        5UoqXzXrjrMTAGNparGF2EqIudZjSG85zIBBQLl3idgSgA0psXruA5rMXPtF+NcK
        DBEzIpCXY2OuzMKhdTiTpk86m2zIVBQn+tyC7Z5LR3o6snZ/5f2vYnu/zw0AlTzp
        dg1MhaUhpqM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 626A675BE0;
        Tue, 28 Mar 2017 13:32:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CA33C75BDF;
        Tue, 28 Mar 2017 13:32:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 00/21] object_id part 7
References: <20170326160143.769630-1-sandals@crustytoothpaste.net>
        <20170328073159.k3xemw6auh3iedgs@sigill.intra.peff.net>
Date:   Tue, 28 Mar 2017 10:32:23 -0700
In-Reply-To: <20170328073159.k3xemw6auh3iedgs@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 28 Mar 2017 03:31:59 -0400")
Message-ID: <xmqqzig5cno8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 81BC3162-13DC-11E7-A64A-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sun, Mar 26, 2017 at 04:01:22PM +0000, brian m. carlson wrote:
>
>> This is part 7 in the continuing transition to use struct object_id.
>> 
>> This series focuses on two main areas: adding two constants for the
>> maximum hash size we'll be using (which will be suitable for allocating
>> memory) and converting struct sha1_array to struct oid_array.
>
> Both changes are very welcome. I do think it's probably worth changing
> the name of sha1-array.[ch], but it doesn't need to happen immediately.
>
> I read through the whole series and didn't find anything objectionable.
> The pointer-arithmetic fix should perhaps graduate separately.

I didn't see anything incorrect when I queued the series, either,
and after I re-read it I saw a few minor readability issues, but
modulo that this looks ready.  I did split the push-cert parsing fix
and applied to an older base independently, though.

> I suggested an additional cleanup around "linelen" in one patch. In the
> name of keeping the number of re-rolls sane, I'm OK if we skip that for
> now (the only reason I mentioned it at all is that you have to justify
> the caveat in the commit message; with the fix, that justification can
> go away).

A follow-up after the dust settles could also mention "we earlier
mentioned this caveat but with this fix we no longer have to worry
about it", no?


Thanks both, anyways.
