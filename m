Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54148C433DF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 18:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30F702073B
	for <git@archiver.kernel.org>; Fri, 29 May 2020 18:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sf4ACxXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgE2SAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 14:00:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56986 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgE2SAs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 14:00:48 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B11C362286;
        Fri, 29 May 2020 14:00:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z1xlVnV5O3sYij8/VcIfVCldBg8=; b=sf4ACx
        XFJled0wCbhBtPTCZ917yq/M7W/24aikgVvXiVuLQBdoM42OUOzN55P1VdZFtJ8G
        WoUrU5AwEKfgLMLb5q+KW71pZMe/ClC5SVXAzMAQqjRmurK9j4YQax8Sli+rlVKC
        kn04mrX8w7C5ZNUxFImOsbdXv09YJ6Ej6Dksc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z0H8c1J5ksa5bGNNZpBoRgt/OWc92N1U
        Tgqm+j6RwTPSdRfXzysPS4PYPSMJWVBAd0iRWk/6ljfgeIbMiNhAmgPqihIdbosb
        /7NlpRkq4FZmlId0zn7q1UXo9zb2GZwXjs8Ay2sLSiSSgVHHoyX77fvXHtr2F7yY
        +RL5kmibZoY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A871E62285;
        Fri, 29 May 2020 14:00:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ED3CE62284;
        Fri, 29 May 2020 14:00:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Xin Li <delphij@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com,
        sandals@crustytoothpaste.net, iankaz@google.com
Subject: Re: [PATCH v4] fetch: allow adding a filter after initial clone.
References: <20200528025359.20931-2-delphij@google.com>
        <xmqqsgfk3xtd.fsf@gitster.c.googlers.com>
        <20200528171924.GC58643@google.com>
        <CAOhzdugK7FQSnWruUrX8gQ98AF6kGvNWqPfHmE+qjGjBgzvmiQ@mail.gmail.com>
        <20200528191739.GA114915@google.com>
        <20200529000432.146618-1-delphij@google.com>
        <xmqqblm71sk1.fsf@gitster.c.googlers.com>
Date:   Fri, 29 May 2020 11:00:44 -0700
In-Reply-To: <xmqqblm71sk1.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 28 May 2020 17:41:18 -0700")
Message-ID: <xmqqo8q6zkmr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5174DB36-A1D6-11EA-B65B-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Which is slightly different from what you did with the three-way
> split of verify_repository_format(), which made the "eligibility"
> thing not to care about unknown extensions in a repository v1 and
> higher.  I actually think we should refuse to update v1 or v2
> repository to v3 with a running Git that knows only about v1
> (i.e. the repository before upgrading may or may not be something we
> understand, and if we do not understand it, we shouldn't touch it).

It does not change the conclusion, but I think the above sample
situation would not make much sense---a caller that asks this
function to upgrade the repository to v3 when the version of Git it
is linked in does not understand v3 is simply buggy.

But we should still refuse to update v1 to v2 with a version of Git
that understands v2 if the repository has some extension that we do
not know about, so 

 (1) if upgrading from v0, there must be no "extensions.*"; and

 (2) if upgrading from other versions, there must be no
     "extensions.*" we do not recognise.

I suggested would still be the reasonably defensive rule.

Thanks.


