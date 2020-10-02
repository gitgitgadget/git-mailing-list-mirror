Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE3AC4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 21:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97874206DD
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 21:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IlpW+UAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbgJBVRV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 17:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJBVRV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 17:17:21 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE947C0613D0
        for <git@vger.kernel.org>; Fri,  2 Oct 2020 14:17:20 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id y17so2027923qky.0
        for <git@vger.kernel.org>; Fri, 02 Oct 2020 14:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=PwL7q5XHCmip45MGSpCBzT82Jx1EO+G5RhfFL8nA/As=;
        b=IlpW+UAnmG4Fz1PXZK7zm0W7Rd7h7pYeHXchFf3RNYa0jZxTAvP9v1YpPXT2HqKueP
         cPN7IeMfrQRscoEvpK0yaLPcvhXbJe6Yv2UzAd08VgCXVjKJJRDNJzwKpEPt6NOxDjZg
         exTgpKdhlF3xRkqiOniGedeSBvFlmfIGPMXAbIuka8zfCiyt9hd4UbkuC0u6m9ab8m6B
         Z2WH4C2V4bz3FBNj2FbVMQLrcKTjm9GMYc8zEM4zJKRvuoqMnIGT3DzBG+WC/Edn9bsZ
         S3gmR9V5SQ5xXd2qfCaZcY+euF3Ig4rTue0oKhF/Calv6dol0ERKf55d6nBv8Wety7WX
         aMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PwL7q5XHCmip45MGSpCBzT82Jx1EO+G5RhfFL8nA/As=;
        b=i7noFQbBxYDP/Iz2m1tv7B5nu3w6XWrd+9E1zvZEu37a5/Nnx93GPcwc7w0ZaVlws+
         Ao7g0tqwJhw3TV1wYahzxj/NwQz3PDT8hhkXIr3z4rb6Rf3tY0RymqfRzEDXPgkG158u
         7zl8rEHT143oSZepC7w7/SB0deM/8mNpSa/U7h1DUWQhWaFK7POdmS7Xz3TSXsLgplyE
         Vu3dKcZjiiekIOKXsrQUw+96kTTpqeJ2UwUIKQ6XLcO3zMhxGda9pfO7FDtTFTWAzZfR
         Un+4nILxnf3BUH6wAfw2FQIR2ITArk5RjMUY20DIqMvX51noVlvLRflqRz0oxiOwsAUD
         HyvA==
X-Gm-Message-State: AOAM533pf20zQd80s19S/vcNFogctFoet1kYFckbar4OxEwPcQmi4yFe
        Vsms3eRwt26WR2KVWLCBiMBL85HQtYoy
X-Google-Smtp-Source: ABdhPJy7gNbDqfX9MueLqQe1L/XdAj+rVhw7ZcacjI7reWPrQAFrmEWSuNyNq23Wfp6tFVTxUdD+gRTrDwmY
Sender: "shengfa via sendgmr" <shengfa@lins.c.googlers.com>
X-Received: from lins.c.googlers.com ([fda3:e722:ac3:10:2b:ff92:c0a8:cb])
 (user=shengfa job=sendgmr) by 2002:a0c:b651:: with SMTP id
 q17mr4131043qvf.33.1601673440092; Fri, 02 Oct 2020 14:17:20 -0700 (PDT)
Date:   Fri,  2 Oct 2020 21:17:19 +0000
In-Reply-To: <20201001024452.GA2930867@google.com>
Message-Id: <20201002211719.68606-1-shengfa@google.com>
Mime-Version: 1.0
References: <20201001024452.GA2930867@google.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: Re: [RFC PATCH 1/1] hideTimezone: add a user.hideTimezone config
From:   Shengfa Lin <shengfa@google.com>
To:     jrnieder@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, nathaniel@google.com,
        rsbecker@nexbridge.com, santiago@nyu.edu, shengfa@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Like Junio mentioned, this affects "git commit" but not other commands
> that record the current date with the local timezone.
> 
> The fundamental tool to exercise that machinery is
> 
> 	$ git var GIT_AUTHOR_IDENT
> 	Jonathan Nieder <jrnieder@gmail.com> 1601517809 -0700
> 
> so I suppose I'd be interested in seeing that exercised in tests.

Next patch should include a test for git var.

> [...]
> 
> The unfortunate thing about these APIs is that there's no way to pass
> in a timezone from a string instead of from the environment.  This
> means that passing through the environment as above is the only
> reasonable way to do it, but that would have the unfortunate result
> of changing the output of commands like "git log --date=local" that
> are about writing dates to the terminal instead of storing them.
> 

The TZ should apply for write but not read.

> [...]
> Looking over callers, who would this affect?  There are three callers:
> 
>  fast-import.c::parse_ident:
> 	Used to handle ident string "now".  That seems in keeping with
> 	the intent here, and fast-import does respect some other
> 	configuration though only affecting storage.  Seems fine.sensible.
> 
>  ident.c::ident_default_date:
> 	Used to produce author and committer timestamps and timestamps for
> 	reflog entries.  That's the goal; good.
> 
>  send-pack.c::generate_push_cert:
> 	Used for the timestamp sent to the server in a signed push
> 	certificate.  Also good.
> 

Thanks for the analysis here. I was wondering whether the TZ should
affect these callers.

> So I think this does the right thing, plus it retains the
> user-friendly feature of being able to *display* timestamps in their
> local timezone.
> 
> Now let's talk through the downsides:
> 
> It's complex.  The performance isn't likely to be bad when
> user.timezone is not set, which is nice, but it still is messier than
> I'd like to see.
> 

+1.
