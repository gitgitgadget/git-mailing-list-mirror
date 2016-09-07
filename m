Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94E631F859
	for <e@80x24.org>; Wed,  7 Sep 2016 18:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932260AbcIGStd (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 14:49:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60522 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756632AbcIGStc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 14:49:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A79173806B;
        Wed,  7 Sep 2016 14:49:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eeILAKHfE3yaaULX0CFTZxGoQTM=; b=p9WadK
        R8wwfEVz0g8SXzi2Cmd0PJSlR/9SkszzQwt2HRckBkL7XbB2rP4XziifYIoNN3UO
        Y+AHo2nRjAXiw+RrWoURSmQu776qKmzjmrAE53kp+DYv+KPk1jNfhfOhikBkxaB3
        /d4+kLq2+kDEvu99tmTO2fyQ1Yj35hWYS2hBE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NX8qmNO+EEwMKsBXThfrXpPHODhItBk7
        pae8SRl6gEXaSVsBxERdFX2HxA47AMAbgHnJCYB/HJJklrD14+T9l9hxLMVIYZSs
        G0dfu0yWfMKTo45gKhHTJ1cvmvghawjK4WDFbHfl05N1/rjLXwUTSXYk5flRzi8D
        OfwfIU+4CiM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E1F73806A;
        Wed,  7 Sep 2016 14:49:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 28AB038068;
        Wed,  7 Sep 2016 14:49:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/5] pack-objects: walk tag chains for --include-tag
References: <20160905215141.b6unqtjqko7775is@sigill.intra.peff.net>
        <20160905215226.m6vv2tk5pe2qt4ui@sigill.intra.peff.net>
        <20160905215939.hriu6ev3m332qhp6@sigill.intra.peff.net>
Date:   Wed, 07 Sep 2016 11:49:28 -0700
In-Reply-To: <20160905215939.hriu6ev3m332qhp6@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 5 Sep 2016 17:59:39 -0400")
Message-ID: <xmqqzinjlf47.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF3594A6-752B-11E6-9AB7-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> As explained further in the commit message, "fetch" is robust to this,
> because it does a real connectivity check and follow-on fetch before
> writing anything it thinks it got via include-tag. So perhaps one could
> argue that pack-objects is correct; include-tag is best-effort, and it
> is the client's job to make sure it has everything it needs. And that
> would mean the bug is in git-clone, which should be doing the
> connectivity check and follow-on fetch.

I think that is probably a more technically correct interpretation
of the history.

I think upgrading "best-effort" to "guarantee" like you did is a
right approach nevertheless.  I think the "best-effort" we initially
did was merely us being lazy.
