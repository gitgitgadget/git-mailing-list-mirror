Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4E9C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 22:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9A1A60FD9
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 22:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238912AbhH3W3r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 18:29:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51438 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238909AbhH3W3q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 18:29:46 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E91A514FAB2;
        Mon, 30 Aug 2021 18:28:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=U2KTvjokuEM7yCoLeuGsucO6lnJJukbv2nVCw9
        SWCew=; b=fYbKsenU6pqhVYTD1jcKNSS/h4yZKQUlH9bpRwQrRJLn1XltLTMOn5
        DvhG8AXhM5IIfOof/gJbvjSBG7Ljo7fjGh+J4N3noZs3V0L1Ol4xEWmHvRXht5Ix
        OhPEtoWIPiXUj+ze6ppRpoMLQwTwV4VNLWCUgLsbuV3GuL8m/396A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E09DB14FAB0;
        Mon, 30 Aug 2021 18:28:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 363FE14FAAC;
        Mon, 30 Aug 2021 18:28:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com, jonathantanmy@google.com
Subject: Re: [PATCH v4 05/25] midx: clear auxiliary .rev after replacing the
 MIDX
References: <YSVjnSDaBXgXvT9W@nand.local> <xmqq35qymrcn.fsf@gitster.g>
        <xmqqy28qlcow.fsf@gitster.g> <YSVuUYFh7lmhNlEy@nand.local>
        <xmqqo89jbf49.fsf@gitster.g> <YSko4OwwPb7MwEMa@nand.local>
        <xmqq4kb797xc.fsf@gitster.g> <YSwhNxqAS8JajA7p@nand.local>
        <xmqqfsur7otx.fsf@gitster.g> <YSwpsp/hQsPFnj+I@nand.local>
        <YS1XOMtj94BcI9HM@camp.crustytoothpaste.net>
Date:   Mon, 30 Aug 2021 15:28:47 -0700
In-Reply-To: <YS1XOMtj94BcI9HM@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Mon, 30 Aug 2021 22:10:00 +0000")
Message-ID: <xmqqmtoy1s9s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A59BF4B4-09E1-11EC-BE1F-9BA3EF469F85-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Yeah, this is a possible problem.  You can also see it when using git
> index-pack outside of a repository with an incorrect --object-format
> option.
>
> I'm not sure how folks want to deal with that; I'm just fine saying,
> "Well, don't do that," but other folks may have different opinions.

OK, so if we go back to the original breakage of the test script
that triggered this discussion, the right solution would be to make
sure both test repositories/object stores are prepared with the
algorithm specified with GIT_TEST_DEFAULT_HASH?

Thanks.
