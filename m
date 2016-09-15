Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72CBA2070F
	for <e@80x24.org>; Thu, 15 Sep 2016 20:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbcIOUEu (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 16:04:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50457 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753552AbcIOUEt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 16:04:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B02873CB24;
        Thu, 15 Sep 2016 16:04:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RfUHC1HBZVLOIi4WpVMa+G3v1eM=; b=BDYeY0
        GyLIdll5UFPOVLAujYxV33f7Yg5dcvHMcmanQG/bmTfo23N79Si1rUIfZ5nV30uu
        hC4Upl8SPpb9MEv619YVfaA0u9Pl7M2yPmOxyi+9ICXnenlGQxBxV0AFElzU4YPq
        Vc0D0iuu37hn0OS5suHgkDHeWHuMss+Dp/j04=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Gec/2EIkbdu/R+bmZSAyydK5BNnzPlTb
        6SnGgaDRNUbirTTRIlwjZm/FqhGsIjo+teyGYHORejt69nq9CxuytOcUbw0VgppN
        6eu/FL1v1xlEul+7Ms1+rIWzMkHybvMmBdmqTABH+NWQyce4AlReEMBdjCtgm1f8
        8MYQryugrXw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A4D043CB23;
        Thu, 15 Sep 2016 16:04:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0F8313CB22;
        Thu, 15 Sep 2016 16:04:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Git Mailing List <git@vger.kernel.org>, peff@peff.net,
        sbeller@google.com, Johannes.Schindelin@gmx.de, jnareb@gmail.com,
        mlbright@gmail.com, jacob.keller@gmail.com
Subject: Re: [PATCH v7 10/10] convert: add filter.<driver>.process option
References: <20160908182132.50788-1-larsxschneider@gmail.com>
        <20160908182132.50788-11-larsxschneider@gmail.com>
        <20160910062919.GB11001@tb-raspi>
        <10020380-76ED-4371-A0BA-59D07AF33CE0@gmail.com>
        <96554f6d-988d-e0b8-7936-8d0f29a7564f@web.de>
        <xmqqvaxzvjj0.fsf@gitster.mtv.corp.google.com>
        <5E675A29-628F-4076-A5D9-E359CCF04295@gmail.com>
Date:   Thu, 15 Sep 2016 13:04:45 -0700
In-Reply-To: <5E675A29-628F-4076-A5D9-E359CCF04295@gmail.com> (Lars
        Schneider's message of "Thu, 15 Sep 2016 18:23:25 +0100")
Message-ID: <xmqq37l1nd42.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A6D43F44-7B7F-11E6-9C06-92D512518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> Wouldn't that complicate the pathname parsing on the filter side?
> Can't we just define in our filter protocol documentation that our 
> "pathname" packet _always_ has a trailing "\n"? That would mean the 
> receiver would know a packet "pathname=ABC\n\n" encodes the path
> "ABC\n" [1].

That's fine, too.  If you declare that pathname over the protocol is
a binary thing, you can also define that the packet does not have
the terminating \n, i.e. the example encodes the path "ABC\n\n",
which is also OK ;-)

As long as the rule is clearly documented, easy for filter
implementors to follow it, and hard for them to get it wrong, I'd be
perfectly happy.

Thanks.
