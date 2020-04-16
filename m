Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9693C2BA19
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 01:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 715382076D
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 01:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ACO0Bvdk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgDPBCV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 21:02:21 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53998 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390560AbgDPBCK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 21:02:10 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 19735D564F;
        Wed, 15 Apr 2020 21:02:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QEgb2GhSdHQbuANxdzLze3HI04A=; b=ACO0Bv
        dko3GouBaYL7+Nyfh+y5oPwwrG3Hrntj9d7sCG4EAVu2gX+sKccJg+Ie+PYDDDT9
        8fhAgpukyAT4RDARjFtJxeJhosKwhDEnP2XHMfe7n+RmFzDGByna9GAMqM8+tF0R
        YXpMwjoKW5xxhEZzjXppqJC6FNb9hayomm4D4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IFDdlWwO1dswiGGl1tpnowCmOQkB9kyC
        jHpA9HiD1/6iOjwUbyPefPhPeRu2FzW/Dpqf0PSrY+JND2FnN5WJoTBVEFkZNqsd
        7mR/ccUb+0AjX7iSn+aqNd3VkF/Nfw2knz+yQlK7KXoIePu/VvTCs630mnMEE4oU
        unq+s4V5hEI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1139DD564E;
        Wed, 15 Apr 2020 21:02:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5C082D564B;
        Wed, 15 Apr 2020 21:02:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     luciano.rocha@booking.com, git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 1/1] freshen_file(): use NULL `times' for implicit current-time
References: <5e95d37d.1c69fb81.2b4ec.ce9f@mx.google.com>
        <xmqq4ktk5t4h.fsf@gitster.c.googlers.com>
        <20200415234847.GI2751707@camp.crustytoothpaste.net>
Date:   Wed, 15 Apr 2020 18:02:03 -0700
In-Reply-To: <20200415234847.GI2751707@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Wed, 15 Apr 2020 23:48:47 +0000")
Message-ID: <xmqqa73c4510.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E392F6D6-7F7D-11EA-96D5-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> So the answer is the user needs to have write access with utime(fn,
> NULL), but the same EUID (or root) with a specific time.

OK, with a specific time, write access is not sufficient, and that
is why this patch helps.

Makes perfect sense.  Thanks for a dose of sanity ;-)
