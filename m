Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00D051F97E
	for <e@80x24.org>; Sun, 25 Nov 2018 23:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbeKZJyi (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 04:54:38 -0500
Received: from 0x63.nu ([109.74.10.199]:58328 "EHLO 0x63.nu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbeKZJyi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 04:54:38 -0500
Received: from ip6-localhost ([::1] helo=moveme2)
        by 0x63.nu with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <anders@0x63.nu>)
        id 1gR3Pw-0005VN-15; Mon, 26 Nov 2018 00:02:20 +0100
References: <20181104152232.20671-1-anders@0x63.nu> <20181118114427.1397-1-anders@0x63.nu> <20181118114427.1397-3-anders@0x63.nu> <xmqqy39o9tmq.fsf@gitster-ct.c.googlers.com>
User-agent: mu4e 0.9.18; emacs 26.0.91
From:   Anders Waldenborg <anders@0x63.nu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/5] pretty: allow showing specific trailers
In-reply-to: <xmqqy39o9tmq.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 26 Nov 2018 00:02:10 +0100
Message-ID: <87a7lw7oct.fsf@0x63.nu>
MIME-Version: 1.0
Content-Type: text/plain
X-SA-Exim-Connect-IP: ::1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on 0x63.nu); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano writes:
> Also, use of 'key=' automatically turns on 'only' as described, and
> I tend to agree that it would a convenient default mode (i.e. when
> picking certain trailers only with this mechanism, it is likely that
> the user is willing to use %(subject) etc. to fill in what was lost
> by the implicit use of 'only'), but at the same time, it makes me
> wonder if we need to have a way to countermand an 'only' (or
> 'unfold' for that matter) that was given earlier, e.g.
>
> 	%(trailers:key=signed-off-by,only=no)
>
> Thanks.

I'm not sure what that would mean. The non-trailer lines in the trailer
block doesn't match the key.

Take this commit as an example:

$ git show -s --pretty=format:'%(trailers)' b4d065df03049bacfbc40467b60b13e804b7d289
Helped-by: Jeff King <peff@peff.net>
[jc: took idea and log message from peff]
Signed-off-by: Junio C Hamano <gitster@pobox.com>

With 'only' it shows:
$ git show -s --pretty=format:'%(trailers:only)' b4d065df03049bacfbc40467b60b13e804b7d289
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>

Now with a "key=signed-off-by" option I would imagine that as adding a
"| grep -i '^signed-off-by:'" to the end. In both cases (with and
without 'only') that would give the same result:
"Signed-off-by: Junio C Hamano <gitster@pobox.com>"


 anders
