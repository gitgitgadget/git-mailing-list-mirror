Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9AEE1F454
	for <e@80x24.org>; Wed,  6 Nov 2019 09:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731637AbfKFJxG (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 04:53:06 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53918 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfKFJxG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 04:53:06 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AF5D926E60;
        Wed,  6 Nov 2019 04:53:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AsZGdIVB3fN01scEgjofIK2eYVw=; b=QLwMPq
        qoRTavkBC6JfHhdAdJ1buer6cAz5Yx0vdgO20HRB/8AwosVjmwfz79gDhDtfh6gp
        PmPEfCIxfqL6nAhgQW2n71K6FTGnrQ6lKOEr4ngYqjiV/vmFbnOv+WEtk5pPRX5w
        +j79bzd2WzCkIv2OqOEuNPqh9jGHZIvMftQbs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xc5I1SmgC/MpFIZz1s9+kf1xi9jBL9QA
        g2/DtOra3I5LbgAE/tRp0ObnK7UrujSV4eBNIRFWRvuQaeUXBYczTz0zd4FLaxKS
        3hDPwksh3dZLEtvMt/uIKCNojjgfo86j4lk3DnSAP2oGvLCovKvzSwl8uLHNfnSW
        dPwajTSW6XE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9838226E5F;
        Wed,  6 Nov 2019 04:53:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8D46126E5E;
        Wed,  6 Nov 2019 04:53:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Davide Berardi <davide.berardi6@unibo.it>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v2] clone: Don't segfault on -b specifing a non-commit
References: <20191101002432.GA49846@carpenter.lan>
        <20191103180716.GA72007@carpenter.lan>
        <20191105043749.GA27601@sigill.intra.peff.net>
        <xmqqbltpyeel.fsf@gitster-ct.c.googlers.com>
        <20191106040523.GB4307@sigill.intra.peff.net>
Date:   Wed, 06 Nov 2019 18:53:02 +0900
In-Reply-To: <20191106040523.GB4307@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 5 Nov 2019 23:05:23 -0500")
Message-ID: <xmqqo8xptjpd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A38B50C-007B-11EA-9779-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If we did want to handle it, though, I think it would be easy with the
> setup I described; update_head() could check is_null_oid() itself.

Yup, that was what I had in my review on the previous round ;-)
