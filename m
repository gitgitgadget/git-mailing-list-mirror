Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BCD71F859
	for <e@80x24.org>; Wed,  7 Sep 2016 20:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755490AbcIGUNc (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 16:13:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51018 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750877AbcIGUMN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 16:12:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 666A13B4D3;
        Wed,  7 Sep 2016 16:12:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GhvuzUjF6iTaOoQ0bTO5Hn2Her0=; b=bdS/TS
        tprj7oqDIGk2jIQavP9HfqEwlF8irWU8jlCwxXu7O7RRSwxIgGBmkUnvD5/Sjj3/
        wxReKcG6EtOw+jVtYTeytxceWcnBnT9NPK+jekVcVQ0o9viAJHiQ67FQku9cUlfg
        D3/9vpjSscqKtHtlyVW9SC3c+eau3iY3vTR7U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WRNHGgM3r/sREpc7xfrL7XC9yspkt9SO
        XqQV428D1UwmkZpoq7djmKKajGk4pZYvmbkfxmaq2slpYMfuEaWAucbwk/xhmBzO
        r4ZGE45pYOG0K+J5M1j5U3mUd1WaFHF9qE/RhEkytsRRNCjStBktqpGi0FYSujC+
        FmEF3TJCSt4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D4E83B4D2;
        Wed,  7 Sep 2016 16:12:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D3EF13B4D1;
        Wed,  7 Sep 2016 16:12:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>,
        =?utf-8?B?Tmd1?= =?utf-8?B?eeG7hW4gVGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v2 00/20] object_id part 5
References: <20160905200811.697889-1-sandals@crustytoothpaste.net>
Date:   Wed, 07 Sep 2016 13:12:09 -0700
In-Reply-To: <20160905200811.697889-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 5 Sep 2016 20:07:51 +0000")
Message-ID: <xmqq60q7lbae.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5CA6D02E-7537-11E6-A7CF-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> This is the fifth in a series of series to convert from unsigned char [20] to
> struct object_id.
>
> This series converts many of the files in the builtin directory to use struct
> object_id.  This gets us almost to the point where we can convert get_tree_entry
> to use struct object_id, but not quite.  That function is used indirectly by
> get_sha1, meaning that get_oid would have to completely replace it in order for
> get_tree_entry to be converted.
>
> However, this series tackles one of two major sources of object ID values: the
> command line (the other, of course, being the refs code).  Converting several of
> the builtin commands to use struct object_id as much as possible makes it easier
> to convert other functions down the line.

It is a bit unfortunate that this conflicts somewhat in builtin/cat-file.c
and heavily with builtin/apply.c with other topics in flight.

Let me see how bad the conflict resolution is and report back later.

Thanks.
