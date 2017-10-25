Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F9541FAED
	for <e@80x24.org>; Wed, 25 Oct 2017 01:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751672AbdJYBvo (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 21:51:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55662 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751323AbdJYBvo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 21:51:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 713F5AB323;
        Tue, 24 Oct 2017 21:51:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=611G1WTv4X6mtFTCAEsv9f7K42Y=; b=VW5tyA
        L8CunUnFtUwYYntScCzIz3wpfoClEnq3RYvqakrw96U8KW1Y3iat+xbGlFEWoknJ
        FVDX2oYQA2FE2d/ANoe7fNDHYs4/IDw1f86Ql7Cf9cDMiwY5zFh+q19rVS7RkVb8
        n5WYPl+rIzXeTdA6S+J6preX73WR3rWM7kSQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jDrwAN1CAGLcFrQGdrfYd9RPgN0OplYu
        K7eCseCECBuGh/m7gmnVsm4o4Z2vzBZUmYG0eXyL0MrZlLCQFS0saUdYVFlNfQfN
        Y4+p8Fy8RkmkLZ6/t8qFHHvF5miPz5jr7olodlItYrLV4wscoWCDoaBQCskm4YyT
        +Vxb/BnhH8I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 69078AB322;
        Tue, 24 Oct 2017 21:51:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CF9CDAB31F;
        Tue, 24 Oct 2017 21:51:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Consequences of CRLF in index?
References: <D0A67AD8-2D63-4683-9F2A-20B0E8E65D4B@gmail.com>
        <20171024181415.3tvmc36aqi335v66@aiede.mtv.corp.google.com>
Date:   Wed, 25 Oct 2017 10:51:41 +0900
In-Reply-To: <20171024181415.3tvmc36aqi335v66@aiede.mtv.corp.google.com>
        (Jonathan Nieder's message of "Tue, 24 Oct 2017 11:14:15 -0700")
Message-ID: <xmqq4lqoj8pe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0CDBFADA-B927-11E7-A09F-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> I'd be interested to hear what happens when diff-ing across a line
> ending fixup commit.  Is this an area where Git needs some
> improvement?  "git merge" knows an -Xrenormalize option to deal with a
> related problem --- it's possible that "git diff" needs to learn a
> similar trick.

My knee-jerk reaction is that (1) the end user definitely wants to
see preimage and postimage lines are different in such a commit by
default, one side has and the other side lacks ^M at the end., and
(2) one of the "whitespace ignoring" options (namely, "ignore space
at eol") may suffice, but if not, it should be easy to invent a new
one "ignore CR at eol".
