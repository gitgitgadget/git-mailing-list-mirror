Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBDC820A26
	for <e@80x24.org>; Fri, 22 Sep 2017 03:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751791AbdIVDri (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 23:47:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50532 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751653AbdIVDrh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 23:47:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1918E940BA;
        Thu, 21 Sep 2017 23:47:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CAZL6jwUBIG+2N6Om9QQuqUi0LE=; b=QTvz2q
        je0h/Q9RYbcOloYa6hHy5St0AKb/C/PAr+Zvl+myHqcGN9Fm3Qop9CBXXf0XVozG
        fAxcmXXhzx/CVRQ03vNMAcfDay0UBYCl7qQKvvyQOO+43Nhwn1yW6+Lp+gVBUbcr
        KaSNg/K+X5ikXnzkaHL9IBgjJaBN/Z9aiW/oI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yFg7UKGlI4vSQceIUnEJ4IK1fDPtXfmo
        +AsNf5FZ/+UbZO2jagaTPRzU5ErvK2jX7WGwKgP2bRxTJzz029D0iMLwfKmOXlIU
        UiquKdc/ayaY8qE+/6jcus/6lNgvqlH1AgyvbgrF+MxHLYhDAkVoLLEB9DvBCI/9
        Uc/opyedkbQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 10843940B9;
        Thu, 21 Sep 2017 23:47:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7F3A5940B8;
        Thu, 21 Sep 2017 23:47:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] test-line-buffer: simplify command parsing
References: <20170921062043.la2f3pjsnojirzyw@sigill.intra.peff.net>
        <20170921062242.t63u2gvpysrrmijs@sigill.intra.peff.net>
Date:   Fri, 22 Sep 2017 12:47:35 +0900
In-Reply-To: <20170921062242.t63u2gvpysrrmijs@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 21 Sep 2017 02:22:43 -0400")
Message-ID: <xmqqh8vvl7hk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C5EEF782-9F48-11E7-9931-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> However, each case arm of the switch falls through to the
> one below it. This is pointless (we know that a command
> starting with 'b' does not need to check any of the commands
> in the 'c' block), and it makes gcc's -Wimplicit-fallthrough
> complain.

Wow, this is an embarassment. The code tries to cleverly optimize
it, and then fails miserably.

The updated one reads good.  Thanks.
