Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EA7C202A5
	for <e@80x24.org>; Mon,  2 Oct 2017 09:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751127AbdJBJwN (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 05:52:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62408 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751119AbdJBJwM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 05:52:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D75897977;
        Mon,  2 Oct 2017 05:52:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fgtkHKqd1RKZH80DJd62Qboghk4=; b=f4zncq
        NfuDXoKvtMsh9cz3dxnqFxQ/3lOYoSf8j3qgVZ/Ans7PiuD2pG2cT//U98BCJiif
        ojGc9GJQETZJTaX0Y6iGP1XE1qgSdrEiutT0ucuKXVHQLOL96Uw9XAxD3kzi0I9N
        yix9zeRhvruA1bNdnPdLq8P/m352jZhc5JU34=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=R8qVEKTzTgQwAZLHlEk9rE/6QEllR56J
        tvNTPzJadnLmnNVK5aQmlHoe9b0K0tfz4k/bdwoFv7tSMfbyn+C5jv/a5JOaXJqf
        fdz/W1UH9e2kkm3DL76Zqqy6wCFXSzdMSgrMaJktRR5LpuFwshViDP9dPLdWVCQ4
        8mOp0WOOT5o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5453697976;
        Mon,  2 Oct 2017 05:52:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8A3AB97975;
        Mon,  2 Oct 2017 05:52:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH v6 7/7] ref-filter.c: parse trailers arguments with %(contents) atom
References: <20171002052326.GA10729@D-10-157-251-166.dhcp4.washington.edu>
        <20171002052524.12627-1-me@ttaylorr.com>
        <20171002052524.12627-7-me@ttaylorr.com>
        <20171002065100.cjawz6pvxjj2w5nr@sigill.intra.peff.net>
Date:   Mon, 02 Oct 2017 18:52:09 +0900
In-Reply-To: <20171002065100.cjawz6pvxjj2w5nr@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 2 Oct 2017 02:51:00 -0400")
Message-ID: <xmqqa819op12.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C037A20-A757-11E7-AB37-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>>  		atom->u.contents.option = C_SUB;
>> -	else if (!strcmp(arg, "trailers"))
>> -		atom->u.contents.option = C_TRAILERS;
>> -	else if (skip_prefix(arg, "lines=", &arg)) {
>> +	else if (skip_prefix(arg, "trailers", &arg)) {
>> +		skip_prefix(arg, ":", &arg);
>> +		trailers_atom_parser(format, atom, *arg ? NULL : arg);
>
> I think your logic is flipped. You want "*arg ? arg : NULL";

Ahh, I was blind.  Will fix locally and push the results out.

Thanks.

