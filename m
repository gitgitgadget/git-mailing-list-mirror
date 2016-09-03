Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D0DD1FBB0
	for <e@80x24.org>; Sat,  3 Sep 2016 02:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753149AbcICCDw (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 22:03:52 -0400
Received: from mail-vk0-f53.google.com ([209.85.213.53]:33867 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752805AbcICCDw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 22:03:52 -0400
Received: by mail-vk0-f53.google.com with SMTP id v189so38183138vkv.1
        for <git@vger.kernel.org>; Fri, 02 Sep 2016 19:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pA1mIRLtJwcqqjQoUKTAyESSlO8JxF3IBw8jADUDNOc=;
        b=fD1DL52weekwpBInsXPo4mWZUZKaBjVn+ptFcXrDtrhjBsRxvX2HvxD0zRKhBE47OB
         dmYzTJPltN2BfSlbaqlfbPOASNnc2pnV+3BjzoAB0DI2fgMStKAYsa+wbajeR7ndKsCe
         WCKqRAr9+tlQFJXT9xk6hbSpaMcpoySE1TIpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pA1mIRLtJwcqqjQoUKTAyESSlO8JxF3IBw8jADUDNOc=;
        b=LsIwtC7lXFfc8zpuleHfkhL2+UEzBgGY27RHSAMNXHqHUufjZBKij98RV7aTrhL/1r
         na7jiHM6i4W6gJL8WzAlNzGHUEqoAdlijxMZ+SiN4mkkHs7U9l8Wzln5OmJYuJDQb3DD
         zFQK+R6tyMZI8oJ8CDyZgx3iMs9TJrlZNl5NsUS4PbiWdGp6sQA5QJcZzrSLaV/stk3V
         gfxfPEGZ/c0JgY+k1Stm111XqM7tU0W0O3sMq5aN/yWgcScRSYRR/oQf3gBXaxQPY1DG
         UhJupmEixvs3qHauEDw6pjt+PxSvIvKhtKEMu8+c9YAyzA5CqFBqZFhO+dg65IMVDVo2
         WGRg==
X-Gm-Message-State: AE9vXwP13eNb4++MwTPwM07nepTeBEt+mOppD0c8FEgQHiv6jIz2MrwDYJlZxBwmeKKv0Jtmjt8cZUIp3IRBUA==
X-Received: by 10.31.158.200 with SMTP id h191mr16135087vke.127.1472868231248;
 Fri, 02 Sep 2016 19:03:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.133.210 with HTTP; Fri, 2 Sep 2016 19:03:30 -0700 (PDT)
In-Reply-To: <20160902201321.35egsg5l6r2fvrtw@sigill.intra.peff.net>
References: <cover.1472836026.git.jonathantanmy@google.com>
 <2bea354c6218a33db3972e42baa75676fdcbc598.1472836026.git.jonathantanmy@google.com>
 <20160902201321.35egsg5l6r2fvrtw@sigill.intra.peff.net>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Fri, 2 Sep 2016 19:03:30 -0700
Message-ID: <CAJo=hJtg1h1Zvu-TjMtDYVjPB2n0pihA18q3sHBPQ_ZA4dWRKg@mail.gmail.com>
Subject: Re: [PATCH 2/2] connect: know that zero-ID is not a ref
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 2, 2016 at 1:13 PM, Jeff King <peff@peff.net> wrote:
>
> Hmm. So since this is backwards-compatible, I'm not overly concerned
> with changing the client. But I wonder if you considered that the
> documentation is wrong, and that JGit should stop sending the extra
> capabilities line?

No, JGit needs to keep sending the capabilities^{} line in upload-pack
if there were no refs advertised to the client. (If it advertises at
least one ref it does not send this capabilities^{} line.)

> In either case, there will still be breakage until _somebody_ upgrades
> (with your patch, until clients upgrade; with a JGit patch, until the
> server upgrades). So perhaps an interesting question would be: if we
> were writing this now, what is the correct behavior?
>
> For pushing, it is obviously useful to send capabilities even though
> there are no refs (because the client is going to send _you_ something).
> And that is why "capabilities^{}" exists; it is a receive-pack feature
> (that is actually implemented!), and the documentation (which came after
> the implementation) blindly mentioned it for upload-pack, as well.
>
> Is it useful for upload-pack? If we have no refs, there's traditionally
> been nothing to fetch. Perhaps that's something that could change,
> though. For example, there could be a capability to allow fetching
> arbitrary sha1s (we have allowTIPSH1InWant and allowReachableSHA1InWant,
> which obviously both require some refs, but allowArbitrarySHA1 does not
> seem outside the realm of possibility).

Its exactly these sort of extra capabilities. We run JGit in modes
where "out of band" (e.g. URL or higher level protocol framing like an
undocumented HTTP header) allows the fetch-pack client to say "do not
send me advertisements, but I want to learn your capabilities". The
fetch-pack client typically activates the allow-reachable-sha1-in-want
feature and names specific SHA-1s it wants.

This allows the fetch-pack client to bypass a very large advertisement
if it wants only a specific SHA-1 and doesn't care about the ref name
its bound to, or reachable through.


This is also perhaps a stepping stone towards "client speaks first".
If we can later standardize an HTTP query parameter or extra HTTP
header, the server may be able to avoid sending a lot of ref
advertisements, but would still need to advertise capabilities.
