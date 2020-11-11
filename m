Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1853CC388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 22:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DE04208B8
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 22:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mu4CpDiK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgKKWmf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 17:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgKKWka (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 17:40:30 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B65AC0401C4
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 14:40:30 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id x15so1319145pfm.9
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 14:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=GDsK2Z+46+yz4SS/Fs5yavi86Rx1QokgdZJcU3qy8qY=;
        b=Mu4CpDiKqSmkfu2cHaWNJez+y7WAKScO9ID8v/tzhSItKJGT0mYW8cxtSa09KaWVw6
         zdvrbhPtM3KgTNdD/LECR4FFzO165rxSSDuYFqOd3nZj0TcLsnoCTc4VlGMYZUelDjtR
         icDs0nIZwKLeqvZONr7VtuU8MPpB6srClo6DRiNs0gEF5SMmDaNzkp8GvQodsUd5j/KV
         +gDFI42TE2DY6vS4Of4hbH2Bojh5tJAu11HDowyc2MflzJlxYH5V8TRtcNYXCMa1oEOg
         xwqkCQlmUoKxqFkf6g06oFWFowrIKJdPUpbZTTAEMIAAdwNxF2aFGtddmawUb546nFpz
         BeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=GDsK2Z+46+yz4SS/Fs5yavi86Rx1QokgdZJcU3qy8qY=;
        b=KcmOdbDPm3635A+3yy5AsVY8uCC9JkNjjGVZ2QtZCOLSwguebo/vtuVufiTNV+UX1J
         E2cyBAhm32+KwGZ6pQc7YWJHz1JUL0qcLBceHM9o7pzBOiBXSUnFQ27W67RvnggOuE4T
         oh1USfVRRdWO2GLYtjSg91oQXaEbSPk/cN825tgt7aSL8yEesVCTOPogl+YOJJ0B2Xpn
         ohipkHh8KK88srZhszJNDaoQDudGzZBgngfC0covhy2o8jVHbFxSYAMaRygLyOJKgIID
         5reKVCARFkk0XUfUgDeK6OtgMgRsEuYyow2Kva/dVG3LSqJIT4dPsG19+C3tja/ou44t
         hSMQ==
X-Gm-Message-State: AOAM533w0pt3eaGyrPC+dLYGM9k+panHTkjXipkMh9nKS1WVH68kmy4o
        mal7o0Co89RKhgvNh/m/wjR6GQ==
X-Google-Smtp-Source: ABdhPJx/OfmzS1RhAF/oGqyKF4VP48kgmzjz5SxDnieiOd/rAz/rJ9A+K7zwFh/jSiLNvf1YUsQWEg==
X-Received: by 2002:a17:90b:ec2:: with SMTP id gz2mr5901125pjb.211.1605134429854;
        Wed, 11 Nov 2020 14:40:29 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
        by smtp.gmail.com with ESMTPSA id w63sm3763966pfc.120.2020.11.11.14.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 14:40:28 -0800 (PST)
Date:   Wed, 11 Nov 2020 14:40:23 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 01/11] docs: new capability to advertise trace2 SIDs
Message-ID: <20201111224023.GF36751@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <cover.1604006121.git.steadmon@google.com>
 <cover.1604355792.git.steadmon@google.com>
 <d04028c3c7574e3ca0f9c1b3d711192ca756158d.1604355792.git.steadmon@google.com>
 <xmqq5z6mqg60.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5z6mqg60.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020.11.03 13:33, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > +trace2-sid=<session-id>
> > +-----------------------
> > +
> > +If trace2 tracing is enabled on the server, it may advertise its session ID via
> > +this capability. The client may choose to log the server's session ID in its
> > +trace logs, and advertise its own session ID back to the server for it to log
> > +as well. This allows for easier debugging of remote sessions when both client
> > +and server logs are available.
> > diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
> > index e597b74da3..a5b9ef04f6 100644
> > --- a/Documentation/technical/protocol-v2.txt
> > +++ b/Documentation/technical/protocol-v2.txt
> > @@ -492,3 +492,12 @@ form `object-format=X`) to notify the client that the server is able to deal
> >  with objects using hash algorithm X.  If not specified, the server is assumed to
> >  only handle SHA-1.  If the client would like to use a hash algorithm other than
> >  SHA-1, it should specify its object-format string.
> > +
> > +trace2-sid=<session-id>
> > +~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +If trace2 tracing is enabled on the server, it may advertise its session ID via
> > +this capability. The client may choose to log the server's session ID in its
> > +trace logs, and advertise its own session ID back to the server for it to log
> > +as well. This allows for easier debugging of remote sessions when both client
> > +and server logs are available.
> 
> Have we documented what a session-id should look like anywhere in
> the documentation?  This document is to help third-party to write
> implementations of the protocol, but the above description leaves
> things "implementation defined" a bit too much, I am afraid.
> 
> For example, as this must fit on a single pkt-line as an advertised
> capability, there would be some length limit.  Are there other
> inherent limitations due to our protocol?  Are there some artificial
> limitations that we may want to impose to make it easier to harden
> implementations against common mistakes?  For example are bytes in
> <session-id> allowed to contain LF, CR, NUL, etc.?

Documented in V3. For argument's sake, I'm going to say that the tokens
should be limited to printable, non-whitespace characters, and should
fit on a single pkt-line.
