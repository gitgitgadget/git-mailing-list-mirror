Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEEDC1F404
	for <e@80x24.org>; Fri, 19 Jan 2018 18:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756107AbeASSsB (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 13:48:01 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52077 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755830AbeASSr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 13:47:59 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 54835C88D7;
        Fri, 19 Jan 2018 13:47:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1QcTpvW3L2wQk6BuN1Q2gq1QJ98=; b=hFf7VM
        IRew4SUMB2guSopAGelpDDXEx95qIk5IN80l/dZ/65nINyOmFQm+8OPEbQeiY/Z9
        i4kUsS6DPguxuYeGQmmBkLCrShWVg5rUJ4GZdrPblavyqW1XXWw/2yaPdvavz3wD
        EksRlYz2QQqUw8En2RAXJwHD7dBQWUjk+C9Io=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WadVvTamtHYlkUMxozXMG+3Iri3NiZsw
        aO/E62MueNm93NHgGj759lXDB/6ftA9Lc9lkWkkjF4zJdI79M7tdHmGrrw8sakiN
        kA7QhGqtHdkwhlVfs3YjXZdhULTIZvawn3jBLaPL0BwVtsvozAKT1XY777dQEphj
        NoONmydWDkY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4AE19C88D6;
        Fri, 19 Jan 2018 13:47:59 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B07CCC88D5;
        Fri, 19 Jan 2018 13:47:58 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?0J7Qu9GPINCi?= =?utf-8?B?0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH v2 03/18] ref-filter: make valid_atom as function parameter
References: <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
        <01020160df6dc529-fae54bd6-e595-44fa-9f9a-c44cb3a5a1a8-000000@eu-west-1.amazonses.com>
        <20180115214208.GD4778@sigill.intra.peff.net>
        <CAL21Bm=+uPrKECcCq2_rfJRuCpsOjZ41NfiyY3d1UA0b8YKj1w@mail.gmail.com>
        <20180117214354.GA13128@sigill.intra.peff.net>
        <CAP8UFD0PtOqX5c4ovRbYDWejQ55iUwtnPv-zGXS2GFAajhXqtA@mail.gmail.com>
        <CAL21BmnKd0qamJWJbrAzg_ZX1GkhCTPO_5zOiFNMBeF-xjDTiQ@mail.gmail.com>
        <CAP8UFD1dcwEA9z+oQKFV=aFoKn73mtP4qkLGovW2XTu6N=N4dA@mail.gmail.com>
        <20180119172353.GA5752@sigill.intra.peff.net>
Date:   Fri, 19 Jan 2018 10:47:57 -0800
In-Reply-To: <20180119172353.GA5752@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 19 Jan 2018 12:23:53 -0500")
Message-ID: <xmqq4lnhr8gy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 44DEA372-FD49-11E7-80C7-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I also think %(deltabase) does make sense for anything that points to an
> object. I suspect it's not all that _useful_ for for-each-ref, but that
> doesn't mean we can't return the sensible thing if somebody asks for it.

This may not be a new issue (or any issue at all), but is the
ability to learn deltabase make any sense in the first place?

What should the code do when an object has three copies in the
repo, i.e. one as a base object (or a loose one), another as a
delta against an object, and the third one as a delta against
a different object?
