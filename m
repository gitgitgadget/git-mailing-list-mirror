Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C717C2D0A3
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A9462076E
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b+vPvTv6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgKBWU2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 17:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgKBWU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 17:20:27 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87098C0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 14:20:27 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id g12so11999370pgm.8
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 14:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=yV/UETkqX37TfCp9cgepgxYn3J4J6OnxW7EKNYnIqJ4=;
        b=b+vPvTv6f2qj5PBQSHmvbvS2mxHjCQWnBWEFu+KsbTHq62JNIX/ZzfgkP009X9wHY5
         lV8y3KUXgr+33c/AAGGPLuyCAG9+SodKWimwI96vT/trBSChc+It5sgffZJKDKYi6S/5
         6Ia/DTzoQeYMiOIhs3sLSI7x4rhIVlBuRiVxfxx7Mb3MM/hzbPZETwhZ51ku2AJegnxH
         LVbjuFZSn4jKhelR33A87IWUxqdI9xh1M66zFVqSt1f8GCfMo3CTaa20yK4Q0yJSUXIg
         eT6zR/Tp7QO/ibSUpQ7I6rnkrUw6W0RFwxuRhDO1eu0K5TFjuCMhPHQPR6+g5QvXmo/R
         LnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=yV/UETkqX37TfCp9cgepgxYn3J4J6OnxW7EKNYnIqJ4=;
        b=mI1qStHl4lUVLK2cS0f0brqGbHraJKAum4Z+QfQfdUv6QwJygkTklqob9nDmeoN/9k
         69Xd0itqr9780AKhgyWMoSppxgkVvK1W7UeO3R9MEJbbqp8juz9yJTalSAw1Yg8jLzMA
         cxHdqMn0c6+SDwcYOyBW9zE5lbCboYOHGFHSW8LgciJ9jEbLQ1pjjXRyxL8H+YTzA7Ja
         WUmgceivuWLSB90OI3GcKi5wHx2PWRnUmnT5Swwy0ANn3ZjhHipxFxvjmGr1Ocs7LBGy
         TuVKXBvzo9vcATuSw9uQWqF/23C9RwzSrKD9pIkx/rpiraC0BJEVeMnseQjfJCc0mg8h
         upVw==
X-Gm-Message-State: AOAM5339kpSyFkIlQrHniI2d/33oEQ1K3LZDHwKTHZKNbpfxrW3bUCJ0
        4uuaUPDKNdBXl4Y5JSfa3GerkJYGTja6sw==
X-Google-Smtp-Source: ABdhPJxgmkZd+JXXmgRthmKCA7Dp59ePZ07XbAPc7CMCDiNIOf6GkbVWw78mK24fx8R2MhFqgn5hyA==
X-Received: by 2002:a65:508a:: with SMTP id r10mr15184814pgp.307.1604355626810;
        Mon, 02 Nov 2020 14:20:26 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
        by smtp.gmail.com with ESMTPSA id 9sm5495223pfp.102.2020.11.02.14.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 14:20:25 -0800 (PST)
Date:   Mon, 2 Nov 2020 14:20:20 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 00/10] Advertise trace2 SID in protocol capabilities
Message-ID: <20201102222020.GA1904687@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <cover.1604006121.git.steadmon@google.com>
 <4f1a1bab-7ac7-b8dd-acb2-6aeb04be3171@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f1a1bab-7ac7-b8dd-acb2-6aeb04be3171@jeffhostetler.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020.10.30 11:54, Jeff Hostetler wrote:
> 
> 
> On 10/29/20 5:32 PM, Josh Steadmon wrote:
> > In order to more easily debug remote operations, it is useful to be able
> > to inspect both client-side and server-side traces. This series allows
> > clients to record the server's trace2 session ID, and vice versa, by
> > advertising the SID in a new "trace2-sid" protocol capability.
> > 
> 
> Very nice!  This should be very helpful when matching up client and
> server commands.
> 
> 
> > Two questions in particular for reviewers:
> > 
> > 1) Is trace2/tr2_sid.h intended to be visible to the rest of the code,
> >    or is the trace2/ directory supposed to be opaque implementation
> >    detail? If the latter, would it be acceptable to move tr2_sid_get()
> >    into trace2.h?
> 
> I put all the trace2-private stuff in that sub-directory and gave
> everything tr2_ prefixes to hide the details as much as I could
> (and as an alternative to the usual tendency of having everything
> be static within a massive .c file).
> 
> So, yeah, my intent was to make all of it opaque.
> So that just trace2.h contains the official API.
> 
> Perhaps in trace2.c you could create:
> 
> const char *trace2_session_id(void)
> {
>     return tr2_sid_get();
> }

Done in V2, thanks.


> > 2) upload-pack generally takes configuration via flags rather than
> >    gitconfig. From offline discussions, it sounds like this is an
> >    intentional choice to limit potential vulnerability from malicious
> >    configs in local repositories accessed via the file:// URL scheme. Is
> >    it reasonable to load the trace2.announceSID option from config files
> >    in upload-pack, or should this be changed to a flag?
> 
> I don't have the history to comment on this.
> 
> One thing to consider is that the SID for a Git process is built up
> from the SID of the parent and the unique data for the current process.
> So for example, if `git fetch` has SID `<sid1>` and it spawns
> `git upload-pack`, the child will have SID `<sid1>/<sid2>` and if that
> spawns `git index-pack`, that child will have `<sid1>/<sid2>/<sid3>`.
> This is very helpful when tracking down parent/child relationships
> and perf hunting.
> 
> This SID inheritance is passed via an environment variable to
> the child, which extends it and passes the longer version to its
> children.
> 
> So the value being passed between client and server over the
> protocol may look like `<sid1>/<sid2>/<sid3>` rather than just a
> single `<sid_x>` term.  For your purposes, do you want or care if
> you get the single term or the full SID ?

I'm not sure we care too much one way or the other. A single component
of the SID should be enough to join client & server logs, but it's
easier to just send the whole thing.


> Also, there's nothing to stop someone from seeding that environment
> variable in their shell with some mischief before launching the
> top-level Git command.  So the above example might see the SID as
> `<mischief>/<sid1>/<sid2>/<sid3>`.  I'm not sure if this could be
> abused when inserted into the V0/V1/V2 protocol or your logging
> facility.
> 
>     $ GIT_TRACE2_EVENT=1 GIT_TRACE2_PARENT_SID=hello git version
>     {"event":"version","sid":"hello/20201030T154143.660608Z-H86606a97-
> P00001d30",...}
>     ...
> 
> So maybe we want to have a public API to return a pointer to just
> the final `<sid_x>` term ?  (Then again, maybe I worry too much.)

Yeah, it's certainly possible to muck with the SID as you describe, but
I'm not sure I see any big problems that could be caused. If someone
points out an issue I've missed, I'll be happy to change this, though.

> Thanks,
> Jeff

Thanks for the review!


> > Josh Steadmon (10):
> >    docs: new capability to advertise trace2 SIDs
> >    docs: new trace2.advertiseSID option
> >    upload-pack: advertise trace2 SID in v0 capabilities
> >    receive-pack: advertise trace2 SID in v0 capabilities
> >    serve: advertise trace2 SID in v2 capabilities
> >    transport: log received server trace2 SID
> >    fetch-pack: advertise trace2 SID in capabilities
> >    upload-pack, serve: log received client trace2 SID
> >    send-pack: advertise trace2 SID in capabilities
> >    receive-pack: log received client trace2 SID
> > 
> >   Documentation/config/trace2.txt               |  4 +
> >   .../technical/protocol-capabilities.txt       | 13 ++-
> >   Documentation/technical/protocol-v2.txt       |  9 +++
> >   builtin/receive-pack.c                        | 16 ++++
> >   fetch-pack.c                                  | 11 +++
> >   send-pack.c                                   |  9 +++
> >   serve.c                                       | 19 +++++
> >   t/t5705-trace2-sid-in-capabilities.sh         | 79 +++++++++++++++++++
> >   transport.c                                   | 10 +++
> >   upload-pack.c                                 | 23 +++++-
> >   10 files changed, 190 insertions(+), 3 deletions(-)
> >   create mode 100755 t/t5705-trace2-sid-in-capabilities.sh
> > 
