Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F6202055E
	for <e@80x24.org>; Sat, 28 Oct 2017 22:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbdJ1W50 (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 18:57:26 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:53488 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751381AbdJ1W5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Oct 2017 18:57:25 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id 8a2ceSP2NmITa8a2ce5Ei5; Sat, 28 Oct 2017 23:57:24 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=W/RIbVek c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=1XWaLZrsAAAA:8
 a=4SDj-MLJHyTqrOITjp4A:9 a=wPNLvfGTeEIA:10
Message-ID: <223949CCB658443C972AB1AC1820F0CC@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Brandon Williams" <bmwill@google.com>, <git@vger.kernel.org>
Cc:     "Brandon Williams" <bmwill@google.com>, <spearce@spearce.org>,
        <git@jeffhostetler.com>, <gitster@pobox.com>,
        <jonathantanmy@google.com>, <jrnieder@gmail.com>, <peff@peff.net>,
        <sbeller@google.com>
References: <20171020171839.4188-1-bmwill@google.com>
Subject: Re: [RFC] protocol version 2
Date:   Sat, 28 Oct 2017 23:57:21 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 171028-0, 28/10/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfI3Swk3pVbLU+H7xEzfZRlytOqw4dnsLqP4yRpfWDZ2RxBSXykTuZYbN8f16zPVyk9+qmsqSvw0TONev+96P0YAWT4C2ac9/UPZBPzwyO9SEA7j5+pnW
 C81jKucK8H8GTF+2Q2rWmDffcuJAw49Nogsn6U973hb0oxda1+PoD8Yo3nGWV+xoKxUwBnkAPsA5zDdTbH9DWzmadL9GDEnUHquL000Qe7QdmwYvnkgPCkuD
 KKI4FbANR3+bUA+JJJt1rIVd2dSZmJv+mHpHrbgiLpLCDNJyrrhVJa8dxGuPwegnguCcgjUv0ax+baoJnc2dsMAu8mL94mZFmOEKADxoAXkvydy75KHgoYaf
 kyScszRVlqY1wOgmdeOftIdh5mdGF0nDb5YYy7zavgiPHsSOO6PsnOM0Z48tTrksJ4NMu9u0v7mKrDVe/AHLVgjJH+9jDw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Brandon Williams" <bmwill@google.com>
Sent: Friday, October 20, 2017 6:18 PM
> Objective
> ===========
>
> Replace Git's current wire protocol with a simpler, less wasteful
> protocol that can evolve over time.
>

<snip>

> Capability Advertisement
> --------------------------
>
> A server which decides to communicate (based on a request from a client)
> using protocol version 2, notifies the client by sending a version
> string in its initial response followed by an advertisement of its
> capabilities.  Each capability is a key with an optional value.  Clients
> must ignore all unknown keys.

>    Semantics of unknown values are left to
> the definition of each key.

This sounds odd. If the keys are known then their semantics are known. Or 
the keys are unknown and they and their values are ignored.

Maybe: Capability keys shall define their response to unknown key values.

>  Some capabilities will describe commands
> which can be requested to be executed by the client.
>
<snip>

> Ls-refs
> ---------
>
> Ls-refs can be looked at as the equivalent of the current ls-remote as
> it is a way to query a remote for the references that it has.  Unlike
> the current ls-remote, the filtering of the output is done on the server
> side by passing a number of parameters to the server-side command
> instead of the filtering occurring on the client.
>
> Ls-ref takes in the following parameters:
>
>  --head, --tags: Limit to only refs/heads or refs/tags
>  --refs: Do not show peeled tags or pseudorefs like HEAD
>  --symref: In addition to the object pointed by it, show the underlying
>            ref pointed by it when showing a symbolic ref
>  <refspec>: When specified, only references matching the given patterns
>             are displayed.

Does the --symref also the pseudorefs?

Isn't there a need somethimes to determine the ref that the remote's HEAD 
points to. This is an issue with the current clone and bundle code when 
there is a choice of refs/branches that could be the current HEAD ref and 
the wrong one is chosen, though this V2 change doesn't affect bundles.

>
> The output of ls-refs is as follows:
>
>    output = (no-refs / list-of-refs)
>      *symref
>             *shallow
>             flush-pkt
>
>    no-refs = PKT-LINE(zero-id SP no-refs LF)
>    list-of-refs = *ref
>    ref = PKT-LINE((tip / peeled) LF)
>    tip = obj-id SP refname
>    peeled = obj-id SP refname "^{}"
>
>    symref = PKT-LINE("symref" SP symbolic-ref SP resolved-ref LF)
>    shallow = PKT-LINE("shallow" SP obj-id LF)
>
> Fetch
> -------
>
> Fetch will need to be a modified version of the v1 fetch protocol.  Some
> potential areas for improvement are: Ref-in-want, CDN offloading,
> Fetch-options.
>
> Since we'll have an 'ls-ref' service we can eliminate the need of fetch
> to perform a ref-advertisement, instead a client can run the 'ls-refs'
> service first, in order to find out what refs the server has, and then
> request those refs directly using the fetch service.
>
> //TODO Flush out the design
>
> Fetch-object
> --------------
>
> This service could be used by partial clones in order to request missing
> objects.
>
> //TODO Flush out the design
>
> Push
> ------
>
> Push will need to be a modified version of the v1 push protocol.  Some
> potential areas for improvement are: Fix push-options, Negotiation for
> force push.
>
> One change that will need to happen is to improve how `push-options` are
> sent to the server (so that they aren't sent twice!!).  Also the
> report-status needs to be better than it currently is in v1 so that
> tools like gerrit can explain what it did with the ref-update the client
> sent to it. Maybe have a push-rebase capability or command?
>
> //TODO Flush out the design
>
> Other Considerations
> ======================
>
>  * Move away from pkt-line framing?
>  * Have responses structured in well known formats (e.g. JSON)
>  * Eliminate initial round-trip using 'GIT_PROTOCOL' side-channel
>  * Additional commands in a partial clone world (e.g. log, grep)
--
Philip 

