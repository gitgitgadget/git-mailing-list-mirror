Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFA8C1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 22:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfGAW2w (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 18:28:52 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65132 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfGAW2w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 18:28:52 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B76D170491;
        Mon,  1 Jul 2019 18:28:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IERAkZCQddKFEyXyJh/91M5YyJs=; b=geAsIi
        iNVwxGf25RBpDvnP3BsNpDw1FMfRIZr3bGW/d0UhnLZMq3K6NjTGgHEtuiJqm4sc
        lC6MiRSMo/qEJYqtg2p424trMj5M0XyXib2G9txjrir5PaM+o3Lx7BwSBpwg0VFW
        dDKL3CLADrXxkYH6a1/x2m7jAVj4s3OcSqvtM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DREWq1kRT7tufHIM+PiTXyVrYU9hkqgZ
        nOaTUX03emuv9BwtuGO5NMwjodnnCT2SCOyPcdyFLLMbAe1Hi77/xTYLGZxkDsFE
        QMV1/YEFSxtfb5n3eIthD1Xiy3LSrpRQJV0l7kf+B+Z0COm4kEMwjqKmGpIT6hls
        wZa9RtY6AC0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AF30870490;
        Mon,  1 Jul 2019 18:28:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DC16D7048C;
        Mon,  1 Jul 2019 18:28:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] test-lib: introduce test_commit_bulk
References: <20190628093751.GA3569@sigill.intra.peff.net>
        <20190629045322.GA8155@sigill.intra.peff.net>
Date:   Mon, 01 Jul 2019 15:28:45 -0700
In-Reply-To: <20190629045322.GA8155@sigill.intra.peff.net> (Jeff King's
        message of "Sat, 29 Jun 2019 00:53:22 -0400")
Message-ID: <xmqq36jp5qzm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 98AA8F4C-9C4F-11E9-A144-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>   - replace eval formatting magic with "%s" printf formatters (safer and
>     gets rid of quoting issues in the callers).

This one actually made me think twice about safety, as we'd be using
end-user supplied formatting string without any inspection.  I think
it is fine as it is merely a test helper.  

If somebody is later making it into a test-tool function, I expect
that our interpolation engine, not the bare sprintf(), would be used
there, and it would hopefully also be safe?

Thanks.

