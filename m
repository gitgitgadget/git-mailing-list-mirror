Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3576C4BA24
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 20:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BCB42072D
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 20:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vovJEsoU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgBZU3R (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 15:29:17 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53662 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbgBZU3R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 15:29:17 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B75758FF8;
        Wed, 26 Feb 2020 15:29:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ff4S0v5BEj6N0arRM2lXQL+rGRY=; b=vovJEs
        oUj19zrSbbqICCaf9HQcewAyHZJSk/dS0VPgc/paVjdo0ckKbyEbYvpQSGSZ27+E
        JQknPyseMPAG7wPqK0A0RM7Ew7UGU4+vRGiXjWK+ZZRY1lgBfQ7sbaqN4ZmAFi9o
        KOEqHRsYyXuDqYm+X7NKSEiNRpAQoqxb/iFEE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hXRfjPbndHmau6U8Mt1J2K6zvvEnoyot
        ZX4ZDi6hBEoreN/7CipbCJ9IqSEk3NlJZccBnDj4feLORlU3cyvvEWMp3ai5VY4r
        u03wNCpHkW8E45F+5NOLzHk0fCHD6UMF8DiOvSxpSriFd5ecDGHkMB0q1N/CTP35
        GBH2SLyH8Bw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 640B758FF7;
        Wed, 26 Feb 2020 15:29:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C50D758FF6;
        Wed, 26 Feb 2020 15:29:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Andrei Rybak <rybak.a.v@gmail.com>,
        Greg Anders <greg@gpanders.com>, git@vger.kernel.org
Subject: Re: git-shell default working directory
References: <20200226004830.oxd5562v7qqspnkk@Kepler>
        <241ea912-44b2-96fa-6f9a-3f04d5386b05@gmail.com>
        <20200226201121.GA287048@coredump.intra.peff.net>
Date:   Wed, 26 Feb 2020 12:29:13 -0800
In-Reply-To: <20200226201121.GA287048@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 26 Feb 2020 15:11:21 -0500")
Message-ID: <xmqqeeuhhz3a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A7B672FA-58D6-11EA-A0F6-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Feb 26, 2020 at 10:10:05AM +0100, Andrei Rybak wrote:
>
>> > I've not yet found a way to get this to work without keeping the
>> > repositories in the git user's home folder.
>> 
>> Disclaimer: I'm not at all familiar with git server setup. Would it make sense
>> to change git user home directory to be the required dedicated directory?
>
> Yeah, that's what I would suggest. git-shell does explicitly cd to
> $HOME, so any chdir you do before then will be lost (though you could
> perhaps just set $HOME in ~/.ssh/rc).

I didn't suggest it because the original request did not sound like
building a dedicated machine that is used only to push into without
interactive shell access.  If $HOME is moved to such a git centric
place, that would make it almost impossible to use the account for
shell interactive access, I would imagine, and if that is acceptable,
perhaps something like gitolite would fit the bill better?
