Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA693C43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 05:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 681B821D24
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 05:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Fw8eyxFB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgIRFMC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 01:12:02 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60970 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgIRFMC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 01:12:02 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 60121F32D8;
        Fri, 18 Sep 2020 01:12:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GN2ycVlPcImOAcf9D905lLuQDJs=; b=Fw8eyx
        FBsrXA27z8+ebZYVMO8oqp6P9mZ7aNiDamzE1tCRCvt/mkJFj2fzjgY9RITvVEP8
        VQ8ZqIeEbUu8WKopuQfYPqxMVP1F98rDZQCfk0WBkqlpRy/Ygh/cHs9xBErYVVTq
        NClne7xo0ENGS1KD2XRV3CQZWhTZvvn6xyFyA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Vnk3iQl9ZfRlBEeHkaNpniSP2fUcqXyZ
        sJhnN7t0AjR4purW5l0G1xSTC7QfGBBYUEWvOE7iPxLcUvv3UyKqhbLIhvFnHB9A
        qy66qsQpvSjtFg9l5yi7muzdfAbIJsNH2Fj/0bQMG9G+1A+igeXsRBMDu5+OYXT8
        DxWQ/QdNqIU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 58C7EF32D7;
        Fri, 18 Sep 2020 01:12:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9F944F32D6;
        Fri, 18 Sep 2020 01:11:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 08/10] builtin/diff-index: learn --merge-base
References: <cover.1599723087.git.liu.denton@gmail.com>
        <cover.1600328335.git.liu.denton@gmail.com>
        <1e4f805e570b8caad26c43b4c8293413e9128d5f.1600328335.git.liu.denton@gmail.com>
        <xmqq8sd8s46i.fsf@gitster.c.googlers.com>
        <20200917181303.GA108156@coredump.intra.peff.net>
Date:   Thu, 17 Sep 2020 22:11:56 -0700
In-Reply-To: <20200917181303.GA108156@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 17 Sep 2020 14:13:03 -0400")
Message-ID: <xmqqk0wroehv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 79B1E604-F96D-11EA-B6EA-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Sep 17, 2020 at 10:28:53AM -0700, Junio C Hamano wrote:
>
>> > -	if (diff_cache(revs, &ent->item->oid, ent->name, !!(option & DIFF_INDEX_CACHED)))
>> > +
>> > +	if (option & DIFF_INDEX_MERGE_BASE) {
>> > +		diff_get_merge_base(revs, &oid);
>> > +		name = xstrdup(oid_to_hex(&oid));
>> 
>> Leak?
>
> Using oid_to_hex_r() avoids an extra copy, and the leak goes away too:
>
>   char merge_base_hex[GIT_MAX_HEXSZ + 1];
>   ...
>   name = oid_to_hex_r(merge_base_hex, &oid);
>
> -Peff

Yes, I was debating myself if I should mention it or trust/assume
that the contributor can easily figure it out.
