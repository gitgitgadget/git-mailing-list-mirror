Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F22C433DF
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 23:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60BBD2076B
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 23:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j2aJjiGB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgFAXHy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 19:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgFAXHx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 19:07:53 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB63C05BD43
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 16:07:52 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id q21so5280527qte.17
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 16:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CrS5H+kAMdkzuN09fHkgq49MGhdTDD3R2gKeKjLAXzg=;
        b=j2aJjiGBY2eYry+XH087Ujjfwm7zygQ4rhl2PHiu2zAeE+3ADDFDswnEzhzwhTaxcQ
         7vAvr03tMATikyjI4uamWwIlgUHLSokIRBIZQHWZrp0jz3T5WLbYGhYmyH8UISpkEWcK
         dtzl3K12zQRX7DKIORo2Q0PwA4tuR9OwwI5N8C1WjSIkMXi5JJXZKE/M3sVHI+k5JY3u
         1h/9+VKKQu/zpyyZIfrkRrgqYPgPPtvUivrdcRxxLdnCNU1UdTm4oM6lVqcxuF0qz4yv
         JKQ783E5uN6t/8tbV38eL5JDKlCyCRXRdwt+QeKSx4Jwmr15aPhal4vbeZ5lZLaKvAlP
         7IoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CrS5H+kAMdkzuN09fHkgq49MGhdTDD3R2gKeKjLAXzg=;
        b=ohY9XZiDgoRflUxVY3T9TlF+/zu5I8Vr/bC2IZkinmHmfVXywjZEA7DVJI6BN3nKqB
         ft6DhaJM1ShyVrw5rhbbexweZPuW7Kti/RPQFU4jA0AM+O6HCBeUq6/HmfsKP2E1hbxv
         xxeCQiPLhB4QuLF6AxtOdTO2g3/pgp6cFlojDTenH/CX9BLfzZ1oQnUJwBwYIb/yGySA
         oE35U37BpiRhpUbeve2IR5dpJB91PGqZsDo3LfVcW3QUBtFD9xRiqwHjBHwf83uZXPEA
         wEF3YDH0uaY3asVz5YvM0rIc3UPSSSuFxO3IjUgGA2tp7n7Z0Li+LwhLoyRI9bH5mRxK
         GIDg==
X-Gm-Message-State: AOAM531GG3F9Aj/v6tThoeomGh/LtFNzKGh6QA/B2PTui8NDK2NBJ6sc
        GnGcJ6xj9NpuGGpT8OtHVujm5GcTEtOni4JVukMk
X-Google-Smtp-Source: ABdhPJyxYooZsMgrHyoArTkbrji9m0fX4NWl1hI6zgKkl6oY1xrq3IUaul8vJqEBFVIpNFBAQ0co7KNsAUCq1NrfJUZ+
X-Received: by 2002:a0c:e952:: with SMTP id n18mr10603007qvo.147.1591052871572;
 Mon, 01 Jun 2020 16:07:51 -0700 (PDT)
Date:   Mon,  1 Jun 2020 16:07:49 -0700
In-Reply-To: <xmqq5zcexoqi.fsf@gitster.c.googlers.com>
Message-Id: <20200601230749.257056-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq5zcexoqi.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
Subject: Re: [PATCH 5/8] Documentation: add Packfile URIs design doc
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > +Protocol
> > +--------
> > +
> > +The server advertises `packfile-uris`.
> 
> Is this a new "protocol capability"?  There are multiple things that
> are "advertised" over the wire (there is "reference advertisement")
> and readers would want to know if this is yet another kind of
> advertisement or a new variety of the "capability".

Yes, it's a new protocol capability. I'll update the text.

> > +If the client then communicates which protocols (HTTPS, etc.) it supports with
> > +a `packfile-uris` argument, the server MAY send a `packfile-uris` section
> > +directly before the `packfile` section (right after `wanted-refs` if it is
> > +sent) containing URIs of any of the given protocols. The URIs point to
> > +packfiles that use only features that the client has declared that it supports
> > +(e.g. ofs-delta and thin-pack). See protocol-v2.txt for the documentation of
> > +this section.
> > +
> > +Clients then should understand that the returned packfile could be incomplete,
> 
> I am guessing that this merely mean that the result of downloading
> and installing the packfile does not necessarily make the resulting
> repository up-to-date with respect to the "want" the "fetch" command
> requested.  But the above can easily be misread that the returned
> packfile is somewhat broken, corrupt or missing objects that it
> ought to have (e.g. a deltified object lacks its base object in the
> file). [#1]

Most of this is resolved below, but I'll try to write upfront what's
going on so it will be clear from the beginning (and not just at the
end).

But you bring up a good point here - can one of the linked-by-URI packs
have a delta against the inline packfile, or vice versa? I'll take a
look and clarify that.

> > +and that it needs to download all the given URIs before the fetch or clone is
> > +complete.
> 
> So if I say "I want history leading to commit X", and choose to use
> the packfile-uris that told me to fetch two packfiles P and Q, does
> it mean that I need to only fetch P and Q, index-pack them and store
> the resulting two packfiles and their idx files in my repository, do
> I have the history leading to commit X?
> 
> I would have guessed that the resulting repository after fetching
> these URIs can still be incomplete and the "packfile" section of the
> response needs to be processed before the fetch or clone is complete,
> but the above does not say so.

I'll clarify the statement.

> > +Server design
> > +-------------
> > +
> > +The server can be trivially made compatible with the proposed protocol by
> > +having it advertise `packfile-uris`, tolerating the client sending
> > +`packfile-uris`, and never sending any `packfile-uris` section. But we should
> > +include some sort of non-trivial implementation in the Minimum Viable Product,
> > +at least so that we can test the client.
> > +
> > +This is the implementation: a feature, marked experimental, that allows the
> > +server to be configured by one or more `uploadpack.blobPackfileUri=<sha1>
> > +<uri>` entries. Whenever the list of objects to be sent is assembled, a blob
> > +with the given sha1 can be replaced by the given URI. This allows, for example,
> > +servers to delegate serving of large blobs to CDNs.
> 
> Let me see if the above is understandable.
> 
> Does "git cat-file blob <sha1>" come back when we try to "wget/curl"
> the <uri>?

No - a packfile containing a single object will be returned, not the
uncompressed and headerless object. I'll update the text to clarify
that.

> > +The division of work (initial fetch + additional URIs) introduces convenient
> > +points for resumption of an interrupted clone - such resumption can be done
> > +after the Minimum Viable Product (see "Future work").
> > +
> > +The client can inhibit this feature (i.e. refrain from sending the
> > +`packfile-uris` parameter) by passing --no-packfile-uris to `git fetch`.
> 
> By default, as long as the other side advertises packfile-uris, the
> client automatically attempts to use it and users need to explicitly
> disable it?  
> 
> It's quite different from the way we introduce new features and I am
> wondering if it is a good approach.

The client has to opt-in first with the fetch.uriprotocols config (which
says what protocols it wants to support) but it's not written here in
this spec. I'll add it.

> > + * On the server, a long-running process that takes in entire requests and
> > +   outputs a list of URIs and the corresponding inclusion and exclusion sets of
> > +   objects. This allows, e.g., signed URIs to be used and packfiles for common
> > +   requests to be cached.
> 
> Did we discuss "inclusion and exclusion sets" whatever they are?

No - this is future/speculative so I didn't want to spend too much time
explaining this. I was thinking of saying that this URI includes all
objects from commit A (inclusion) but not from commits B and C
(exclusion). Maybe I should just leave it out.

> > diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
> > index ef7514a3ee..7e1b3a0bfe 100644
> > --- a/Documentation/technical/protocol-v2.txt
> > +++ b/Documentation/technical/protocol-v2.txt
> > @@ -325,13 +325,26 @@ included in the client's request:
> >  	indicating its sideband (1, 2, or 3), and the server may send "0005\2"
> >  	(a PKT-LINE of sideband 2 with no payload) as a keepalive packet.
> >  
> > +If the 'packfile-uris' feature is advertised, the following argument
> > +can be included in the client's request as well as the potential
> > +addition of the 'packfile-uris' section in the server's response as
> > +explained below.
> > +
> > +    packfile-uris <comma-separated list of protocols>
> > +	Indicates to the server that the client is willing to receive
> > +	URIs of any of the given protocols in place of objects in the
> > +	sent packfile. Before performing the connectivity check, the
> > +	client should download from all given URIs. Currently, the
> > +	protocols supported are "http" and "https".
> 
> Ah, I think the puzzlement I repeatedly expressed above is starting
> to dissolve.  You are assuming that the receiving end would remember
> the URIs but the in-protocol packfile data at the end is handled
> first, and then before the final connectivity check is done,
> packfiles are downloaded from the URIs.  If you spelled out that
> assumption early in the document, then I wouldn't have had to ask
> all those questions.  I was assuming a different order (i.e. CDN
> packfiles first to establish the baseline, and then in-protocol
> packfile to fill the "latest bits", the last mile to reach the tips
> of requested refs).
> 
> In practice, I suspect that these fetches would go in parallel with
> the processing of the in-protocol packfile, but spelling it out as
> if these are done sequencially would help establishing the right
> mental model.  

OK.

> "(1) Process in-protocol packfiles first, and then (2) fetch CDN
> URIs, and after all is done, (3) update the tips of refs" would
> serve as a base to establish a good mental model.  It would be even
> better to throw in another step before all that: (0) record the
> wanted-refs and CDN URIs to the safe place.  If you get disconnected
> before finishing (1), you have to redo from the scratch, but once
> you finished (0) and (1), then (2) and (3) can be done at your
> leisure using the information you saved in step (0), and (1) can be
> retried if your connection is lousy.

OK. This set of patches does not do (0) yet, and I think doing so would
require more design - in particular, if we have fetch resumption, we
would need to somehow track that none of the previously fetched objects
have been deleted.

Thanks for all your comments.
