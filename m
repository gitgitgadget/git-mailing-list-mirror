Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAB9C83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 20:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EA312082E
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 20:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JdpkAm43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgD2UWi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 16:22:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52905 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgD2UWi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 16:22:38 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 459EF47125;
        Wed, 29 Apr 2020 16:22:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gX2Nb6hV572n+G7hD1CvRQc0Z9o=; b=JdpkAm
        43+YSJBXpw9HcoImIsBMg7oxzpVHprassj9uAMau/cobElfIeQGYqAx0sP8ccNQb
        UHC73f3nAfuf7OV5zhp2URt0ELFVuubMmUuvABR3hw+e2NDqaauF3Zyik3TL1+wo
        a8ayExrt5no//SqVcSJlWS+hbj25c2UVv2NoU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Kj4fL/m0UTJAghOTwQhkLUCO+hUhS53i
        8+dod7hce9QRlppOm3W/hinyZy0Mb3xhA7oRC+PYKyQr0c99QayJajk5EndRHEXL
        sZcBCH/DyHZ1O7Gz+gQhrAT7RX7JkgZ4s6dP0Fuo1m29lrmpbJz2R5IodvYj/Aoz
        haAWKQHV2s0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3DA9647124;
        Wed, 29 Apr 2020 16:22:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BF7E147123;
        Wed, 29 Apr 2020 16:22:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Ivan Tham <pickfire@riseup.net>, git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] branch: add '-' to delete previous branch
References: <20200429130133.520981-1-pickfire@riseup.net>
        <877dxyo1k8.fsf@osv.gnss.ru> <20200429190013.GG83442@syl.local>
        <87v9likr5a.fsf@osv.gnss.ru> <20200429195745.GC3920@syl.local>
Date:   Wed, 29 Apr 2020 13:22:36 -0700
In-Reply-To: <20200429195745.GC3920@syl.local> (Taylor Blau's message of "Wed,
        29 Apr 2020 13:57:45 -0600")
Message-ID: <xmqqa72uvy7n.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A7F8FC6-8A57-11EA-AA83-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Again, not sure that this is always the case. This *is* how 'git
> checkout' works.

To be honest, I am somewhat sympathetic to those who find "-" ==
"@{-1}" unless it is used as an argument to "git checkout/switch".
The use of "-" in "checkout" is the exception, not the norm, and it
was sort of justifiable due to similarity to "cd -".  Both are
commands to the computer you give to "go to the previous place".

"git merge -", "git branch -d -" etc. are not about *going* to the
previous place, and declaring the "-" is "previous place" is taking
it a bit too far, at least to my taste.

Oh, I do not like those who advocate "@" as a synonym for "HEAD",
either.  If there is one simple thing I want to get rid of from the
system, that's it ;-).

Anyway...

