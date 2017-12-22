Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 072C61F406
	for <e@80x24.org>; Fri, 22 Dec 2017 18:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755940AbdLVSrQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 13:47:16 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57639 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750864AbdLVSrP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 13:47:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8DA59BB544;
        Fri, 22 Dec 2017 13:47:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Vx3G7U9L1nUxEOsQo4lKaBel07M=; b=cGLrtb
        mda55X6LQr92m2SGJU+WR4huKdNzTrL5PdXvkkr37IjoJppxHFW5c9lnUShHyaz3
        1nxkORSBWrhUO/fdkqg7peVi6m825JPQV9NsZY51mxOVDL++0mdjlDLNVKXjLakS
        Cf4/J5NkNKijqXJ/MUuAQd41R/aY7mC5gCwbo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vjTxfyqDigf21bQv1Czh5gIKioRqS/N0
        vGbLMDgPieydq9O4PRVWr01mqtS5Q4N6yJ3Ans11cE8j6IxRxPJZepvSjoBQjyXK
        HgeAPX+e6AI406+rv8ziUy9nTHIQj90dwErmLdmWDgFAy3ga0AUp59uK3D55OLjh
        giIIkZxG5dQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 85DB7BB543;
        Fri, 22 Dec 2017 13:47:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 02512BB542;
        Fri, 22 Dec 2017 13:47:13 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Carlsson\, Magnus" <Magnus.Carlsson@arris.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Fetching commit instead of ref
References: <1513600223353.28799@arris.com>
        <xmqqh8snyiz0.fsf@gitster.mtv.corp.google.com>
        <1513672915856.50628@arris.com>
        <xmqqtvwmwvkp.fsf@gitster.mtv.corp.google.com>
        <1513756114533.56362@arris.com>
Date:   Fri, 22 Dec 2017 10:47:12 -0800
In-Reply-To: <1513756114533.56362@arris.com> (Magnus Carlsson's message of
        "Wed, 20 Dec 2017 07:48:34 +0000")
Message-ID: <xmqqlghusiq7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 869E0A44-E748-11E7-9857-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Carlsson, Magnus" <Magnus.Carlsson@arris.com> writes:

> $ git fetch subrepo 50f730db793e0733b159326c5a3e78fd48cedfec:refs/remote/subrepo/foo-commit
> remote: Counting objects: 2311, done.
> remote: Total 2311 (delta 0), reused 0 (delta 0), pack-reused 2311
> -- >>> Receiving objects: 100% (2311/2311), 703.64 KiB | 0 bytes/s, done.
> Resolving deltas: 100% (1174/1174), done.
> error: Server does not allow request for unadvertised object 50f730db793e0733b159326c5a3e78fd48cedfec

Unless that "fetch" is doing a recursive fetch from another
repository (which causes the counting to be shown) or something
silly, the above makes it look like that the server is broken.

A quick test locally does not seem to show such a behaviour, but I
do not enable pack bitmaps and I know github does at least for some
repositories, so it is possible there is a problem somewhere in that
codepath.
