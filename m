Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66E481FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 17:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750925AbdFSRj6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 13:39:58 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:32786 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbdFSRj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 13:39:57 -0400
Received: by mail-pg0-f68.google.com with SMTP id u62so11612268pgb.0
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 10:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DluEaAPp2V5HJvgyU5/j4ABiA9aMTpJ/Ev+WFO1nv8E=;
        b=SKjAJZs2ckao48jYopYw6sAXu0E8ml+9w/Jgl2NpekFSj366l91QwCXHHXZby62T6V
         c9pJk7MK44AM0358G0rmYY3//jSjwL62ck/kWG3Y3Gxses5KAydAsPdo8tA3FdYml7TY
         z6kQ5SP3NNTfGtd6GJWG/t26hTIu8G6fZP+7l01PnomeYpSLAL5DUyRyzBabG0TMT1NF
         1fdSY0tO1s8H0u4LcVUocQ1ZgS/qpdRyj3VKfBpUuFttaAb2wTHqsrHUaY3HSkxTYE6z
         GijAEBS/V0E8o9v5cgx3ZX7ypLD6iFni4gZDHf3TOccO9QdQqeqEQsqwwi7LUjC3Omsv
         NGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DluEaAPp2V5HJvgyU5/j4ABiA9aMTpJ/Ev+WFO1nv8E=;
        b=JO69Ul0nXq4/I311/qfknzPbYeL9Fycv0DdXwkyeFb2Rtg0rD04Osb692XmwKkGF5s
         Qx+BMpzWho1th4RElJD0wSDdKCR/k3nmifE31mwCpxt9CL3AGPsD5gCwksHXfWrrl6Oa
         deuXL6k6PuuSP6OxJ/WtbVdEPmLY+bOCBK5MXEb4fSY48vCcx7JjUP4pE4f/wJRZULM1
         +3CuD3jHxFiz96fL/1zUZzNSmTG61+5RQhGfBhkk789WPn0miNNKHg1KIL6AciV9qd1f
         JUCuE7M8ZWxHcN3l+m4wDW29jGMURmpWMnNqwLVTZAep9z17EQDxoyMyN9B6pRdjjy+I
         9yCQ==
X-Gm-Message-State: AKS2vOx2waOT3PJ38AoWckAn0maLaq9hIsia0oXEQXYsgFPu8eAGG8U2
        DdPHgx4hfD8j8g==
X-Received: by 10.98.166.196 with SMTP id r65mr26141922pfl.120.1497893996628;
        Mon, 19 Jun 2017 10:39:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:7466:3d2b:4ee9:fc7])
        by smtp.gmail.com with ESMTPSA id t23sm20589020pgb.25.2017.06.19.10.39.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 10:39:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Liam Beguin <liambeguin@gmail.com>, git@vger.kernel.org,
        Philip Oakley <philipoakley@iee.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v5 08/10] rebase -i: skip unnecessary picks using the rebase--helper
References: <cover.1497444257.git.johannes.schindelin@gmx.de>
        <72bbfcae2abcb14f6b1288051a244faadbee29e0.1497444257.git.johannes.schindelin@gmx.de>
        <a12767b9-a947-e0a2-fc82-fc25992fd0d1@gmail.com>
        <alpine.DEB.2.21.1.1706161551030.4200@virtualbox>
        <529f6cc7-ab2b-72bb-bc51-f4cca4e98652@gmail.com>
        <alpine.DEB.2.21.1.1706191127450.57822@virtualbox>
        <20170619161051.silyrlwrnjjspoxe@sigill.intra.peff.net>
Date:   Mon, 19 Jun 2017 10:39:54 -0700
In-Reply-To: <20170619161051.silyrlwrnjjspoxe@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 19 Jun 2017 12:10:51 -0400")
Message-ID: <xmqqinjrub9x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Jun 19, 2017 at 11:45:50AM +0200, Johannes Schindelin wrote:
>
>> The reason for this suggestion is that one of the revision machinery's
>> implementation details is an ugly little semi-secret: the pretty-printing
>> machinery uses a global state, and that is why we need the "pretty_given"
>> flag in the first place.
>
> I think that's mis-stating Junio's complaint. The point is not the
> pretty_given flag itself, which we know about and can work around. The
> point is that we don't know what other similar problems we have or will
> have due to future changes in the revision code.
>
> In other words, there are two APIs: the one where C code manipulates
> rev_info directly, and the one where revision.c responds to string
> arguments. From a maintenance perspective, it is easy for somebody make
> a change that works for the latter but not the former.

There are (1) the API for users of revision traversal machinery and
(2) the implementation detail of the API.  Of course, the code that
actually parses the plumbing and end-user supplied set of options
needs to manipulate rev_info directly, but we should avoid direct
manipulation when we can to future-proof the codebase.

My main complaint is that Johannes's "compiler can catch mistakes"
is true only for the most trivial kind of mistakes.

The current implementation detail for reacting to --format="<string>"
given by the revision traversal machinery happens to be to set three
things in rev_info structure: set verbose_header and pretty_given to
1 and then call get_commit_format() on the format string.  Dscho is
correct to say that the compiler can catch a mistake that misspells,
say verbose_header as verbos_header.  The compiler would not catch
an equivalent mistake to misspell the option as --formta="<string>",
so from that point of view, his argument may seem to make sense.

But the compiler would not help catching a copy-and-paste mistake to
do only two out of the three things needed (e.g. forgetting to set
pretty_given).  If the code relies on setup_revisions() to react to
options just the way "rev-list" plumbing does, such a mistake cannot
happen in the first place---there is no need to worry about "catching".

As you clarified correctly, the writer of the code that _uses_ the
machinery, like the one in sequencer_make_script(), cannot
anticipate how the internal implementation of reacting to the
features will change, and more importantly, it should not have to
know how it will change.  By using the setup_revisions() API that
uses the exactly the same parser as plumbing command "git rev-list"
does, the forward compatibility is guaranteed.  Copying and pasting
the current internal implementation detail will break that.

> I do agree that the lack of compile-time safety for obvious mistakes
> like "--pertty" is a downside, though. On the other hand, there are
> strong run-time checks there, so the tests would catch it.

True.

After setup_revisions() returns, if there are unrecognized options
(e.g. misspelt "--pertty"), that can be used as the indication of a
programming error, as the new code is not even parsing arbitrary set
of options given by the end-user.
