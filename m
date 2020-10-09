Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CAFC433E7
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 16:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D366D2227F
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 16:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NgY73Rl4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389798AbgJIQ2Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 12:28:16 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65018 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389144AbgJIQ2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 12:28:16 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E8C3CDAF47;
        Fri,  9 Oct 2020 12:28:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RC2/F2r7XoWjzbPEg3PczRz97Lc=; b=NgY73R
        l4FHST22qaj0O03sRtIW4ubxRWTpUOymqfPFG3A0xoJK7yfP0R+8Y2vKdxusV1Vs
        5RD7jFiNFOWUiAqs4D6v/kbrZt8ckGVq9uj4CXu3slBEryaKgKE7ZE3G0DIEZccc
        1g3T6mZnyL2GYcBuDNjmOnWwwdqHX8lvEpW3M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Jn8TtFjnY6+8FKLBPOY9dCHhv7DfX/jv
        CRjMhxlAxg0EaPd461wugLBPhgsDOKwFOLzeRlet9cKsoQ5Pi6ta7tZ19wVfLO0S
        j6e31iwRKnZVR9XIgNy/vEzh4xpYIdXTrS469vFTPsjXnkrJOr6RJRX0BvdopoMA
        Mrfj+ZM5eZY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E1544DAF46;
        Fri,  9 Oct 2020 12:28:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 333D6DAF45;
        Fri,  9 Oct 2020 12:28:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2020, #02; Fri, 9)
References: <xmqq362nv18o.fsf@gitster.c.googlers.com>
        <512a3dc5-4937-8679-c4c8-5144ac50450b@gmail.com>
Date:   Fri, 09 Oct 2020 09:28:10 -0700
In-Reply-To: <512a3dc5-4937-8679-c4c8-5144ac50450b@gmail.com> (Derrick
        Stolee's message of "Fri, 9 Oct 2020 12:15:31 -0400")
Message-ID: <xmqqpn5rtld1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6CB11E62-0A4C-11EB-A6DE-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> As for discarding them all: we would need to add code to "reparse"
> a commit from the object database. Perhaps that is doable, but we
> have so far not removed data from a parsed 'struct commit'. This
> is probably the easiest way forward to guarantee correct data here.

Oh, no, by "discarding" I just meant to blow away suspect on-disk
files and recompute them from scratch.  I didn't have anything
clever like correcting in-core data structure by parsing the commits
and updating.

> Again, let's find a way to test this before committing.

Yes, that is sensible.  After all this is not a recent regression.
