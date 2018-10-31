Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E71701F453
	for <e@80x24.org>; Wed, 31 Oct 2018 14:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbeJaXWJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 19:22:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39069 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729289AbeJaXWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 19:22:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id r10-v6so16720806wrv.6
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 07:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=yDSyShu5qH24Bscl53/8sAoC0c0qFfDG65whC1E+Sec=;
        b=AtjUjg0WW7SVuUwrR2iKns9kzN02nwakB47lg560VOJ1Ikr/KcjkXhINZBP+tLlZ2u
         b7gghbWvEHyeNP3vHJWbSgkFrs59y12cTsUVhNY5lcyz/znSBtCcHiXckdafQrtwCY2r
         tWZqlmQho3jppnTW7rUoSLxFgpWncNswNmG+YIUnoe2QzKCg4LPOJhCqeXwsT6ZWBlZV
         9PFF6zxMQPJBAGLLUx5fie4evgO48QjguyVkNxYP1rGXX9/NxUaIoF82SWifgppf4Oy3
         3sS9O5Sz469zYFJA3sypqQw6t8Yl1vVAhF1jiEm5Hc/ykr/oJ6+0+QkHMGcVlGlzX6xU
         8+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=yDSyShu5qH24Bscl53/8sAoC0c0qFfDG65whC1E+Sec=;
        b=PGfaZ7r0Hk+Li50jMbf4kkpsOJqQhK3d4o7igyT7Sy/Tsy9Pzq1nmoEk9hqVDw/BZq
         ZHAhhrOl9LWcH/PatYhMRfkt1Iw9VD0nXRxCqOcD/uZE6YcEnW1cRznbfYK7GVWtmNJM
         wWFKGP1bf5DTsVlw+KZ+ZEa41xwiYPjBUDMNf/mwx6eky1sS2HVObEErFgpaEytF0o9L
         OJqDncEGoSAFeRqfpISFwoixu7QgIFecLb6YznHL9bGDTKKL3/hPtja28MWUDrZYYAuX
         XBSBxK9AJ8yRRkO4tsO7OXydjSvC/MZ3wBsc2T6D1b+RADWIdb3jVe6JwxYEvMkbHuYi
         mvNg==
X-Gm-Message-State: AGRZ1gJXfEUtu60bwgevnRmqQ89zZx0yPqi+2yWAZkL0TezWUUt1TL+R
        tGUUQToAk9swCGw0o8ZM8vU=
X-Google-Smtp-Source: AJdET5elPTBCnBaMftsm1rnVqrjtVPIQ54NuaZ8Aw3MtZ7hjAguOHB4BEjvzAhXG9CI+JX2h7U9dzg==
X-Received: by 2002:a5d:608e:: with SMTP id w14-v6mr3100910wrt.193.1540995832134;
        Wed, 31 Oct 2018 07:23:52 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i11-v6sm16865510wrs.87.2018.10.31.07.23.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 07:23:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        John Szakmeister <john@szakmeister.net>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH 3/3] cat-file: handle streaming failures consistently
References: <20181030231232.GA6141@sigill.intra.peff.net>
        <20181030232337.GC32038@sigill.intra.peff.net>
        <20181031133341.GA5070@tor.lan>
Date:   Wed, 31 Oct 2018 23:23:48 +0900
In-Reply-To: <20181031133341.GA5070@tor.lan> ("Torsten =?utf-8?Q?B=C3=B6ge?=
 =?utf-8?Q?rshausen=22's?= message
        of "Wed, 31 Oct 2018 14:33:41 +0100")
Message-ID: <xmqqva5iurd7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

>> +static int stream_blob(const struct object_id *oid)
>
> Sorry for nit-picking:
> could this be renamed into stream_blob_to_stdout() ?

I think that name makes sense, even though stream_blob() is just
fine for a fuction that takes a single parameter oid, as there is no
other sane choice than streaming to the standard output stream the
blob data.

>> +{
>> +	if (stream_blob_to_fd(1, oid, NULL, 0))
>
> And I wonder if we could make things clearer:
>  s/1/STDOUT_FILENO/

What would benefit from symbolic constant more in that function call
may be CAN_SEEK thing, but s/1/STDOUT_FILENO/ adds negative value to
that line, I would think.  The name of the function already makes it
clear this is sending the output to a file descriptor, and an
integer 1 that specifies a file descriptor cannot mean anything
other than the standard output stream.
