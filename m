Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8A0A202F2
	for <e@80x24.org>; Tue, 21 Nov 2017 02:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752228AbdKUChc (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 21:37:32 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54854 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751876AbdKUChb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 21:37:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B6F03BC404;
        Mon, 20 Nov 2017 21:37:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T6qDAv6vRL02mxc7V0FetSbmA20=; b=oiEcQO
        F6SRt6sQGyNLdP96OV3qnBKlW8jAenHZ9plN9FCZQ3UWMASIkh0jhGsV5SSEJlap
        /0gRayhtUVU4XAw5/JtJa+LYQAC8aa5YsJfeP3og57iY5b0R8N7+mzymvHctslTQ
        kNyrrw1g9aSfdu7JdS+e/uuROnCn7lsaD3hFw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GgikkfFja7EFCmmNNzaNiraL288tkJLZ
        J88jUgr8RijfsiT2V9yLOs6sCUczmt2iaMabA0wAJPDY0MJ6l6wIS6ARdI93om15
        2Yy7VRxebBhwhKimHiZhOCv3DyeYPUuPdIgf2EIIxQxAX6jpeIgBXlrTRNViObTi
        p/XJs+bfKoQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF1D9BC403;
        Mon, 20 Nov 2017 21:37:30 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1C1CFBC401;
        Mon, 20 Nov 2017 21:37:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/5] sha1_file: don't re-scan pack directory for null sha1
References: <20171120202607.tf2pvegqe35mhxjs@sigill.intra.peff.net>
        <20171120203523.c3pt5qi43e24ttqq@sigill.intra.peff.net>
Date:   Tue, 21 Nov 2017 11:37:28 +0900
In-Reply-To: <20171120203523.c3pt5qi43e24ttqq@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 20 Nov 2017 15:35:23 -0500")
Message-ID: <xmqqd14cjr13.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EB820886-CE64-11E7-B719-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> In an ideal world, we'd simply fix all of the callers to
> notice the null sha1 and avoid passing it to us. But a
> simple experiment to catch this with a BUG() shows that
> there are a large number of code paths.

Well, we can view this (or the alternative you sent later that does
the same a bit earlier in the function) as "fixing the caller" but
has already refactord the common logic to a helper function that all
of these callers call into ;-).

