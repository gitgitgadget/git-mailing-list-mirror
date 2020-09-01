Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F461C433E2
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 16:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C0D8204EC
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 16:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GoQdli0j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbgIAQLS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:11:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62787 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730520AbgIAQLO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 12:11:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3633E74827;
        Tue,  1 Sep 2020 12:11:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=giJq9et9/nhAZl2OXDYXO8fZStY=; b=GoQdli
        0jRtkKaK8ar6qEe2CPqT/LF8UbYucIQLNNmfxZGPeoy7QDp/kJKNyd0AwACBL7UU
        1zL/p00VjpsEyOQ5vh4vBbUEjJEX4tO8EbdRgnLPnvGqRSOhkScmTi1EvmpPymij
        haheItNPWwEGJwXvMIoM7bZrQUgmaMAIO/MKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lbo705a+wTup32K99vxEPetT+ANpqgKW
        PJ/1c+E5831ZtLGVTk78MhRnLrfHP5eB7ov8DQhpkRmLD8mhp3n7CCzQAwxrNM0E
        +9DAapDcrYg3B3KkL2TAANqbkyVlXNTnsj126QWMezYxwKIkQQz9+i6dAbOjJn75
        OCiiDA34I6o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2EC9F74826;
        Tue,  1 Sep 2020 12:11:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A797A74825;
        Tue,  1 Sep 2020 12:11:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/2] credential-cache: use child_process.args
References: <xmqqd03dwe2x.fsf@gitster.c.googlers.com>
        <20200826194650.4031087-1-gitster@pobox.com>
        <20200826194650.4031087-3-gitster@pobox.com>
        <xmqqzh6ht7fg.fsf_-_@gitster.c.googlers.com>
        <xmqqpn76e873.fsf@gitster.c.googlers.com>
        <20200901044954.GB3956172@coredump.intra.peff.net>
Date:   Tue, 01 Sep 2020 09:11:10 -0700
In-Reply-To: <20200901044954.GB3956172@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 1 Sep 2020 00:49:54 -0400")
Message-ID: <xmqqy2ltcw9t.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C0B6D27E-EC6D-11EA-8DF5-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Hmm, that is interesting. I thought it would work OK because we don't
> rely on any process-id magic for finding the daemon, etc, and instead
> talk over pipe descriptors. But that proves to be our undoing.

Yup.  I also do suspect that closing all excess fds in the git
process in the middle may not be a bad idea, but we may not know
what the upper bound is.

> Perhaps git.c should be closing all descriptors after spawning the
> child. Of course that gets weird if it wants to write an error to stderr
> about spawning the child. I dunno. It seems as likely to introduce
> problems as solve them, so if nothing is broken beyond this cache-daemon
> thing, I'd just as soon leave it.

We do employ the "open extra pipe that is set to close-on-exec so
that child that failed to exec can report back" trick, but in order
to report the failure back, the standard error of the process in the
middle may have to be kept open, so let's not disturb this sleeping
dragon ;-)

