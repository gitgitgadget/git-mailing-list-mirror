Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A29B31F405
	for <e@80x24.org>; Thu,  9 Aug 2018 00:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731680AbeHIDV5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 23:21:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46969 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeHIDV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 23:21:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id h14-v6so3575167wrw.13
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 17:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=40Bq1IWNWp1Ne2AvebYuW7nCOcvn932cll+69/r5+Go=;
        b=LG842ZquCK8wQ92Gn6ajWPQ4WtGJNsQgfcNE2yegGgfbR3vvlS/2rFFFkTfWFKr/GK
         CB1worjIF8bLTOSgQXc7LfQfBIxn0msyQIXYha1A8FkvbI/qnv7x2tUm2IW9oC4rgO4v
         xQjMAysQXGDFFNQKtPqcHnQJJfjKXOP89LsSfF6Ohdn0Ux8aUQf2wlYzasgME92ErGcU
         9n3c2rrJDtylbOuvYiDAdc4BzT30oGloJRmKibLABytpxYoozjPqsIDV2MzeUAxsjhhu
         W9k6D7yurM/p0TYDZ6erktdIXKvPL/dLmnzTG75bAv74yCUVFrC6PIxz/y677Sd0FINs
         bUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=40Bq1IWNWp1Ne2AvebYuW7nCOcvn932cll+69/r5+Go=;
        b=rEXfAQFAv6AarsNbOE+nT8yBPV7HRAyiVIbf+gpoPYP54KnY58V4UjRewmyCnENWS9
         IpcSB/24cLhP0At6aRVGbgnFhCmHCaAaMrTJ2nuweUxSPjsoIxeGkC3Fj05UoCotDIvT
         i+vLGTJ/23UbMPeyKu5yp7xItCxZFh+x6Jgmp6md3MRrzisjeb5FowrC9YewArO8D2n1
         RmcuNXhtSAqFavS/FRq5lLIqfH3YrL5132wYsNWx9P0fGpmCDCaHkXqDA/r/D0vEftCw
         F1VWYAZsXnvGPAjsZRHy+fALYrfuJMMBRlPQ1RvXqjzWIZYRfOVpzIuHRXu9FVK+p2Q8
         ARVQ==
X-Gm-Message-State: AOUpUlH1CjFfOmANXdm52IDALdS6m+pkSXH+CUCEqeyHsVLWQuPgxde+
        KU+tbHWK1dAxfud5M5eCuDw=
X-Google-Smtp-Source: AA+uWPxIzr5legrOfrnk8EfKzjKVBUBUc09u1zB2LP2rd7sFNuEeY7jyRsdtFjBk7zwwxAC8BM6XLg==
X-Received: by 2002:adf:fc45:: with SMTP id e5-v6mr3263471wrs.157.1533776385212;
        Wed, 08 Aug 2018 17:59:45 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 1-v6sm10839914wmf.47.2018.08.08.17.59.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Aug 2018 17:59:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jeff King <peff@peff.net>,
        Karel =?utf-8?B?S2/EjcOt?= <karel.koci@nic.cz>,
        Santiago Torres <santiago@nyu.edu>,
        Vojtech Myslivec <vojtech.myslivec@nic.cz>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] verify-tag/verify-commit should exit unsuccessfully when signature is not trusted
References: <09f9803c-3f4b-a97c-2c59-e9d6b924892f@nic.cz>
        <20180801001942.GC45452@genre.crustytoothpaste.net>
        <20180801002546.du52zkxjupzcw2p6@LykOS.localdomain>
        <20180803133630.32oxubwttealvhxk@work-pc>
        <20180803154343.z3lgkudleood6lhs@LykOS.localdomain>
        <20180803160634.GA19944@sigill.intra.peff.net>
        <20180804084346.fhte5wusbfb5baem@cynerd-laptop>
        <20180808230456.GA21882@sigill.intra.peff.net>
        <20180808231226.GA34639@genre.crustytoothpaste.net>
Date:   Wed, 08 Aug 2018 17:59:43 -0700
In-Reply-To: <20180808231226.GA34639@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Wed, 8 Aug 2018 23:12:27 +0000")
Message-ID: <xmqqzhxwcq2o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> FWIW, I'm on board with returning non-zero in any case where gpg would.
>
> I think that's probably the best solution overall.

FWIW, I am not married to the current behaviour.  I would not be
surprised if it mostly came by accident and not designed.

> There's a bug report
> in Debian (https://bugs.debian.org/895048) that requests that behavior
> instead of the status quo, and also it's the behavior that's documented:

The last bit is a bit questionable; I think you are reading too much
into the description.

A substitute for gpg.program MUST signal good (or not good)
signature the same way as gpg would with its exit code---that is all
the description says.  It does not say anything about how that exit
code affects the exit status of "tag --verify" and friends that
called gpg.program.

>        gpg.program
>            Use this custom program instead of "gpg" found on $PATH when
>            making or verifying a PGP signature. The program must support
>            the same command-line interface as GPG, namely, to verify a
>            detached signature, "gpg --verify $file - <$signature" is
>            run, and the program is expected to signal a good signature
>            by exiting with code 0, and to generate an ASCII-armored
>            detached signature, the standard input of "gpg -bsau $key" is
>            fed with the contents to be signed, and the program is
>            expected to send the result to its standard output.
