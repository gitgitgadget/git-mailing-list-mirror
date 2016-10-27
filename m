Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EEE62022A
	for <e@80x24.org>; Thu, 27 Oct 2016 04:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750918AbcJ0ENo (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 00:13:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54066 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750780AbcJ0ENn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 00:13:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1326849391;
        Thu, 27 Oct 2016 00:13:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jBsv1xJdLvbpgeDT0rMpsQgUQbE=; b=BRAKgf
        XWWCUikDwoES8L08vNvYmbBRTxtgOkkgMcOEX+tNz4PWRDZWzx/lnIzTHsdEOlRh
        beEXcCkF7g5x2ZFALOmeLQdHRng8Qhw4wZr0OVhcwOcdCvhBFMFseaJjAW7enD0r
        gC12KHSusdOfcJbyfucbcVZJpPHoEdWR+ZKoA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UdecYm5TbfveRSrjLENL5DavZzV1UVsq
        sg0rJEGzFTcR9KScgupvtlaJiCfujkQ+cIeElO+Pu0Fk5M/VwZUmcwTg/d7OaewA
        HfPRV3J2G7bemHdqUo80HyIGhpeb1HB5EXCq+4YZH5hFnlc1/qCgEQ+0vykCoN4d
        Vb9qc2ORtnk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A08B49390;
        Thu, 27 Oct 2016 00:13:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 702A84938F;
        Thu, 27 Oct 2016 00:13:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>,
        Simon Ruderich <simon@ruderich.org>
Subject: Re: [PATCHv2 1/2] attr: convert to new threadsafe API
References: <CAGZ79kYhMVrKHhNGYcf_D9kWEYp+sC+tMGbuE+gnD8AU27dh8g@mail.gmail.com>
        <20161026224104.31844-1-sbeller@google.com>
        <xmqqbmy6aa6b.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYiVxJwtAYsgks8LVNWvawWxdy=8Xpdrki-C_u15C3Z9w@mail.gmail.com>
Date:   Wed, 26 Oct 2016 21:13:39 -0700
In-Reply-To: <CAGZ79kYiVxJwtAYsgks8LVNWvawWxdy=8Xpdrki-C_u15C3Z9w@mail.gmail.com>
        (Stefan Beller's message of "Wed, 26 Oct 2016 19:19:54 -0700")
Message-ID: <xmqq37jia0p8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BE6E3D16-9BFB-11E6-B7C1-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Yeah, I can make it work without exposing struct git_attr.

You completely misunderstood me.  "struct git_attr" MUST be visible
to the users so that they can ask for the name in git_check.attr[0].

What would be nice to hide if you can is the function to intern a
string into a pointer to struct git_attr, i.e. git_attr() function.

