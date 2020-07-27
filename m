Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2834DC433E0
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 22:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA87920809
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 22:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XrbYmysd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgG0Wxf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 18:53:35 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51744 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgG0Wxf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 18:53:35 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1CD43CE352;
        Mon, 27 Jul 2020 18:53:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gzaoQS1A/IVCj3kmfqYy27Pml7k=; b=XrbYmy
        sd92BeCeeJhE+Nmuui/kEvH4LUNE7jHO1akp9SHLpcS3xamNbq8T2bnmLS6bOvg1
        Iib00sk+lQpFeRfACjbzHReAzLXkp7PScvn9sX7f67KbLCLfwpzHbAyXSrY3mDIt
        Sjuqgb4tu3g/9UpMjqYlKMJQp3bbQigrd5GTE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VkhMtWypksUN3DEWDRmLg+z0RCSS4m8V
        P71SmJGmk/2XDhqLKQZ2aD1K4+VTsaPu93AlMODTB3wWmE4aO8uYingBEqVQJ1a/
        IhM8wuLJjB9LQT8svyRasjRlId5EnX8HatiCLC2h9be6Xi43b0CLicpgOc2y+mXq
        OIGxYBnNnOM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 15CAACE350;
        Mon, 27 Jul 2020 18:53:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 628A5CE34F;
        Mon, 27 Jul 2020 18:53:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anders Waldenborg <anders@0x63.nu>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Questions about trailer configuration semantics
References: <87blk0rjob.fsf@0x63.nu> <xmqqr1swg9lc.fsf@gitster.c.googlers.com>
        <CAP8UFD1XV_jN10yOc2o4=5PtPcvT-RbxhY1H3swZz2r4g-Uzkw@mail.gmail.com>
        <87a6zkr5z7.fsf@0x63.nu>
Date:   Mon, 27 Jul 2020 15:53:28 -0700
In-Reply-To: <87a6zkr5z7.fsf@0x63.nu> (Anders Waldenborg's message of "Mon, 27
        Jul 2020 23:41:16 +0200")
Message-ID: <xmqqa6zkfu3b.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FDA33EB2-D05B-11EA-885E-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anders Waldenborg <anders@0x63.nu> writes:

> However I guess one alternative implementation would be that if
> trailer.X.something is configured but not trailer.X.key it would work as
> if there was an implicit "trailer.X.key=X" configured. The name of the
> configuration value would specify the correct spelling.

I had the same thought but then a question struck and stopped me:
what should happen if "trailer.X.something" and
"trailer.x.somethingelse" are both defined?
