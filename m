Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CA6C433DF
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 19:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37E8A2064C
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 19:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ga0drJqX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbgGQTbD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 15:31:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55897 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbgGQTbD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 15:31:03 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D529619E0;
        Fri, 17 Jul 2020 15:31:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RTCpDNn73cgA/QqLytrUtkgUr6Q=; b=ga0drJ
        qXC+Fi6zihg/RIeaaz9NYUWX0AXi10qExHOUc9XMkqX3xMi3+r0a7sMdoRwT6ioR
        UUdSbWy7IMs7bQkxnVE3HU0MulqRV/EDaawWAU47LgoEVPu+twz5Bj4QK6hAfc9I
        7E28/IKVpVFExirmBuQAqyqaf9XG+MnU2K4aQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=W1ZTqy1cw3PrdQnTLSP4z9oz1Gkx1rGq
        I9Aalf/5mp+D2gNSEZCQupaDvOcxN8hcsyw9yudXu7BHLP4TY6V3S4sRs7OYP18O
        +1UtruwVneBgRoGRSFGlA4/pE6ziHROuEAdP7cUmmWWwvyVvjNv1GVu7eIf7Pvf/
        1/sQYvXu0xQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 67088619DF;
        Fri, 17 Jul 2020 15:31:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CB7E2619DE;
        Fri, 17 Jul 2020 15:30:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jean Abou Samra <jean@abou-samra.fr>
Cc:     git@vger.kernel.org
Subject: Re: Git bisect run should check for the existence of the script
References: <9cea8076-be96-19c5-c368-288193daedd8@abou-samra.fr>
        <xmqq1rlclte2.fsf@gitster.c.googlers.com>
        <8c683b56-d17a-78ce-67bb-477e5b307df9@abou-samra.fr>
        <xmqqeepadk8q.fsf@gitster.c.googlers.com>
Date:   Fri, 17 Jul 2020 12:30:59 -0700
In-Reply-To: <xmqqeepadk8q.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 17 Jul 2020 12:17:25 -0700")
Message-ID: <xmqqa6zydjm4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B345B42-C864-11EA-A6F4-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Do you mean a new option must be passed if the end-user expects the
> script to always exist across revisions, or the script is not
> tracked to begin with?  It feels somewhat backwards and the effort
> by the end-user to always type the option is better spent to make
> sure there is no typo on the command line.

I forgot to follow up on this part.

It does not change the conclusion that it needs to be done carefully
if we chose to retroactivelyreserve return code 127 for our own use,
but such a backward incompatible change can easily be worked around
if users relied on the current behaviour that a missing (tracked)
script would mark the revision "bad" without being a fatal error in
"git bisect run".  Instead of

    git bisect run "./tracked-script"

they can just do

    git bisect run "test -f ./tracked-script && ./tracked-script"

and the problem is solved ;-)
