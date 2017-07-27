Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5941120899
	for <e@80x24.org>; Thu, 27 Jul 2017 18:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751510AbdG0S1g (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jul 2017 14:27:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53307 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751452AbdG0S1f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2017 14:27:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B2711A2DE5;
        Thu, 27 Jul 2017 14:27:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PxlcH1WeRZSKQG44h8fQ/5rT5KY=; b=NkzrU5
        MzGsI3oYCrDXge5JJSnQXnRMJIELLocVAHFhRnUAnn+N9IHpFPa0scPo4B8oGtcL
        FuzF+KpN7Fvt63b2nJqm+QEO2Swlge3sWuPebAtYmuAt1sjsXqhYN7Oko982mjSu
        Zv0NA6qcn37pU+gbhD/GJ8ciIPsJ0JUNw8seQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BWwf9TE1sTD3dEEfWiYOvnCENcBqZ7br
        YEs/csN6w5uDJ0jXdogVGbnbntht8aDm5xZ6hgA5cs3jexmVUQwv5n3BXHSmdFNY
        8tKoFeuufOHSj4+7etJlzMr5VZjT7J2GLe0w2Bpjl3iFhHdUAc2oryVJDa45fYOv
        GXNjZgb81Xs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A929EA2DE4;
        Thu, 27 Jul 2017 14:27:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EBF57A2DE1;
        Thu, 27 Jul 2017 14:27:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCHv2] builtin/blame: highlight interesting things
References: <20170613023151.9688-1-sbeller@google.com>
        <20170726230425.24307-1-sbeller@google.com>
        <xmqqwp6uojzr.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZ5x8p7CE6zGQ2HOJFPV_8_XKsENKt70ETACvvYZYKp2Q@mail.gmail.com>
Date:   Thu, 27 Jul 2017 11:27:26 -0700
In-Reply-To: <CAGZ79kZ5x8p7CE6zGQ2HOJFPV_8_XKsENKt70ETACvvYZYKp2Q@mail.gmail.com>
        (Stefan Beller's message of "Wed, 26 Jul 2017 16:57:01 -0700")
Message-ID: <xmqq4ltxohv5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E8B775A-72F9-11E7-8080-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Well, we could also try a "zebra"  as in sb/diff-color-move to show blocks
> with the same fancy border detection.

Luckily, blame output has places for metainfo on each line, unlike
diff output, so there won't be a need for painting border
differently.  For example, if we decide that metainfo is shown only
for the first line for each block, then by definition, the border
between blocks is just before a line with metainfo and nowhere else.
So in that sense, the problem should be a lot easier to solve ;-)

Unluckily, a block may span several pages, so "only at the first
line" might not be very useful.  I wonder if we can print in black
ink on black background and let selection by mouse or in screen
still reveal useful information?

