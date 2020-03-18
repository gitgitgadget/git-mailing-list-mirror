Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98355C4332B
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 21:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F53420777
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 21:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="O9s+AFdG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgCRV2X (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 17:28:23 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40370 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbgCRV2X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 17:28:23 -0400
Received: by mail-pj1-f68.google.com with SMTP id bo3so1759486pjb.5
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 14:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/tZ0s0cXZSPBf0ieJui8DN5LBal1zO9XQNEglkx5PaM=;
        b=O9s+AFdGNerpUIbHWo/ZQ/v6oOs9gb9bmPeQtuy7mBWIxmmrSlTWpAjq+B1Qxesqyg
         /ZyIzShRukZDBLDU/DmiETVLkKqlb7UVWW946sJh7rXB6q7WJkCNLsvIcRp13O/acKN1
         1Lj8MvI/vKnepQyqKCfZNb7hiDR4lkfz47q74IylkN+9qa7rV92OTN19HGyGILvD2FZd
         TEyJwsLoC40RthrBFmO9KjdIu/ayHc6yvYZYjgQzAnm9E1292H9QM/A+JG0V4zWQQw55
         zMsZQ+cjURi99/nH1UqH3Sk0Xe+1bVMXubBvCqIPKC3UWVUremK5AMFCSO2fjKZ/Qt1M
         og9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/tZ0s0cXZSPBf0ieJui8DN5LBal1zO9XQNEglkx5PaM=;
        b=Oe3I9CTkHPPcPmv2LrT30Juy6fTx+gJ5WTZTNe+RlMTcvJNNMqz44uv5c3WHlz7NQN
         Fm/k6IL1ZGfXU5wgywiWEApicytt8KZW2Fc/MCDL68FzXhU2ldX9ColofavATxS9cUOt
         q129syvbBH7JPeK1S7eno70JxDQodt87QR1vfQTWVeS6wDltcNcPEnu+sRWv4GZUWJ4G
         LIVAcCsym7dTTA4aORQ/JfytoGMhTxjzav/mHCBoD5tl3ngojHJhV/iTR3rC9RU0sx/s
         0opjVmjBwp6L/Knwx9sLfMd/ZXczt2f5yhDdv79aWl5DsKhfnwfLHZU7D5YRCLNJxx09
         9/KA==
X-Gm-Message-State: ANhLgQ18vSLEcOyDlh/s4Oi6lR3HWNpugYVwosp5NzOy33a6syuJ6/Cr
        uo2oexoqUvj2Zwk2cb+cyorA9A==
X-Google-Smtp-Source: ADFU+vvIjFwNCa4CaAhu2xK4JBToSN2FaVY40ZCweKYR4tDsi7BefUKhgOHFvxmO0DwaxBgoxW6Dhw==
X-Received: by 2002:a17:902:8f8a:: with SMTP id z10mr6387plo.169.1584566899934;
        Wed, 18 Mar 2020 14:28:19 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id w31sm41221pgl.84.2020.03.18.14.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 14:28:19 -0700 (PDT)
Date:   Wed, 18 Mar 2020 15:28:18 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        christian.couder@gmail.com, james@jramsay.com.au
Subject: Re: [RFC PATCH 0/2] upload-pack.c: limit allowed filter choices
Message-ID: <20200318212818.GE31397@syl.local>
References: <CAP8UFD0wJo4onz0_Vw4-bcX1h61=J=ZiKfM-fMXLj4B9q0aveg@mail.gmail.com>
 <cover.1584477196.git.me@ttaylorr.com>
 <20200318101825.GB1227946@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200318101825.GB1227946@coredump.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 18, 2020 at 06:18:25AM -0400, Jeff King wrote:
> On Tue, Mar 17, 2020 at 02:39:05PM -0600, Taylor Blau wrote:
>
> > Hi Christian,
> >
> > Of course, I would be happy to send along our patches. They are included
> > in the series below, and correspond roughly to what we are running at
> > GitHub. (For us, there have been a few more clean-ups and additional
> > patches, but I squashed them into 2/2 below).
> >
> > The approach is roughly that we have:
> >
> >   - 'uploadpack.filter.allow' -> specifying the default for unspecified
> >     filter choices, itself defaulting to true in order to maintain
> >     backwards compatibility, and
> >
> >   - 'uploadpack.filter.<filter>.allow' -> specifying whether or not each
> >     filter kind is allowed or not. (Originally this was given as 'git
> >     config uploadpack.filter=blob:none.allow true', but this '=' is
> >     ambiguous to configuration given over '-c', which itself uses an '='
> >     to separate keys from values.)
>
> One thing that's a little ugly here is the embedded dot in the
> subsection (i.e., "filter.<filter>"). It makes it look like a four-level
> key, but really there is no such thing in Git.  But everything else we
> tried was even uglier.
>
> I think we want to declare a real subsection for each filter and not
> just "uploadpack.filter.<filter>". That gives us room to expand to other
> config options besides "allow" later on if we need to.
>
> We don't want to claim "uploadpack.allow" and "uploadpack.<filter>.allow";
> that's too generic.
>
> Likewise "filter.allow" is too generic.

I wonder. A multi-valued 'uploadpack.filter.allow' *might* solve some
problems, but the more I turn it over in my head, the more that I think
that it's creating more headaches for us than it's removing.

On the pro's side, is that we could have this be a multi-valued key
where each value is the name of an allowed filter. I guess that would
solve the subsection-naming problem, but it is admittedly generic, not
to mention the fact that we already *use* this key to specify a default
value for missing 'uploadpack.filter.<filter>.allow' values. For that
reason, it seems like a non-starter to me.

> We could do "uploadpackfilter.allow" and "uploadpackfilter.<filter>.allow",
> but that's both ugly _and_ separates these options from the rest of
> uploadpack.*.
>
> We could use a character besides ".", which would reduce confusion. But
> what? Using colon is kind of ugly, because it's already syntactically
> significant in filter names, and you get:
>
>   uploadpack.filter:blob:none.allow
>
> We tried equals, like:
>
>   uploadpack.filter=blob:none.allow
>
> but there's an interesting side effect. Doing:
>
>   git -c uploadpack.filter=blob:none.allow=true upload-pack ...
>
> doesn't work, because the "-c" parser ends the key at the first "=". As
> it should, because otherwise we'd get confused by an "=" in a value.
> This is a failing of the "-c" syntax; it can't represent values with
> "=". Fixing it would be awkward, and I've never seen it come up in
> practice outside of this (you _could_ have a branch with a funny name
> and try to do "git -c branch.my=funny=branch.remote=origin" or
> something, but the lack of bug reports suggests nobody is that
> masochistic).

Thanks for adding some more detail to this decision.

Another thing we could do is just simply use a different character. It
may be a little odd, but it keeps the filter-related variables in their
own sub-section, allowing us to add more configuration sub-variables in
the future. I guess that calling it something like:

  $ git config uploadpack.filter@blob:none.allow <true|false>

is a little strange (i.e., why '@' over '#'? There's certainly no
precedent here that I can think of...), but maybe it is slightly
less-weird than a pseudo-four-level key.

> So...maybe the extra dot is the last bad thing?
>
> > I noted in the second patch that there is the unfortunate possibility of
> > encountering a SIGPIPE when trying to write the ERR sideband back to a
> > client who requested a non-supported filter. Peff and I have had some
> > discussion off-list about resurrecting SZEDZER's work which makes room
> > in the buffer by reading one packet back from the client when the server
> > encounters a SIGPIPE. It is for this reason that I am marking the series
> > as 'RFC'.
>
> For reference, the patch I was thinking of was this:
>
>   https://lore.kernel.org/git/20190830121005.GI8571@szeder.dev/

Thanks.

> -Peff

Thanks,
Taylor
