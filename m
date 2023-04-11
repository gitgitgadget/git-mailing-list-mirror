Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F31C7619A
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 22:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjDKWws (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 18:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDKWwr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 18:52:47 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEFE210C
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 15:52:46 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso2463594pjc.1
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 15:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681253566; x=1683845566;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=loBrMNdj4PeXTc4fRQwp2tubHRC2LByVenchxvWdRiU=;
        b=HQP/w5jCjhbkijYB77D8Xjba5PPr+0IC9/tE9s+jrAzYAifFzQs4pDmX5nCsly7L1H
         /3ysohVSA45Scxa24+0Mko4U8XDildwP7tqcRfrNvkW4b/NHlFM/WCUTGivllJEDCteG
         XjIB0qWk2DPB86jXuMKS2g6ODRSThrFzI37oj9+Unx03NlslyhEgAXjyBtq6kQWL4RgP
         t6qFU3OsvgBIxugR+xiFhabSbfj6/0u2peBlmxQAgdx1g6FaIksWNK3sD4I2SKQul4lN
         08y/5Hli3Rq9/qXEB2+5EQPgQnVJ+lli+wyHcv61m31r5dOKPSvh+cbxSRwUodyf8mKQ
         B6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681253566; x=1683845566;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=loBrMNdj4PeXTc4fRQwp2tubHRC2LByVenchxvWdRiU=;
        b=OF6DIyeBWCvOqCqur3gvfry7y86sq3t1RSsOob31c5OZpZjB/YAel5+vIB8pXQ58gL
         IPCxLuC1fvP5IEDmtdKgxIzaRphmftsFg3BPK+p7TBfxlGgbcCjn/qO0ho9MVEeDr1zy
         JVDYBwcCpXwih48fXrvN1+yPQQmC/5DQAq/0hVSiB9XLyeWXgC4LS3i9AhyjeT0XJL0d
         JMtYCr7V6NRSzUx7sEazpOPTl6TEEdQqlInsJnWdoEtXCiPQDLVVp7A01uFe/HwMe3Cb
         TnzkTiJMOdnmPdTzxxnXDT59blSww7W4YfNS+3tmOQmZ8hv7W/ZFOCcREK2W5d7YYC0y
         f2Qw==
X-Gm-Message-State: AAQBX9eLAoG/OwDCpnLvoMdvwZLeHooLqPZjxv/TscMlWg40Is485b9D
        fpxqsfgy3pFLWtaWYxs8wNE=
X-Google-Smtp-Source: AKy350ZYkvgspUkAluSyZStssoenhAdxIXUFe9Lp3mwCP1vgwCgcekdegA8ndAeiP9VWjitlonMYEA==
X-Received: by 2002:a17:902:ec91:b0:1a4:fe07:49e9 with SMTP id x17-20020a170902ec9100b001a4fe0749e9mr22623347plg.63.1681253566255;
        Tue, 11 Apr 2023 15:52:46 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id w7-20020a170902904700b0019fcece6847sm10201575plz.227.2023.04.11.15.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 15:52:44 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Jonas Haag <jonas@lophus.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: Infinite loop + memory leak in annotate_refs_with_symref_info
References: <39035D34-8548-44B0-BBBB-5C36B3876C4A@lophus.org>
        <20230411210633.GA626331@coredump.intra.peff.net>
        <20230411211604.GB626331@coredump.intra.peff.net>
        <ZDXPemH0d3YWnpjL@nand.local>
        <20230411215845.GA678138@coredump.intra.peff.net>
Date:   Tue, 11 Apr 2023 15:52:43 -0700
In-Reply-To: <20230411215845.GA678138@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 11 Apr 2023 17:58:45 -0400")
Message-ID: <xmqqa5ze9glg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yep. And Jonas's suggested fix is the right thing. Assigning offset
> directly _would_ be the right thing, since we are taking the distance
> back to the beginning of the feature_list string. Except that earlier in
> the function we incremented feature_list by the incoming value of
> the offset!

Sigh.  Thanks for finding the problem with a fix.  The data flow in
this function is horrible, but yes, "found + len - feature_list" is
smaller than the code expects to be because feature_list is moved
forward before entering the loop, and I can see how the patch fixes
the problem.

> diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
> index 20d063fb9a..c8422d66e7 100755
> --- a/t/t5512-ls-remote.sh
> +++ b/t/t5512-ls-remote.sh
> @@ -360,4 +360,39 @@ test_expect_success 'ls-remote prefixes work with all protocol versions' '
>  	test_cmp expect actual.v2
>  '
>  
> +test_expect_success 'v0 clients can handle multiple symrefs' '
> +	# Git will not generate multiple symref entries for v0 these days, but it
> +	# is technically allowed, and we did so until d007dbf7d6 (Revert
> +	# "upload-pack: send non-HEAD symbolic refs", 2013-11-18). Test the
> +	# client handling here by faking that older behavior.

Yeah, I remember that fix where somebody had tons of symbolic refs
and busted the protocol limit.  Is "multiple symref" used here
because it is the easiest to reproduce the issue, or have we saw
such a potentially broken server in the wild?

> +	# Note that our oid is hard-coded to always be sha1, and not using
> +	# test_oid. Since our fake capabilities line does not have an
> +	# object-format entry, the client will always use sha1 mode.

It probably is OK to run the test in that "undeclared - assume
SHA-1" mode, even though I think we give an explicit "object-format"
capability even when talking from the SHA-1 repository these days.

> +	oid=1234567890123456789012345678901234567890 &&
> +	symrefs="symref=refs/remotes/origin/HEAD:refs/remotes/origin/main" &&
> +	symrefs="$symrefs symref=HEAD:refs/heads/main" &&

> I also wondered if we tested this multiple-symref case for protocol v2
> (where it works fine), but it looks like we may not. There are earlier
> tests which _would_ trigger it, but we force them into v0 mode, due to
> b2f73b70b2 (t5512: compensate for v0 only sending HEAD symrefs,
> 2019-02-25). I think we really should be letting ls-remote use the
> protocol it prefers (v2 by default, and v0 if the suite is run in that
> mode), and the expected output should be adjusted based on the mode.
> I'll see if I can do that as well, to make this a two-patch series.

Thanks.  I really appreciate your being almost always thorough and
wish more contributors took inspirations.


