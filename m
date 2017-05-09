Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B18241FC44
	for <e@80x24.org>; Tue,  9 May 2017 02:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752548AbdEICOV (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 22:14:21 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35354 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751243AbdEICOU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 22:14:20 -0400
Received: by mail-pg0-f68.google.com with SMTP id i63so13003239pgd.2
        for <git@vger.kernel.org>; Mon, 08 May 2017 19:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BalowxapUaHdNnmDAG6UBxqbrYCwl2f/D69LaZ+iJvc=;
        b=p1eJkc4Azn/bwjnW2Le3ZH4R4AVdI4Fce9DUYEXKHxHrOWKZvA4Maz9MPFAL7j7DYK
         kEARCY3ndKI6xTu19DL/QeDmwdIN6YT4nFMQqbyRH023vyE4i0PH68eRsvmtHe96uBpE
         Jviy8+lHjNkme0EPbyxWOUWvrzmx0GlPYcEsyXQlin6z7BstmtdgRLPG5OghK5qENaXT
         f8OwcjkOOFWLar0Ovl5TjR32GZjTDuj0TN0TdhSpSn4llJiq+QZisfq6hM1Ow6edDDtI
         aTUlFjwzAdXFcwFlQ+8GQLvc/Cw3qrPWDRbYENTAKAUilYiEb6GMqojt0d8fS12NSY/u
         ToYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BalowxapUaHdNnmDAG6UBxqbrYCwl2f/D69LaZ+iJvc=;
        b=E2zgmJKRerppzPQPTftTExSNMJm02M7kzV5a3OhP4JDRF0z8Yfi9ES5Vj021xTjFW1
         KX0hRG/f9ov9Dk5z3HJuM/013vFTaTqUxxfFuyPkR4d1wIXr6pHxaYM3woge0bf/38ur
         1o48zrg11S3NxY1yF1gbFO8CbRoxVI4DdB6pGnF2hGX0IVO6QiPC74zJHMI1F1k7C5Lg
         tSR8c6RQqGfIfXvgVWS5lZdrYnPm1OF5GhvwFLSACGKJN0pJstKKhj4/HE2rQ3G1P9+e
         PPh7eVAft263TplSIF3Pr/BWVhes6L8iO0yMG5eEfDd4m4sUt3VeyNat8WumImDjawAU
         dfzA==
X-Gm-Message-State: AN3rC/4WohuZcKPDcv9NTBR3smDz389iNXMMbK9FFCDAQo5K6T+tEqoj
        5ZkESkq1ErvJn4vJM5U9Bw==
X-Received: by 10.99.112.68 with SMTP id a4mr21565483pgn.198.1494296060094;
        Mon, 08 May 2017 19:14:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:2823:d4da:fd9a:464a])
        by smtp.gmail.com with ESMTPSA id s7sm19670749pgs.52.2017.05.08.19.14.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 May 2017 19:14:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pack-objects: disable pack reuse for object-selection options
References: <20170502084326.65eisqmr4th5cbf7@sigill.intra.peff.net>
        <xmqq4lww9cas.fsf@gitster.mtv.corp.google.com>
        <20170508073143.lu73w5b54lvstty2@sigill.intra.peff.net>
        <xmqqd1bi7ta5.fsf@gitster.mtv.corp.google.com>
        <20170509020010.meefcustv7uufard@sigill.intra.peff.net>
Date:   Tue, 09 May 2017 11:14:18 +0900
In-Reply-To: <20170509020010.meefcustv7uufard@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 8 May 2017 22:00:10 -0400")
Message-ID: <xmqqfuge6akl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Ah, OK, and now I understand why you called this a "bug" (which is
>> older and do not need to be addressed as part of 2.13) in the
>> original message.  The new tests check requests that ought to
>> produce an empty packfile as the result actually do, but with the
>> current code, the reuse code does not work with --local and friends
>> and ends up including what was requested to be excluded.
>
> Right. Did you want me to try re-wording the commit message, or does it
> make sense now?

It does make sense to me now, but I do not speak for all future
readers of "git log", so...
